From: Esben Mose Hansen <kde@mosehansen.dk>
Subject: [PATCH] git_odb_open ckeck for valid path to database
Date: Fri,  6 Nov 2009 13:32:09 +0100
Message-ID: <1257510729-6803-1-git-send-email-kde@mosehansen.dk>
Cc: git@vger.kernel.org, Esben Mose Hansen <kde@mosehansen.dk>
To: ae@op5.com
X-From: git-owner@vger.kernel.org Fri Nov 06 13:39:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6O6I-0005JR-Hl
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 13:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871AbZKFMjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 07:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756237AbZKFMjV
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 07:39:21 -0500
Received: from 1503033659.dong.dbnet.dk ([89.150.121.59]:32950 "EHLO
	mosehansen.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330AbZKFMjU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 07:39:20 -0500
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2009 07:39:20 EST
Received: from localhost.localdomain (unknown [192.168.0.6])
	by mosehansen.dk (Postfix) with ESMTPSA id DF813BFA051;
	Fri,  6 Nov 2009 13:32:23 +0100 (CET)
X-Mailer: git-send-email 1.6.3.3
X-MailScanner-ID: DF813BFA051.D141B
X-mosehansen.dk-MailScanner: Found to be clean
X-mosehansen.dk-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-4.399, required 6, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -2.60)
X-mosehansen.dk-MailScanner-From: kde@mosehansen.dk
MailScanner-NULL-Check: 1258115546.67491@zs5kzDGBqtWWLWihskWp9g
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132298>

---
 src/errors.c                |    1 +
 src/git/common.h            |    3 +++
 src/odb.c                   |   13 +++++++++++++
 tests/t0204-opendb_errors.c |   38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100644 tests/t0204-opendb_errors.c

diff --git a/src/errors.c b/src/errors.c
index f348997..074c01c 100644
--- a/src/errors.c
+++ b/src/errors.c
@@ -36,6 +36,7 @@ static struct {
 	{ GIT_ENOTOID, "Not a git oid" },
 	{ GIT_ENOTFOUND, "Object does not exist in the scope searched" },
 	{ GIT_ENOMEM, "Not enough space" },
+	{ GIT_ENOTDIR, "Not a directory" }
 };
 
 const char *git_strerror(int num)
diff --git a/src/git/common.h b/src/git/common.h
index c470e0e..96f2971 100644
--- a/src/git/common.h
+++ b/src/git/common.h
@@ -65,6 +65,9 @@
 /** Consult the OS error information. */
 #define GIT_EOSERR (GIT_ERROR - 4)
 
+/** The path is not a directory */
+#define GIT_ENOTDIR (GIT_ERROR - 5)
+
 GIT_BEGIN_DECL
 
 /** A revision traversal pool. */
diff --git a/src/odb.c b/src/odb.c
index 6d646a4..89d6d03 100644
--- a/src/odb.c
+++ b/src/odb.c
@@ -30,6 +30,10 @@
 #include "hash.h"
 #include "odb.h"
 
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
 #define GIT_PACK_NAME_MAX (5 + 40 + 1)
 struct git_pack {
 	git_odb *db;
@@ -1023,6 +1027,15 @@ int git_odb_open(git_odb **out, const char *objects_dir)
 		free(db);
 		return GIT_ERROR;
 	}
+	struct stat objects_dir_stat;
+	if (stat(db->objects_dir, &objects_dir_stat)) {
+		free(db);
+		return GIT_EOSERR;
+	}
+	if (!S_ISDIR(objects_dir_stat.st_mode)) {
+		free(db);
+		return GIT_ENOTDIR;
+	}
 
 	gitlck_init(&db->lock);
 
diff --git a/tests/t0204-opendb_errors.c b/tests/t0204-opendb_errors.c
new file mode 100644
index 0000000..e9b52c9
--- /dev/null
+++ b/tests/t0204-opendb_errors.c
@@ -0,0 +1,38 @@
+#include "test_lib.h"
+#include "test_helpers.h"
+#include <git/odb.h>
+#include "fileops.h"
+
+static char *odb_dir = "test-objects";
+
+static unsigned char one_bytes[] = {
+    0x31, 0x78, 0x9c, 0xe3, 0x02, 0x00, 0x00, 0x0b,
+    0x00, 0x0b,
+};
+
+static unsigned char one_data[] = {
+    0x0a,
+};
+
+static object_data one = {
+    one_bytes,
+    sizeof(one_bytes),
+    "8b137891791fe96927ad78e64b0aad7bded08bdc",
+    "blob",
+    "test-objects/8b",
+    "test-objects/8b/137891791fe96927ad78e64b0aad7bded08bdc",
+    one_data,
+    sizeof(one_data),
+};
+
+BEGIN_TEST(opendb_errors)
+    git_odb *db;
+    int error = git_odb_open(&db, odb_dir);
+    must_be_true(error == GIT_EOSERR);
+    must_be_true(errno == ENOENT);
+    must_pass(write_object_files(odb_dir, &one));
+    error = git_odb_open(&db, one.file);
+    must_be_true(error == GIT_ENOTDIR);
+
+    must_pass(remove_object_files(odb_dir, &one));
+END_TEST
-- 
1.6.3.3
