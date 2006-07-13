From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] diff: Support 256 colors
Date: Thu, 13 Jul 2006 19:08:06 +0300
Message-ID: <20060713190806.4700b24c.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 18:11:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G13m8-0005Ep-UE
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 18:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWGMQKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 12:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWGMQKm
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 12:10:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:27170 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751430AbWGMQKl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 12:10:41 -0400
Received: by nf-out-0910.google.com with SMTP id p48so210754nfa
        for <git@vger.kernel.org>; Thu, 13 Jul 2006 09:10:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=aktogMODDvzom2SadiX97Ly1cCfCIlAr0NfKn8aJ+7AmRYeWWtd0TVaU/ILGqIRwri0IYbxk6GogH1wdo6JehqhCqgiFnUMcCEQqhsYCz3U5kkjWVcJXLIu/h2aeEu7glw1lbVAGwBDvG/S+7ESsvWBMoejWh9wqtgHeq15S354=
Received: by 10.49.15.4 with SMTP id s4mr1071664nfi;
        Thu, 13 Jul 2006 09:10:41 -0700 (PDT)
Received: from garlic.home.net ( [82.128.203.107])
        by mx.gmail.com with ESMTP id o9sm3420410nfa.2006.07.13.09.10.39;
        Thu, 13 Jul 2006 09:10:40 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.0; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23840>

Add support for more than 8 colors.  Colors can be specified as numbers
-1..255.  -1 is same as "normal".

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 diff.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index a9118a9..351cd07 100644
--- a/diff.c
+++ b/diff.c
@@ -26,8 +26,8 @@ enum color_diff {
 	DIFF_FILE_NEW = 5,
 };
 
-/* "\033[1;30;47m\0" is 11 bytes */
-static char diff_colors[][16] = {
+/* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
+static char diff_colors[][24] = {
 	"\033[m",	/* reset */
 	"",		/* normal */
 	"\033[1m",	/* bold */
@@ -57,12 +57,16 @@ static int parse_color(const char *name,
 		"normal", "black", "red", "green", "yellow",
 		"blue", "magenta", "cyan", "white"
 	};
+	char *end;
 	int i;
 	for (i = 0; i < ARRAY_SIZE(color_names); i++) {
 		const char *str = color_names[i];
 		if (!strncasecmp(name, str, len) && !str[len])
 			return i - 1;
 	}
+	i = strtol(name, &end, 10);
+	if (*name && !*end && i >= -1 && i <= 255)
+		return i;
 	return -2;
 }
 
@@ -135,14 +139,22 @@ static void parse_diff_color_value(const
 		if (fg >= 0) {
 			if (sep++)
 				*dst++ = ';';
-			*dst++ = '3';
-			*dst++ = '0' + fg;
+			if (fg < 8) {
+				*dst++ = '3';
+				*dst++ = '0' + fg;
+			} else {
+				dst += sprintf(dst, "38;5;%d", fg);
+			}
 		}
 		if (bg >= 0) {
 			if (sep++)
 				*dst++ = ';';
-			*dst++ = '4';
-			*dst++ = '0' + bg;
+			if (bg < 8) {
+				*dst++ = '4';
+				*dst++ = '0' + bg;
+			} else {
+				dst += sprintf(dst, "48;5;%d", bg);
+			}
 		}
 		*dst++ = 'm';
 	}
-- 
1.4.1.gd0c9d-dirty
