From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Pure renames/copies
Date: Mon, 21 Nov 2005 14:17:12 -0800
Message-ID: <43824768.2070207@zytor.com>
References: <87hda61a80.fsf@gmail.com>	<Pine.LNX.4.64.0511211020130.13959@g5.osdl.org>	<7vacfxrdao.fsf@assigned-by-dhcp.cox.net> <438235AA.8070805@zytor.com>	<7vpsotofd0.fsf@assigned-by-dhcp.cox.net> <43823E31.2050500@zytor.com> <7vd5ktoe52.fsf@assigned-by-dhcp.cox.net> <438245CF.9030501@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070601020608070701070108"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 23:20:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJys-0008TZ-Pm
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 23:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVKUWRi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 17:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVKUWRh
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 17:17:37 -0500
Received: from terminus.zytor.com ([192.83.249.54]:43672 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751168AbVKUWRg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 17:17:36 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jALMHHte031987
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Nov 2005 14:17:17 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <438245CF.9030501@zytor.com>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12497>

This is a multi-part message in MIME format.
--------------070601020608070701070108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Better variant, which handles stuff like "4.5%" and rejects 
"192.168.0.1".  Additionally, make sure numbers are unsigned (I'm making 
them unsigned long just for the hell of it), to make sure that 
artificial wraparound scenarios don't cause harm.

	-hpa


--------------070601020608070701070108
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --git a/diff.c b/diff.c
index 0391e8c..ffe8a55 100644
--- a/diff.c
+++ b/diff.c
@@ -838,16 +838,29 @@ int diff_opt_parse(struct diff_options *
 
 static int parse_num(const char **cp_p)
 {
-	int num, scale, ch, cnt;
+	unsigned long num, scale;
+	int ch, dot;
 	const char *cp = *cp_p;
 
-	cnt = num = 0;
+	num = 0;
 	scale = 1;
-	while ('0' <= (ch = *cp) && ch <= '9') {
-		if (cnt++ < 5) {
-			/* We simply ignore more than 5 digits precision. */
-			scale *= 10;
-			num = num * 10 + ch - '0';
+	dot = 0;
+	for(;;) {
+		ch = *cp;
+		if ( !dot && ch == '.' ) {
+			scale = 1;
+			dot = 1;
+		} else if ( ch == '%' ) {
+			scale = dot ? scale*100 : 100;
+			cp++;	/* % is always at the end */
+			break;
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
@@ -856,7 +869,7 @@ static int parse_num(const char **cp_p)
 	/* user says num divided by scale and we say internally that
 	 * is MAX_SCORE * num / scale.
 	 */
-	return (MAX_SCORE * num / scale);
+	return (num >= scale) ? MAX_SCORE : (MAX_SCORE * num / scale);
 }
 
 int diff_scoreopt_parse(const char *opt)

--------------070601020608070701070108--
