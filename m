From: Adam Simpkins <simpkins@facebook.com>
Subject: [PATCH 1/3] prune: honor --expire=never
Date: Fri, 26 Feb 2010 19:50:02 -0800
Message-ID: <1267242604-5215-1-git-send-email-simpkins@facebook.com>
References: <20100227012130.GA28452@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Adam Simpkins <simpkins@facebook.com>
To: <git@vger.kernel.org>, <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 04:52:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlDj0-0001L5-PG
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 04:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967764Ab0B0DwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 22:52:10 -0500
Received: from mailout-snc1.facebook.com ([69.63.179.25]:50250 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967749Ab0B0DwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 22:52:09 -0500
Received: from mail.thefacebook.com ([192.168.18.83])
	by pp01.snc1.tfbnw.net (8.14.3/8.14.3) with ESMTP id o1R3paEG004077
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Fri, 26 Feb 2010 19:51:38 -0800
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.83) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 26 Feb
 2010 19:50:30 -0800
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1NlDhG-0001Mp-Gn; Fri, 26 Feb 2010 19:50:30 -0800
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <20100227012130.GA28452@facebook.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166
 definitions=2010-02-27_02:2010-02-06,2010-02-27,2010-02-26 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141169>

Previously, prune treated an expiration time of 0 to mean that no
expire argument was supplied, and everything should be pruned.  As a
result, "prune --expire=never" would prune all unreachable objects,
regardless of their timestamp.

prune can be called with --expire=never automatically by gc, when the
gc.pruneExpire configuration is set to "never".

Signed-off-by: Adam Simpkins <simpkins@facebook.com>
---
 builtin-prune.c  |   25 +++++++++++--------------
 t/t5304-prune.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index 4675f60..f22bcf6 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -18,13 +18,11 @@ static unsigned long expire;
 static int prune_tmp_object(const char *path, const char *filename)
 {
 	const char *fullpath = mkpath("%s/%s", path, filename);
-	if (expire) {
-		struct stat st;
-		if (lstat(fullpath, &st))
-			return error("Could not stat '%s'", fullpath);
-		if (st.st_mtime > expire)
-			return 0;
-	}
+	struct stat st;
+	if (lstat(fullpath, &st))
+		return error("Could not stat '%s'", fullpath);
+	if (st.st_mtime > expire)
+		return 0;
 	printf("Removing stale temporary file %s\n", fullpath);
 	if (!show_only)
 		unlink_or_warn(fullpath);
@@ -34,13 +32,11 @@ static int prune_tmp_object(const char *path, const char *filename)
 static int prune_object(char *path, const char *filename, const unsigned char *sha1)
 {
 	const char *fullpath = mkpath("%s/%s", path, filename);
-	if (expire) {
-		struct stat st;
-		if (lstat(fullpath, &st))
-			return error("Could not stat '%s'", fullpath);
-		if (st.st_mtime > expire)
-			return 0;
-	}
+	struct stat st;
+	if (lstat(fullpath, &st))
+		return error("Could not stat '%s'", fullpath);
+	if (st.st_mtime > expire)
+		return 0;
 	if (show_only || verbose) {
 		enum object_type type = sha1_object_info(sha1, NULL);
 		printf("%s %s\n", sha1_to_hex(sha1),
@@ -139,6 +135,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	};
 	char *s;
 
+	expire = (unsigned long)-1;
 	save_commit_buffer = 0;
 	read_replace_refs = 0;
 	init_revisions(&revs, prefix);
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 3c6687a..e2ed13d 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -148,6 +148,38 @@ test_expect_success 'gc --prune=<date>' '
 
 '
 
+test_expect_success 'gc --prune=never' '
+
+	add_blob &&
+	git gc --prune=never &&
+	test -f $BLOB_FILE &&
+	git gc --prune=now &&
+	test ! -f $BLOB_FILE
+
+'
+
+test_expect_success 'gc respects gc.pruneExpire=never' '
+
+	git config gc.pruneExpire never &&
+	add_blob &&
+	git gc &&
+	test -f $BLOB_FILE &&
+	git config gc.pruneExpire now &&
+	git gc &&
+	test ! -f $BLOB_FILE
+
+'
+
+test_expect_success 'prune --expire=never' '
+
+	add_blob &&
+	git prune --expire=never &&
+	test -f $BLOB_FILE &&
+	git prune &&
+	test ! -f $BLOB_FILE
+
+'
+
 test_expect_success 'gc: prune old objects after local clone' '
 	add_blob &&
 	test-chmtime =-$((2*$week+1)) $BLOB_FILE &&
-- 
1.6.3.3
