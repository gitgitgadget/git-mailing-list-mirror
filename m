From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] revert/cherry-pick: work on merge commits as well
Date: Tue, 23 Oct 2007 13:33:26 -0700
Message-ID: <7vejfl7eqx.fsf_-_@gitster.siamese.dyndns.org>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net>
	<alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org>
	<7vir4x7hiu.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0710231247301.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 22:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkQRc-0005fs-Tb
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 22:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbXJWUdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 16:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909AbXJWUde
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 16:33:34 -0400
Received: from rune.pobox.com ([208.210.124.79]:44443 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbXJWUdd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 16:33:33 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 5DD9A14EB2B;
	Tue, 23 Oct 2007 16:33:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D5C9614EB52;
	Tue, 23 Oct 2007 16:33:49 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0710231247301.30120@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 23 Oct 2007 12:49:12 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62158>

Usually you cannot revert a merge because you do not know which
side of the merge should be considered the mainline (iow, what
change to reverse).

With this patch, cherry-pick and revert learn -m (--mainline)
option that lets you specify the parent number (starting from 1)
of the mainline, so that you can:

	git revert -m 1 $merge

to reverse the changes introduced by the $merge commit relative
to its first parent, and:

	git cherry-pick -m 2 $merge

to replay the changes introduced by the $merge commit relative
to its second parent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Linus Torvalds <torvalds@linux-foundation.org> writes:

 > On Tue, 23 Oct 2007, Junio C Hamano wrote:
 >> 
 >> Desire to revert an octopus would, as you demonstrated, often be
 >> to revert only one arm, but I think allowing to revert a twohead
 >> merge should be trivial.  If we define "reverting a merge" to
 >> always revert all arms, then this should suffice.
 >
 > The only reason I don't like this is that it kind of assumes that the 
 > mainline is the first parent. 
 >
 > Maybe I'd like to revert a merge, but I want to revert a merge that 
 > somebody *else* did, and maybe it was the first-hand parent I don't like. 
 >
 > Those kinds of issues don't exist with non-merge commits: there's never 
 > any question "which side" to revert.

 Fair enough.  How about this?

 Documentation/git-cherry-pick.txt |    9 +++++++-
 Documentation/git-revert.txt      |    9 +++++++-
 builtin-revert.c                  |   42 ++++++++++++++++++++++++++++++------
 git-compat-util.h                 |   13 +++++++++++
 4 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 76a2edf..937c4a7 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -7,7 +7,7 @@ git-cherry-pick - Apply the change introduced by an existing commit
 
 SYNOPSIS
 --------
-'git-cherry-pick' [--edit] [-n] [-x] <commit>
+'git-cherry-pick' [--edit] [-n] [-m parent-number] [-x] <commit>
 
 DESCRIPTION
 -----------
@@ -44,6 +44,13 @@ OPTIONS
 	described above, and `-r` was to disable it.  Now the
 	default is not to do `-x` so this option is a no-op.
 
+-m parent-number|--mainline parent-number::
+	Usually you cannot revert a merge because you do not know which
+	side of the merge should be considered the mainline.  This
+	option specifies the parent number (starting from 1) of
+	the mainline and allows cherry-pick to replay the change
+	relative to the specified parent.
+
 -n|--no-commit::
 	Usually the command automatically creates a commit with
 	a commit log message stating which commit was
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 69db498..3457c40 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -7,7 +7,7 @@ git-revert - Revert an existing commit
 
 SYNOPSIS
 --------
-'git-revert' [--edit | --no-edit] [-n] <commit>
+'git-revert' [--edit | --no-edit] [-n] [-m parent-number] <commit>
 
 DESCRIPTION
 -----------
@@ -27,6 +27,13 @@ OPTIONS
 	message prior committing the revert. This is the default if
 	you run the command from a terminal.
 
+-m parent-number|--mainline parent-number::
+	Usually you cannot revert a merge because you do not know which
+	side of the merge should be considered the mainline.  This
+	option specifies the parent number (starting from 1) of
+	the mainline and allows revert to reverse the change
+	relative to the specified parent.
+
 --no-edit::
 	With this option, `git-revert` will not start the commit
 	message editor.
diff --git a/builtin-revert.c b/builtin-revert.c
index a655c8e..bfed69d 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -19,9 +19,9 @@
  * Copyright (c) 2005 Junio C Hamano
  */
 
-static const char *revert_usage = "git-revert [--edit | --no-edit] [-n] <commit-ish>";
+static const char *revert_usage = "git-revert [--edit | --no-edit] [-n] [-m parent-number] <commit-ish>";
 
-static const char *cherry_pick_usage = "git-cherry-pick [--edit] [-n] [-r] [-x] <commit-ish>";
+static const char *cherry_pick_usage = "git-cherry-pick [--edit] [-n] [-m parent-number] [-r] [-x] <commit-ish>";
 
 static int edit;
 static int replay;
@@ -29,6 +29,7 @@ static enum { REVERT, CHERRY_PICK } action;
 static int no_commit;
 static struct commit *commit;
 static int needed_deref;
+static int mainline;
 
 static const char *me;
 
@@ -58,6 +59,12 @@ static void parse_options(int argc, const char **argv)
 		else if (!strcmp(arg, "-x") || !strcmp(arg, "--i-really-want-"
 				"to-expose-my-private-commit-object-name"))
 			replay = 0;
+		else if (!strcmp(arg, "-m") || !strcmp(arg, "--mainline")) {
+			if (++i >= argc ||
+			    strtol_i(argv[i], 10, &mainline) ||
+			    mainline <= 0)
+				usage(usage_str);
+		}
 		else if (strcmp(arg, "-r"))
 			usage(usage_str);
 	}
