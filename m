From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/7] Fix ignoring of pathspecs with rev-list --objects
Date: Tue, 24 Aug 2010 20:53:10 -0600
Message-ID: <1282704795-29661-3-git-send-email-newren@gmail.com>
References: <1282704795-29661-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 04:52:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo65q-0007sX-TC
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 04:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473Ab0HYCv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 22:51:58 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33622 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab0HYCvt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 22:51:49 -0400
Received: by mail-vw0-f46.google.com with SMTP id 3so180848vws.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 19:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wzfCtkY+ybsG/jQm6Zw44XCz6bTIHeBDEyuBkX8ZHPk=;
        b=ggep9WAmkOp3EpX2y/YGHNbjd29Q+EBvSqjmEDrsHpSFsMmK/7/rWXV9B45QHj6Eyv
         v+ZXRs/3t37100PFBiS+SfikXqk/yIUdWUBbeBuKJ9zqdyjrGdh0gfPm2yu1310nR+yw
         KTQhJPnsBufdWzykyPmx0iv05Evl/HB4CqKIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JFfa1E8HvP9aES9aix4eqtxQ6CxDy8/GnTAq6Ndu9hVYDg9ueloV9MOjJD7R9PgoOR
         KOn5w30CiTnjGXKaVRdxi6I/WhlFcAdwu+UUAtjasO0bqMXem2ZroJOEFdCkiv3lnmbQ
         OjsLp19oxKQjGpiS9Ya5W2M8DYH0r5QxigVM8=
Received: by 10.220.157.140 with SMTP id b12mr4779958vcx.16.1282704708727;
        Tue, 24 Aug 2010 19:51:48 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id v11sm577473vbb.3.2010.08.24.19.51.46
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 19:51:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.39.gf7e23
In-Reply-To: <1282704795-29661-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154395>

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
 list-objects.c           |   20 +++++++++++++++++++-
 t/t6000-rev-list-misc.sh |    2 +-
 tree-diff.c              |    2 +-
 4 files changed, 22 insertions(+), 3 deletions(-)

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
index 8953548..daa50bf 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -67,6 +67,7 @@ static void process_tree(struct rev_info *revs,
 	struct tree_desc desc;
 	struct name_entry entry;
 	struct name_path me;
+	int all_interesting = (revs->diffopt.nr_paths == 0);
 
 	if (!revs->tree_objects)
 		return;
@@ -84,7 +85,24 @@ static void process_tree(struct rev_info *revs,
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
 
-	while (tree_entry(&desc, &entry)) {
+	for (; desc.size; update_tree_entry(&desc)) {
+		entry = desc.entry;
+
+		if (!all_interesting) {
+			char *full_path = path_name(path, name);
+			int full_path_len = strlen(full_path);
+			int showit = tree_entry_interesting(&desc, full_path, full_path_len,
+							    &revs->diffopt);
+			free(full_path);
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
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 2c403ac..1bc395c 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -12,7 +12,7 @@ test_expect_success setup '
 	git commit -mone
 '
 
-test_expect_failure 'rev-list --objects heeds pathspecs' '
+test_expect_success 'rev-list --objects heeds pathspecs' '
 
 	git rev-list --objects HEAD -- wanted_file >output &&
 	grep wanted_file output &&
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
1.7.2.2.39.gf7e23
