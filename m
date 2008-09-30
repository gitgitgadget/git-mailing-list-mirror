From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] Documentation: add manpage about workflows
Date: Tue, 30 Sep 2008 18:07:13 +0200
Message-ID: <200809301807.15932.trast@student.ethz.ch>
References: <1221147525-5589-3-git-send-email-trast@student.ethz.ch> <20080921202620.GG21650@dpotapov.dyndns.org> <200809301805.30753.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Santi =?utf-8?q?B=C3=A9jar?=" <santi@agolina.net>,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 18:08:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkhm5-0006Zi-Go
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 18:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbYI3QHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 12:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbYI3QHS
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 12:07:18 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:38901 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933AbYI3QHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 12:07:16 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Sep 2008 18:07:14 +0200
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Sep 2008 18:07:14 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200809301805.30753.trast@student.ethz.ch>
Content-Disposition: inline
X-OriginalArrivalTime: 30 Sep 2008 16:07:14.0296 (UTC) FILETIME=[9A5F4F80:01C92316]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97131>

I wrote:
> The WIP text is below, and I'll follow up with an interdiff to the
> last version.

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index b4b43da..87c2270 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -13,13 +13,15 @@ git *
 DESCRIPTION
 -----------
 
-This tutorial gives a brief overview of workflows recommended to
-use, and collaborate with, Git.
+This document attempts to write down and motivate some of the workflow
+elements used for `git.git` itself.  Many ideas apply in general,
+though the full workflow is rarely required for smaller projects with
+fewer people involved.
 
-While the prose tries to motivate each of them, we formulate a set of
-'rules' for quick reference.  Do not always take them literally; you
-should value good reasons higher than following a random manpage to
-the letter.
+We formulate a set of 'rules' for quick reference, while the prose
+tries to motivate each of them.  Do not always take them literally;
+you should value good reasons for your actions higher than manpages
+such as this one.
 
 
 SEPARATE CHANGES
@@ -28,49 +30,68 @@ SEPARATE CHANGES
 As a general rule, you should try to split your changes into small
 logical steps, and commit each of them.  They should be consistent,
 working independently of any later commits, pass the test suite, etc.
+This makes the review process much easier, and the history much more
+useful for later inspection and analysis, for example with
+linkgit:git-blame[1] and linkgit:git-bisect[1].
 
-To achieve this, try to commit your new work at least every couple
-hours.  You can always go back and edit the commits with `git rebase
---interactive` to further improve the history before you publish it.
+To achieve this, try to split your work into small steps from the very
+beginning. It is always easier to squash a few commits together than
+to split one big commit into several.  Don't be afraid of making too
+small or imperfect steps along the way. You can always go back later
+and edit the commits with `git rebase \--interactive` before you
+publish them.
 
 
 MANAGING BRANCHES
 -----------------
 
-In the following, we will assume there are 'developers', 'testers' and
-'users'.  Even if the "Testers" are actually an automated test suite
-and all "Users" are developers themselves, try to think in these terms
-as you follow a software change through its life cycle.
+Usually a feature (or other change) evolves in stages: it "graduates"
+from patch to the testing branches and on to stable releases.  During
+this process, it may require fixes or improvements.  XXX terrible
+paragraph XXX
 
-Usually a change evolves in a few steps:
+Merges (as opposed to cherry-picks, see below) greatly simplify
+handling large numbers of commits, so a scalable workflow needs to use
+merges.  Fortunately Git is very good at merging.
 
-* The developers implement a few iterations until it "seems to work".
+XXX non sequitur XXX
+In the following sections we discuss some problems that arise from
+such a "change flow", and how to solve them with Git.
 
-* The testers play with it, report bugs, test the fixes, eventually
-  clearing the change for stable releases.
 
-* As the users work with the new feature, they report bugs which will
-  have to be fixed.
+Graduation
+~~~~~~~~~~
 
-In the following sections we discuss some problems that arise from
-such a "change flow", and how to solve them with Git.
+As a given feature goes from experimental to stable, it also
+"graduates" between the corresponding branches of the software.
+`git.git` uses the following 'main branches':
+
+* 'master' tracks the commits that should go into the next release;
+
+* 'maint' tracks the commits that should go into the next "maintenance
+  release", i.e., update of the last released stable version; and
 
-We consider a fictional project with (supported) stable branch
-'maint', main testing/development branch 'master' and "bleeding edge"
-branch 'next'.  We collectively call these three branches 'main
-branches'.
+* 'next' is intended as a testing branch for people who like to use
+  more experimental stuff.
+
+There is a fourth official branch that is used slightly differently:
+
+* 'pu' (proposed updates) is an integration branch for things that are
+  not quite ready for inclusion yet (see "Integration Branches"
+  below).
+
+Conceptually, the feature enters at an unstable branch (usually 'next'
+or 'pu'), and "graduates" to 'master' for the next release once it is
+considered stable enough.
 
 
 Merging upwards
 ~~~~~~~~~~~~~~~
 
-Since Git is quite good at merges, one should try to use them to
-propagate changes.  For example, if a bug is fixed, you would want to
-apply the corresponding fix to all main branches.
-
-A quick moment of thought reveals that you cannot do this by merging
-"downwards" to older releases, since that would merge 'all' changes.
-Hence the following:
+As explained above, features conceptually "graduate downwards" to
+older releases.  This cannot be done by actually merging downwards,
+however, since that would merge 'all' changes on the unstable branch
+into the stable one.  Hence the following:
 
 .Merge upwards
 [caption="Rule: "]
