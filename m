From: newren@gmail.com
Subject: [PATCHv2 1/2] fast-export: Fix dropping of files with --import-marks and path limiting
Date: Wed,  7 Jul 2010 14:46:01 -0600
Message-ID: <1278535562-14875-2-git-send-email-newren@gmail.com>
References: <1278535562-14875-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 22:38:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWbOC-0007Ae-G2
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 22:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab0GGUi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 16:38:28 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53423 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab0GGUi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 16:38:26 -0400
Received: by pzk26 with SMTP id 26so13557pzk.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UbEssJWVR7c2aFGZMZBqY3G8DYKXQD5FKW0rjL53Bx0=;
        b=x3uInCOxKL/K58+ovkosvq6sUNwVWSOuJtxYgrvvH2UmS72bUj2Lc6zSvAveNjHQjY
         V0ECYzr/UacOSYBYZmJUHswBzIyIiXclIhg4kit3gNY4RB0431qAzQvi0OT/b4b28+gF
         v9sgdgCgD2/DWcksGSfKHONxdIqhcVYG21iQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=udwFMckNg9gH0tbcfqYCUZiJ6XX/8nj8Xu0QFF1y6fSlDGZHcikfwbM2dL9qKKNYLJ
         22E52KzboUy0/gugcghTS8OnTVQ8tr6fO3/6nbN7NXUkn0vWssdLiuRgyG8sk24hxkav
         KQsGZM6mlpL24snNIM7404BfO7olyaHEA5jtA=
Received: by 10.142.142.12 with SMTP id p12mr8597224wfd.13.1278535104579;
        Wed, 07 Jul 2010 13:38:24 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id c26sm7589013rvf.15.2010.07.07.13.38.20
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 13:38:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc1.14.g19914
In-Reply-To: <1278535562-14875-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150502>

From: Elijah Newren <newren@gmail.com>

Since fast-export operates by listing file changes since the (first) parent
commit, when using --import-marks and path limiting and using a wider list
of paths than in previous runs, files from the new path(s) will silently be
omitted from the result unless or until a commit which explicitly changes
those files.  The resulting repository in such cases is broken and makes no
sense.

This commit fixes this by having fast-export work with complete trees
instead of incremental changes (when both --import-marks and path limiting
are used).  It works by issuing a 'deleteall' directive with each commit and
then listing the full set of files that make up that commit, rather than
just showing the list of files that have changed since the (first) parent
commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c  |    9 ++++++++-
 t/t9350-fast-export.sh |    9 +++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c6dd71a..25d13a1 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -27,6 +27,7 @@ static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_mode = ABORT;
 static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ABORT;
 static int fake_missing_tagger;
 static int no_data;
+static int full_tree = 0;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -241,7 +242,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 		message += 2;
 
 	if (commit->parents &&
-	    get_object_mark(&commit->parents->item->object) != 0) {
+	    get_object_mark(&commit->parents->item->object) != 0 &&
+	    !full_tree) {
 		parse_commit(commit->parents->item);
 		diff_tree_sha1(commit->parents->item->tree->object.sha1,
 			       commit->tree->object.sha1, "", &rev->diffopt);
@@ -281,6 +283,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 		i++;
 	}
 
+	if (full_tree)
+		printf("deleteall\n");
 	log_tree_diff_flush(rev);
 	rev->diffopt.output_format = saved_output_format;
 
@@ -608,6 +612,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (import_filename)
 		import_marks(import_filename);
 
+	if (import_filename && revs.prune_data)
+		full_tree = 1;
+
 	get_tags_and_duplicates(&revs.pending, &extra_refs);
 
 	if (prepare_revision_walk(&revs))
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index d43f37c..6069e1f 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -355,6 +355,15 @@ test_expect_failure 'no exact-ref revisions included' '
 	)
 '
 
+test_expect_success 'path limiting with import-marks does not lose unmodified files'        '
+	git checkout -b simple marks~2 &&
+	git fast-export --export-marks=marks simple -- file > /dev/null &&
+	echo more content >> file &&
+	test_tick &&
+	git commit -mnext file &&
+	git fast-export --import-marks=marks simple -- file file0 | grep file0
+'
+
 test_expect_success 'set-up a few more tags for tag export tests' '
 	git checkout -f master &&
 	HEAD_TREE=`git show -s --pretty=raw HEAD | grep tree | sed "s/tree //"` &&
-- 
1.7.2.rc1.14.g19914
