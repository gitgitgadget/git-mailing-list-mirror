From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] dir: allow a BOM at the beginning of exclude files
Date: Thu, 16 Apr 2015 16:05:12 +0200
Message-ID: <1429193112-41184-1-git-send-email-cmn@elego.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 16:11:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YikW8-0008Tu-Ny
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 16:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbbDPOLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 10:11:40 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:60806 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753001AbbDPOLj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 10:11:39 -0400
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Apr 2015 10:11:38 EDT
Received: from cmartin.tk (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPA id A4CD480454
	for <git@vger.kernel.org>; Thu, 16 Apr 2015 16:05:12 +0200 (CEST)
Received: (nullmailer pid 41222 invoked by uid 1000);
	Thu, 16 Apr 2015 14:05:12 -0000
X-Mailer: git-send-email 2.0.0.5.gbce14aa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267288>

Some text editors like Notepad or LibreOffice write an UTF-8 BOM in
order to indicate that the file is Unicode text rather than whatever the
current locale would indicate.

If someone uses such an editor to edit a gitignore file, we are left
with those three bytes at the beginning of the file. If we do not skip
them, we will attempt to match a filename with the BOM as prefix, which
won't match the files the user is expecting.

---

If you're wondering how I came up with LibreOffice, I was doing a
workshop recently and one of the participants was not content with the
choice of vim or nano, so he opened LibreOffice to edit the gitignore
file with confusing consequences.

This codepath doesn't go as far as the config code in validating that
we do not have a partial BOM which would mean there's some invalid
content, but we don't really have invalid content any other way, as
we're just dealing with a list of paths in the file.

 dir.c                      | 8 +++++++-
 t/t7061-wtstatus-ignore.sh | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 0943a81..6368247 100644
--- a/dir.c
+++ b/dir.c
@@ -581,6 +581,7 @@ int add_excludes_from_file_to_list(const char *fname,
 	struct stat st;
 	int fd, i, lineno = 1;
 	size_t size = 0;
+	static const unsigned char *utf8_bom = (unsigned char *) "\xef\xbb\xbf";
 	char *buf, *entry;
 
 	fd = open(fname, O_RDONLY);
@@ -617,7 +618,12 @@ int add_excludes_from_file_to_list(const char *fname,
 	}
 
 	el->filebuf = buf;
-	entry = buf;
+
+	if (size >= 3 && !memcmp(buf, utf8_bom, 3))
+		entry = buf + 3;
+	else
+		entry = buf;
+
 	for (i = 0; i < size; i++) {
 		if (buf[i] == '\n') {
 			if (entry != buf + i && entry[0] != '#') {
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 460789b..0a06fbf 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -13,6 +13,8 @@ EOF
 
 test_expect_success 'status untracked directory with --ignored' '
 	echo "ignored" >.gitignore &&
+	sed -e "s/^/\xef\xbb\xbf/" .gitignore >.gitignore.new &&
+	mv .gitignore.new .gitignore &&
 	mkdir untracked &&
 	: >untracked/ignored &&
 	: >untracked/uncommitted &&
-- 
2.0.0.5.gbce14aa
