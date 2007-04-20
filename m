From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT vs Other: Need argument
Date: Fri, 20 Apr 2007 01:36:52 -0700
Message-ID: <7vzm531ly3.fsf@assigned-by-dhcp.cox.net>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	<200704171818.28256.andyparkins@gmail.com>
	<8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com>
	<200704181426.29969.andyparkins@gmail.com>
	<462650A7.5030404@midwinter.com> <f06d4m$3rs$1@sea.gmane.org>
	<4626C4B9.1040707@midwinter.com>
	<7vy7kpaz9s.fsf@assigned-by-dhcp.cox.net>
	<7vejmg9a1z.fsf@assigned-by-dhcp.cox.net>
	<4627B292.6080202@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 10:37:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Heoby-0004k5-0I
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 10:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbXDTIgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 04:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965397AbXDTIgz
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 04:36:55 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57752 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965301AbXDTIgy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 04:36:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420083653.JWY1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 04:36:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pLcs1W00P1kojtg0000000; Fri, 20 Apr 2007 04:36:53 -0400
In-Reply-To: <4627B292.6080202@midwinter.com> (Steven Grimm's message of "Thu,
	19 Apr 2007 11:18:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45073>

Steven Grimm <koreth@midwinter.com> writes:

> When git pull --continue does the commit, it *might* be nice for it to
> do a variant of commit -a: if the user has modified all the
> conflicting files, *and* not done an update-index on any of them
> manually,...

How do you propose to detect that?  We do not record the
conflicted semi-merged state we leave the user to sort out
anywhere else, and I do not think we would want to stash away a
hidden duplicates of all unmerged files somewhere only for this
application.  That feels too wasteful and messy.  You also need
to worry about how to garbage collect such copies if you go that
route.

-- >8 --
By the way, I've been wondering if giving "git add" an ability
to do "git commit -a" without actual committing.

	$ edit edit edit
        $ git add -u

would run "git add" for all modified (and deleted) files.

I picked "-u" instead of "-a" because I wanted to stress that
this is about "updating" (which has connotation that it is
relative to something, and in this case it is relative to the
current "index"), and not about "all", which "-a" would imply.

Hmm?

 builtin-add.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 9ec2925..5e6748f 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -8,10 +8,15 @@
 #include "dir.h"
 #include "exec_cmd.h"
 #include "cache-tree.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "commit.h"
+#include "revision.h"
 
 static const char builtin_add_usage[] =
-"git-add [-n] [-v] [-f] [--interactive | -i] [--] <filepattern>...";
+"git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--] <filepattern>...";
 
+static int take_all_worktree_changes;
 static const char *excludes_file;
 
 static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
@@ -92,6 +97,44 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec)
 		prune_directory(dir, pathspec, baselen);
 }
 
+static void update_callback(struct diff_queue_struct *q,
+			    struct diff_options *opt, void *cbdata)
+{
+	int i, verbose;
+
+	verbose = *((int *)cbdata);
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		const char *path = p->one->path;
+		switch (p->status) {
+		default:
+			die("unexpacted diff status %c", p->status);
+		case DIFF_STATUS_UNMERGED:
+		case DIFF_STATUS_MODIFIED:
+			add_file_to_cache(path, verbose);
+			break;
+		case DIFF_STATUS_DELETED:
+			remove_file_from_cache(path);
+			if (verbose)
+				printf("remove '%s'\n", path);
+			break;
+		}
+	}
+}
+
+static void update_all(int verbose)
+{
+	struct rev_info rev;
+	init_revisions(&rev, "");
+	setup_revisions(0, NULL, &rev, NULL);
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = update_callback;
+	rev.diffopt.format_callback_data = &verbose;
+	if (read_cache() < 0)
+		die("index file corrupt");
+	run_diff_files(&rev, 0);
+}
+
 static int git_add_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "core.excludesfile")) {
@@ -156,8 +199,20 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			verbose = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-u")) {
+			take_all_worktree_changes = 1;
+			continue;
+		}
 		usage(builtin_add_usage);
 	}
+
+	if (take_all_worktree_changes) {
+		if (i < argc)
+			die("-u and explicit paths are incompatible");
+		update_all(verbose);
+		goto finish;
+	}
+
 	if (argc <= i) {
 		fprintf(stderr, "Nothing specified, nothing added.\n");
 		fprintf(stderr, "Maybe you wanted to say 'git add .'?\n");
@@ -207,6 +262,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < dir.nr; i++)
 		add_file_to_cache(dir.entries[i]->name, verbose);
 
+ finish:
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    close(newfd) || commit_locked_index(&lock_file))
