From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] git-daemon extra paranoia
Date: Tue, 18 Oct 2005 13:54:15 -0700
Message-ID: <435560F7.4080006@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090608030500080202070100"
X-From: git-owner@vger.kernel.org Tue Oct 18 22:56:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERyTz-0008CD-52
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 22:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbVJRUye (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 16:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbVJRUyd
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 16:54:33 -0400
Received: from terminus.zytor.com ([192.83.249.54]:24718 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751498AbVJRUy2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 16:54:28 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9IKsK47007529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Oct 2005 13:54:21 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10233>

This is a multi-part message in MIME format.
--------------090608030500080202070100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds some extra paranoia to the git-daemon filename test.  In 
particular, it now rejects pathnames containing // or ending with /; it 
also adds a redundant test for pathname absoluteness (belts and suspenders.)

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------090608030500080202070100
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

Extra paranoia about non-canonical pathnames

---
commit a22f643931e48a319a70af7e91f809648160ecbf
tree 9d6934089c2628253d0690efde3fa7f36a1a8861
parent 4aaa702794447d9b281dd22fe532fd61e02434e1
author Peter Anvin <hpa@tazenda.sc.orionmulti.com> Tue, 18 Oct 2005 13:51:45 -0700
committer Peter Anvin <hpa@tazenda.sc.orionmulti.com> Tue, 18 Oct 2005 13:51:45 -0700

 daemon.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -80,17 +80,25 @@ static int path_ok(const char *dir)
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
 		} else if ( *p == '/' || *p == '\0' ) {
-			if ( sl && ndot > 0 && ndot < 3 )
-				return 0; /* . or .. in path */
+			if ( sl && ndot < 3 )	/* Refuse "", "." or ".." */
+				return 0;
 			sl = 1;
+
+			/* If this was end of string, we passed all tests */
 			if ( *p == '\0' )
-				break; /* End of string and all is good */
+				break;
 		} else {
 			sl = ndot = 0;
 		}

--------------090608030500080202070100--
