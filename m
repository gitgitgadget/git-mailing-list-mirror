From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How to list versioned files with modification status
Date: Sat, 4 Oct 2008 16:10:17 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810041608150.3208@nehalem.linux-foundation.org>
References: <20081004131256.586a5fbf@smartavionics.com> <81b0412b0810041440w131647aeo9c14f55cd38da635@mail.gmail.com> <loom.20081004T215458-15@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 01:12:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmGI6-0001jK-Os
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 01:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765AbYJDXKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 19:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754756AbYJDXKf
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 19:10:35 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40633 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754633AbYJDXKe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Oct 2008 19:10:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m94NAHQw021217
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 4 Oct 2008 16:10:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m94NAH2O004394;
	Sat, 4 Oct 2008 16:10:17 -0700
In-Reply-To: <loom.20081004T215458-15@post.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.434 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97487>


On Sat, 4 Oct 2008, Mark Burton wrote:
>
> 'git diff --name-status' looks useful but it only shows the files that have
> changed - I would like to see the names of the files that haven't changed. Even
> svn could do that (svn status).

Nobody has ever asked for such a crazy thing, but here's a test-patch to 
teach 'git ls-files' the '--unmodified' flag.

It's strictly bigger than need be, partly because ls-files is a horror, 
partly because it needed that 'name_status()' helper function to make it 
not turn into something even worse.

I also fixed a git ls-files buglet: a deleted file implies modification, 
so if you ask for --deleted _and_ --modified at the same time, you'll see 
a deleted file listed twice. Use '-v' to see the type. This makes it 
only show it once - as deleted if you asked for that information, 
otherwise as modified.

So with something like this, you can do

	git ls-files -v --modified --deleted --unmodified

and you'll see all files with a tag in front (the tag for unmodified is 
empty).

Not very well tested (aka "Hey, it's a patch from Linus, caveat emptor!")

		Linus

---
 builtin-ls-files.c |   48 +++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 068f424..27a318a 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -18,6 +18,7 @@ static int show_others;
 static int show_stage;
 static int show_unmerged;
 static int show_modified;
+static int show_unmodified;
 static int show_killed;
 static int show_valid_bit;
 static int line_terminator = '\n';
@@ -35,6 +36,7 @@ static const char *tag_removed = "";
 static const char *tag_other = "";
 static const char *tag_killed = "";
 static const char *tag_modified = "";
+static const char *tag_unmodified = "";
 
 
 /*
@@ -218,6 +220,20 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 	write_name_quoted(ce->name + offset, stdout, line_terminator);
 }
 
+enum show_state {
+	unmodified, deleted, modified
+};
+
+static enum show_state name_status(struct cache_entry *ce)
+{
+	struct stat st;
+	int err = lstat(ce->name, &st);
+
+	if (err)
+		return deleted;
+	return ce_modified(ce, &st, 0) ? modified : unmodified;
+}
+
 static void show_files(struct dir_struct *dir, const char *prefix)
 {
 	int i;
@@ -248,19 +264,27 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
 		}
 	}
-	if (show_deleted | show_modified) {
+	if (show_deleted | show_modified | show_unmodified) {
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
-			struct stat st;
-			int err;
 			int dtype = ce_to_dtype(ce);
 			if (excluded(dir, ce->name, &dtype) != dir->show_ignored)
 				continue;
-			err = lstat(ce->name, &st);
-			if (show_deleted && err)
-				show_ce_entry(tag_removed, ce);
-			if (show_modified && ce_modified(ce, &st, 0))
-				show_ce_entry(tag_modified, ce);
+			switch (name_status(ce)) {
+			default:
+				if (show_unmodified)
+					show_ce_entry(tag_unmodified, ce);
+				break;
+			case deleted:
+				if (show_deleted) {
+					show_ce_entry(tag_removed, ce);
+					break;
+				}
+				/* Fall through */
+			case modified:
+				if (show_modified)
+					show_ce_entry(tag_modified, ce);
+			}
 		}
 	}
 }
@@ -457,6 +481,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 			tag_modified = "C ";
 			tag_other = "? ";
 			tag_killed = "K ";
+			tag_unmodified = "  ";
 			if (arg[1] == 'v')
 				show_valid_bit = 1;
 			continue;
@@ -474,6 +499,11 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 			require_work_tree = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--unmodified")) {
+			show_unmodified = 1;
+			require_work_tree = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-o") || !strcmp(arg, "--others")) {
 			show_others = 1;
 			require_work_tree = 1;
@@ -593,7 +623,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 
 	/* With no flags, we default to showing the cached files */
 	if (!(show_stage | show_deleted | show_others | show_unmerged |
-	      show_killed | show_modified))
+	      show_killed | show_modified | show_unmodified))
 		show_cached = 1;
 
 	read_cache();
