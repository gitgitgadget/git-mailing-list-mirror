From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/4] Use git_mkstemp_mode and xmkstemp_mode in odb_mkstemp, not chmod later.
Date: Fri, 19 Feb 2010 17:33:27 +0100
Message-ID: <1266597207-32036-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 17:37:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiVrT-0008N8-V2
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 17:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab0BSQhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 11:37:47 -0500
Received: from imag.imag.fr ([129.88.30.1]:40414 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863Ab0BSQhq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 11:37:46 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o1JGXdDG021256
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 19 Feb 2010 17:33:39 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NiVnO-0006F6-IF; Fri, 19 Feb 2010 17:33:38 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NiVnO-0008Ll-H9; Fri, 19 Feb 2010 17:33:38 +0100
X-Mailer: git-send-email 1.7.0.rc2.4.gc602c4
In-Reply-To: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 19 Feb 2010 17:33:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140464>

We used to create 0600 files, and then use chmod to set the group and
other permission bits to the umask. This usually has the same effect
as a normal file creation with a umask.

But in the presence of ACLs, the group permission plays the role of
the ACL mask: the "g" bits of newly created files are chosen according
to default ACL mask of the directory, not according to the umask, and
doing a chmod() on these "g" bits affect the ACL's mask instead of
actual group permission.

In other words, creating files with 0600 and then doing a chmod to the
umask creates files which are unreadable by users allowed in the
default ACL. To create the files without breaking ACLs, we let the
umask do it's job at the file's creation time, and get rid of the
later chmod.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin-pack-objects.c |   18 ++----------------
 t/t1304-default-acl.sh |    2 +-
 wrapper.c              |   10 +++++++---
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e1d3adf..539e75d 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -464,9 +464,6 @@ static int write_one(struct sha1file *f,
 	return 1;
 }
 
-/* forward declaration for write_pack_file */
-static int adjust_perm(const char *path, mode_t mode);
-
 static void write_pack_file(void)
 {
 	uint32_t i = 0, j;
@@ -523,21 +520,17 @@ static void write_pack_file(void)
 		}
 
 		if (!pack_to_stdout) {
-			mode_t mode = umask(0);
 			struct stat st;
 			const char *idx_tmp_name;
 			char tmpname[PATH_MAX];
 
-			umask(mode);
-			mode = 0444 & ~mode;
-
 			idx_tmp_name = write_idx_file(NULL, written_list,
 						      nr_written, sha1);
 
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
 				 base_name, sha1_to_hex(sha1));
 			free_pack_by_name(tmpname);
-			if (adjust_perm(pack_tmp_name, mode))
+			if (adjust_shared_perm(pack_tmp_name))
 				die_errno("unable to make temporary pack file readable");
 			if (rename(pack_tmp_name, tmpname))
 				die_errno("unable to rename temporary pack file");
@@ -565,7 +558,7 @@ static void write_pack_file(void)
 
 			snprintf(tmpname, sizeof(tmpname), "%s-%s.idx",
 				 base_name, sha1_to_hex(sha1));
-			if (adjust_perm(idx_tmp_name, mode))
+			if (adjust_shared_perm(idx_tmp_name))
 				die_errno("unable to make temporary index file readable");
 			if (rename(idx_tmp_name, tmpname))
 				die_errno("unable to rename temporary index file");
@@ -2125,13 +2118,6 @@ static void get_object_list(int ac, const char **av)
 		loosen_unused_packed_objects(&revs);
 }
 
-static int adjust_perm(const char *path, mode_t mode)
-{
-	if (chmod(path, mode))
-		return -1;
-	return adjust_shared_perm(path);
-}
-
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 4ee44a1..b8e9c34 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -27,7 +27,7 @@ modebits () {
 	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
 }
 
-test_expect_failure 'git gc does not break ACLs with restrictive umask' '
+test_expect_success 'git gc does not break ACLs with restrictive umask' '
 	umask 077 &&
 	git gc &&
 	actual=$(modebits .git/objects/pack/*.pack) &&
diff --git a/wrapper.c b/wrapper.c
index 673762f..b2c784d 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -277,10 +277,14 @@ int git_inflate(z_streamp strm, int flush)
 int odb_mkstemp(char *template, size_t limit, const char *pattern)
 {
 	int fd;
-
+	/*
+	 * we let the umask do it's job, don't try to be more
+	 * restrictive.
+	 */
+	int mode = 0666;
 	snprintf(template, limit, "%s/%s",
 		 get_object_directory(), pattern);
-	fd = mkstemp(template);
+	fd = git_mkstemp_mode(template, mode);
 	if (0 <= fd)
 		return fd;
 
@@ -289,7 +293,7 @@ int odb_mkstemp(char *template, size_t limit, const char *pattern)
 	snprintf(template, limit, "%s/%s",
 		 get_object_directory(), pattern);
 	safe_create_leading_directories(template);
-	return xmkstemp(template);
+	return xmkstemp_mode(template, mode);
 }
 
 int odb_pack_keep(char *name, size_t namesz, unsigned char *sha1)
-- 
1.7.0.rc2.4.gc602c4
