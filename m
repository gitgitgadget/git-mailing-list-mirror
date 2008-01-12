From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] [WIP] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Sat, 12 Jan 2008 22:14:29 +0300
Message-ID: <20080112191429.GI2963@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0801111103420.3148@woody.linux-foundation.org> <12001604531066-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@linux-foundation.org, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Jan 12 20:15:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDlou-0000d7-8q
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 20:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756335AbYALTOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 14:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756223AbYALTOg
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 14:14:36 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:51851 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068AbYALTOg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 14:14:36 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 95CE918718EE;
	Sat, 12 Jan 2008 22:14:32 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-170-195.pppoe.mtu-net.ru [85.140.170.195])
	by smtp03.mtu.ru (Postfix) with ESMTP id EB69D1871A7F;
	Sat, 12 Jan 2008 22:14:29 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JDloL-0000X7-Kw; Sat, 12 Jan 2008 22:14:29 +0300
Content-Disposition: inline
In-Reply-To: <12001604531066-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70349>

On Sat, Jan 12, 2008 at 06:54:13PM +0100, Steffen Prohaska wrote:
> diff --git a/convert.c b/convert.c
> index 4df7559..598cf0b 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -132,6 +132,27 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
>  				*dst++ = c;
>  		} while (--len);
>  	}
> +	if (safe_crlf) {
> +		if ((action == CRLF_INPUT) || auto_crlf <= 0) {
> +			/* autocrlf=input: check if we removed CRLFs */
> +			if (buf->len != dst - buf->buf) {
> +				if (safe_crlf == SAFE_CRLF_WARN)
> +					warning("Stripped CRLF from %s.", path);
> +				else
> +					die("Refusing to strip CRLF from %s.", path);
> +			}

This check is okay, however

> +		} else {
> +			/* autocrlf=true: check if we had LFs (without CR) */
> +			if (stats.lf != stats.crlf) {
> +				if (safe_crlf == SAFE_CRLF_WARN)
> +					warning(
> +					  "Checkout will replace LFs with CRLF in %s", path);
> +				else
> +					die("Checkout would replace LFs with CRLF in %s", path);
> +			}
> +		}

this is not, because if you really want to be sure that file will not be mangled
by checkout, you should not allow a text file with naked LF when autocrlf=true.
And the following lines after gather_stats() can cause:

		/* No CR? Nothing to convert, regardless. */
		if (!stats.cr)
			return 0;

So, I propose a slightly different patch for convert.c:

diff --git a/convert.c b/convert.c
index 4df7559..9fd88d9 100644
--- a/convert.c
+++ b/convert.c
@@ -90,9 +90,6 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		return 0;
 
 	gather_stats(src, len, &stats);
-	/* No CR? Nothing to convert, regardless. */
-	if (!stats.cr)
-		return 0;
 
 	if (action == CRLF_GUESS) {
 		/*
@@ -108,8 +105,23 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		 */
 		if (is_binary(len, &stats))
 			return 0;
+
+		if (safe_crlf) {
+			/* check if we have "naked" LFs */
+			if (stats.lf != stats.crlf) {
+				if (safe_crlf == SAFE_CRLF_WARN)
+					warning(
+					  "Checkout will replace LFs with CRLF in %s", path);
+				else
+					die("Checkout would replace LFs with CRLF in %s", path);
+			}
+		}
 	}
 
+	/* No CR? Nothing to convert, regardless. */
+	if (!stats.cr)
+		return 0;
+
 	/* only grow if not in place */
 	if (strbuf_avail(buf) + buf->len < len)
 		strbuf_grow(buf, len - buf->len);
@@ -131,6 +143,16 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 			if (! (c == '\r' && (1 < len && *src == '\n')))
 				*dst++ = c;
 		} while (--len);
+
+		if (safe_crlf && (action == CRLF_INPUT || auto_crlf <= 0)) {
+			/* autocrlf=input: check if we removed CRLFs */
+			if (buf->len != dst - buf->buf) {
+				if (safe_crlf == SAFE_CRLF_WARN)
+					warning("Stripped CRLF from %s.", path);
+				else
+					die("Refusing to strip CRLF from %s.", path);
+			}
+		}
 	}
 	strbuf_setlen(buf, dst - buf->buf);
 	return 1;


Dmitry
