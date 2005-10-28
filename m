From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Fri, 28 Oct 2005 02:31:26 -0700
Message-ID: <7v3bmmvvgx.fsf@assigned-by-dhcp.cox.net>
References: <20051027203945.GC1622@pe.Belkin>
	<7vfyqm1uvx.fsf@assigned-by-dhcp.cox.net>
	<20051027234813.GA512@pe.Belkin>
	<Pine.LNX.4.64.0510271709120.4664@g5.osdl.org>
	<20051028005029.GA2654@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 11:32:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVQaE-0002hW-Bw
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 11:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbVJ1Jb2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 05:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbVJ1Jb2
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 05:31:28 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:27570 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965200AbVJ1Jb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2005 05:31:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051028093042.WPMR2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Oct 2005 05:30:42 -0400
To: Chris Shoemaker <c.shoemaker@cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10765>

Chris Shoemaker <c.shoemaker@cox.net> writes:

> Ok, but that cache would live inside GIT_DIR an be shared with gitk,
> right?

It is up to gitk.  If your cache file format is simple, concise
and easy to access, then it might be useful for gitk to take
advantage of it.  Although I doubt many people would run gitk
and gitweb on the same repository (usually the former is run on
the private developer repository and the latter public one).

Caching the 'git-diff-tree -p | git-apply --numstat' output
might be useful and compact enough.  I often wonder if the
commit page (i.e. gitweb?p=$repository;a=commit;h=$sha1) might
be more useful if it had diffstat drawing on each blob line at
the end of the page, and the output from the above pipe can be
used for that.

I wonder how big that thing would become if we cache it for the
whole history, using something simple and lightweight like
berkeley db or dbm, 20-byte commit ID as the key (for now,
ignoring merges, but we could use 40-byte commit-parent ID pair
as the key) and a list of the number of insertions and deletions
for affected paths as the value.  If we can do it quickly
enough, you could put the cache update in post-update hook, so
that every time you push into the public repository the
patch-size cache is updated for gitweb's use.  This can be done
by the repository owner, and gitweb can stay read-only consumer
of the information.

Just in case people find this useful, here is a patch to
implement git-apply --numstat.

    ------------
[PATCH] git-apply --numstat

The new option, --numstat, shows number of inserted and deleted
lines for each path.  It is similar to --stat output but is
meant to be more machine friendly by giving number of added and
deleted lines and unabbreviated paths.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

git diff
diff --git a/apply.c b/apply.c
index e5c0b7d..73dfd0c 100644
--- a/apply.c
+++ b/apply.c
@@ -13,18 +13,20 @@
 //  --check turns on checking that the working tree matches the
 //    files that are being modified, but doesn't apply the patch
 //  --stat does just a diffstat, and doesn't actually apply
+//  --numstat does numeric diffstat, and doesn't actually apply
 //  --index-info shows the old and new index info for paths if available.
 //
 static int check_index = 0;
 static int write_index = 0;
 static int diffstat = 0;
+static int numstat = 0;
 static int summary = 0;
 static int check = 0;
 static int apply = 1;
 static int show_index_info = 0;
 static int line_termination = '\n';
 static const char apply_usage[] =
-"git-apply [--stat] [--summary] [--check] [--index] [--apply] [--index-info] [-z] <patch>...";
+"git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--apply] [--index-info] [-z] <patch>...";
 
 /*
  * For "diff-stat" like behaviour, we keep track of the biggest change
@@ -1317,6 +1319,20 @@ static void stat_patch_list(struct patch
 	printf(" %d files changed, %d insertions(+), %d deletions(-)\n", files, adds, dels);
 }
 
+static void numstat_patch_list(struct patch *patch)
+{
+	for ( ; patch; patch = patch->next) { 
+		const char *name;
+		name = patch->old_name ? patch->old_name : patch->new_name;
+		printf("%d\t%d\t", patch->lines_added, patch->lines_deleted);
+		if (line_termination && quote_c_style(name, NULL, NULL, 0))
+			quote_c_style(name, NULL, stdout, 0);
+		else
+			fputs(name, stdout);
+		putchar('\n');
+	}
+}
+
 static void show_file_mode_name(const char *newdelete, unsigned int mode, const char *name)
 {
 	if (mode)
@@ -1650,6 +1666,9 @@ static int apply_patch(int fd)
 	if (diffstat)
 		stat_patch_list(list);
 
+	if (numstat)
+		numstat_patch_list(list);
+	
 	if (summary)
 		summary_patch_list(list);
 
@@ -1683,6 +1702,11 @@ int main(int argc, char **argv)
 			diffstat = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--numstat")) {
+			apply = 0;
+			numstat = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--summary")) {
 			apply = 0;
 			summary = 1;
