From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Pure renames/copies
Date: Mon, 21 Nov 2005 14:10:23 -0800
Message-ID: <438245CF.9030501@zytor.com>
References: <87hda61a80.fsf@gmail.com>	<Pine.LNX.4.64.0511211020130.13959@g5.osdl.org>	<7vacfxrdao.fsf@assigned-by-dhcp.cox.net> <438235AA.8070805@zytor.com>	<7vpsotofd0.fsf@assigned-by-dhcp.cox.net> <43823E31.2050500@zytor.com> <7vd5ktoe52.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070500060208030002050706"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 23:14:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJtB-0006AM-D3
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 23:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVKUWK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 17:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVKUWK4
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 17:10:56 -0500
Received: from terminus.zytor.com ([192.83.249.54]:52409 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751126AbVKUWKj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 17:10:39 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jALMARf6031860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Nov 2005 14:10:28 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5ktoe52.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12495>

This is a multi-part message in MIME format.
--------------070500060208030002050706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>Okay, in that post Linus suggests that -M without an argument should be 
>>== 100% (1.0), thus avoiding having to mess up the meaning of -M100 as 
>>0.100.  It seems like a really odd thing to have -M100 mean something 
>>that's completely out of line with the rest of the meaning.
> 
> True, but it might be too late to change that; I suspect people
> expect -M to do a bit more than pure renames by now.
> 

Okay, how about the following?  It lets both -M1.0 and -M100% work, 
while keeping everything else compatible, and avoiding artificial 
special cases.

	-hpa

--------------070500060208030002050706
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --git a/diff.c b/diff.c
index 0391e8c..df62d2b 100644
--- a/diff.c
+++ b/diff.c
@@ -843,11 +843,19 @@ static int parse_num(const char **cp_p)
 
 	cnt = num = 0;
 	scale = 1;
-	while ('0' <= (ch = *cp) && ch <= '9') {
-		if (cnt++ < 5) {
-			/* We simply ignore more than 5 digits precision. */
-			scale *= 10;
-			num = num * 10 + ch - '0';
+	for(;;) {
+		ch = *cp;
+		if ( ch == '.' ) {
+			scale = 1;
+		} else if ( ch == '%' ) {
+			scale = 100;
+		} else if ( ch >= '0' && ch <= '9' ) {
+			if ( scale < 100000 ) {
+				scale *= 10;
+				num = (num*10) + (ch-'0');
+			}
+		} else {
+			break;
 		}
 		cp++;
 	}
@@ -856,7 +864,7 @@ static int parse_num(const char **cp_p)
 	/* user says num divided by scale and we say internally that
 	 * is MAX_SCORE * num / scale.
 	 */
-	return (MAX_SCORE * num / scale);
+	return (num >= scale) ? MAX_SCORE : (MAX_SCORE * num / scale);
 }
 
 int diff_scoreopt_parse(const char *opt)

--------------070500060208030002050706--
