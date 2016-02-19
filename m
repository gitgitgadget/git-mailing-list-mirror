From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/21] hardening allocations against integer overflow
Date: Fri, 19 Feb 2016 06:19:41 -0500
Message-ID: <20160219111941.GA31906@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 12:19:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWj6D-0001O9-3q
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 12:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425751AbcBSLTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 06:19:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:45212 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422854AbcBSLTo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 06:19:44 -0500
Received: (qmail 20000 invoked by uid 102); 19 Feb 2016 11:19:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 06:19:44 -0500
Received: (qmail 26420 invoked by uid 107); 19 Feb 2016 11:19:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 06:19:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2016 06:19:41 -0500
Content-Disposition: inline
In-Reply-To: <20160215214516.GA4015@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286684>

Here's a re-roll of jk/tighten-alloc series from:

  http://thread.gmane.org/gmane.comp.version-control.git/286253

This one fixes all of the minor typo/gramm-o problems from the first
round. As Eric noted, the change to reflog_expire_cfg is an actual
bug-fix. Rather than silently fixing it, I've bumped the fix out to its
own commit at the front of the series.

I also took a look at the raw computation in the ALLOC_ARRAY and
REALLOC_ARRAY lines, as well as the ones in ALLOC_GROW. In theory
something like this is dangerous:

  ALLOC_GROW(foo, nr_foo + 1, alloc_foo);
  foo[nr_foo++] = whatever;

if we overflow nr_foo, which is quite often an "int". In practice, I
think we're OK, for two reasons:

  1. Overflowing a signed "int" here is going to make it go negative
     (technically, it invokes undefined behavior, but let's be blindly
     pragmatic for a minute and assume twos-complement wrapping). On a
     system with a 64-bit size_t, that will try to allocate an enormous
     amount of memory and fail. On a 32 bit system, it will be only
     about 2GB.  But...

  2. We're talking about overflowing 2^31 counters here. And the counter
     is multiplied by the size of each object we're storing in the
     array. So even if we assume that foo is "char *", we know we've
     allocated close to 2GB already. On a 32-bit system, the subsequent
     2GB allocation is pretty much guaranteed to fail.

     On a 64-bit system, I suspect it's possible to convince some of
     these counters to wrap (e.g., storing an array of ints, we're
     talking about only 8GB; that's a lot, but plenty of machines,
     especially servers, can allocate that).

So I have a feeling we're mostly OK there, but the reasoning is
certainly hand-wavy and I'd like to do better. Just switching to:

  ALLOC_GROW(foo, st_add(nr_foo, 1), alloc_foo);
  foo[nr_foo++] = whatever;

doesn't quite cut it. We might succeed in the allocation, and it stays
big, which is good. But if nr_foo is an int, and we wrap to negative
values, we'll start writing to memory before "foo", corrupting the heap.

So I really think we need to look at each site (and there are a lot of
them) and start using size_t more consistently for these. Or
alternatively, have an int-sized version of st_add and use that, though
it's probably just as much work to convert it to a size_t, which IMHO is
more correct. I really wanted to make a type-agnostic version of
st_add(), but I don't think it's possible to do so portably. My best
attempts needed either typeof() or compiler intrinsics.

So I've punted on that for this series, because I'm not convinced there
are active problems, and it's quite a lot of work (and the patches will
be quite disruptive).

While pondering this, I also looked at what happens if an incoming
packfile claims to have 2^32 objects in its header. In index-pack we
actually read this into a signed "int". Which is kind of bad, but in
practice means we run into the "whoops, I can't allocate (size_t)-1
memory" problem and die. We could change this to a uint32_t (which is
what the actual incoming format supports), but I have a feeling that
makes things worse (if we actually manage to process that many objects,
we then start doing some other computations based on the number of
objects, all using ints; so at least as it is now, we bail early).

While peeking at some of these sites, though, I did realize that many of
the ones that became "ALLOC_ARRAY(foo + 1)" were doing so to make a
NULL-terminated argv list. So there are two new patches in this
iteration to switch them to argv_array (one to catch the mundane cases,
and one for a unique snowflake).

  [01/21]: reflog_expire_cfg: NUL-terminate pattern field
  [02/21]: add helpers for detecting size_t overflow
  [03/21]: tree-diff: catch integer overflow in combine_diff_path allocation
  [04/21]: harden REALLOC_ARRAY and xcalloc against size_t overflow
  [05/21]: add helpers for allocating flex-array structs
  [06/21]: convert manual allocations to argv_array
  [07/21]: convert trivial cases to ALLOC_ARRAY
  [08/21]: use xmallocz to avoid size arithmetic
  [09/21]: convert trivial cases to FLEX_ARRAY macros
  [10/21]: use st_add and st_mult for allocation size computation
  [11/21]: prepare_{git,shell}_cmd: use argv_array
  [12/21]: write_untracked_extension: use FLEX_ALLOC helper
  [13/21]: fast-import: simplify allocation in start_packfile
  [14/21]: fetch-pack: simplify add_sought_entry
  [15/21]: test-path-utils: fix normalize_path_copy output buffer size
  [16/21]: sequencer: simplify memory allocation of get_message
  [17/21]: git-compat-util: drop mempcpy compat code
  [18/21]: transport_anonymize_url: use xstrfmt
  [19/21]: diff_populate_gitlink: use a strbuf
  [20/21]: convert ewah/bitmap code to use xmalloc
  [21/21]: ewah: convert to REALLOC_ARRAY, etc

-Peff
