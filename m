From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Sun, 09 Jun 2013 14:28:50 -0700
Message-ID: <7vtxl7nfcd.fsf@alter.siamese.dyndns.org>
References: <7v61xt7gej.fsf@alter.siamese.dyndns.org>
	<1370724291-30088-1-git-send-email-apelisse@gmail.com>
	<7vsj0roxnr.fsf@alter.siamese.dyndns.org>
	<CALWbr2xijB+UD9gwc+HmMdHM9OT+2Lzr9w3h22=CegKHK-Ocng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 23:29:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlnAh-000296-6p
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 23:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268Ab3FIV2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 17:28:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63215 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab3FIV2y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 17:28:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5921426003;
	Sun,  9 Jun 2013 21:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CoJcp94UBJI7ze7QiWttfqzBzU8=; b=NTRsSk
	iRO6JKXdszWht5sDzLb/My+UYoZgZDegIQYZudWK0fj5q1bOyAd2ipw5xpuEDVhd
	HcMdd4MIgy0KNGOzMg9y6ln/as87CV0aLV0/bkape0nuyNLztLdx55UFb5/IIR2S
	Orf9BarAU4OYzQufmXGnndiOnNDMeO1JEDLuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=etX1XIXISTT8lmH9ygq/rGHN0pxTarYD
	WaIeKYBi6W1L5HYKQAHLqiyUHMqyK38Te0bG5v5WT6XsmLoRdTWf3nLBIGfIRvNv
	tL0qrJ5t3NZ5F7TL8DKKsUciwFhCpnR7ZCJPFHyt8X4X3Wf7Q6GURgvnVi3TpB0u
	P9dT0FAZjvM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F61D26002;
	Sun,  9 Jun 2013 21:28:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FE5C25FFD;
	Sun,  9 Jun 2013 21:28:52 +0000 (UTC)
In-Reply-To: <CALWbr2xijB+UD9gwc+HmMdHM9OT+2Lzr9w3h22=CegKHK-Ocng@mail.gmail.com>
	(Antoine Pelisse's message of "Sun, 9 Jun 2013 22:32:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94EF1D4E-D14B-11E2-841C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227170>

Antoine Pelisse <apelisse@gmail.com> writes:

> It might be kind of noisy, but I think trying to improve the solution
> might lead to over-engineering.
> How would we compute the "minimal distance between interesting and
> blank" so that the blank becomes interesting ?
> Using the context size for that is quite convenient, while creating
> another variable would probably become overkill..
>
> The original goal is to remove hunks created solely for
> addition/suppression, and I think it's what it should do for the
> moment.

Something like this on top of your original one is what I had in
mind as a starting point.

 t/t4015-diff-whitespace.sh |  5 +----
 xdiff/xemit.c              | 45 ++++++++++++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index b3c4fcc..acc2159 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -185,7 +185,7 @@ test_expect_success 'ignore-blank-lines: with changes' '
 	git diff --ignore-blank-lines >out.tmp &&
 	sed -e "1,/^+++ b\/x/d" <out.tmp >out &&
 	cat <<-\EOF >expect &&
-	@@ -1,6 +2,7 @@
+	@@ -1,11 +2,14 @@
 	 1
 	 2
 	 3
@@ -193,9 +193,6 @@ test_expect_success 'ignore-blank-lines: with changes' '
 	 4
 	 5
 	 6
-	@@ -5,7 +7,9 @@
-	 5
-	 6
 	 7
 	+
 	 8
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 52dfef8..27e1105 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -59,32 +59,39 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
  * Also advance xscr if the first changes must be discareded.
  */
 xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg) {
-	xdchange_t *xch, *xchp;
+	xdchange_t *xch, *xchp = NULL, *xch_start = NULL;
 	long max_common = 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
-	long ignorable_context = max_common / 2 - 1;
-	int interesting = 0;
 
-	for (xchp = *xscr, xch = (*xscr)->next; xch; xchp = xch, xch = xch->next) {
-		long thresh;
-		if (xchp->ignore || xch->ignore)
-			thresh = ignorable_context;
-		else
-			thresh = max_common;
-
-		if (!xchp->ignore)
-			interesting = 1;
+	/* Skip the ones that can be ignored from the beginning */
+	for (xch = *xscr; xch; xch = xch->next) {
+		if (xch->ignore)
+			continue;
+		xch_start = xch;
+		break;
+	}
 
-		if (xch->i1 - (xchp->i1 + xchp->chg1) > thresh) {
-			if (interesting)
+	for (xchp = xch_start; xchp; ) {
+		/* Find the next one that is not ignored */
+		for (xch = xchp->next; xch; xch = xch->next)
+			if (!xch->ignore)
 				break;
-			else
-				*xscr = xch;
+		if (!xch)
+			break; /* show xch_start thru xchp */
+
+		/* are these hunks close enough? */
+		if ((xchp->i1 + xchp->chg1) - xch->i1 < max_common) {
+			xchp = xch;
+			continue;
 		}
-	}
 
-	if (!interesting && xchp->ignore)
-		*xscr = NULL;
+		/*
+		 * otherwise, xchp is the last one (inclusive) we want
+		 * to coalesce into a single output hunk.
+		 */
+		break;
+	}
 
+	*xscr = xch_start;
 	return xchp;
 }
 
-- 
1.8.3-477-gc2fede3
