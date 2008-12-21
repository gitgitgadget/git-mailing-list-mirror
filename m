From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] fast-import: add special mode; copy from parent.
Date: Sun, 21 Dec 2008 04:11:41 +0200
Message-ID: <1229825502-963-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 21 03:13:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEDov-00074a-7Q
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 03:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbYLUCLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 21:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbYLUCLr
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 21:11:47 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:37167 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbYLUCLq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 21:11:46 -0500
Received: by bwz14 with SMTP id 14so6034723bwz.13
        for <git@vger.kernel.org>; Sat, 20 Dec 2008 18:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=U/pTqkQwsO6pQNbSEC0+gStRCDLTbo2YpFouGRy5rQc=;
        b=noXpr0zqlfIR3HTDDao7CjRPqqgjys3vv1oUbxCzp0N/zq0+nKd65AeJX6oop/u18o
         SoFS3zkvEGtmitDW+n8zPePcraBsklGngrZB9I12pIdrV1xbSNvnKbKv7Tw7xLGl526M
         YWoEq0yqR6SYNbKoOIGO3GF8ilReD4bJsgdR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=gVWHOWwQ/zDgsaitryP5boMYfK/tvV+rscH3WTA1Agav8nEUszXHxdmy/VmkkPNhsi
         LvYX7sLP3SB01A96T9Q5IXv5jCj27x+gAkBzCL9wDFV01EmRohtaElyxXnS2O0hDrdOx
         juIFe4TO85+r1tYzdIappakXy9ryluNCssNUE=
Received: by 10.181.20.13 with SMTP id x13mr1708206bki.164.1229825504385;
        Sat, 20 Dec 2008 18:11:44 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id k29sm11691324fkk.3.2008.12.20.18.11.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Dec 2008 18:11:43 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6.3.g7ccbd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103680>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fast-import.txt |    1 +
 fast-import.c                     |   41 +++++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index c2f483a..9d4231e 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -484,6 +484,7 @@ in octal.  Git only supports the following modes:
 * `160000`: A gitlink, SHA-1 of the object refers to a commit in
   another repository. Git links can only be specified by SHA or through
   a commit mark. They are used to implement submodules.
+* `-`: A special mode; copy the parent's mode.
 
 In both formats `<path>` is the complete path of the file to be added
 (if not already existing) or modified (if already existing).
diff --git a/fast-import.c b/fast-import.c
index 3c035a5..a00d3fe 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1356,7 +1356,7 @@ static int tree_content_set(
 	struct tree_entry *root,
 	const char *p,
 	const unsigned char *sha1,
-	const uint16_t mode,
+	uint16_t mode,
 	struct tree_content *subtree)
 {
 	struct tree_content *t = root->tree;
@@ -1382,7 +1382,9 @@ static int tree_content_set(
 						&& e->versions[1].mode == mode
 						&& !hashcmp(e->versions[1].sha1, sha1))
 					return 0;
-				e->versions[1].mode = mode;
+				if (mode == S_IFREG)
+					mode = e->versions[0].mode;
+				e->versions[1].mode = (mode == S_IFREG) ? (S_IFREG | 0644) : mode;
 				hashcpy(e->versions[1].sha1, sha1);
 				if (e->tree)
 					release_tree_content_recursive(e->tree);
@@ -1417,7 +1419,7 @@ static int tree_content_set(
 		tree_content_set(e, slash1 + 1, sha1, mode, subtree);
 	} else {
 		e->tree = subtree;
-		e->versions[1].mode = mode;
+		e->versions[1].mode = (mode == S_IFREG) ? (S_IFREG | 0644) : mode;
 		hashcpy(e->versions[1].sha1, sha1);
 	}
 	hashclr(root->versions[1].sha1);
@@ -1862,20 +1864,25 @@ static void file_change_m(struct branch *b)
 	unsigned char sha1[20];
 	uint16_t mode, inline_data = 0;
 
-	p = get_mode(p, &mode);
-	if (!p)
-		die("Corrupt mode: %s", command_buf.buf);
-	switch (mode) {
-	case S_IFREG | 0644:
-	case S_IFREG | 0755:
-	case S_IFLNK:
-	case S_IFGITLINK:
-	case 0644:
-	case 0755:
-		/* ok */
-		break;
-	default:
-		die("Corrupt mode: %s", command_buf.buf);
+	if (!prefixcmp(p, "- ")) {
+		mode = 0;
+		p += 2;
+	} else {
+		p = get_mode(p, &mode);
+		if (!p)
+			die("Corrupt mode: %s", command_buf.buf);
+		switch (mode) {
+		case S_IFREG | 0644:
+		case S_IFREG | 0755:
+		case S_IFLNK:
+		case S_IFGITLINK:
+		case 0644:
+		case 0755:
+			/* ok */
+			break;
+		default:
+			die("Corrupt mode: %s", command_buf.buf);
+		}
 	}
 
 	if (*p == ':') {
-- 
1.6.0.6.3.g7ccbd
