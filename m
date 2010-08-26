From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 2/8] Make rev-list --objects work together with pathspecs
Date: Thu, 26 Aug 2010 00:21:45 -0600
Message-ID: <1282803711-10253-3-git-send-email-newren@gmail.com>
References: <1282803711-10253-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 08:20:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVpT-0002cj-U4
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 08:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350Ab0HZGU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 02:20:29 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34823 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab0HZGU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 02:20:26 -0400
Received: by mail-yx0-f174.google.com with SMTP id 6so511700yxg.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 23:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Hlxvx27ZFfnxLBHgHXQr3f3RhbxTvSAMwq+NOs4dhuU=;
        b=fPpphV9alOp9Ai5W/8swhDImAM2Qbv5RnNLZLPzAlRVvafd9kpgH20Hcjx0qKPDjrk
         cevjz5XlZ8x9SMXgIRfAn1WvmMppm70z6LZgtVPP9gtZlqKCQ5loXwMWjd85rrcYqsBS
         WHPR3m3afC5Mr2ie+Luykv7yjWnWfVkgjHWMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UFfFZQbX+JqkpIqfX4ll98UUg8bQW+yX5YvI3sVF3hpFtL8XUxxAvtOuWayTRG4QQt
         7nFrn9WjcOMjOSg3AxTlCEvGh3tQhZKFEQ4kVl7ccWQHMOLMQYK+QFZG5gxyEF8sX2kR
         Uxnh0FdKXu2F63I5+0rvuf0CaaMtnO0Yasxrw=
Received: by 10.150.69.11 with SMTP id r11mr9709411yba.446.1282803626350;
        Wed, 25 Aug 2010 23:20:26 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t20sm7160156ybm.5.2010.08.25.23.20.24
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 23:20:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.45.ga60f
In-Reply-To: <1282803711-10253-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154519>

When traversing commits, the selection of commits would heed the list of
pathspecs passed, but subsequent walking of the trees of those commits
would not.  This resulted in 'rev-list --objects HEAD -- <paths>'
displaying objects at unwanted paths.

Have process_tree() call tree_entry_interesting() to determine which paths
are interesting and should be walked.

Naturally, this change can provide a large speedup when paths are specified
together with --objects, since many tree entries are now correctly ignored.
Interestingly, though, this change also gives me a small (~1%) but
repeatable speedup even when no paths are specified with --objects.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.h                   |    1 +
 list-objects.c           |   27 ++++++++++++++++++++++++++-
 revision.c               |    8 ++++++--
 revision.h               |    3 ++-
 t/t6000-rev-list-misc.sh |    6 +++---
 tree-diff.c              |    2 +-
 6 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/diff.h b/diff.h
index 6fff024..35130b8 100644
--- a/diff.h
+++ b/diff.h
@@ -169,6 +169,7 @@ extern int diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 			  const char *base, struct diff_options *opt);
 extern int diff_root_tree_sha1(const unsigned char *new, const char *base,
                                struct diff_options *opt);
