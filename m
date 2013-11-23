From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH] disable complete ignorance of submodules for index <->
 HEAD diff
Date: Sat, 23 Nov 2013 02:11:45 +0100
Message-ID: <20131123011145.GB4952@sandbox-ub>
References: <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
 <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
 <20131122151120.GA32361@sigill.intra.peff.net>
 <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
 <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
 <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
 <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
 <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
 <528FC638.5060403@web.de>
 <20131122215454.GA4952@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Nov 23 02:11:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vk1lM-0004RR-Iy
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 02:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab3KWBLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 20:11:53 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:54263 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521Ab3KWBLv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 20:11:51 -0500
Received: from [77.20.34.36] (helo=sandbox-ub)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Vk1lD-0004a9-18; Sat, 23 Nov 2013 02:11:47 +0100
Content-Disposition: inline
In-Reply-To: <20131122215454.GA4952@sandbox-ub>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238226>

If the value of ignore for submodules is set to "all" we would not show
whats actually committed during status or diff. This can result in the
user committing unexpected submodule references. Lets be nicer and always
show whats in the index.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
This probably needs splitting up into two patches one for the
refactoring and one for the actual fix. It is also missing tests, but I
would first like to know what you think about this approach.

 builtin/diff.c | 43 +++++++++++++++++++++++++++----------------
 diff.h         |  2 +-
 submodule.c    |  6 ++++--
 wt-status.c    |  3 +++
 4 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index adb93a9..e9a356c 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -249,6 +249,21 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 	return run_diff_files(revs, options);
 }
 
+static int have_cached_option(int argc, const char **argv)
+{
+	int i;
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--"))
+			return 0;
+		else if (!strcmp(arg, "--cached") ||
+			 !strcmp(arg, "--staged")) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
 int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -259,6 +274,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	struct blobinfo blob[2];
 	int nongit;
 	int result = 0;
+	int have_cached;
 
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
@@ -305,6 +321,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	if (nongit)
 		die(_("Not a git repository"));
+
+	have_cached = have_cached_option(argc, argv);
+	if (have_cached)
+		DIFF_OPT_SET(&rev.diffopt, NO_IGNORE_SUBMODULE);
+
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
@@ -319,22 +340,12 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 * Do we have --cached and not have a pending object, then
 	 * default to HEAD by hand.  Eek.
 	 */
-	if (!rev.pending.nr) {
-		int i;
-		for (i = 1; i < argc; i++) {
-			const char *arg = argv[i];
-			if (!strcmp(arg, "--"))
-				break;
-			else if (!strcmp(arg, "--cached") ||
-				 !strcmp(arg, "--staged")) {
-				add_head_to_pending(&rev);
-				if (!rev.pending.nr) {
-					struct tree *tree;
-					tree = lookup_tree(EMPTY_TREE_SHA1_BIN);
-					add_pending_object(&rev, &tree->object, "HEAD");
-				}
-				break;
-			}
+	if (!rev.pending.nr && have_cached) {
+		add_head_to_pending(&rev);
+		if (!rev.pending.nr) {
+			struct tree *tree;
+			tree = lookup_tree(EMPTY_TREE_SHA1_BIN);
+			add_pending_object(&rev, &tree->object, "HEAD");
 		}
 	}
 
diff --git a/diff.h b/diff.h
index e342325..81561b3 100644
--- a/diff.h
+++ b/diff.h
@@ -64,7 +64,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
 #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
 #define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
-/* (1 <<  9) unused */
+#define DIFF_OPT_NO_IGNORE_SUBMODULE (1 <<  9)
 #define DIFF_OPT_HAS_CHANGES         (1 << 10)
 #define DIFF_OPT_QUICK               (1 << 11)
 #define DIFF_OPT_NO_INDEX            (1 << 12)
diff --git a/submodule.c b/submodule.c
index 1905d75..9d81712 100644
--- a/submodule.c
+++ b/submodule.c
@@ -301,9 +301,11 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 	DIFF_OPT_CLR(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
 	DIFF_OPT_CLR(diffopt, IGNORE_DIRTY_SUBMODULES);
 
-	if (!strcmp(arg, "all"))
+	if (!strcmp(arg, "all")) {
+		if (DIFF_OPT_TST(diffopt, NO_IGNORE_SUBMODULE))
+			return;
 		DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
-	else if (!strcmp(arg, "untracked"))
+	} else if (!strcmp(arg, "untracked"))
 		DIFF_OPT_SET(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
 	else if (!strcmp(arg, "dirty"))
 		DIFF_OPT_SET(diffopt, IGNORE_DIRTY_SUBMODULES);
diff --git a/wt-status.c b/wt-status.c
index b4e44ba..34be1cc 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -462,6 +462,9 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
 	}
 
+	/* for the index we need to disable complete ignorance of submodules */
+	DIFF_OPT_SET(&rev.diffopt, NO_IGNORE_SUBMODULE);
+
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_collect_updated_cb;
 	rev.diffopt.format_callback_data = s;
-- 
1.8.5.rc3.1.gcd6363f
