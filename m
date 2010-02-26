From: Adam Simpkins <simpkins@facebook.com>
Subject: [PATCH] prune: honor --expire=never
Date: Fri, 26 Feb 2010 13:59:16 -0800
Message-ID: <20100226215916.GF5116@facebook.com>
Reply-To: Adam Simpkins <simpkins@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: <git@vger.kernel.org>, <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 00:42:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl9pS-0005al-24
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 00:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966588Ab0BZXmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 18:42:36 -0500
Received: from mailout-snc1.facebook.com ([69.63.179.25]:44171 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966562Ab0BZXmf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 18:42:35 -0500
X-Greylist: delayed 5798 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Feb 2010 18:42:34 EST
Received: from mail.thefacebook.com ([192.168.18.104])
	by pp01.snc1.tfbnw.net (8.14.3/8.14.3) with ESMTP id o1QLx3wh009308
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Fri, 26 Feb 2010 13:59:03 -0800
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.104) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 26 Feb
 2010 13:59:17 -0800
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1Nl8DM-0005ul-UJ; Fri, 26 Feb 2010 13:59:16 -0800
Mail-Followup-To: git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166
 definitions=2010-02-26_06:2010-02-06,2010-02-26,2010-02-25 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141160>

Previously, prune treated an expiration time of 0 to mean that no
expire argument was supplied, and everything should be pruned.  As a
result, "prune --expire=never" would prune all unreachable objects,
regardless of their timestamps.

prune can be called with --expire=never automatically by gc, when the
gc.pruneExpire configuration is set to "never".

Signed-off-by: Adam Simpkins <simpkins@facebook.com>
---
 builtin-prune.c  |    7 +++++--
 t/t5304-prune.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index 4675f60..ce43271 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -7,6 +7,8 @@
 #include "parse-options.h"
 #include "dir.h"
 
+#define ALWAYS_EXPIRE ((unsigned int)-1)
+
 static const char * const prune_usage[] = {
 	"git prune [-n] [-v] [--expire <time>] [--] [<head>...]",
 	NULL
@@ -18,7 +20,7 @@ static unsigned long expire;
 static int prune_tmp_object(const char *path, const char *filename)
 {
 	const char *fullpath = mkpath("%s/%s", path, filename);
-	if (expire) {
+	if (expire != ALWAYS_EXPIRE) {
 		struct stat st;
 		if (lstat(fullpath, &st))
 			return error("Could not stat '%s'", fullpath);
@@ -34,7 +36,7 @@ static int prune_tmp_object(const char *path, const char *filename)
 static int prune_object(char *path, const char *filename, const unsigned char *sha1)
 {
 	const char *fullpath = mkpath("%s/%s", path, filename);
-	if (expire) {
+	if (expire != ALWAYS_EXPIRE) {
 		struct stat st;
 		if (lstat(fullpath, &st))
 			return error("Could not stat '%s'", fullpath);
@@ -139,6 +141,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	};
 	char *s;
 
+	expire = ALWAYS_EXPIRE;
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
