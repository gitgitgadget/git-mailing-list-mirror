From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH v2 1/1] clone: replace relative paths in the alternates
Date: Mon, 22 Aug 2011 17:05:57 +0800
Message-ID: <1314003957-9455-2-git-send-email-jason77.wang@gmail.com>
References: <1314003957-9455-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 22 11:06:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvQSN-0004ND-9G
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 11:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864Ab1HVJGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 05:06:00 -0400
Received: from mail.windriver.com ([147.11.1.11]:59602 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab1HVJF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 05:05:59 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p7M95vkW001145
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 22 Aug 2011 02:05:57 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.220) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Mon, 22 Aug 2011 02:05:56 -0700
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1314003957-9455-1-git-send-email-jason77.wang@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179853>

When we clone a local source repository to a new local destination
repository without "--shared" option, if source repository has
relative path in the alternates, the clone will fail.

The root cause is when cloning local source repository to local
destination repository, the alternates of the source repository
will be copied to the destination repository, the relative path in
the alternates is source repository to base repository rather than
destination repository to base repository, so the destination
repository get a wrong relative path in the alternates, this will
cause errors when refer to base repository in the destination
repository.

To fix it, adding a function update_alt_rel_path() to replace all
relative paths to absolute paths in the alternates of the destination
repository before destination repository use those paths to look for
the base repository.

Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
 builtin/clone.c |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 cache.h         |    1 +
 sha1_file.c     |   11 +++++++++++
 3 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 7663bc2..7b5e603 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -286,6 +286,50 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 	closedir(dir);
 }
 
+/*
+ * This function is called by clone_local() of clone.c
+ * If alternates in the src_repo (source repository) has relative path,
+ * call this function will replace the relative path to absolute path
+ * in the des_repo (destination repository) alternates.
+ */
+static void update_alt_rel_path(const char *src_repo)
+{
+	int need_update = 0;
+	FILE *ifp;
+	struct strbuf istr = STRBUF_INIT;
+	struct strbuf ostr = STRBUF_INIT;
+
+	ifp = fopen(git_path("objects/info/alternates"), "r");
+	if (!ifp)
+		return;
+
+	while (strbuf_getline(&istr, ifp, '\n') != EOF) {
+		/* comment line, empty line or absolute path line */
+		if (istr.buf[0] == '#' || istr.len == 0 || is_absolute_path(istr.buf)) {
+			strbuf_add(&ostr, istr.buf, istr.len);
+			strbuf_add(&ostr, "\n", 1);
+		} else {
+			char *abs_path, abs_buf[PATH_MAX];
+			int len;
+
+			abs_path = mkpath("%s/objects/%s", src_repo, istr.buf);
+			normalize_path_copy(abs_buf, abs_path);
+			len = strlen(abs_buf);
+			strbuf_add(&ostr, abs_buf, len);
+			strbuf_add(&ostr, "\n", 1);
+			need_update = 1;
+		}
+	}
+
+	fclose(ifp);
+
+	if (need_update)
+		update_alternates_file_content(ostr.buf);
+
+	strbuf_release(&istr);
+	strbuf_release(&ostr);
+}
+
 static const struct ref *clone_local(const char *src_repo,
 				     const char *dest_repo)
 {
@@ -303,8 +347,9 @@ static const struct ref *clone_local(const char *src_repo,
 		copy_or_link_directory(&src, &dest);
 		strbuf_release(&src);
 		strbuf_release(&dest);
-	}
 
+		update_alt_rel_path(src_repo);
+	}
 	remote = remote_get(src_repo);
 	transport = transport_get(remote, src_repo);
 	ret = transport_get_remote_refs(transport);
diff --git a/cache.h b/cache.h
index fcf4501..d81c0f0 100644
--- a/cache.h
+++ b/cache.h
@@ -913,6 +913,7 @@ extern struct alternate_object_database {
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
 extern void add_to_alternates_file(const char *reference);
+extern void update_alternates_file_content(const char *content);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern void foreach_alt_odb(alt_odb_fn, void*);
 
diff --git a/sha1_file.c b/sha1_file.c
index d5616dc..dae7bf6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -388,6 +388,17 @@ void add_to_alternates_file(const char *reference)
 		link_alt_odb_entries(alt, alt + strlen(alt), '\n', NULL, 0);
 }
 
+void update_alternates_file_content(const char *content)
+{
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	int fd = hold_lock_file_for_update(lock, git_path("objects/info/alternates"), LOCK_DIE_ON_ERROR);
+	write_or_die(fd, content, strlen(content));
+	if (commit_lock_file(lock))
+		die("could not close alternates file");
+	if (alt_odb_tail)
+		link_alt_odb_entries(content, content + strlen(content), '\n', NULL, 0);
+}
+
 void foreach_alt_odb(alt_odb_fn fn, void *cb)
 {
 	struct alternate_object_database *ent;
-- 
1.7.6
