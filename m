From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] diff --color-words -U0: fix the location of hunk headers
Date: Thu, 29 Oct 2009 12:22:41 +0100
Message-ID: <200910291222.42598.markus.heidelberg@web.de>
References: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de> <1256732672-11817-4-git-send-email-markus.heidelberg@web.de> <alpine.DEB.1.00.0910291144170.3687@felix-maschine>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 29 12:24:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3T61-0007Uq-Ok
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 12:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbZJ2LXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 07:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbZJ2LXB
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 07:23:01 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:60652 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbZJ2LXB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 07:23:01 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id B657B12C5996F;
	Thu, 29 Oct 2009 12:22:32 +0100 (CET)
Received: from [89.59.78.39] (helo=pluto.fritz.box)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N3T5M-0005zW-00; Thu, 29 Oct 2009 12:22:32 +0100
User-Agent: KMail/1.9.10
In-Reply-To: <alpine.DEB.1.00.0910291144170.3687@felix-maschine>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX185Wjpv3NYOM0UXyNO9cQne3gZfgj6OQLXVldti
	sgVyuNyUfsTUDqaxv2XqPeXbqE3d6g/RbUapmswiOI/q37rGsr
	jjvY6m7DOZmaMXHX9zpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131583>

Johannes Schindelin, 29.10.2009:
> 
> 	I would strongly prefer this fix instead of your 2/3 and 3/3.
> 
>  diff.c                |    6 ++++++
>  t/t4034-diff-words.sh |    2 +-
>  2 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 51b5dbb..4eafaf5 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -656,6 +656,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  	for (i = 0; i < len && line[i] == '@'; i++)
>  		;
>  	if (2 <= i && i < len && line[i] == ' ') {
> +		/* flush --color-words even for --unified=0 */
> +		if (ecbdata->diff_words &&
> +		    (ecbdata->diff_words->minus.text.size ||
> +		     ecbdata->diff_words->plus.text.size))
> +			diff_words_show(ecbdata->diff_words);
> +
>  		ecbdata->nparents = i - 1;
>  		len = sane_truncate_line(ecbdata, line, len);
>  		emit_line(ecbdata->file,

This seems to apply before commit b8d9c1a (diff.c: the builtin_diff()
deals with only two-file comparison, 2009-09-03).

Indeed my initial fix was in the same fashion:

@@ -772,6 +772,15 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
        }

        if (line[0] == '@') {
+               if (ecbdata->diff_words) {
+                       /*
+                        * The content of the previous hunk, necessary for
+                        * 0-context.
+                        */
+                       if (ecbdata->diff_words->minus.text.size ||
+                           ecbdata->diff_words->plus.text.size)
+                               diff_words_show(ecbdata->diff_words);
+               }
                len = sane_truncate_line(ecbdata, line, len);
                find_lno(line, ecbdata);
                emit_line(ecbdata->file,

But then I thought I should not put the diff output from --color-words
into the block that deals with the hunk header, but save another place
where diff_words_show() is called.

Markus