+extern int tree_entry_interesting(struct tree_desc *desc, const char *base, int baselen, struct diff_options *opt);
 
 struct combine_diff_path {
 	struct combine_diff_path *next;
diff --git a/list-objects.c b/list-objects.c
index 8953548..bb95962 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -67,6 +67,9 @@ static void process_tree(struct rev_info *revs,
 	struct tree_desc desc;
 	struct name_entry entry;
 	struct name_path me;
+	int all_interesting = (revs->diffopt.nr_paths == 0);
+	char *full_prefix = NULL;
+	int full_prefix_len = 0;
 
 	if (!revs->tree_objects)
 		return;
@@ -82,9 +85,30 @@ static void process_tree(struct rev_info *revs,
 	me.elem = name;
 	me.elem_len = strlen(name);
 
+	if (!all_interesting) {
+		full_prefix = path_name_impl(path, name, 1);
+		full_prefix_len = strlen(full_prefix);
+	}
+
 	init_tree_desc(&desc, tree->buffer, tree->size);
 
-	while (tree_entry(&desc, &entry)) {
+	for (; desc.size; update_tree_entry(&desc)) {
+		entry = desc.entry;
+
+		if (!all_interesting) {
+			int showit = tree_entry_interesting(&desc,
+							    full_prefix,
+							    full_prefix_len,
+							    &revs->diffopt);
+
+			if (showit < 0)
+				break;
+			else if (!showit)
+				continue;
+			else if (showit == 2)
+				all_interesting = 1;
+		}
+
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
 				     lookup_tree(entry.sha1),
@@ -97,6 +121,7 @@ static void process_tree(struct rev_info *revs,
 				     lookup_blob(entry.sha1),
 				     show, &me, entry.path);
 	}
+	free(full_prefix);
 	free(tree->buffer);
 	tree->buffer = NULL;
 }
diff --git a/revision.c b/revision.c
index 7e82efd..64d8316 100644
--- a/revision.c
+++ b/revision.c
@@ -16,7 +16,7 @@
 
 volatile show_early_output_fn_t show_early_output;
 
-char *path_name(const struct name_path *path, const char *name)
+char *path_name_impl(const struct name_path *path, const char *name, int isdir)
 {
 	const struct name_path *p;
 	char *n, *m;
@@ -27,7 +27,7 @@ char *path_name(const struct name_path *path, const char *name)
 		if (p->elem_len)
 			len += p->elem_len + 1;
 	}
-	n = xmalloc(len);
+	n = xmalloc(len + !!isdir);
 	m = n + len - (nlen + 1);
 	strcpy(m, name);
 	for (p = path; p; p = p->up) {
@@ -37,6 +37,10 @@ char *path_name(const struct name_path *path, const char *name)
 			m[p->elem_len] = '/';
 		}
 	}
+	if (isdir && len > 1) {
+		n[len-1] = '/';
+		n[len] = '\0';
+	}
 	return n;
 }
 
diff --git a/revision.h b/revision.h
index 36fdf22..5ecbeb0 100644
--- a/revision.h
+++ b/revision.h
@@ -172,7 +172,8 @@ struct name_path {
 	const char *elem;
 };
 
-char *path_name(const struct name_path *path, const char *name);
+char *path_name_impl(const struct name_path *path, const char *name, int isdir);
+#define path_name(path, name) path_name_impl(path, name, 0)
 
 extern void add_object(struct object *obj,
 		       struct object_array *p,
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index a298f0d..b6a7c9c 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -11,13 +11,13 @@ test_expect_success setup '
 	git commit -mone
 '
 
-test_expect_failure 'rev-list --objects heeds pathspecs' '
+test_expect_success 'rev-list --objects heeds pathspecs' '
 	git rev-list --objects HEAD -- wanted_file >output &&
 	grep wanted_file output &&
 	! grep unwanted_file output
 '
 
-test_expect_failure 'rev-list --objects with pathspecs and deeper paths' '
+test_expect_success 'rev-list --objects with pathspecs and deeper paths' '
 	mkdir foo &&
 	> foo/file &&
 	git add foo/file &&
@@ -31,7 +31,7 @@ test_expect_failure 'rev-list --objects with pathspecs and deeper paths' '
 	! grep unwanted_file output
 '
 
-test_expect_failure 'rev-list --objects with pathspecs and copied files' '
+test_expect_success 'rev-list --objects with pathspecs and copied files' '
 	git checkout --orphan junio-testcase &&
 	git rm -rf . &&
 
diff --git a/tree-diff.c b/tree-diff.c
index cd659c6..2fb670b 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -91,7 +91,7 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
  *  - zero for no
  *  - negative for "no, and no subsequent entries will be either"
  */
-static int tree_entry_interesting(struct tree_desc *desc, const char *base, int baselen, struct diff_options *opt)
+int tree_entry_interesting(struct tree_desc *desc, const char *base, int baselen, struct diff_options *opt)
 {
 	const char *path;
 	const unsigned char *sha1;
-- 
1.7.2.2.45.ga60f
