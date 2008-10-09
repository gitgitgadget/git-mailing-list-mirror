From: Thomas Rast <trast@student.ethz.ch>
Subject: [Interdiff] [RFC PATCH v2] Documentation: add manpage about workflows
Date: Thu,  9 Oct 2008 13:42:17 +0200
Message-ID: <1223552537-6918-2-git-send-email-trast@student.ethz.ch>
References: <adf1fd3d0810010254k5961b182ked9acda55e2aa57c@mail.gmail.com>
 <1223552537-6918-1-git-send-email-trast@student.ethz.ch>
Cc: <santi@agolina.net>, "Dmitry Potapov" <dpotapov@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 13:43:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kntva-0000tQ-Aq
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 13:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888AbYJILmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 07:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756784AbYJILmZ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 07:42:25 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:21224 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756754AbYJILmV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 07:42:21 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 9 Oct 2008 13:42:14 +0200
Received: from localhost.localdomain ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 9 Oct 2008 13:42:14 +0200
X-Mailer: git-send-email 1.6.0.2.796.gd596a
In-Reply-To: <1223552537-6918-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 09 Oct 2008 11:42:14.0939 (UTC) FILETIME=[1355B6B0:01C92A04]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97845>

---

I wrote:
> Interdiff will follow, as before.



diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 87c2270..037ace5 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -39,24 +39,32 @@ beginning. It is always easier to squash a few commits together than
 to split one big commit into several.  Don't be afraid of making too
 small or imperfect steps along the way. You can always go back later
 and edit the commits with `git rebase \--interactive` before you
-publish them.
+publish them.  You can use `git stash save \--keep-index` to run the
+test suite independent of other uncommitted changes; see the EXAMPLES
+section of linkgit:git-stash[1].
 
 
 MANAGING BRANCHES
 -----------------
 
-Usually a feature (or other change) evolves in stages: it "graduates"
-from patch to the testing branches and on to stable releases.  During
-this process, it may require fixes or improvements.  XXX terrible
-paragraph XXX
+There are two main tools that can be used to include changes from one
+branch on another: linkgit:git-merge[1] and
+linkgit:git-cherry-pick[1].
 
-Merges (as opposed to cherry-picks, see below) greatly simplify
-handling large numbers of commits, so a scalable workflow needs to use
-merges.  Fortunately Git is very good at merging.
+Merges have many advantages, so we try to solve as many problems as
+possible with merges alone.  Cherry-picking is still occasionally
+useful; see "Merging upwards" below for an example.
 
-XXX non sequitur XXX
-In the following sections we discuss some problems that arise from
-such a "change flow", and how to solve them with Git.
+Most importantly, merging works at the branch level, while
+cherry-picking works at the commit level.  This means that a merge can
+carry over the changes from 1, 10, or 1000 commits with equal ease,
+which in turn means the workflow scales much better to a large number
+of contributors (and contributions).  Merges are also easier to
+understand because a merge commit is a "promise" that all changes from
+all its parents are now included.
+
+There is a tradeoff of course: merges require a more careful branch
+management.  The following subsections discuss the important points.
 
 
 Graduation
@@ -66,13 +74,13 @@ As a given feature goes from experimental to stable, it also
 "graduates" between the corresponding branches of the software.
 `git.git` uses the following 'main branches':
 
-* 'master' tracks the commits that should go into the next release;
-
 * 'maint' tracks the commits that should go into the next "maintenance
-  release", i.e., update of the last released stable version; and
+  release", i.e., update of the last released stable version;
 
-* 'next' is intended as a testing branch for people who like to use
-  more experimental stuff.
+* 'master' tracks the commits that should go into the next release;
+
+* 'next' is intended as a testing branch for topics not stable enough
+  for master yet.
 
 There is a fourth official branch that is used slightly differently:
 
@@ -80,6 +88,9 @@ There is a fourth official branch that is used slightly differently:
   not quite ready for inclusion yet (see "Integration Branches"
   below).
 
+Each of the four branches is usually a direct descendant of the one
+above it.
+
 Conceptually, the feature enters at an unstable branch (usually 'next'
 or 'pu'), and "graduates" to 'master' for the next release once it is
 considered stable enough.
@@ -88,10 +99,9 @@ considered stable enough.
 Merging upwards
 ~~~~~~~~~~~~~~~
 
