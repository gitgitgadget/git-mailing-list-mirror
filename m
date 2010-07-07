From: newren@gmail.com
Subject: [PATCHv3 5/6] fast-export: Fix output order of D/F changes
Date: Tue,  6 Jul 2010 23:20:33 -0600
Message-ID: <1278480034-22939-6-git-send-email-newren@gmail.com>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, spearce@spearce.org, agladysh@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 07:13:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWMwq-0002I3-Sj
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab0GGFNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 01:13:13 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61704 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab0GGFNL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 01:13:11 -0400
Received: by mail-gw0-f46.google.com with SMTP id 21so1665527gwj.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 22:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gf67hE4y1uPXKwYb/FRU8jpvqQJ6v9fEjtH68ZTYm7A=;
        b=nSoGU2p+9AN4x8zbMo9B5cNPA0fkDv3Hibf0rfuA+/HM6V35Yo08vLFkCaLrJZiryg
         nNmK46caNhOaxXfQmZBviA2fjSiFjq3IRfzYigzPrDTqMQ9sBjgFOXte/3fn0DZT5Ti3
         j3zvVWdjZPLcjt0hrKqLXZMKYqrs8yr1Z9xr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FhGJHWoT7JL42lz1LiLGXQDo1vG9ghkN2OVLx4rAi4qWN2xDNuhpbQYUVIG6Gy2kOC
         wGFJ4+W0RJjEXAbkB9k6ka8DYBRErkfhEiIfn9+zUEyOlqhGHOQz69xmCTqy7ZRj6Fmc
         9yGeTLwrf9u6L7IIEKuKxr8UvAFwymGZD/p/s=
Received: by 10.101.189.8 with SMTP id r8mr90775anp.53.1278479590689;
        Tue, 06 Jul 2010 22:13:10 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id h5sm60464675anb.28.2010.07.06.22.13.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 22:13:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.10.g6dbc5
In-Reply-To: <1278480034-22939-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150443>

From: Elijah Newren <newren@gmail.com>

The fast-import stream format requires incremental changes which take place
immediately, meaning that for D->F conversions all files below the relevant
directory must be deleted before the resulting file of the same name is
created.  Reversing the order can result in fast-import silently deleting
the file right after creating it, resulting in the file missing from the
resulting repository.

We correct the order by instructing the diff_tree machinery to compare
entries using df_name_compare instead of base_name_compare.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c  |    1 +
 diff.h                 |    1 +
 t/t9350-fast-export.sh |    2 +-
 tree-diff.c            |    4 +++-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c6dd71a..de6349f 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -614,6 +614,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		die("revision walk setup failed");
 	revs.diffopt.format_callback = show_filemodify;
 	DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
+	DIFF_OPT_SET(&revs.diffopt, COMPARE_DF_EQUAL);
 	while ((commit = get_revision(&revs))) {
 		if (has_unshown_parent(commit)) {
 			add_object_array(&commit->object, NULL, &commits);
diff --git a/diff.h b/diff.h
index 6a71013..6e1a1db 100644
--- a/diff.h
+++ b/diff.h
@@ -71,6 +71,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_SUBMODULE_LOG       (1 << 23)
 #define DIFF_OPT_DIRTY_SUBMODULES    (1 << 24)
 #define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
+#define DIFF_OPT_COMPARE_DF_EQUAL    (1 << 26)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 69179c6..1ee1461 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -376,7 +376,7 @@ test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
-test_expect_failure 'directory becomes symlink'        '
+test_expect_success 'directory becomes symlink'        '
 	git init dirtosymlink &&
 	git init result &&
 	(
diff --git a/tree-diff.c b/tree-diff.c
index fe9f52c..03f93b7 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -40,7 +40,9 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 
 	pathlen1 = tree_entry_len(path1, sha1);
 	pathlen2 = tree_entry_len(path2, sha2);
-	cmp = base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2);
+	cmp = DIFF_OPT_TST(opt, COMPARE_DF_EQUAL) ?
+	      df_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2) :
+	      base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2);
 	if (cmp < 0) {
 		show_entry(opt, "-", t1, base, baselen);
 		return -1;
-- 
1.7.1.1.10.g2e807
