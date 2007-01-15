From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fetch while on "(no branch)"
Date: Mon, 15 Jan 2007 13:56:05 -0800
Message-ID: <7vzm8k0xai.fsf@assigned-by-dhcp.cox.net>
References: <200701151009.51868.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 22:56:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6ZoW-0006Gy-GN
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 22:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbXAOV4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 16:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXAOV4J
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 16:56:09 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:39132 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbXAOV4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 16:56:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070115215607.PPNZ19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Mon, 15 Jan 2007 16:56:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id BZvD1W00c1kojtg0000000; Mon, 15 Jan 2007 16:55:14 -0500
To: Andy Parkins <andyparkins@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36887>

Andy Parkins <andyparkins@gmail.com> writes:

> Hello,
>
> Just ran this while on a detached HEAD.
>
> $ git fetch
> fatal: ref HEAD is not a symbolic ref
> fatal: ref HEAD is not a symbolic ref
> fatal: ref HEAD is not a symbolic ref
> remote: Generating pack...
> ...etc...
>
> The fetch appears to have succeeded anyway, but it's a scary message that 
> tells a user something is "fatal".  Has this done any damage?

I do not think it has done any damage, but that is certainly alarming.
This might help (untested, of course).

By the way, with or without this patch, there currently is no
good way to tell failure modes between "git symbolic-ref HAED"
and "git symbolic-ref HEAD".  Both says "is not a symbolic ref".

We may want to do something about it.

---


diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index 4bc35a1..1e818bb 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -7,7 +7,7 @@ git-symbolic-ref - read and modify symbolic refs
 
 SYNOPSIS
 --------
-'git-symbolic-ref' <name> [<ref>]
+'git-symbolic-ref' [-q] <name> [<ref>]
 
 DESCRIPTION
 -----------
@@ -23,6 +23,14 @@ A symbolic ref is a regular file that stores a string that
 begins with `ref: refs/`.  For example, your `.git/HEAD` is
 a regular file whose contents is `ref: refs/heads/master`.
 
+OPTIONS
+-------
+
+-q::
+	Do not issue an error message if the <name> is not a
+	symbolic ref but a detached HEAD; instead exit with
+	non-zero status silently.
+
 NOTES
 -----
 In the past, `.git/HEAD` was a symbolic link pointing at
diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index d8be052..227c9d4 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -3,9 +3,9 @@
 #include "refs.h"
 
 static const char git_symbolic_ref_usage[] =
-"git-symbolic-ref name [ref]";
+"git-symbolic-ref [-q] name [ref]";
 
-static void check_symref(const char *HEAD)
+static void check_symref(const char *HEAD, int quiet)
 {
 	unsigned char sha1[20];
 	int flag;
@@ -13,17 +13,41 @@ static void check_symref(const char *HEAD)
 
 	if (!refs_heads_master)
 		die("No such ref: %s", HEAD);
-	else if (!(flag & REF_ISSYMREF))
-		die("ref %s is not a symbolic ref", HEAD);
+	else if (!(flag & REF_ISSYMREF)) {
+		if (!quiet)
+			die("ref %s is not a symbolic ref", HEAD);
+		else
+			exit(1);
+	}
 	puts(refs_heads_master);
 }
 
 int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 {
+	int quiet = 0;
+
 	git_config(git_default_config);
+
+	while (1 < argc) {
+		const char *arg = argv[1];
+		if (arg[0] != '-')
+			break;
+		else if (!strcmp("-q", arg))
+			quiet = 1;
+		else if (!strcmp("--", arg)) {
+			argc--;
+			argv++;
+			break;
+		}
+		else
+			die("unknown option %s", arg);
+		argc--;
+		argv++;
+	}
+
 	switch (argc) {
 	case 2:
-		check_symref(argv[1]);
+		check_symref(argv[1], quiet);
 		break;
 	case 3:
 		create_symref(argv[1], argv[2]);
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index d2e4c2b..4fc6020 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -49,7 +49,7 @@ get_remote_url () {
 }
 
 get_default_remote () {
-	curr_branch=$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
+	curr_branch=$(git-symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
 	origin=$(git-repo-config --get "branch.$curr_branch.remote")
 	echo ${origin:-origin}
 }
@@ -137,7 +137,7 @@ canon_refs_list_for_fetch () {
 		shift
 		if test "$remote" = "$(get_default_remote)"
 		then
-			curr_branch=$(git-symbolic-ref HEAD | \
+			curr_branch=$(git-symbolic-ref -q HEAD | \
 			    sed -e 's|^refs/heads/||')
 			merge_branches=$(git-repo-config \
 			    --get-all "branch.${curr_branch}.merge")
