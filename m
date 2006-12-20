X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH] rev-list: Add a new option --skip.
Date: Wed, 20 Dec 2006 00:29:06 +0000
Message-ID: <20061220002906.GB17864@localhost>
References: <20061219205422.GA17864@localhost> <7v1wmvpmef.fsf@assigned-by-dhcp.cox.net> <em9oi5$72t$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 00:29:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <em9oi5$72t$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=2.988, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_NJABL_DUL 3.00,
	RCVD_IN_SORBS_DUL 1.99)
X-blacknight-igraine-MailScanner-SpamScore: ss
X-MailScanner-From: robfitz@273k.net
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34869>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwpKV-0001y4-A0 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 01:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752313AbWLTA3E (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 19:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752877AbWLTA3D
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 19:29:03 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:37146 "EHLO
 igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752313AbWLTA3B (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 19:29:01 -0500
Received: from 213-202-161-139.bas503.dsl.esat.net ([213.202.161.139]
 helo=localhost) by igraine.blacknight.ie with esmtp (Exim 4.60)
 (envelope-from <robfitz@273k.net>) id 1GwpK5-0008Ei-JQ; Wed, 20 Dec 2006
 00:28:43 +0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Added a new option --skip=<N> which is used to allow the caller to
specify how many commit items to skip before displaying the commit
output.  This option is most useful for programs which want to display
fixed length pages of commit items, i.e. gitweb.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---

> I'm also for --skip (not --start-count), although... --start-count with
> --max-count seems more natural; one place it can be confusing is that we
> count skipped commits or not? I.e. we use --start-count=10 --max-count=20
> to get second 10 of commits, or --skip=10 --max-count=10 to get second 10
> of commits?

Here's the patch with the renamed option.  It also does not count
skipped commits, so --skip=10 --max-count=10 will display 10 items.

Robert


 Documentation/git-rev-list.txt |    5 +++++
 builtin-rev-list.c             |   17 +++++++++++++++++
 list-objects.c                 |    8 ++++++--
 revision.c                     |    1 +
 revision.h                     |    1 +
 5 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index ec43c0b..7c86abc 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git-rev-list' [ \--max-count=number ]
 	     [ \--max-age=timestamp ]
 	     [ \--min-age=timestamp ]
+	     [ \--skip=number ]
 	     [ \--sparse ]
 	     [ \--no-merges ]
 	     [ \--remove-empty ]
@@ -151,6 +152,10 @@ limiting may be applied.
 
 	Limit the commits output to specified time range.
 
+--skip='number'::
+
+	Skip 'number' commits before starting to display commit output.
+
 --author='pattern', --committer='pattern'::
 
 	Limit the commits output to ones with author/committer
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index fb7fc92..432f901 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -20,6 +20,7 @@ static const char rev_list_usage[] =
 "    --max-count=nr\n"
 "    --max-age=epoch\n"
 "    --min-age=epoch\n"
+"    --skip=nr\n"
 "    --sparse\n"
 "    --no-merges\n"
 "    --remove-empty\n"
@@ -219,6 +220,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	struct commit_list *list;
 	int i;
 	int read_from_stdin = 0;
+	int skip = -1;
 
 	init_revisions(&revs, prefix);
 	revs.abbrev = 0;
@@ -246,6 +248,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			read_revisions_from_stdin(&revs);
 			continue;
 		}
+		if (!strncmp(arg, "--skip=", 7)) {
+			skip = atoi(arg + 7);
+			continue;
+		}
 		usage(rev_list_usage);
 
 	}
@@ -261,6 +267,17 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		/* Only --header was specified */
 		revs.commit_format = CMIT_FMT_RAW;
 
+	/*
+	 * If a skip value is specified set start_count appropriately,
+	 * and if max_count is set it should be adjusted to account
+	 * for the skip value.
+	 */
+	if (skip > 0) {
+		revs.start_count = skip;
+		if (revs.max_count > 0)
+			revs.max_count += skip;
+	}
+
 	list = revs.commits;
 
 	if ((!list &&
diff --git a/list-objects.c b/list-objects.c
index f1fa21c..d96c8bf 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -108,8 +108,12 @@ void traverse_commit_list(struct rev_info *revs,
 	struct object_array objects = { 0, 0, NULL };
 
 	while ((commit = get_revision(revs)) != NULL) {
-		process_tree(revs, commit->tree, &objects, NULL, "");
-		show_commit(commit);
+		if (revs->start_count <= 0) {
+			process_tree(revs, commit->tree, &objects, NULL, "");
+			show_commit(commit);
+		} else {
+			revs->start_count--;
+		}
 	}
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending = revs->pending.objects + i;
diff --git a/revision.c b/revision.c
index 993bb66..70f4861 100644
--- a/revision.c
+++ b/revision.c
@@ -524,6 +524,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->prefix = prefix;
 	revs->max_age = -1;
 	revs->min_age = -1;
+	revs->start_count = -1;
 	revs->max_count = -1;
 
 	revs->prune_fn = NULL;
diff --git a/revision.h b/revision.h
index 3adab95..c2dce8c 100644
--- a/revision.h
+++ b/revision.h
@@ -75,6 +75,7 @@ struct rev_info {
 	struct grep_opt	*grep_filter;
 
 	/* special limits */
+	int start_count;
 	int max_count;
 	unsigned long max_age;
 	unsigned long min_age;
-- 
1.4.4.2.g80fef-dirty
