From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug?] log -p -W showing the whole file for a patch that adds to the end?
Date: Tue, 10 May 2016 15:51:18 -0700
Message-ID: <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 00:51:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0GUx-0004Va-AS
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 00:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbcEJWvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 18:51:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751293AbcEJWvX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 18:51:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A92C81ADE1;
	Tue, 10 May 2016 18:51:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IMlJqPIY2U74oy4E0MUednSwzkw=; b=i7T12r
	1+Y0EsxeD0pY02GzB8w+uNhpLe35RDm9THsa23t8vpW+AvdHv4D6e0+1GIhbWc3q
	bIjpQgdcUAehVDIh5fdPYlUtN+8pgsOyWUkTn7k5OyNIYBLpA0pC/J1mrpWCGUb5
	UGsVNjJaEGqQq1NZhcyBPYnh3GJ6GIf4nhTP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qCcgJjrHSGm8Zkv5dLOkOlcDva7zJlRt
	UIuv1I9u2BGoRenPt2Mh2rAos5oriYyhzJ9V0zUzLvEwfzuD6EbpmRV7ZjPtLaMz
	rrgKqdnElLcK6hIZuDF2RsgHOYcd1rhjtdlpIPDBCtCZDJJYX/oa6O4l8cRWnLx7
	Fu2cgdNsduI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FBE61ADE0;
	Tue, 10 May 2016 18:51:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20EC41ADDF;
	Tue, 10 May 2016 18:51:21 -0400 (EDT)
In-Reply-To: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 10 May 2016 14:51:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B6D97B44-1701-11E6-8278-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294204>

Junio C Hamano <gitster@pobox.com> writes:

> Just noticed a curiosity:
>
>     $ git show -W 3e3ceaa58 quote.c
>
> shows the entire file.  The commit in question adds a whole new
> function at the end of the file.  If I move that addition to just
> before the last function the file already had before the change and
> amend the commit, "show -W" would work as expected, i.e. addition of
> the function, with three lines before and three lines after context.
>
> The -W feature was added by 14937c2c (diff: add option to show whole
> functions as context, 2011-10-09).

A workaround (atEnd) seems to give me a slightly better result, but
I am not sure if this breaks other corner cases.

The real problem is that get_func_line() is called with (start,
limit) but a hunk that adds to the end does not even enter the loop
that goes back (i.e. step = -1) to find the funcline:

	for (l = start; l != limit && 0 <= l && l < xe->xdf1.nrec; l += step) {
		const char *rec;
		long reclen = xdl_get_rec(&xe->xdf1, l, &rec);
		long len = ff(rec, reclen, buf, size, xecfg->find_func_priv);

because start == xe->xdf1.nrec in that case.  We could instead force
it to enter the loop by decrementing start when it is xe->xdf1.nrec
and we are going down, but that would show two functions in the
resulting hunk (one that is the existing function at the end of the
file, the other that is added by the patch), which is not better than
showing the patch unmodified.

-- >8 --
Subject: diff -W: do not show the whole file when punting

The -W option to "diff" family of commands allows the pre- and post-
context of hunks extended to cover the previous and the next
"function header line", so that the whole function that is patched
can be seen in the hunk.

The helper function get_func_line() however gets confused when a
hunk adds a new function at the very end, and returns -1 to signal
that it did not find a suitable "function header line", i.e. the
beginning of previous function.  The caller then takes this signal
and shows from the very beginning of the file.  We end up showing
the entire file, starting from the very beginning to the end of the
newly added lines.

We can avoid this by using the original hunk boundary when the
helper gives up.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff/xemit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 993724b..4e58482 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -166,7 +166,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		if (xecfg->flags & XDL_EMIT_FUNCCONTEXT) {
 			long fs1 = get_func_line(xe, xecfg, NULL, xch->i1, -1);
 			if (fs1 < 0)
-				fs1 = 0;
+				fs1 = xch->i1;
 			if (fs1 < s1) {
 				s2 -= s1 - fs1;
 				s1 = fs1;
