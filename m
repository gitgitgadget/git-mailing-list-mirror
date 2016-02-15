From: Jeff King <peff@peff.net>
Subject: [PATCH 0/18] hardening allocations against integer overflow
Date: Mon, 15 Feb 2016 16:45:16 -0500
Message-ID: <20160215214516.GA4015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 22:45:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQxR-00045A-GO
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbcBOVpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:45:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:42458 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752499AbcBOVpS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:45:18 -0500
Received: (qmail 2158 invoked by uid 102); 15 Feb 2016 21:45:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:45:18 -0500
Received: (qmail 12237 invoked by uid 107); 15 Feb 2016 21:45:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:45:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:45:16 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286253>

About 6 months or so ago, I did an audit of git's code base for uses of
strcpy and sprintf that could overflow, fixing any bugs and cleaning up
any suspect spots to make further audits simpler.  This is a
continuation of that work, for size computations which can overflow and
cause us to allocate a too-small buffer. E.g., something like:

  char *concat(const char *a, const char *b)
  {
	unsigned len_a = strlen(a);
	unsigned len_b = strlen(b);
	char *ret = xmalloc(len_a + len_b);
	memcpy(ret, a, len_a);
	memcpy(ret, b, len_b);
  }

will behave badly if the sum of "a" and "b" overflows "unsigned". There
are other variants, too (we are also truncating the return value from
strlen, and we'd frequently use "int" here, so the lengths can actually
be negative!). It also varies based on platform. If the sites use size_t
instead of int, then 64-bit systems are typically hard to trigger in
practice (just because you'd need petabytes to store "a" and "b" in the
first place).

The only bug I have actually confirmed in practice here is fixed by
patch 2 (which is why it's at the front). There's another one in
path_name(), but that function is already dropped by the nearby
jk/lose-name-path topic.

The rest are cleanups of spots which _might_ be buggy, but I didn't dig
too far to find out. As with the earlier audit, I tried to refactor
using helpers that make the code clearer and less error-prone. So maybe
they're fixing bugs or not, but they certainly make it easier to audit
the result for problems.

  [01/18]: add helpers for detecting size_t overflow
  [02/18]: tree-diff: catch integer overflow in combine_diff_path allocation
  [03/18]: harden REALLOC_ARRAY and xcalloc against size_t overflow
  [04/18]: add helpers for allocating flex-array structs
  [05/18]: convert trivial cases to ALLOC_ARRAY
  [06/18]: use xmallocz to avoid size arithmetic
  [07/18]: convert trivial cases to FLEX_ARRAY macros
  [08/18]: use st_add and st_mult for allocation size computation
  [09/18]: write_untracked_extension: use FLEX_ALLOC helper
  [10/18]: fast-import: simplify allocation in start_packfile
  [11/18]: fetch-pack: simplify add_sought_entry
  [12/18]: test-path-utils: fix normalize_path_copy output buffer size
  [13/18]: sequencer: simplify memory allocation of get_message
  [14/18]: git-compat-util: drop mempcpy compat code
  [15/18]: transport_anonymize_url: use xstrfmt
  [16/18]: diff_populate_gitlink: use a strbuf
  [17/18]: convert ewah/bitmap code to use xmalloc
  [18/18]: ewah: convert to REALLOC_ARRAY, etc

-Peff
