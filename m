From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [RFC/PATCH] git-submodule: add support for --rebase.
Date: Wed, 8 Apr 2009 14:22:14 +1000
Message-ID: <20090408042212.GA4702@dingo.bne.redhat.com>
References: <20090407111445.GA11344@dingo> <alpine.DEB.1.00.0904071428350.6897@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 08 06:24:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrPKq-0003Qp-6B
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 06:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbZDHEWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 00:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbZDHEWv
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 00:22:51 -0400
Received: from ipx-119-252-190-80.ipxserver.de ([80.190.252.119]:36821 "EHLO
	ipx10616.ipxserver.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750997AbZDHEWu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 00:22:50 -0400
Received: from whot by ipx10616.ipxserver.de with local (Exim 4.63)
	(envelope-from <peter.hutterer@who-t.net>)
	id 1LrPJG-0001RA-J6; Wed, 08 Apr 2009 06:22:47 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904071428350.6897@intel-tinevez-2-302>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116030>

On Tue, Apr 07, 2009 at 02:38:37PM +0200, Johannes Schindelin wrote:
> Disclaimer: if you are offended by constructive criticism, or likely to
> answer with insults to the comments I offer, please stop reading this mail
> now (and please do not answer my mail, either). :-)
> 
> Still with me?  Good.  Nice to meet you.
> 
> Just for the record: responding to a patch is my strongest way of saying
> that I appreciate your work.

Thanks for the review, the updated patch is below. 
Changes:
- Commit message extended with a description of why this patch is handy.
- Less duplication in the if --rebase/else condition.
- Test case included. The test updates with and without rebase and compares
  the sha of HEAD to the sha of the master branch.

I do have a few other comments though:

> > 'git submodule update --rebase' rebases onto the current branch rather 
> > than detaching the HEAD.
> 
> I know what you want to do, but this text is wrong: it should rather read 
> something like this:
> 
> 	'git submodule update --rebase' rebases your local branch on 
> 	top of what would have been checked out to a detached HEAD 
> 	otherwise.
> 
> Maybe some of these native English speakers on this list can come up with 
> something even better ;-)

amended to your version, see below.

> > I use git-submodule to keep track of repositories that I only 
> > infrequently commit to. I keep them to have a set that is known to work.
> > 
> > git submodule update is annoying, as it (in my case needlessly) detaches the
> > HEAD, making the workflow more complicated when I do have to commit (checkout
> > master, rebase onto master, then commit).
> > 
> > This patch adds a "--rebase" flag to git submodule update that calls
> > git-rebase instead of git-checkout.
> 
> Maybe a non-first person version of this comment could go into the commit 
> message, too?  I found this highly informative.

amended, see below

> > diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> > index 3b8df44..117ad3d 100644
> > --- a/Documentation/git-submodule.txt
> > +++ b/Documentation/git-submodule.txt
> > @@ -177,6 +178,12 @@ OPTIONS
> >  	This option is only valid for the update command.
> >  	Don't fetch new objects from the remote site.
> >  
> > +--rebase::
> > +	This option is only valid for the update command.
> 
> This is unnecessary, it was mentioned in the synopsis.

Correct, but in the same file the options --cached, --no-fetch, and
--summary-limit do state that they are only valid for the
update/status/summary commands, respectively. For consistency, we should
either add this sentence to --rebase, or remove them from the others. I
personally prefer having it there, just to make it more obvious.

> > +	Forward-port local commits to the index of the containing repository.
> 
> This is a bit misleading/unclear.  I'd rather have it read like this:
> 
> 	Instead of detaching the HEAD to the revision committed in the 
> 	superproject, rebase the current branch onto that revision.

Hehe. I had something like this before and then decided to copy/paste the line
from the git-rebase man page :)

Changed to: "Rebase the current branch onto the index of the containing
repository instead of detaching the HEAD." (I vaguely remember the rule that
sentences are easier to understand if you have "blah instead of foo" rather
than "instead of foo, blah")
The phrase "index of the containing repository" is commonly used in this man
page, so I think it's best to stick with it.
That better now?

> > +	If a a merge failure prevents this process, you will have to resolve
> > +	these failures with linkgit:git-rebase[1].
> > +
> >  <path>...::
> >  	Paths to submodule(s). When specified this will restrict the command
> >  	to only operate on the submodules found at the specified paths.
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 7c2e060..6180bf4 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> 
> You might want to error out when --rebase was passed with another command 
> than "update".

cmd_init(), cmd_summary(), etc. have catch-all rules for unknown options to
display the usage, so this is covered. (e.g. line 439, git-submodule.sh)

