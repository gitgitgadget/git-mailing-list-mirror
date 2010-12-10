From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP/RFC PATCH] Teach fetch and pull the on-demand mode for submodules
Date: Fri, 10 Dec 2010 19:45:27 +0100
Message-ID: <4D027547.2050709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 10 19:46:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR7yk-00063p-4b
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 19:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824Ab0LJSpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 13:45:39 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:56398 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463Ab0LJSpi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 13:45:38 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4742018D15CF7;
	Fri, 10 Dec 2010 19:45:28 +0100 (CET)
Received: from [93.246.34.120] (helo=[192.168.178.51])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PR7yC-0003u6-00; Fri, 10 Dec 2010 19:45:28 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/J2lYdWeso/EFNWCo5C0jhdsgpbIcFDnkUs7v1
	FgbfiTc6Nh5SEJ3CsuK/WwglXYasvRFcprQ01lxU0k5zYO6tPY
	F73tzrjJn9HqqDcB/0jQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163429>

To be able to recursively checkout submodules it is sufficient to only
then fetch a submodule recursively when the new commits fetched in the
superproject record new commits for it.

Before a new or changed ref from upstream is updated in update_local_ref()
"git rev-list <new-sha1> --not --branches --remotes" is used to determine
all newly fetched commits. These are then walked and diffed against their
parent(s) to see if a submodule has been changed. If that is the case, its
path is stored to fetch it after the superproject fetch is completed. This
is the new default behavior for fetch and pull.

Using the "--recurse-submodules" or the "--no-recurse-submodules" option
disables the examination of the fetched refs because the result will be
ignored anyway.

Because of the currently lacking infrastructure for storing deleted and
new submodules in the .git directory of the superproject fetch and pull
can currently only fetch submodules that are already checked out.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


So here is the first usable iteration of on-demand fetching for submodules
for people to test and comment on.

Still missing:

1) A new "on-demand" (other suggestions are welcome) value for the
   recurse[-]submodules command line and config options.

2) Tests. This patch currently breaks 5 tests and needs some of its own.

3) Optimizations:

   a) Check if the submodule commit is already present locally and don't
      add it to the to-be-fetched-list then.

   b) It hurts me to do the same computations again locally that the remote
      side already did to decide what commits to send. But not being very
      familiar with revision walking and transport I couldn't come up with
      a better solution for now. Ideas welcome.

And when we start implementing deletion and creation of submodules where
the .git directories have to live in the superprojects .git this code can
be extended to fetch into those directories when the submodule isn't even
checked out.

This patch applies to next.


 builtin/fetch.c |   11 ++++++++-
 submodule.c     |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 submodule.h     |    1 +
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 357f3cd..417fe77 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -284,6 +284,9 @@ static int update_local_ref(struct ref *ref,
 		else {
 			msg = "storing head";
 			what = "[new branch]";
+			if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
+			    (recurse_submodules != RECURSE_SUBMODULES_ON))
+				check_for_new_submodule_commits(ref->new_sha1);
 		}

 		r = s_update_ref(msg, ref, 0);
@@ -299,6 +302,9 @@ static int update_local_ref(struct ref *ref,
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
 		strcat(quickref, "..");
 		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
+		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
+		    (recurse_submodules != RECURSE_SUBMODULES_ON))
+			check_for_new_submodule_commits(ref->new_sha1);
 		r = s_update_ref("fast-forward", ref, 1);
 		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : ' ',
 			TRANSPORT_SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
