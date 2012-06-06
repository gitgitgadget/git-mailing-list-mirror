From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] ls-files -i: pay attention to exclusion of leading paths
Date: Tue,  5 Jun 2012 22:45:14 -0700
Message-ID: <1338961519-30970-2-git-send-email-gitster@pobox.com>
References: <1338961519-30970-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 07:46:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc94L-0002JF-KL
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 07:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743Ab2FFFpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 01:45:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45577 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894Ab2FFFpY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 01:45:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36BDB5FF7
	for <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Qn0o
	y3K3OB+ssi8wy3oVZGyNFFY=; b=oBh0CCD3/aGXSJ0NrCDv0K3BR0me+tB+CJyo
	RSzPCSmyzy+CFmjrvq4y1+qc84Ht0luUvfZ8V7QD6+pSxNaWUK9PbKPxSs3wxu6M
	oOF4LJ8EJwWdfx1HDj3AYU71k3ZfxB8w7EcI1/ZO5DcOHR/1DE7vxfHW768/UshO
	zLJ6I74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=XoBY0H
	FZAiM16Z91PgRjj2/RgtZg+M60icLb7pNNtjSlPGK3PwLGGttbO2g7e5Fg052TGx
	6lZAQKfJV0dxlUxqFm4q7mLtKaEKwz1BDw6IwhYOWPOaeymr+kPRdgAH9QI1iFQr
	sv8DADKJ6agMWO6ZgVWIn09oYNoHqSTiEaUic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E8AE5FF6
	for <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 760AB5FEA for
 <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:22 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc1.37.g09843ac
In-Reply-To: <1338961519-30970-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CEAA8A60-AF9A-11E1-9540-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199299>

"git ls-files --exclude=t/ -i" does not show paths in directory t/
that have been added to the index, but it should.

The excluded() API was designed for callers who walk the tree from
the top, checking each level of the directory hierarchy as it
descends if it is excluded, and not even bothering to recurse into
an excluded directory.  This would allow us optimize for a common
case by not having to check if the exclude pattern "foo/" matches
when looking at "foo/bar", because the caller should have noticed
that "foo" is excluded and did not even bother to read "foo/bar"
out of opendir()/readdir() to call it.

The code for "ls-files -i" however walks the index linearly, feeding
paths without checking if the leading directory is already excluded.

Introduce a helper function path_excluded() to let this caller
properly call excluded() check for higher hierarchies as necessary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-files.c | 17 +++++++++++------
 dir.c              | 32 ++++++++++++++++++++++++++++++++
 dir.h              | 16 ++++++++++++++++
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7cff175..90dc360 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -203,6 +203,10 @@ static void show_ru_info(void)
 static void show_files(struct dir_struct *dir)
 {
 	int i;
+	struct path_exclude_check check;
+
+	if ((dir->flags & DIR_SHOW_IGNORED))
+		path_exclude_check_init(&check, dir);
 
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
@@ -215,9 +219,8 @@ static void show_files(struct dir_struct *dir)
 	if (show_cached | show_stage) {
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
-			int dtype = ce_to_dtype(ce);
-			if (dir->flags & DIR_SHOW_IGNORED &&
-			    !excluded(dir, ce->name, &dtype))
+			if ((dir->flags & DIR_SHOW_IGNORED) &&
+			    !path_excluded(&check, ce))
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
@@ -232,9 +235,8 @@ static void show_files(struct dir_struct *dir)
 			struct cache_entry *ce = active_cache[i];
 			struct stat st;
 			int err;
-			int dtype = ce_to_dtype(ce);
-			if (dir->flags & DIR_SHOW_IGNORED &&
-			    !excluded(dir, ce->name, &dtype))
+			if ((dir->flags & DIR_SHOW_IGNORED) &&
+			    !path_excluded(&check, ce))
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
@@ -247,6 +249,9 @@ static void show_files(struct dir_struct *dir)
 				show_ce_entry(tag_modified, ce);
 		}
 	}
+
+	if ((dir->flags & DIR_SHOW_IGNORED))
+		path_exclude_check_clear(&check);
 }
 
 /*
diff --git a/dir.c b/dir.c
index 0a78d00..c3f0884 100644
--- a/dir.c
+++ b/dir.c
@@ -580,6 +580,38 @@ int excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
 	return 0;
 }
 
+void path_exclude_check_init(struct path_exclude_check *check,
+			     struct dir_struct *dir)
+{
+	check->dir = dir;
+	strbuf_init(&check->path, 256);
+}
+
+void path_exclude_check_clear(struct path_exclude_check *check)
+{
+	strbuf_release(&check->path);
+}
+
+int path_excluded(struct path_exclude_check *check, struct cache_entry *ce)
+{
+	int i, dtype;
+	struct strbuf *path = &check->path;
+
+	strbuf_setlen(path, 0);
+	for (i = 0; ce->name[i]; i++) {
+		int ch = ce->name[i];
+
+		if (ch == '/') {
+			dtype = DT_DIR;
+			if (excluded(check->dir, path->buf, &dtype))
+				return 1;
+		}
+		strbuf_addch(path, ch);
+	}
+	dtype = ce_to_dtype(ce);
+	return excluded(check->dir, ce->name, &dtype);
+}
+
 static struct dir_entry *dir_entry_new(const char *pathname, int len)
 {
 	struct dir_entry *ent;
diff --git a/dir.h b/dir.h
index dd6947e..7378e69 100644
--- a/dir.h
+++ b/dir.h
@@ -1,6 +1,8 @@
 #ifndef DIR_H
 #define DIR_H
 
+#include "strbuf.h"
+
 struct dir_entry {
 	unsigned int len;
 	char name[FLEX_ARRAY]; /* more */
@@ -78,6 +80,20 @@ extern int excluded_from_list(const char *pathname, int pathlen, const char *bas
 			      int *dtype, struct exclude_list *el);
 extern int excluded(struct dir_struct *, const char *, int *);
 struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len);
+
+/*
+ * The excluded() API is meant for callers that check each level of leading
+ * directory hierarchies with excluded() to avoid recursing into excluded
+ * directories.  Callers that do not do so should use this API instead.
+ */
+struct path_exclude_check {
+	struct dir_struct *dir;
+	struct strbuf path;
+};
+extern void path_exclude_check_init(struct path_exclude_check *, struct dir_struct *);
+extern void path_exclude_check_clear(struct path_exclude_check *);
+extern int path_excluded(struct path_exclude_check *, struct cache_entry *);
+
 extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
 					  char **buf_p, struct exclude_list *which, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
-- 
1.7.11.rc1.37.g09843ac
