From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] git apply: option to ignore whitespace differences
Date: Tue, 01 Sep 2009 02:17:27 -0700
Message-ID: <7vocpvvxaw.fsf@alter.siamese.dyndns.org>
References: <1249384609-30240-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 11:18:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiPV9-0004WZ-C5
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 11:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbZIAJRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 05:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbZIAJRo
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 05:17:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbZIAJRo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 05:17:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BEF1C3FBFD;
	Tue,  1 Sep 2009 05:17:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6T0BFBne7SScsIpT2BesbjXsNEY=; b=rhvsE5
	uTI9r69wc3UtyzfkWhMJyVHoaGKOlpHPqSMmFstKtFhlRT4Hul1Uq6uRTxHG/G4e
	q6gMglxD4xV6ftDHDQmE4ug5d6chp/nhl1eKXo/ZDWGZ5d2L6zkIyx9U1DVFI+X0
	PmsfLafVJvYFUAYlqtLo4GhBy+34zcLhDQrTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NODnxSGlsrswFEsIUHmFxZ9BhGX67OZE
	IqLOE9UfMU0XJ76T0/VShF8iVoRMrLoqt+37exPxYnVFF51+z851I8VzAV/HpvBv
	ZKw4+J3dUYr5ytdGaEHBCsGBmVU/pWeymfMUpKUhIchajTgKCfG/i3sWo9L9C+qZ
	Oo/2B06QM84=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 883F23FBF9;
	Tue,  1 Sep 2009 05:17:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AB7283FBF3; Tue,  1 Sep 2009
 05:17:29 -0400 (EDT)
In-Reply-To: <1249384609-30240-1-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Tue\,  4 Aug 2009 13\:16\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4BB7BFAC-96D8-11DE-9670-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127527>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> diff --git a/builtin-apply.c b/builtin-apply.c
> index 39dc96a..7ec5b8b 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -1773,12 +1866,57 @@ static int match_fragment(struct image *img,
>  	    !memcmp(img->buf + try, preimage->buf, preimage->len))
>  		return 1;
>  
> +	/*
> +	 * No exact match. If we are ignoring whitespace, run a line-by-line
> +	 * fuzzy matching. We collect all the line length information because
> +	 * we need it to adjust whitespace if we match.
> +	 */
> +	if (ws_ignore_action == ignore_ws_change) {
> +		size_t imgoff = 0;
> +		size_t preoff = 0;
> +		size_t postlen = postimage->len;
> +		size_t imglen[preimage->nr];
> +		for (i = 0; i < preimage->nr; i++) {
> +			imglen[i] = img->line[try_lno+i].len;
> +			size_t prelen = preimage->line[i].len;
> +			if (!fuzzy_matchlines(
> +				img->buf + try + imgoff, imglen[i],
> +				preimage->buf + preoff, prelen))
> +				return 0;
> +			if (preimage->line[i].flag & LINE_COMMON)
> +				postlen += imglen[i] - prelen;
> +			imgoff += imglen[i];
> +			preoff += prelen;
> +		}
> +
> +		/*
> +		 * Ok, the preimage matches with whitespace fuzz. Update it and
> +		 * the common postimage lines to use the same whitespace as the
> +		 * target. imgoff now holds the true length of the target that
> +		 * matches the preimage, and we need to update the line lengths
> +		 * of the preimage to match the target ones.
> +		 */
> +		fixed_buf = xmalloc(imgoff);
> +		memcpy(fixed_buf, img->buf + try, imgoff);
> +		for (i = 0; i < preimage->nr; i++)
> +			preimage->line[i].len = imglen[i];
> +
> +		/*
> +		 * Update the preimage buffer and the postimage context lines.
> +		 */
> +		update_pre_post_images(preimage, postimage,
> +				fixed_buf, imgoff, postlen);
> +		return 1;
> +	}
> +

Why do you need imglen[] vla here?  IOW, can't the above be simply like
this?

diff --git a/builtin-apply.c b/builtin-apply.c
index ae11b41..c8372a0 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1874,20 +1874,18 @@ static int match_fragment(struct image *img,
 	if (ws_ignore_action == ignore_ws_change) {
 		size_t imgoff = 0;
 		size_t preoff = 0;
 		size_t postlen = postimage->len;
-		size_t imglen[preimage->nr];
 		for (i = 0; i < preimage->nr; i++) {
 			size_t prelen = preimage->line[i].len;
+			size_t imglen = img->line[try_lno+i].len;
 
-			imglen[i] = img->line[try_lno+i].len;
-			if (!fuzzy_matchlines(
-				img->buf + try + imgoff, imglen[i],
-				preimage->buf + preoff, prelen))
+			if (!fuzzy_matchlines(img->buf + try + imgoff, imglen,
+					      preimage->buf + preoff, prelen))
 				return 0;
 			if (preimage->line[i].flag & LINE_COMMON)
-				postlen += imglen[i] - prelen;
-			imgoff += imglen[i];
+				postlen += imglen - prelen;
+			imgoff += imglen;
 			preoff += prelen;
 		}
 
 		/*
@@ -1899,9 +1897,9 @@ static int match_fragment(struct image *img,
 		 */
 		fixed_buf = xmalloc(imgoff);
 		memcpy(fixed_buf, img->buf + try, imgoff);
 		for (i = 0; i < preimage->nr; i++)
-			preimage->line[i].len = imglen[i];
+			preimage->line[i].len = img->line[try_lno+i].len;
 
 		/*
 		 * Update the preimage buffer and the postimage context lines.
 		 */