@@ -84,27 +105,31 @@ This gives a very controlled flow of fixes.  If you notice that you
 have applied a fix to e.g. 'master' that is also required in 'maint',
 you will need to cherry-pick it (using linkgit:git-cherry-pick[1])
 downwards.  This will happen a few times and is nothing to worry about
-unless you do it all the time.
+unless you do it very frequently.
 
 
 Topic branches
 ~~~~~~~~~~~~~~
 
 Any nontrivial feature will require several patches to implement, and
-may get extra bugfixes or improvements during its lifetime.  If all
-such commits were in one long linear history chain (e.g., if they were
-all committed directly to 'master'), it becomes very hard to see how
-they belong together.
+may get extra bugfixes or improvements during its lifetime.
+
+Committing everything directly on the main branches leads to many
+problems: Bad commits cannot be undone, so they must be reverted one
+by one, which creates confusing histories and further error potential
+when you forget to revert part of a group of changes.  Working in
+parallel mixes up the changes, creating further confusion.
 
 The key concept here is "topic branches".  The name is pretty self
-explanatory, with a minor caveat that comes from the "merge upwards"
-rule above:
+explanatory, with a caveat that comes from the "merge upwards" rule
+above:
 
 .Topic branches
 [caption="Rule: "]
 =====================================
-Make a side branch for every topic. Fork it off at the oldest main
-branch that you will eventually want to merge it into.
+Make a side branch for every topic (feature, bugfix, ...). Fork it off
+at the oldest main branch that you will eventually want to merge it
+into.
 =====================================
 
 Many things can then be done very naturally:
@@ -112,7 +137,7 @@ Many things can then be done very naturally:
 * To get the feature/bugfix into a main branch, simply merge it.  If
   the topic has evolved further in the meantime, merge again.
 
-* If you find you need new features from an 'other' branch to continue
+* If you find you need new features from the branch 'other' to continue
   working on your topic, merge 'other' to 'topic'.  (However, do not
   do this "just habitually", see below.)
 
@@ -133,16 +158,17 @@ frowned upon:
 =====================================
 Do not merge to downstream except:
 
-* with a good reason (such as upstream API changes that affect you), or
+* with a good reason: upstream API changes affect your branch; your
+  branch no longer merges to upstream cleanly; etc.
 
 * at well-defined points such as when an upstream release has been tagged.
 =====================================
 
 Otherwise, the many resulting small merges will greatly clutter up
 history.  Anyone who later investigates the history of a file will
-have to find out whether that merge affected the topic in
-development.  Linus hates it.  An upstream might even inadvertently be
-merged into a "more stable" branch.  And so on.
+have to find out whether that merge affected the topic in development.
+An upstream might even inadvertently be merged into a "more stable"
+branch.  And so on.
 
 
 Integration branches
@@ -167,7 +193,9 @@ throw-away branch.
 If you make it (very) clear that this branch is going to be deleted
 right after the testing, you can even publish this branch, for example
 to give the testers a chance to work with it, or other developers a
-chance to see if their in-progress work will be compatible.
+chance to see if their in-progress work will be compatible.  `git.git`
+has such an official integration branch called 'pu'.  You must never
+base any work on such a throw-away branch!
 
 
 SHARING WORK
@@ -177,17 +205,17 @@ After the last section, you should know how to manage topics.  In
 general, you will not be the only person working on the project, so
 you will have to share your work.
 
-Roughly speaking, there are two important workflows.  Their
-distinguishing mark is whether they can be used to propagate merges.
-Medium to large projects will typically employ some mixture of the
-two:
+Roughly speaking, there are two important workflows: push/pull and
+format-patch/am.  The important difference is that push/pull can
+propagate merges, while format-patch cannot.  Medium to large projects
+will typically employ some mixture of the two:
 
 * "Upstream" in the most general sense 'pushes' changes to the
-  repositor(ies) holding the main history.  Everyone can 'pull' from
-  there to stay up to date.
+  repositor(ies) holding the official history of the project.
+  Everyone can 'fetch' from there to stay up to date.
 
-* Frequent contributors, subsystem maintainers, etc. may use push/pull
-  to send their changes upstream.
+* Frequent contributors, subsystem maintainers, etc. may push to a
+  public repository to make their changes available to upstream.
 
 * The rest -- typically anyone more than one or two levels away from the
   main maintainer -- send patches by mail.
@@ -291,15 +319,15 @@ merge because you cannot format-patch merges):
 .format-patch/am: Keeping topics up to date
 [caption="Recipe: "]
 =====================================
-`git rebase upstream`
+`git pull --rebase <url> <branch>`
 =====================================
 
 You can then fix the conflicts during the rebase.  Presumably you have
 not published your topic other than by mail, so rebasing it is not a
 problem.
 
-If you receive such a patch (as maintainer, or perhaps reader of the
-mailing list it was sent to), save the mail to a file and use
+If you receive such a patch (as maintainer, or perhaps as a reader of
+the mailing list it was sent to), save the mail to a file and use
 'git-am':
 
 .format-patch/am: Publishing branches/topics
@@ -309,9 +337,9 @@ mailing list it was sent to), save the mail to a file and use
 =====================================
 
 One feature worth pointing out is the three-way merge, which can help
-if you get conflicts because of renames: `git am -3` will use index
-information contained in patches to reconstruct a merge base.  See
-linkgit:git-am[1] for other options.
+if you get conflicts: `git am -3` will use index information contained
+in patches to figure out the merge base.  See linkgit:git-am[1] for
+other options.
 
 
 SEE ALSO
