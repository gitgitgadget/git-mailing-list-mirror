From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [regression?] trailing slash required in .gitattributes
Date: Sat, 23 Mar 2013 11:43:32 +0700
Message-ID: <20130323044331.GA11256@lanh>
References: <20130319175756.GA13760@sigill.intra.peff.net>
 <20130319181042.GA14295@sigill.intra.peff.net>
 <20130322222438.GA13207@sigill.intra.peff.net>
 <20130323041824.GA11142@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 23 05:44:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJGJF-0001rF-WF
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 05:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469Ab3CWEne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 00:43:34 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46583 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab3CWEnd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 00:43:33 -0400
Received: by mail-pa0-f42.google.com with SMTP id kq12so229675pab.29
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 21:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=GNqye1iv26HA3Hi+XcKPEgkdOnbMXCORV0UJPA/HH8o=;
        b=qdX2LBkNWTYORMx7c8yo8reyPNDnyzKSEn0k5khsU9lU3+Nso4CKkMDDgszViOR5R5
         obSRnYbW3jCRmyVsx0I2Eaflf0tJriMXMKXF4KRInVUx6N2se6DMa9pNePshao3EPuix
         EqFiOcxqvKWXV3EEfPnVO4ThZKWttATpxDtYLgMwwUWcKTVeqr9ZkdSpfMkfidQo9U09
         WFw28/PKEsU3gkNwkIhVhHfTUhFQ55Wftkw2k+9srL+3r+/G4jTDumzZ8FZu1s35P/z5
         WQzmdu52KWYeyu9oF9dvXTivXpVcFLHD3rnk7K7Jo43p1F1QMbr6vW5t0P8BHl8OsPxz
         naMA==
X-Received: by 10.66.148.136 with SMTP id ts8mr6881298pab.12.1364013813397;
        Fri, 22 Mar 2013 21:43:33 -0700 (PDT)
Received: from lanh ([115.74.37.60])
        by mx.google.com with ESMTPS id ce16sm5554488pac.5.2013.03.22.21.43.29
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 21:43:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 23 Mar 2013 11:43:32 +0700
Content-Disposition: inline
In-Reply-To: <20130323041824.GA11142@lanh>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218885>

On Sat, Mar 23, 2013 at 11:18:24AM +0700, Duy Nguyen wrote:
> You can use nwildmatch() from this patch. I tested it lightly with
> t3070-wildmatch.sh, feeding the strings with no terminating NUL. It
> seems to work ok.

And valgrind spotted my faults, especially for using strchr. You would
need this on top:

-- 8< --
diff --git a/wildmatch.c b/wildmatch.c
index f97ae2a..939bac8 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -61,9 +61,13 @@ static int dowild(const uchar *p, const uchar *text,
 	for ( ; (p_ch = *p) != '\0'; text++, p++) {
 		int matched, match_slash, negated;
 		uchar t_ch, prev_ch;
-		if (text >= textend && p_ch != '*')
-			return WM_ABORT_ALL;
-		t_ch = *text;
+		if (text >= textend) {
+			if (p_ch != '*')
+				return WM_ABORT_ALL;
+			else
+				t_ch = '\0';
+		} else
+			t_ch = *text;
 		if ((flags & WM_CASEFOLD) && ISUPPER(t_ch))
 			t_ch = tolower(t_ch);
 		if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
@@ -115,8 +119,9 @@ static int dowild(const uchar *p, const uchar *text,
 				/* Trailing "**" matches everything.  Trailing "*" matches
 				 * only if there are no more slash characters. */
 				if (!match_slash) {
-					if (strchr((char*)text, '/') != NULL)
-						return WM_NOMATCH;
+					for (;text < textend; text++)
+						if (*text == '/')
+							return WM_NOMATCH;
 				}
 				return WM_MATCH;
 			} else if (!match_slash && *p == '/') {
@@ -125,10 +130,11 @@ static int dowild(const uchar *p, const uchar *text,
 				 * with WM_PATHNAME matches the next
 				 * directory
 				 */
-				const char *slash = strchr((char*)text, '/');
-				if (!slash)
+				for (;text < textend; text++)
+					if (*text == '/')
+						break;
+				if (text == textend)
 					return WM_NOMATCH;
-				text = (const uchar*)slash;
 				/* the slash is consumed by the top-level for loop */
 				break;
 			}
@@ -151,7 +157,7 @@ static int dowild(const uchar *p, const uchar *text,
 							t_ch = tolower(t_ch);
 						if (t_ch == p_ch)
 							break;
-						t_ch = *++text;
+						t_ch = ++text < textend ? *text : '\0';
 					}
 					if (t_ch != p_ch)
 						return WM_NOMATCH;
-- 8< --
