From: Jeff King <peff@peff.net>
Subject: [PATCH] fetch: avoid quadratic loop checking for updated submodules
Date: Mon, 12 Sep 2011 15:56:52 -0400
Message-ID: <20110912195652.GA27850@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-dev@github.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 12 21:57:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Ccn-0000IS-Ek
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 21:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243Ab1ILT4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 15:56:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56719
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792Ab1ILT4z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 15:56:55 -0400
Received: (qmail 17984 invoked by uid 107); 12 Sep 2011 19:57:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Sep 2011 15:57:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2011 15:56:52 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181235>

Recent versions of git can be slow to fetch repositories with a
large number of refs (or when they already have a large
number of refs). For example, GitHub makes pull-requests
available as refs, which can lead to a large number of
available refs. This slowness goes away when submodule
recursion is turned off:

  $ git ls-remote git://github.com/rails/rails.git | wc -l
  3034

  [this takes ~10 seconds of CPU time to complete]
  git fetch --recurse-submodules=no \
    git://github.com/rails/rails.git "refs/*:refs/*"

  [this still isn't done after 10 _minutes_ of pegging the CPU]
  git fetch \
    git://github.com/rails/rails.git "refs/*:refs/*"

You can produce a quicker and simpler test case like this:

  doit() {
    head=`git rev-parse HEAD`
    for i in `seq 1 $1`; do
      echo $head refs/heads/ref$i
    done >.git/packed-refs
    echo "==> $1"
    rm -rf dest
    git init -q --bare dest &&
      (cd dest && time git.compile fetch -q .. refs/*:refs/*)
  }

  rm -rf repo
  git init -q repo && cd repo &&
  >file && git add file && git commit -q -m one

  doit 100
  doit 200
  doit 400
  doit 800
  doit 1600
  doit 3200

Which yields timings like:

  # refs  seconds of CPU
     100            0.06
     200            0.24
     400            0.95
     800            3.39
    1600           13.66
    3200           54.09

Notice that although the number of refs doubles in each
trial, the CPU time spent quadruples.

The problem is that the submodule recursion code works
something like:

  - for each ref we fetch
    - for each commit in git rev-list $new_sha1 --not --all
      - add modified submodules to list
  - fetch any newly referenced submodules

But that means if we fetch N refs, we start N revision
walks. Worse, because we use "--all", the number of refs we
must process that constitute "--all" keeps growing, too. And
you end up doing O(N^2) ref resolutions.

Instead, this patch structures the code like this:

  - for each sha1 we already have
    - add $old_sha1 to list $old
  - for each ref we fetch
    - add $new_sha1 to list $new
  - for each commit in git rev-list $new --not $old
    - add modified submodules to list
  - fetch any newly referenced submodules

This yields timings like:

  # refs  seconds of CPU
  100               0.00
  200               0.04
  400               0.04
  800               0.10
  1600              0.21
  3200              0.39

Note that the amount of effort doubles as the number of refs
doubles. Similarly, the fetch of rails.git takes about as
much time as it does with --recurse-submodules=no.

Signed-off-by: Jeff King <peff@peff.net>
---
 submodule.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 7a76edf..00aeb71 100644
--- a/submodule.c
+++ b/submodule.c
@@ -8,12 +8,17 @@
 #include "diffcore.h"
 #include "refs.h"
 #include "string-list.h"
+#include "sha1-array.h"
 
 static struct string_list config_name_for_path;
 static struct string_list config_fetch_recurse_submodules_for_name;
 static struct string_list config_ignore_for_name;
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static struct string_list changed_submodule_paths;
+static int initialized_fetch_ref_tips;
+static struct sha1_array ref_tips_before_fetch;
+static struct sha1_array ref_tips_after_fetch;
+
 /*
  * The following flag is set if the .gitmodules file is unmerged. We then
  * disable recursion for all submodules where .git/config doesn't have a
@@ -474,16 +479,71 @@ static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 	}
 }
 
+static int add_sha1_to_array(const char *ref, const unsigned char *sha1,
+			     int flags, void *data)
+{
+	sha1_array_append(data, sha1);
+	return 0;
+}
+
 void check_for_new_submodule_commits(unsigned char new_sha1[20])
 {
+	if (!initialized_fetch_ref_tips) {
+		for_each_ref(add_sha1_to_array, &ref_tips_before_fetch);
+		initialized_fetch_ref_tips = 1;
+	}
+
+	sha1_array_append(&ref_tips_after_fetch, new_sha1);
+}
+
+struct argv_array {
+	const char **argv;
+	unsigned int argc;
+	unsigned int alloc;
+};
+
+static void init_argv(struct argv_array *array)
+{
+	array->argv = NULL;
+	array->argc = 0;
+	array->alloc = 0;
+}
+
+static void push_argv(struct argv_array *array, const char *value)
+{
+	ALLOC_GROW(array->argv, array->argc + 2, array->alloc);
+	array->argv[array->argc++] = xstrdup(value);
+	array->argv[array->argc] = NULL;
+}
+
+static void clear_argv(struct argv_array *array)
+{
+	int i;
+	for (i = 0; i < array->argc; i++)
+		free((char **)array->argv[i]);
+	free(array->argv);
+	init_argv(array);
+}
+
+static void add_sha1_to_argv(const unsigned char sha1[20], void *data)
+{
+	push_argv(data, sha1_to_hex(sha1));
+}
+
+static void calculate_changed_submodule_paths() {
 	struct rev_info rev;
 	struct commit *commit;
-	const char *argv[] = {NULL, NULL, "--not", "--all", NULL};
-	int argc = ARRAY_SIZE(argv) - 1;
+	struct argv_array argv;
 
 	init_revisions(&rev, NULL);
-	argv[1] = xstrdup(sha1_to_hex(new_sha1));
-	setup_revisions(argc, argv, &rev, NULL);
+	init_argv(&argv);
+	push_argv(&argv, "--"); /* argv[0] program name */
+	sha1_array_for_each_unique(&ref_tips_after_fetch,
+				   add_sha1_to_argv, &argv);
+	push_argv(&argv, "--not");
+	sha1_array_for_each_unique(&ref_tips_before_fetch,
+				   add_sha1_to_argv, &argv);
+	setup_revisions(argv.argc, argv.argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
 
@@ -507,7 +567,11 @@ void check_for_new_submodule_commits(unsigned char new_sha1[20])
 			parent = parent->next;
 		}
 	}
-	free((char *)argv[1]);
+
+	clear_argv(&argv);
+	sha1_array_clear(&ref_tips_before_fetch);
+	sha1_array_clear(&ref_tips_after_fetch);
+	initialized_fetch_ref_tips = 0;
 }
 
 int fetch_populated_submodules(int num_options, const char **options,
@@ -541,6 +605,8 @@ int fetch_populated_submodules(int num_options, const char **options,
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 
+	calculate_changed_submodule_paths();
+
 	for (i = 0; i < active_nr; i++) {
 		struct strbuf submodule_path = STRBUF_INIT;
 		struct strbuf submodule_git_dir = STRBUF_INIT;
-- 
1.7.6.10.g62f04
