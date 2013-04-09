From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Using a bit more decoration
Date: Mon, 8 Apr 2013 23:51:26 -0400
Message-ID: <20130409035126.GA17319@sigill.intra.peff.net>
References: <20130408210903.GC9649@sigill.intra.peff.net>
 <1365462114-8630-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 05:51:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPPap-0001nI-Lf
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 05:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935675Ab3DIDvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 23:51:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34667 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935659Ab3DIDvb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 23:51:31 -0400
Received: (qmail 19276 invoked by uid 107); 9 Apr 2013 03:53:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 23:53:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 23:51:26 -0400
Content-Disposition: inline
In-Reply-To: <1365462114-8630-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220545>

On Mon, Apr 08, 2013 at 04:01:51PM -0700, Junio C Hamano wrote:

> This comes on top of the two "decorate" patches that introduced the
> clear_decoration() function.
> [...]
> Junio C Hamano (3):
>   commit: shrink "indegree" field
>   commit: rename parse_commit_date()
>   commit: add get_commit_encoding()

Neat. Reading through, I didn't notice anything obviously wrong with any
of the patches (though there is one gcc warning, which I'll respond to
separately).

It does make me a little nervous to have code that almost never gets
exercised (i.e., when indegree is really high, or a large number of
encodings). It seems like a bug waiting to happen when somebody does hit
that condition. But the decoration lookups do look fairly simple and
easy to get right.

> I am not sure if pre-parsing and sharing the encoding values in-core
> would affect performance very much, but now we have 2 bytes (or 6
> bytes, if you are on 64-bit archs) free to use in "struct commit"
> for later use (e.g. extra object flags that are relevant only for
> commit objects, without having to widen "struct object").

I wasn't able to measure any speedup, but I'm not surprised; something
like "git log" already spends way more effort extracting and
pretty-printing the commit objects.

I was actually thinking of something related to this recently. It would
be nice to be able to allocate a slab of very efficient fixed-size
per-commit or per-object storage. That would eliminate the need to pay
the cost for "indegree" all the time; the topo-sort could allocate a
slab of indegree integers, then throw it away when the sort was done.
Similarly, a traversal would not have to worry about pollution of the
object flags, nor about using an arbitrarily large number of flags[1],
if it could allocate a separate flag structure.

Using a separate hash would be too slow. I'm thinking more like giving
each commit an integer "id" as it is parsed, and then using that id to
index into a temporary slab (you'd grow the slab as you see more commits
but that's OK, since we're always indexing it, not using a pointer). The
slab management would get amortized, so the main cost would be the extra
indirect memory access (i.e., hitting "flags[commit->id]" instead of
"commit->id"), and the extra memory used by the id field.

I dunno. Maybe those costs would make it too slow. I haven't actually
coded or measured anything yet.

-Peff

[1] The thing that made me think about this was making a version of
    paint_down_to_common that could keep a separate color for each
    source, rather than only PARENT1 and PARENT2. That would let us do
    the "--contains" traversal in a breadth-first way, but calculate the
    answer simultaneously for all sources (i.e., avoid the depth-first
    "go to roots" problem that the current "tag --contains" has if you
    do not use timestamp cutoffs).
