From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] Revised - git-daemon extra paranoia
Date: Tue, 18 Oct 2005 15:13:28 -0700
Message-ID: <43557388.2060508@zytor.com>
References: <435560F7.4080006@zytor.com> <7vll0qploy.fsf@assigned-by-dhcp.cox.net> <4355691D.2010200@zytor.com> <43557254.3010807@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070000070609090106050209"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 00:15:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERziY-0005A3-SQ
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 00:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVJRWN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 18:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVJRWN4
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 18:13:56 -0400
Received: from terminus.zytor.com ([192.83.249.54]:34745 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932175AbVJRWNz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 18:13:55 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9IMDXo2009176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Oct 2005 15:13:36 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43557254.3010807@zytor.com>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10237>

This is a multi-part message in MIME format.
--------------070000070609090106050209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds some extra paranoia to the git-daemon filename test.  In 
particular, it now rejects pathnames containing //; it also adds a 
redundant test for pathname absoluteness (belts and suspenders.)

A single / at the end of the path is still permitted, however.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------070000070609090106050209
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -80,17 +80,29 @@ static int path_ok(const char *dir)
 {
 	const char *p = dir;
 	char **pp;
-	int sl = 1, ndot = 0;
+	int sl, ndot;
+
+	/* The pathname here should be an absolute path. */
+	if ( *p++ != '/' )
+		return 0;
+
+	sl = 1;  ndot = 0;
 
 	for (;;) {
 		if ( *p == '.' ) {
 			ndot++;
-		} else if ( *p == '/' || *p == '\0' ) {
+		} else if ( *p == '\0' ) {
+			/* Reject "." and ".." at the end of the path */
 			if ( sl && ndot > 0 && ndot < 3 )
-				return 0; /* . or .. in path */
+				return 0;
+
+			/* Otherwise OK */
+			break;
+		} else if ( *p == '/' ) {
+			/* Refuse "", "." or ".." */
+			if ( sl && ndot < 3 )
+				return 0;
 			sl = 1;
-			if ( *p == '\0' )
-				break; /* End of string and all is good */
 		} else {
 			sl = ndot = 0;
 		}

--------------070000070609090106050209--