-As explained above, features conceptually "graduate downwards" to
-older releases.  This cannot be done by actually merging downwards,
-however, since that would merge 'all' changes on the unstable branch
-into the stable one.  Hence the following:
+The "downwards graduation" discussed above cannot be done by actually
+merging downwards, however, since that would merge 'all' changes on
+the unstable branch into the stable one.  Hence the following:
 
 .Merge upwards
 [caption="Rule: "]
@@ -187,45 +197,41 @@ into a throw-away branch.
 [caption="Rule: "]
 =====================================
 To test the interaction of several topics, merge them into a
-throw-away branch.
+throw-away branch.  You must never base any work on such a branch!
 =====================================
 
 If you make it (very) clear that this branch is going to be deleted
 right after the testing, you can even publish this branch, for example
 to give the testers a chance to work with it, or other developers a
 chance to see if their in-progress work will be compatible.  `git.git`
-has such an official integration branch called 'pu'.  You must never
-base any work on such a throw-away branch!
+has such an official integration branch called 'pu'.
 
 
-SHARING WORK
-------------
+DISTRIBUTED WORKFLOWS
+---------------------
 
 After the last section, you should know how to manage topics.  In
 general, you will not be the only person working on the project, so
 you will have to share your work.
 
-Roughly speaking, there are two important workflows: push/pull and
-format-patch/am.  The important difference is that push/pull can
-propagate merges, while format-patch cannot.  Medium to large projects
-will typically employ some mixture of the two:
+Roughly speaking, there are two important workflows: merge and patch.
+The important difference is that the merge workflow can propagate full
+history, including merges, while patches cannot.  Both workflows can
+be used in parallel: in `git.git`, only subsystem maintainers use
+the merge workflow, while everyone else sends patches.
 
-* "Upstream" in the most general sense 'pushes' changes to the
-  repositor(ies) holding the official history of the project.
-  Everyone can 'fetch' from there to stay up to date.
+Note that the maintainer(s) may impose restrictions, such as
+"Signed-off-by" requirements, that all commits/patches submitted for
+inclusion must adhere to.  Consult your project's documentation for
+more information.
 
-* Frequent contributors, subsystem maintainers, etc. may push to a
-  public repository to make their changes available to upstream.
-
-* The rest -- typically anyone more than one or two levels away from the
-  main maintainer -- send patches by mail.
-
-None of these boundaries are sharp, so find out what works best for
-you.
 
+Merge workflow
+~~~~~~~~~~~~~~
 
-Push/pull
-~~~~~~~~~
+The merge workflow works by copying branches between upstream and
+downstream.  Upstream can merge contributions into the official
+history; downstream base their work on the official history.
 
 There are three main tools that can be used for this:
 
@@ -267,11 +273,11 @@ explained earlier.
 
 If you are a maintainer and would like to merge other people's topic
 branches to the main branches, they will typically send a request to
-do so by mail.  Such a request might say
+do so by mail.  Such a request looks like
 
 -------------------------------------
 Please pull from
-    git://some.server.somewhere/random/repo.git mytopic
+    <url> <branch>
 -------------------------------------
 
 In that case, 'git-pull' can do the fetch and merge in one go, as
@@ -290,8 +296,8 @@ know better how to resolve them).  It is one of the rare cases where
 downstream 'should' merge from upstream.
 
 
-format-patch/am
-~~~~~~~~~~~~~~~
+Patch workflow
+~~~~~~~~~~~~~~
 
 If you are a contributor that sends changes upstream in the form of
 emails, you should use topic branches as usual (see above).  Then use
@@ -308,9 +314,7 @@ maintainer's life easier).
 =====================================
 
 See the linkgit:git-format-patch[1] and linkgit:git-send-email[1]
-manpages for further usage notes.  Also you should be aware that the
-maintainer may impose further restrictions, such as "Signed-off-by"
-requirements.
+manpages for further usage notes.
 
 If the maintainer tells you that your patch no longer applies to the
 current upstream, you will have to rebase your topic (you cannot use a
@@ -326,11 +330,11 @@ You can then fix the conflicts during the rebase.  Presumably you have
 not published your topic other than by mail, so rebasing it is not a
 problem.
 
-If you receive such a patch (as maintainer, or perhaps as a reader of
-the mailing list it was sent to), save the mail to a file and use
-'git-am':
+If you receive such a patch series (as maintainer, or perhaps as a
+reader of the mailing list it was sent to), save the mails to files,
+create a new topic branch and use 'git-am' to import the commits:
 
-.format-patch/am: Publishing branches/topics
+.format-patch/am: Importing patches
 [caption="Recipe: "]
 =====================================
 `git am < patch`
