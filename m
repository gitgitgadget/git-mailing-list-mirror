From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Add 'sane' mode to 'git reset'
Date: Mon, 1 Dec 2008 09:30:31 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812010908120.3256@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 18:32:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7CdN-00014w-2m
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 18:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbYLARbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 12:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbYLARbJ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 12:31:09 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60351 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752071AbYLARbH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2008 12:31:07 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mB1HUWdV032482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Dec 2008 09:30:33 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mB1HUVYZ012462;
	Mon, 1 Dec 2008 09:30:31 -0800
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.436 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102067>


We have always had a nice way to reset a working tree to another state 
while carrying our changes around: "git read-tree -u -m". Yes, it fails if 
the target tree is different in the paths that are dirty in the working 
tree, but this is how we used to switch branches in "git checkout", and it 
worked fine.

However, perhaps exactly _because_ we've supported this from very early 
on, another low-level command, namely "git reset", never did. 

But as time went on, 'git reset' remains as a very common command, while 
'git read-tree' is now a very odd and low-level plumbing thing that nobody 
sane should ever use, because it only makes sense together with other 
operations like either switching branches or just rewriting HEAD.

Which means that we have effectively lost the ability to do something very 
common: jump to another point in time without always dropping all our 
dirty state.

So add this kind of mode to "git reset", and since it's probably the 
sanest form of reset (it will not throw any state away), just call it 
that: "git reset --sane". It should probably be the default, but we likely 
cannot change the semantics of a regular "git reset", even though it is 
unlikely that very many people really use the current (insane) default 
mode of "--mixed" that only resets the index.

I've wanted this for a long time, since I very commonly carry a dirty 
tree while working on things. My main 'Makefile' file quite often has the 
next version already modified, and sometimes I have local modifications 
that I don't want to commit, but I still do pulls and patch applications, 
and occasionally want to do "git reset" to undo them - while still keeping 
my local modifications.

(Maybe we could eventually change it to something like "if we have a 
working tree, default to --sane, otherwise default to --mixed").

NOTE! This new mode is certainly not perfect. There's a few things to look 
out for:

 - if the index has unmerged entries, "--sane" will currently simply 
   refuse to reset ("you need to resolve your current index first"). 
   You'll need to use "--hard" or similar in this case.

   This is sad, because normally a unmerged index means that the working 
   tree file should have matched the source tree, so the correct action is 
   likely to make --sane reset such a path to the target (like --hard), 
   regardless of dirty state in-tree or in-index. But that's not how 
   read-tree has ever worked, so..

 - "git checkout -m" actually knows how to do a three-way merge, rather 
   than refuse to update the working tree. So we do know how to do that, 
   and arguably that would be even nicer behavior.

   At the same time it's also arguably true that there is a chance of loss 
   of state (ie you cannot get back to the original tree if the three-way 
   merge ends up resolving cleanly to no diff at all), so the "refuse to 
   do it" is in some respects the safer - but less user-friendly - option.

In other words, I think 'git reset --sane' could become a bit more 
friendly, but this is already a big improvement. It allows you to undo a 
recent commit without having to throw your current work away.

Yes, yes, with a dirty tree you could always do

	git stash
	git reset --hard
	git stash apply

instead, but isn't "git reset --sane" a nice way to handle one particular 
simple case?

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
--

Hmm? Maybe I'm the only one that does a lot of work with a dirty tree, and 
sure, I can do other things like the "git stash" thing, or using "git 
checkout" to actually create a new branch, and then playing games with 
branch renaming etc to make it work like this one. 

But I suspect others dislike how "git reset" works too. But see the 
suggested improvements above.

 builtin-reset.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 9514b77..05c176d 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -20,11 +20,14 @@
 #include "parse-options.h"
 
 static const char * const git_reset_usage[] = {
-	"git reset [--mixed | --soft | --hard] [-q] [<commit>]",
+	"git reset [--mixed | --soft | --hard | --sane] [-q] [<commit>]",
 	"git reset [--mixed] <commit> [--] <paths>...",
 	NULL
 };
 
+enum reset_type { MIXED, SOFT, HARD, SANE, NONE };
+static const char *reset_type_names[] = { "mixed", "soft", "hard", "sane", NULL };
+
 static char *args_to_str(const char **argv)
 {
 	char *buf = NULL;
@@ -49,7 +52,7 @@ static inline int is_merge(void)
 	return !access(git_path("MERGE_HEAD"), F_OK);
 }
 
-static int reset_index_file(const unsigned char *sha1, int is_hard_reset, int quiet)
+static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet)
 {
 	int i = 0;
 	const char *args[6];
@@ -57,9 +60,17 @@ static int reset_index_file(const unsigned char *sha1, int is_hard_reset, int qu
 	args[i++] = "read-tree";
 	if (!quiet)
 		args[i++] = "-v";
-	args[i++] = "--reset";
-	if (is_hard_reset)
+	switch (reset_type) {
+	case SANE:
 		args[i++] = "-u";
+		args[i++] = "-m";
+		break;
+	case HARD:
+		args[i++] = "-u";
+		/* fallthrough */
+	default:
+		args[i++] = "--reset";
+	}
 	args[i++] = sha1_to_hex(sha1);
 	args[i] = NULL;
 
@@ -169,9 +180,6 @@ static void prepend_reflog_action(const char *action, char *buf, size_t size)
 		warning("Reflog action message too long: %.*s...", 50, buf);
 }
 
-enum reset_type { MIXED, SOFT, HARD, NONE };
-static const char *reset_type_names[] = { "mixed", "soft", "hard", NULL };
-
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
@@ -186,6 +194,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "soft", &reset_type, "reset only HEAD", SOFT),
 		OPT_SET_INT(0, "hard", &reset_type,
 				"reset HEAD, index and working tree", HARD),
+		OPT_SET_INT(0, "sane", &reset_type,
+				"reset HEAD, index and working tree", SANE),
 		OPT_BOOLEAN('q', NULL, &quiet,
 				"disable showing new HEAD in hard reset and progress message"),
 		OPT_END()
@@ -266,7 +276,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		if (is_merge() || read_cache() < 0 || unmerged_cache())
 			die("Cannot do a soft reset in the middle of a merge.");
 	}
-	else if (reset_index_file(sha1, (reset_type == HARD), quiet))
+	else if (reset_index_file(sha1, reset_type, quiet))
 		die("Could not reset index file to revision '%s'.", rev);
 
 	/* Any resets update HEAD to the head being switched to,
