From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH 1/1] clone: replace relative paths in the alternates
Date: Fri, 19 Aug 2011 13:23:16 +0800
Message-ID: <1313731396-10458-2-git-send-email-jason77.wang@gmail.com>
References: <1313731396-10458-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 07:23:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuHYF-000475-OF
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 07:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab1HSFXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 01:23:25 -0400
Received: from mail.windriver.com ([147.11.1.11]:38383 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab1HSFXW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 01:23:22 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p7J5NJSc005542
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 18 Aug 2011 22:23:19 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.220) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Thu, 18 Aug 2011 22:23:19 -0700
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1313731396-10458-1-git-send-email-jason77.wang@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179675>

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

update_alt_rel_path() is referred to link_alt_odb_entries() in the
sha1_file.c, update_alternates_file() is referred to
add_to_alternates_file() in the sha1_file.c.

Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
 builtin/clone.c |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 cache.h         |    1 +
 sha1_file.c     |   11 +++++++
 3 files changed, 95 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 7663bc2..65c1eaf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -286,6 +286,87 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 	closedir(dir);
 }
 
+#define linesize(end, start) (end - start + 1)
+/*
+ * This function is called by clone_local() of clone.c
+ * If alternates in the src_repo (source repository) has relative paths,
+ * call this function will replace the relative paths to absolute paths
+ * in the des_repo (destination repository) alternates.
+ */
+static void update_alt_rel_path(const char *src_repo)
+{
+	void *map;
+	size_t mapsz;
+	char *cp, *last, *ep, sep = '\n';
+	int fd, buf_start = 0, needwrite = 0;
+	char *tmpbuf;
+	struct stat st;
+
+	fd = open(git_path("objects/info/alternates"), O_RDONLY);
+	if (fd < 0)
+		return;
+
+	if (fstat(fd, &st) || (st.st_size == 0)) {
+		close(fd);
+		return;
+	}
+
+	mapsz = xsize_t(st.st_size);
+	map = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+
+	tmpbuf = mapsz > 4096 ? xmalloc(mapsz * 2) : xmalloc(mapsz + 4096);
+
+	ep = map + mapsz;
+	last = map;
+	buf_start = 0;
+	while (last < ep) {
+		cp = last;
+		if (cp < ep && *cp == '#') {
+			while (cp < ep && *cp != sep)
+				cp++;
+			memcpy(tmpbuf + buf_start, last, linesize(cp, last));
+			buf_start += linesize(cp, last);
+			last = cp + 1;
+			continue;
+		}
+		while (cp < ep && *cp != sep)
+			cp++;
+		if (last != cp) {
+			if (!is_absolute_path(last)) {
+				char *abs_path, *abs_buf;
+				int len;
+
+				needwrite = 1;
+				memcpy(tmpbuf + buf_start, last, linesize(cp, last));
+				tmpbuf[buf_start + linesize(cp, last)] = '\0';
+				abs_path = mkpath("%s/objects/%s", src_repo, tmpbuf + buf_start);
+				abs_buf = xmalloc(PATH_MAX);
+				normalize_path_copy(abs_buf, abs_path);
+				len = strlen(abs_buf);
+				memcpy(tmpbuf + buf_start, abs_buf, len);
+				free(abs_buf);
+				buf_start += len;
+			} else {
+				memcpy(tmpbuf + buf_start, last, linesize(cp, last));
+				buf_start += linesize(cp, last);
+			}
+		}
+		while (cp < ep && *cp == sep)
+			cp++;
+		last = cp;
+	}
+	tmpbuf[buf_start] = '\0';
+
+	if (needwrite)
+		update_alternates_file_content(tmpbuf);
+
+	munmap(map, mapsz);
+	free(tmpbuf);
+
+	return;
+}
+
 static const struct ref *clone_local(const char *src_repo,
 				     const char *dest_repo)
 {
@@ -303,8 +384,9 @@ static const struct ref *clone_local(const char *src_repo,
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
