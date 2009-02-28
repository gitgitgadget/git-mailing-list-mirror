From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/4] diffcore-pickaxe: further refactor count_match()
Date: Sat, 28 Feb 2009 02:13:11 +0100
Message-ID: <49A88FA7.1020402@lsrfire.ath.cx>
References: <cover.1235629933.git.gitster@pobox.com> <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 02:14:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdDmv-0006w3-0k
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 02:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560AbZB1BNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 20:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbZB1BNQ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 20:13:16 -0500
Received: from india601.server4you.de ([85.25.151.105]:38201 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbZB1BNP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 20:13:15 -0500
Received: from [10.0.1.101] (p57B7E8A9.dip.t-dialin.net [87.183.232.169])
	by india601.server4you.de (Postfix) with ESMTPSA id 0D8A92F8045;
	Sat, 28 Feb 2009 02:13:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111732>

Junio C Hamano schrieb:
> -static unsigned int count_match(int one_or_more,
> -				struct diff_filespec *one,
> -				const char *needle, unsigned long len,
> -				regex_t *regexp)
> +static unsigned int count_match_internal(int one_or_more,
> +					 const char *data, unsigned long sz,
> +					 const char *needle, unsigned long len,
> +					 regex_t *regexp)
>  {

I don't especially like flags like one_or_more.  Having two functions
(which possibly call a common function that does most of the work) is
nicer.  And it's a bit sad here because there already are two functions
with nice names: count_match() and has_match().  But, well, since the
functions are not exported anyway it doesn't matter much.

> @@ -29,16 +20,14 @@ static unsigned int count_match(int one_or_more,
>  		while (*data && !regexec(regexp, data, 1, &regmatch, flags)) {
>  			flags |= REG_NOTBOL;
>  			data += regmatch.rm_so;
> -			if (*data) data++;
> +			if (*data)
> +				data++;
>  			cnt++;
>  			if (one_or_more)
>  				break;
>  		}
> -
> -	} else { /* Classic exact string match */
> -		/* Yes, I've heard of strstr(), but the thing is *data may
> -		 * not be NUL terminated.  Sue me.
> -		 */
> +	} else {
> +		/* data many not be NUL terminated; we cannot use strstr() */

That looks fishy to me.  regexec() expects data to be a NUL-terminated
string, so either the comment is wrong or the regexp case needs to take
better care to add a NUL at the end of the buffer.

In any case, there is also memmem(), which uses the same fast algorithm
as strstr() in recent glibc versions.  Like this?


diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index f4870b4..4c19967 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -11,7 +11,6 @@ static unsigned int count_match_internal(int one_or_more,
 					 regex_t *regexp)
 {
 	unsigned int cnt = 0;
-	unsigned long offset;
 
 	if (regexp) {
 		regmatch_t regmatch;
@@ -27,15 +26,15 @@ static unsigned int count_match_internal(int one_or_more,
 				break;
 		}
 	} else {
-		/* data many not be NUL terminated; we cannot use strstr() */
-		for (offset = 0; offset + len <= sz; offset++) {
-			/* we count non-overlapping occurrences of needle */
-			if (!memcmp(needle, data + offset, len)) {
-				offset += len - 1;
-				cnt++;
-				if (one_or_more)
-					break;
-			}
+		while (sz) {
+			const char *found = memmem(data, sz, needle, len);
+			if (!found)
+				break;
+			sz -= found - data + len;
+			data = found + len;
+			cnt++;
+			if (one_or_more)
+				break;
 		}
 	}
 	return cnt;
