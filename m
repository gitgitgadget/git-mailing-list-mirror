From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 11/16] rev-list: add bitmap mode to speed up lists
Date: Tue, 25 Jun 2013 01:23:08 +0200
Message-ID: <1372116193-32762-12-git-send-email-tanoku@gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Vicent Marti <tanoku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:24:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG7R-0003Sv-9g
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab3FXXYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:24:09 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:44310 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab3FXXYF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:24:05 -0400
Received: by mail-we0-f175.google.com with SMTP id t59so8634635wes.20
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CDxQoWpp6EdE4AecQFg8xrfOCW8/X2fo29H4WdgdiVs=;
        b=sjpTBiM7UkzUYkZHM+6Rq5urG1Rec4ir6/GsLYx+cz8HgU3PF7jiYKf4wIbL46c6kC
         Wt5+iigDZRUVRl0DLbXVMVfEXejZ/ecXi32F5Q7ZLGqUwCTjLd1UEm/Vfh7RuC5oGZhA
         TVydt5lTIn97fBUamD1UhY5gwAg8NhzWzQlaqcs1xf+vkPLfrSadxRZkaP3wecIu/19j
         JrOC/Dx7fhs0AeNbiU6dNGI4bM+6oxWz8rJjVgbyWY2G5iIx+Vzjqw+t8ZxucYI/4rRY
         F8gYsTRdV2bHgSPkfOYnKhUlmX0z2sjjy4Cyl5yTjzoNVeoDkbiojtgSfeCLd62pDiwG
         jCew==
X-Received: by 10.180.90.104 with SMTP id bv8mr7387617wib.15.1372116243877;
        Mon, 24 Jun 2013 16:24:03 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.24.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:24:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228930>

The bitmap reachability index used to speed up the counting objects
phase during `pack-objects` can also be used to optimize a normal
rev-list if the only thing required are the SHA1s of the objects during
the list.

Calling `git rev-list --use-bitmaps [committish]` is the equivalent
of `git rev-list --objects`, but the rev list is performed based on
a bitmap result instead of using a manual counting objects phase.

These are some example timings for `torvalds/linux`:

	$ time ../git/git rev-list --objects master > /dev/null

	real    0m25.567s
	user    0m25.148s
	sys     0m0.384s

	$ time ../git/git rev-list --use-bitmaps master > /dev/null

	real    0m0.393s
	user    0m0.356s
	sys     0m0.036s

Additionally, a `--test-bitmap` flag has been added that will perform
the same rev-list manually (i.e. using a normal revwalk) and using
bitmaps, and verify that the results are the same.
---
 builtin/rev-list.c |   28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 67701be..905ed08 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -3,6 +3,8 @@
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "pack.h"
+#include "pack-bitmap.h"
 #include "builtin.h"
 #include "log-tree.h"
 #include "graph.h"
@@ -256,6 +258,17 @@ static int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 	return 0;
 }
 
+static int show_object_fast(
+	const unsigned char *sha1,
+	enum object_type type,
+	uint32_t hash, int exclude,
+	struct packed_git *found_pack,
+	off_t found_offset)
+{
+	fprintf(stdout, "%ss\n", sha1_to_hex(sha1));
+	return 1;
+}
+
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -264,6 +277,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int bisect_list = 0;
 	int bisect_show_vars = 0;
 	int bisect_find_all = 0;
+	int use_bitmaps = 0;
 
 	git_config(git_default_config, NULL);
 	init_revisions(&revs, prefix);
@@ -305,8 +319,15 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			bisect_show_vars = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--use-bitmaps")) {
+			use_bitmaps = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--test-bitmap")) {
+			test_bitmap_walk(&revs);
+			return 0;
+		}
 		usage(rev_list_usage);
-
 	}
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
 		/* The command line has a --pretty  */
@@ -332,6 +353,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list)
 		revs.limited = 1;
 
+	if (use_bitmaps && !prepare_bitmap_walk(&revs, NULL)) {
+		traverse_bitmap_commit_list(&show_object_fast);
+		return 0;
+	}
+
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	if (revs.tree_objects)
-- 
1.7.9.5
