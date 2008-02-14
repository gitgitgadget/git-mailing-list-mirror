From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-branch -m interprets first argument differently when two
 are   supplied
Date: Thu, 14 Feb 2008 08:37:40 +0100
Message-ID: <47B3EFC4.1020808@viscovery.net>
References: <47B3497A.9050703@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Feb 14 08:38:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPYfu-00039d-Q9
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 08:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757527AbYBNHhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 02:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757506AbYBNHhp
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 02:37:45 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:20494 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757260AbYBNHho (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 02:37:44 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JPYeh-0004PN-Du; Thu, 14 Feb 2008 08:37:15 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3B5D8A33B; Thu, 14 Feb 2008 08:37:40 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <47B3497A.9050703@nrlssc.navy.mil>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73863>

Brandon Casey schrieb:
> The first non-option argument is interpreted differently depending on
> whether one argument or two arguments have been supplied.
> 
> 	git-branch -m [<oldbranch>] <newbranch>
> 
> Has anyone considered whether this is inconsistent with how other
> commands operate?

Funny, I fell into this trap just yesterday and accidentally renamed
my master branch to something else. IMO git-branch -m should take two
arguments. Full stop.

Something like this.

-- >8 --
From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] git-branch: Deprecate -m with only one argument.

"git branch -m" can be invoked with only one argument, in which case
it renames the current branch to the new name. This is inconsistent since
the first argument is either a source or destination depending on whether
a second argument follows. Furthermore, it is surprising that a rename
command that is given only one argument succeeds at all.

Let's aim for removing this feature.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Documentation/git-branch.txt |    4 ++--
 builtin-branch.c             |    9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 7e8874a..56bea06 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	   [-v [--abbrev=<length> | --no-abbrev]]
 	   [--contains <commit>]
 'git-branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
-'git-branch' (-m | -M) [<oldbranch>] <newbranch>
+'git-branch' (-m | -M) <oldbranch> <newbranch>
 'git-branch' (-d | -D) [-r] <branchname>...

 DESCRIPTION
@@ -136,7 +136,7 @@ OPTIONS

 <newbranch>::
 	The new name for an existing branch. The same restrictions as for
-	<branchname> applies.
+	<branchname> apply.


 Examples
diff --git a/builtin-branch.c b/builtin-branch.c
index e414c88..14df594 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -17,7 +17,7 @@ static const char * const builtin_branch_usage[] = {
 	"git-branch [options] [-r | -a]",
 	"git-branch [options] [-l] [-f] <branchname> [<start-point>]",
 	"git-branch [options] [-r] (-d | -D) <branchname>",
-	"git-branch [options] (-m | -M) [<oldbranch>] <newbranch>",
+	"git-branch [options] (-m | -M) <oldbranch> <newbranch>",
 	NULL
 };

@@ -609,9 +609,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		return delete_branches(argc, argv, delete > 1, kinds);
 	else if (argc == 0)
 		print_ref_list(kinds, detached, verbose, abbrev, with_commit);
-	else if (rename && (argc == 1))
+	else if (rename && (argc == 1)) {
+		fprintf(stderr, "'git branch -m' with only one parameter is deprecated.\n"
+			"Will continue, assuming that you meant\n"
+			"    git branch -m %s %s\n", head, argv[0]);
 		rename_branch(head, argv[0], rename > 1);
-	else if (rename && (argc == 2))
+	} else if (rename && (argc == 2))
 		rename_branch(argv[0], argv[1], rename > 1);
 	else if (argc <= 2)
 		create_branch(argv[0], (argc == 2) ? argv[1] : head,
-- 
1.5.4.1.104.g84d88