@@ -310,6 +316,9 @@ static int update_local_ref(struct ref *ref,
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
 		strcat(quickref, "...");
 		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
+		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
+		    (recurse_submodules != RECURSE_SUBMODULES_ON))
+			check_for_new_submodule_commits(ref->new_sha1);
 		r = s_update_ref("forced-update", ref, 1);
 		sprintf(display, "%c %-*s %-*s -> %s  (%s)", r ? '!' : '+',
 			TRANSPORT_SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
@@ -951,7 +960,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		int num_options = 0;
 		/* Set recursion as default when we already are recursing */
 		if (submodule_prefix[0])
-			set_config_fetch_recurse_submodules(1);
+			set_config_fetch_recurse_submodules(recurse_submodules == RECURSE_SUBMODULES_ON ? 1 : -1);
 		gitmodules_config();
 		git_config(submodule_config, NULL);
 		add_options_to_argv(&num_options, options);
diff --git a/submodule.c b/submodule.c
index 4e62900..54eda96 100644
--- a/submodule.c
+++ b/submodule.c
@@ -12,7 +12,8 @@
 struct string_list config_name_for_path;
 struct string_list config_fetch_recurse_submodules_for_name;
 struct string_list config_ignore_for_name;
-static int config_fetch_recurse_submodules;
+static int config_fetch_recurse_submodules = -1;
+struct string_list changed_submodule_paths;

 static int add_submodule_odb(const char *path)
 {
@@ -248,6 +249,66 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }

+static void submodule_collect_changed_cb(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data)
+{
+	int i;
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (S_ISGITLINK(p->two->mode)) {
+			if (S_ISGITLINK(p->one->mode)) {
+				/* FIXME: We should be using the name configured in the
+				 * .gitmodules file of the commit we are examining here to
+				 * be able to follow moved submodules. */
+				struct string_list_item *path;
+				path = unsorted_string_list_lookup(&changed_submodule_paths, p->two->path);
+				if (!path)
+					string_list_append(&changed_submodule_paths, xstrdup(p->two->path));
+			} else {
+				/* Submodule is new or was moved here */
+
+				/* FIXME: When the .git directories of submodules live inside
+				 * the superprojects .git directory some day we should fetch
+				 * new submodules into that location too so they can be
+				 * checked out from there when needed. */
+				return;
+			}
+		}
+	}
+}
+
+void check_for_new_submodule_commits(unsigned char new_sha1[20])
+{
+	struct rev_info rev;
+	struct commit *commit;
+	int argc = 5;
+	const char *argv[] = {NULL, NULL, "--not", "--branches", "--remotes", NULL};
+
+	init_revisions(&rev, NULL);
+	argv[1] = xstrdup(sha1_to_hex(new_sha1));
+	setup_revisions(argc, argv, &rev, NULL);
+	if (prepare_revision_walk(&rev))
+		die("revision walk setup failed");
+
+	while ((commit = get_revision(&rev))) {
+		struct commit_list *parent = commit->parents;
+		while (parent) {
+			struct diff_options diff_opts;
+			diff_setup(&diff_opts);
+			diff_opts.output_format |= DIFF_FORMAT_CALLBACK;
+			diff_opts.format_callback = submodule_collect_changed_cb;
+			if (diff_setup_done(&diff_opts) < 0)
+				die("diff-setup");
+			diff_tree_sha1(parent->item->object.sha1, commit->object.sha1, "", &diff_opts);
+			diffcore_std(&diff_opts);
+			diff_flush(&diff_opts);
+			parent = parent->next;
+		}
+	}
+	free((char *)argv[1]);
+}
+
 int fetch_populated_submodules(int num_options, const char **options,
 			       const char *prefix, int ignore_config,
 			       int quiet)
@@ -300,6 +361,9 @@ int fetch_populated_submodules(int num_options, const char **options,
 			} else {
 				if (!config_fetch_recurse_submodules)
 					continue;
+				if ((config_fetch_recurse_submodules < 0) &&
+				    !unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
+					continue;
 			}
 		}

diff --git a/submodule.h b/submodule.h
index 4729023..a574f11 100644
--- a/submodule.h
+++ b/submodule.h
@@ -14,6 +14,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset);
 void set_config_fetch_recurse_submodules(int value);
+void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 int fetch_populated_submodules(int num_options, const char **options,
 			       const char *prefix, int ignore_config,
 			       int quiet);
-- 
1.7.3.3.711.g95750
