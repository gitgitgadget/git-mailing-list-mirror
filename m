From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [RFC/PATCH] git-submodule: add support for --rebase.
Date: Tue, 7 Apr 2009 21:14:55 +1000
Message-ID: <20090407111445.GA11344@dingo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 14:09:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrA7R-0004NI-9T
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 14:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbZDGMGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 08:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755779AbZDGMGS
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 08:06:18 -0400
Received: from ipx-119-252-190-80.ipxserver.de ([80.190.252.119]:43214 "EHLO
	ipx10616.ipxserver.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757521AbZDGMGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 08:06:16 -0400
X-Greylist: delayed 3044 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Apr 2009 08:06:15 EDT
Received: from whot by ipx10616.ipxserver.de with local (Exim 4.63)
	(envelope-from <peter.hutterer@who-t.net>)
	id 1Lr9H6-0006ks-0x
	for git@vger.kernel.org; Tue, 07 Apr 2009 13:15:28 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115950>

'git submodule update --rebase' rebases onto the current branch rather than
detaching the HEAD.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---

I use git-submodule to keep track of repositories that I only infrequently
commit to. I keep them to have a set that is known to work.

git submodule update is annoying, as it (in my case needlessly) detaches the
HEAD, making the workflow more complicated when I do have to commit (checkout
master, rebase onto master, then commit).

This patch adds a "--rebase" flag to git submodule update that calls
git-rebase instead of git-checkout.

Any comments? Is there a better solution for this problem?

Cheers,
  Peter

 Documentation/git-submodule.txt |   11 +++++++++--
 git-submodule.sh                |   21 +++++++++++++++++----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 3b8df44..117ad3d 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git submodule' [--quiet] add [-b branch] [--] <repository> <path>
 'git submodule' [--quiet] status [--cached] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--] [<path>...]
+'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach <command>
 'git submodule' [--quiet] sync [--] [<path>...]
@@ -113,7 +113,8 @@ init::
 update::
 	Update the registered submodules, i.e. clone missing submodules and
 	checkout the commit specified in the index of the containing repository.
-	This will make the submodules HEAD be detached.
+	This will make the submodules HEAD be detached unless '--rebase' is
+	specified.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
@@ -177,6 +178,12 @@ OPTIONS
 	This option is only valid for the update command.
 	Don't fetch new objects from the remote site.
 
+--rebase::
+	This option is only valid for the update command.
+	Forward-port local commits to the index of the containing repository.
+	If a a merge failure prevents this process, you will have to resolve
+	these failures with linkgit:git-rebase[1].
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/git-submodule.sh b/git-submodule.sh
index 7c2e060..6180bf4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -17,6 +17,7 @@ branch=
 quiet=
 cached=
 nofetch=
+rebase=
 
 #
 # print stuff on stdout unless -q was specified
@@ -314,6 +315,10 @@ cmd_update()
 			shift
 			nofetch=1
 			;;
+		-r|--rebase)
+			shift
+			rebase=1
+			;;
 		--)
 			shift
 			break
@@ -367,11 +372,19 @@ cmd_update()
 				die "Unable to fetch in submodule path '$path'"
 			fi
 
-			(unset GIT_DIR; cd "$path" &&
-				  git-checkout $force -q "$sha1") ||
-			die "Unable to checkout '$sha1' in submodule path '$path'"
+			if test -z "$rebase"
+			then
+				(unset GIT_DIR; cd "$path" &&
+					  git-checkout $force -q "$sha1") ||
+				die "Unable to checkout '$sha1' in submodule path '$path'"
+				say "Submodule path '$path': checked out '$sha1'"
+			else
+				(unset GIT_DIR; cd "$path" &&
+					git-rebase "$sha1") ||
+					die "Unable to rebase onto '$sha1' in submodule path '$path'"
+				say "Submodule path '$path': rebased onto '$sha1'"
+			fi
 
-			say "Submodule path '$path': checked out '$sha1'"
 		fi
 	done
 }
-- 
1.6.2.2.447.ge953ab