> > @@ -367,11 +372,19 @@ cmd_update()
> >  				die "Unable to fetch in submodule path '$path'"
> >  			fi
> >  
> > -			(unset GIT_DIR; cd "$path" &&
> > -				  git-checkout $force -q "$sha1") ||
> > -			die "Unable to checkout '$sha1' in submodule path '$path'"
> > +			if test -z "$rebase"
> > +			then
> > +				(unset GIT_DIR; cd "$path" &&
> > +					  git-checkout $force -q "$sha1") ||
> > +				die "Unable to checkout '$sha1' in submodule path '$path'"
> > +				say "Submodule path '$path': checked out '$sha1'"
> > +			else
> > +				(unset GIT_DIR; cd "$path" &&
> > +					git-rebase "$sha1") ||
> > +					die "Unable to rebase onto '$sha1' in submodule path '$path'"
> > +				say "Submodule path '$path': rebased onto '$sha1'"
> > +			fi
> 
> I'd actually put the "(unset GIT_DIR; cd "$path" &&" in front of the "if" 
> due to the DRY principle (Don't Repeat Yourself).
> 
> In the same spirit, I'd set a variable "action" to "checkout" or "rebase 
> onto" and munge the error/info message to use $action.
 
amended, see patch below

> Maybe you want to add a single primitive test case to make sure this 
> feature will not get broken in the future?
> 
> Other than that: nice!  very nice!
> 
> Ciao,
> Dscho
> 
> P.S.: the next patch is obvious, too: add support to specify desire to 
> rebase the submodule in .gitmodules and .git/config.
 
Cheers,
  Peter

>From b5ed1a17aa9b6042f68a546ceb3990b65d0862e0 Mon Sep 17 00:00:00 2001
From: Peter Hutterer <peter.hutterer@who-t.net>
Date: Fri, 27 Mar 2009 13:42:42 +1000
Subject: [PATCH] git-submodule: add support for --rebase.

'git submodule update --rebase' rebases your local branch on top of what would
have been checked out to a detached HEAD otherwise.

In some cases, detaching the HEAD when updating a submodule complicates the
workflow to commit to this submodule (checkout master, rebase, then commit).
For submodules that require frequent updates but infrequent (if any) commits,
a rebase can be executed directly by the git-submodule command, ensuring that
the submodules stay on their respective branches.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 Documentation/git-submodule.txt |   12 +++++-
 git-submodule.sh                |   22 +++++++++--
 t/t7404-submodule-update.sh     |   79 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 6 deletions(-)
 create mode 100755 t/t7404-submodule-update.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 3b8df44..7e0dcb1 100644
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
@@ -177,6 +178,13 @@ OPTIONS
 	This option is only valid for the update command.
 	Don't fetch new objects from the remote site.
 
+--rebase::
+	This option is only valid for the update command.
+	Rebase the current branch onto the index of the containing repository
+	instead of detaching the HEAD.
+	If a a merge failure prevents this process, you will have to resolve
+	these failures with linkgit:git-rebase[1].
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/git-submodule.sh b/git-submodule.sh
index 7c2e060..e2d40ee 100755
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
@@ -367,11 +372,20 @@ cmd_update()
 				die "Unable to fetch in submodule path '$path'"
 			fi
 
-			(unset GIT_DIR; cd "$path" &&
-				  git-checkout $force -q "$sha1") ||
-			die "Unable to checkout '$sha1' in submodule path '$path'"
+			if test -z "$rebase"
+			then
+				command="git-checkout $force -q"
+				action="checkout"
+				msg="checked out"
+			else
+				command="git-rebase"
+				action="rebase"
+				msg="rebased onto"
+			fi
 
-			say "Submodule path '$path': checked out '$sha1'"
+			(unset GIT_DIR; cd "$path" && $command "$sha1") ||
+			die "Unable to $action '$sha1' in submodule path '$path'"
+			say "Submodule path '$path': $msg '$sha1'"
 		fi
 	done
 }
diff --git a/t/t7404-submodule-update.sh b/t/t7404-submodule-update.sh
new file mode 100755
index 0000000..55fa291
--- /dev/null
+++ b/t/t7404-submodule-update.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Red Hat, Inc.
+#
+
+test_description='Test updating submodules
+
+This test verifies that "git submodule update" detaches the HEAD of the
+submodule and "git submodule update --rebase" does not detach the HEAD.
+'
+
+. ./test-lib.sh
+
+
+compare_head()
+{
+    sha_master=`git-rev-list --max-count=1 master`
+    sha_head=`git-rev-list --max-count=1 HEAD`
+
+    test "$sha_master" = "$sha_head"
+}
+
+
+test_expect_success 'setup a submodule tree' '
+	echo file > file &&
+	git add file &&
+	test_tick &&
+	git commit -m upstream
+	git clone . super &&
+	git clone super submodule &&
+	(cd super &&
+	 git submodule add ../submodule submodule &&
+	 test_tick &&
+	 git commit -m "submodule" &&
+	 git submodule init submodule
+	) &&
+	(cd submodule &&
+	echo "line2" > file &&
+	git add file &&
+	git commit -m "Commit 2"
+	) &&
+	(cd super &&
+ 	 (cd submodule &&
+	  git pull --rebase origin
+	 ) &&
+	 git add submodule &&
+	 git commit -m "submodule update"
+	)
+'
+
+test_expect_success 'submodule update detaching the HEAD ' '
+	(cd super/submodule &&
+	 git reset --hard HEAD~1
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update submodule &&
+	 cd submodule &&
+	 ! compare_head
+	)
+'
+
+test_expect_success 'submodule update --rebase staying on master' '
+	(cd super/submodule &&
+	  git checkout master
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update --rebase submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
+test_done
-- 
1.6.2.2.447.g4afa7
