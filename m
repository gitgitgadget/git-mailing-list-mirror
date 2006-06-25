From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] format-patch: introduce "--ignore-if-in-upstream"
Date: Sun, 25 Jun 2006 03:52:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606250351180.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jun 25 03:52:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJnE-0005oA-21
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWFYBwF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWFYBwF
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:52:05 -0400
Received: from mail.gmx.de ([213.165.64.21]:48787 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751345AbWFYBwE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:52:04 -0400
Received: (qmail invoked by alias); 25 Jun 2006 01:52:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 25 Jun 2006 03:52:02 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net, martin@catalyst.net.nz
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22568>


With this flag, format-patch will try very hard not to output patches which
are already in the upstream branch.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-log.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 5a8a50b..e78a9a4 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -160,6 +160,71 @@ static void reopen_stdout(struct commit 
 	freopen(filename, "w", stdout);
 }
 
+static void reset_all_objects_flags()
+{
+	int i;
+
+	for (i = 0; i < obj_allocs; i++)
+		if (objs[i])
+			objs[i]->flags = 0;
+}
+
+static int get_patch_id(struct commit *commit, struct diff_options *options,
+		unsigned char *sha1)
+{
+	diff_tree_sha1(commit->parents->item->object.sha1, commit->object.sha1,
+			"", options);
+	diffcore_std(options);
+	return diff_flush_patch_id(options, sha1);
+}
+
+static void get_patch_ids(struct rev_info *rev, struct diff_options *options)
+{
+	struct rev_info check_rev;
+	struct commit *commit;
+	struct object *o1, *o2;
+	unsigned flags1, flags2;
+	unsigned char sha1[20];
+
+	if (rev->pending.nr != 2)
+		die("Need exactly one range.");
+
+	o1 = rev->pending.objects[0].item;
+	flags1 = o1->flags;
+	o2 = rev->pending.objects[1].item;
+	flags2 = o2->flags;
+
+	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
+		die("Not a range.");
+
+	diff_setup(options);
+	options->recursive = 1;
+	if (diff_setup_done(options) < 0)
+		die("diff_setup_done failed");
+
+	/* given a range a..b get all patch ids for b..a */
+	init_revisions(&check_rev);
+	o1->flags ^= UNINTERESTING;
+	o2->flags ^= UNINTERESTING;
+	add_pending_object(&check_rev, o1, "o1");
+	add_pending_object(&check_rev, o2, "o2");
+	prepare_revision_walk(&check_rev);
+
+	while ((commit = get_revision(&check_rev)) != NULL) {
+		/* ignore merges */
+		if (commit->parents && commit->parents->next)
+			continue;
+
+		if (!get_patch_id(commit, options, sha1))
+			created_object(sha1, xcalloc(1, sizeof(struct object)));
+	}
+
+	/* reset for next revision walk */
+	reset_all_objects_flags();
+	o1->flags = flags1;
+	o2->flags = flags2;
+}
+
 int cmd_format_patch(int argc, const char **argv, char **envp)
 {
 	struct commit *commit;
@@ -170,6 +235,8 @@ int cmd_format_patch(int argc, const cha
 	int numbered = 0;
 	int start_number = -1;
 	int keep_subject = 0;
+	int ignore_if_in_upstream = 0;
+	struct diff_options patch_id_opts;
 	char *add_signoff = NULL;
 
 	init_revisions(&rev);
@@ -235,6 +302,8 @@ int cmd_format_patch(int argc, const cha
 			rev.mime_boundary = git_version_string;
 		else if (!strncmp(argv[i], "--attach=", 9))
 			rev.mime_boundary = argv[i] + 9;
+		else if (!strcmp(argv[i], "--ignore-if-in-upstream"))
+			ignore_if_in_upstream = 1;
 		else
 			argv[j++] = argv[i];
 	}
@@ -262,14 +331,25 @@ int cmd_format_patch(int argc, const cha
 		add_head(&rev);
 	}
 
+	if (ignore_if_in_upstream)
+		get_patch_ids(&rev, &patch_id_opts);
+
 	if (!use_stdout)
 		realstdout = fdopen(dup(1), "w");
 
 	prepare_revision_walk(&rev);
 	while ((commit = get_revision(&rev)) != NULL) {
+		unsigned char sha1[20];
+
 		/* ignore merges */
 		if (commit->parents && commit->parents->next)
 			continue;
+
+		if (ignore_if_in_upstream &&
+				!get_patch_id(commit, &patch_id_opts, sha1) &&
+				lookup_object(sha1))
+			continue;
+
 		nr++;
 		list = realloc(list, nr * sizeof(list[0]));
 		list[nr - 1] = commit;
-- 
1.4.0.g7a200-dirty