@@ -234,7 +241,7 @@ static int merge_recursive(const char *base_sha1,
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
-	struct commit *base, *next;
+	struct commit *base, *next, *parent;
 	int i;
 	char *oneline, *reencoded_message = NULL;
 	const char *message, *encoding;
@@ -269,8 +276,29 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	if (!commit->parents)
 		die ("Cannot %s a root commit", me);
-	if (commit->parents->next)
-		die ("Cannot %s a multi-parent commit.", me);
+	if (commit->parents->next) {
+		/* Reverting or cherry-picking a merge commit */
+		int cnt;
+		struct commit_list *p;
+
+		if (!mainline)
+			die("Commit %s is a merge but no -m option was given.",
+			    sha1_to_hex(commit->object.sha1));
+
+		for (cnt = 1, p = commit->parents;
+		     cnt != mainline && p;
+		     cnt++)
+			p = p->next;
+		if (cnt != mainline || !p)
+			die("Commit %s does not have parent %d",
+			    sha1_to_hex(commit->object.sha1), mainline);
+		parent = p->item;
+	} else if (0 < mainline)
+		die("Mainline was specified but commit %s is not a merge.",
+		    sha1_to_hex(commit->object.sha1));
+	else
+		parent = commit->parents->item;
+
 	if (!(message = commit->buffer))
 		die ("Cannot get commit message for %s",
 				sha1_to_hex(commit->object.sha1));
@@ -299,14 +327,14 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		char *oneline_body = strchr(oneline, ' ');
 
 		base = commit;
-		next = commit->parents->item;
+		next = parent;
 		add_to_msg("Revert \"");
 		add_to_msg(oneline_body + 1);
 		add_to_msg("\"\n\nThis reverts commit ");
 		add_to_msg(sha1_to_hex(commit->object.sha1));
 		add_to_msg(".\n");
 	} else {
-		base = commit->parents->item;
+		base = parent;
 		next = commit;
 		set_author_ident_env(message);
 		add_message_to_msg(message);
diff --git a/git-compat-util.h b/git-compat-util.h
index f23d934..a12c36b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -376,4 +376,17 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
 	return 0;
 }
 
+static inline int strtol_i(char const *s, int base, int *result)
+{
+	long ul;
+	char *p;
+
+	errno = 0;
+	ul = strtol(s, &p, base);
+	if (errno || *p || p == s || (int) ul != ul)
+		return -1;
+	*result = ul;
+	return 0;
+}
+
 #endif
-- 
1.5.3.4.1324.ga7925
