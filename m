From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix Q-encoded multi-octet-char split in email.
Date: Tue, 3 Jul 2012 02:35:11 -0400
Message-ID: <20120703063511.GA16679@sigill.intra.peff.net>
References: <1341279697-4596-1-git-send-email-gkatsu.ne@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Takeharu Katsuyama <tkatsu.ne@gmail.com>
To: katsu <gkatsu.ne@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 08:35:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slwho-0007U6-DL
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 08:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933446Ab2GCGfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 02:35:16 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52080
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933430Ab2GCGfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 02:35:15 -0400
Received: (qmail 18678 invoked by uid 107); 3 Jul 2012 06:35:22 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jul 2012 02:35:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2012 02:35:11 -0400
Content-Disposition: inline
In-Reply-To: <1341279697-4596-1-git-send-email-gkatsu.ne@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200902>

On Tue, Jul 03, 2012 at 10:41:37AM +0900, katsu wrote:

> Issue: Email subject written in multi-octet language like japanese cannot
> be displayed in correct at destinations's email client, because the
> Q-encoded subject which is longer than 78 octets is split by a octet not by
> a character at line breaks.
> e.g.)
>    "=?utf-8?q? [PATCH] ... =E8=83=86=E8=81=A9?="
>                     |
>                     V
>    "=?utf-8?q? [PATCH] ... =E8=83=86=E8?="
>    "=?utf-8?q?=81=A9=?"
> 
> Changes: Add a judge if a character is an part of utf-8 muti-octet, and
> split the characters by a character not by a octet at line breaks in
> function add_rfc2407() in pretty.c. Like following.
> 
>    "=?utf-8?q? [PATCH] ... =E8=83=86?="
>    "=?utf-8?q?=E8=81=A9=?"
> 
> Signed-off-by: Takeharu Katsuyama <tkatsu.ne@gmail.com>

Yeah, we definitely don't handle that properly according to the rfc.
This patch is is going in the right direction, but I have a few
comments:

> --- a/pretty.c
> +++ b/pretty.c
> @@ -272,6 +272,12 @@ static void add_rfc2047(struct strbuf *sb, const char *line, int len,
>  	static const int max_length = 78; /* per rfc2822 */
>  	int i;
>  	int line_len;
> +	int utf_ctr, use_utf;
> +
> +	if (!strcmp(encoding, "UTF-8") || !strcmp(encoding, "utf-8"))
> +		use_utf = 1;
> +	else
> +		use_utf = 0;

Please use is_encoding_utf8, which handles both of these spellings, as
well as "utf8" and "UTF8" (it also handles encoding==NULL; I don't think
that can happen in this code path, but it is nice to be defensive).

> @@ -293,10 +299,31 @@ needquote:
>  	strbuf_grow(sb, len * 3 + strlen(encoding) + 100);
>  	strbuf_addf(sb, "=?%s?q?", encoding);
>  	line_len += strlen(encoding) + 5; /* 5 for =??q? */
> +	utf_ctr = 0;
>  	for (i = 0; i < len; i++) {
>  		unsigned ch = line[i] & 0xFF;
>  
> -		if (line_len >= max_length - 2) {
> +		/*
> +		 * Judge if it is an utf-8 char, to avoid inserting newline
> +		 * in the middle of utf-8 char code.
> +		 */
> +		if (use_utf) {
> +			if (ch >= 0xC2 && ch <= 0xDF)	/* 1'st byte of 2-bytes utf-8 */
> +				utf_ctr = 1;
> +			else if (ch >= 0xE0 && ch <= 0xEF)	/*  3-bytes utf-8 */
> +				utf_ctr = 2;
> +			else if (ch >= 0xF0 && ch <= 0xF7)	/*  4-bytes utf-8 */
> +				utf_ctr = 3;
> +			else if (ch >= 0xF8 && ch <= 0xFB)	/*  5-bytes utf-8 */
> +				utf_ctr = 4;
> +			else if (ch >= 0xFC && ch <= 0xFD)	/*  6-bytes utf-8 */
> +				utf_ctr = 5;
> +			else if (ch >= 0x80 && ch <= 0xBF)  /* 2'nd to 6'th byte of utf-8 */
> +				utf_ctr--;
> +			else
> +				utf_ctr = 0;
> +		}
> +		if (line_len >= (max_length - 2 - utf_ctr *3)) {

Can we re-use utf8_width here instead of rewriting these rules?

-Peff
