From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 0/8] port branch.c to use the filtering part of ref-filter.
Date: Wed, 23 Sep 2015 23:41:05 +0530
Message-ID: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 20:11:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeoVc-0001XF-Gg
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 20:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbbIWSLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 14:11:07 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33849 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbbIWSLF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 14:11:05 -0400
Received: by pablk4 with SMTP id lk4so5528359pab.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Vi44ur2gY4zlyEvquC1PX8vqfK6oSlnw1ChQBSk6ruw=;
        b=qPCZgIFRjDW18cRR1y2pSgNaVtRKcn6oFuDclVndog8SFD9A2ysr/ON59yq3knqtJG
         jstALMr4060jq8LqlSGg2KoDqzbV7jcipu+mdhhhEKTL4q45ETjk+YXf0ibYn3gGVSYE
         iAUkg7cfMiEnwrhJYb8rO1rceEJCZSawJW7jASH5kdW/mWnzLTVE/7H+b7Enu3el7d2y
         CgxhnRLYkLKjnf9XAngS4Hd9EkDZqPsldUjrL8oC8D2OH6CpSGrRjwQYJFHRYubzVc79
         36gr2JcMdk0O2OfIzZDcH+eI26nB2GlGcqjgWfdPDkSLxer1F33oF+MIleCH3u/kszrT
         B8Xg==
X-Received: by 10.66.160.34 with SMTP id xh2mr39929095pab.67.1443031863958;
        Wed, 23 Sep 2015 11:11:03 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id bs3sm9107777pbd.89.2015.09.23.11.11.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Sep 2015 11:11:03 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278494>

The previous iteration of the same can be found:
http://www.mail-archive.com/git@vger.kernel.org/msg78153.html

Changes in this version:
* use ref_default_sorting()
* Improve documentation, comments and commit message.

Karthik Nayak (8):
  branch: refactor width computation
  branch: bump get_head_description() to the top
  branch: roll show_detached HEAD into regular ref_list
  branch: move 'current' check down to the presentation layer
  branch: drop non-commit error reporting
  branch.c: use 'ref-filter' data structures
  branch.c: use 'ref-filter' APIs
  branch: add '--points-at' option

 Documentation/git-branch.txt |  16 +-
 builtin/branch.c             | 502 +++++++++++++------------------------------
 ref-filter.c                 |   2 +-
 ref-filter.h                 |   6 +-
 t/t1430-bad-ref-name.sh      |  31 ++-
 t/t3203-branch-output.sh     |  20 ++
 6 files changed, 211 insertions(+), 366 deletions(-)

Interdiff:

diff --git a/builtin/branch.c b/builtin/branch.c
index b0a96e1..b7a60f4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -479,8 +479,6 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	struct ref_array array;
 	int maxwidth = 0;
 	const char *remote_prefix = "";
-	struct ref_sorting def_sorting;
-	const char *sort_type = "refname";
 
 	/*
 	 * If we are listing more than just remote branches,
@@ -498,12 +496,15 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
-	if (!sorting) {
-		def_sorting.next = NULL;
-		def_sorting.atom = parse_ref_filter_atom(sort_type,
-							 sort_type + strlen(sort_type));
-		sorting = &def_sorting;
-	}
+	/*
+	 * If no sorting parameter is given then we default to sorting
+	 * by 'refname'. This would give us an alphabetically sorted
+	 * array with the 'HEAD' ref at the beginning followed by
+	 * local branches 'refs/heads/...' and finally remote-tacking
+	 * branches 'refs/remotes/...'.
+	 */
+	if (!sorting)
+		sorting = ref_default_sorting();
 	ref_array_sort(sorting, &array);

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 647a9cf..03c7af1 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -237,8 +235,11 @@ start-point is either a local or remote-tracking branch.
 	order of the value. You may use the --sort=<key> option
 	multiple times, in which case the last key becomes the primary
 	key. The keys supported are the same as those in `git
-	for-each-ref`. Sort order defaults to sorting based on branch
-	type.
+	for-each-ref`. Sort order defaults to sorting based on the
+	full refname (including `refs/...` prefix). This lists
+	detached HEAD (if present) first, then local branches and
+	finally remote-tracking branches.
+
 
 --points-at <object>::
 	Only list branches of the given object.

 
-- 
2.5.1
