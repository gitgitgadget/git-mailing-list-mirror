From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH] [BUG FIXED] git-add (-a|-u)  and -n support
Date: Sun, 14 Oct 2007 08:11:23 -0400
Message-ID: <0458D1DA-6261-4DA6-91B0-739F4D35AADF@mit.edu>
References: <E1DCA1D1-1ED3-498A-A919-9EBAF3BA0870@mit.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 14:11:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih2K0-000814-Gn
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 14:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757465AbXJNML2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 08:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754190AbXJNML2
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 08:11:28 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:39232 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757305AbXJNML1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2007 08:11:27 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9ECBPFM025476
	for <git@vger.kernel.org>; Sun, 14 Oct 2007 08:11:25 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9ECBO3Z013323
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sun, 14 Oct 2007 08:11:25 -0400 (EDT)
In-Reply-To: <E1DCA1D1-1ED3-498A-A919-9EBAF3BA0870@mit.edu>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60833>


On 14 Oct 2007, at 6:26:28 AM, Michael Witten wrote:

> Hello,
>
> The git-add command doesn't handle -n when using -u.
>
> I fixed this and added -a for adding ALL files, not
> just those below the current directory (just like
> git-commit).
>
> The patch is below, but you can also download it from
> http://web.mit.edu/mfwitten/git/0001-git-add-now-understands-two- 
> kinds-of-update.patch
>


Unfortunately, I introduced a bug.
The following:

> +				if (show_only)
> +					remove_file_from_cache(path);
> +				if (verbose)
> +					printf("remove '%s'\n", path);

Should be:

> +				if (!show_only)
> +					remove_file_from_cache(path);
> +				if (verbose)
> +					printf("remove '%s'\n", path);


The new patch is listed below:
(http://web.mit.edu/mfwitten/git/0001-git-add-now-understands-two- 
kinds-of-update.patch)


 From 6d7480062b1e1c513441d4bbc17a9a8b5d9b1c8f Mon Sep 17 00:00:00 2001
From: Michael Witten <mfwitten@mit.edu>
Date: Sun, 14 Oct 2007 06:13:20 -0400
Subject: [PATCH] git-add now understands two kinds of update:

  	-u: update as before
  	-a: update all as in a true 'git commit -a'

Also, -n works correctly now with the above options.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
  builtin-add.c |   69 +++++++++++++++++++++++++++++++++++++ 
+-------------------
  1 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index f9a6580..f180afe 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -13,10 +13,11 @@
  #include "commit.h"
  #include "revision.h"

+enum update_type {NONE, ALL, CURRENT_DIRECTORY};
+
  static const char builtin_add_usage[] =
  "git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--refresh] [--]  
<filepattern>...";

-static int take_worktree_changes;
  static const char *excludes_file;

  static void prune_directory(struct dir_struct *dir, const char  
**pathspec, int prefix)
@@ -83,40 +84,57 @@ static void fill_directory(struct dir_struct  
*dir, const char **pathspec,
  static void update_callback(struct diff_queue_struct *q,
  			    struct diff_options *opt, void *cbdata)
  {
-	int i, verbose;
-
-	verbose = *((int *)cbdata);
+	int i;
+	
+	int* options   = (int*)cbdata;
+	int  verbose   = options[0];
+	int  show_only = options[1];
+	
  	for (i = 0; i < q->nr; i++) {
  		struct diff_filepair *p = q->queue[i];
  		const char *path = p->one->path;
-		switch (p->status) {
-		default:
-			die("unexpected diff status %c", p->status);
-		case DIFF_STATUS_UNMERGED:
-		case DIFF_STATUS_MODIFIED:
-		case DIFF_STATUS_TYPE_CHANGED:
-			add_file_to_cache(path, verbose);
-			break;
-		case DIFF_STATUS_DELETED:
-			remove_file_from_cache(path);
-			if (verbose)
-				printf("remove '%s'\n", path);
-			break;
+		
+		switch (p->status) {			
+			case DIFF_STATUS_UNMERGED:
+			case DIFF_STATUS_MODIFIED:
+			case DIFF_STATUS_TYPE_CHANGED:
+				if (show_only)
+					printf("add '%s'\n", path);
+				else
+					add_file_to_cache(path, verbose);
+				break;
+			
+			case DIFF_STATUS_DELETED:
+				if (verbose)
+					printf("remove '%s'\n", path);
+				if (!show_only)
+					remove_file_from_cache(path);
+				break;
+			
+			default:
+				die("unexpected diff status %c", p->status);
  		}
  	}
  }

-static void update(int verbose, const char *prefix, const char **files)
+static void update(enum update_type type, int verbose, int show_only,
+                  const char *prefix, const char **files)
  {
  	struct rev_info rev;
+	int callback_options[] = {verbose, show_only};
+	
  	init_revisions(&rev, prefix);
  	setup_revisions(0, NULL, &rev, NULL);
-	rev.prune_data = get_pathspec(prefix, files);
+	
+	rev.prune_data = type == ALL ? NULL : get_pathspec(prefix, files);
+	
  	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
  	rev.diffopt.format_callback = update_callback;
-	rev.diffopt.format_callback_data = &verbose;
+	rev.diffopt.format_callback_data = callback_options;
+	
  	if (read_cache() < 0)
  		die("index file corrupt");
+	
  	run_diff_files(&rev, 0);
  }

@@ -158,6 +176,7 @@ int cmd_add(int argc, const char **argv, const  
char *prefix)
  {
  	int i, newfd;
  	int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
+	enum update_type update_type = NONE;
  	const char **pathspec;
  	struct dir_struct dir;
  	int add_interactive = 0;
@@ -201,8 +220,12 @@ int cmd_add(int argc, const char **argv, const  
char *prefix)
  			verbose = 1;
  			continue;
  		}
+		if (!strcmp(arg, "-a")) {
+			update_type = ALL;
+			continue;
+		}
  		if (!strcmp(arg, "-u")) {
-			take_worktree_changes = 1;
+			update_type = CURRENT_DIRECTORY;
  			continue;
  		}
  		if (!strcmp(arg, "--refresh")) {
@@ -212,8 +235,8 @@ int cmd_add(int argc, const char **argv, const  
char *prefix)
  		usage(builtin_add_usage);
  	}

-	if (take_worktree_changes) {
-		update(verbose, prefix, argv + i);
+	if (update_type) {
+		update(update_type, verbose, show_only, prefix, argv + i);
  		goto finish;
  	}

-- 
1.5.3.4.206.g58ba4-dirty
