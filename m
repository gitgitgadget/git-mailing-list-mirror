From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3] Documentation: add manpage about workflows
Date: Sun, 19 Oct 2008 17:20:21 +0200
Message-ID: <1224429622-1548-1-git-send-email-trast@student.ethz.ch>
References: <7v8wsyortf.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, santi@agolina.net,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 23:06:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kra66-0007uK-34
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 17:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbYJSPUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 11:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbYJSPUY
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 11:20:24 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:37582 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbYJSPUX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 11:20:23 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 19 Oct 2008 17:20:21 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 19 Oct 2008 17:20:21 +0200
X-Mailer: git-send-email 1.6.0.2.916.g8e7f4
In-Reply-To: <7v8wsyortf.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 19 Oct 2008 15:20:21.0208 (UTC) FILETIME=[337D6580:01C931FE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98602>

This attempts to make a manpage about workflows that is both handy to
point people at it and as a beginner's introduction.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

> > +Integration branches
> > +~~~~~~~~~~~~~~~~~~~~
> 
> Nomenclature.  I think we use the word "integration branches" to mean the
> stable branches such as maint/master/next, not the ones you use for
> throw-away test merges.

I renamed those, and now call 'pu' a "throw-away integration branch",
which is sort of unwieldy but I can't think of a good short name.

Full interdiff follows, as before.


 Documentation/Makefile         |    2 +-
 Documentation/gitworkflows.txt |  364 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 365 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ded0e40..e33ddcb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -6,7 +6,7 @@ MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
 	gitrepository-layout.txt
 MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
 	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
-	gitdiffcore.txt
+	gitdiffcore.txt gitworkflows.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
new file mode 100644
index 0000000..7fe9f72
--- /dev/null
+++ b/Documentation/gitworkflows.txt
@@ -0,0 +1,364 @@
+gitworkflows(7)
+===============
+
+NAME
+----
+gitworkflows - An overview of recommended workflows with git
+
+SYNOPSIS
+--------
+git *
+
+
+DESCRIPTION
+-----------
+
+This document attempts to write down and motivate some of the workflow
+elements used for `git.git` itself.  Many ideas apply in general,
+though the full workflow is rarely required for smaller projects with
+fewer people involved.
+
+We formulate a set of 'rules' for quick reference, while the prose
+tries to motivate each of them.  Do not always take them literally;
+you should value good reasons for your actions higher than manpages
+such as this one.
+
+
+SEPARATE CHANGES
+----------------
+
+As a general rule, you should try to split your changes into small
+logical steps, and commit each of them.  They should be consistent,
+working independently of any later commits, pass the test suite, etc.
+This makes the review process much easier, and the history much more
+useful for later inspection and analysis, for example with
+linkgit:git-blame[1] and linkgit:git-bisect[1].
+
+To achieve this, try to split your work into small steps from the very
+beginning. It is always easier to squash a few commits together than
+to split one big commit into several.  Don't be afraid of making too
+small or imperfect steps along the way. You can always go back later
+and edit the commits with `git rebase \--interactive` before you
+publish them.  You can use `git stash save \--keep-index` to run the
+test suite independent of other uncommitted changes; see the EXAMPLES
+section of linkgit:git-stash[1].
+
+
+MANAGING BRANCHES
+-----------------
+
+There are two main tools that can be used to include changes from one
+branch on another: linkgit:git-merge[1] and
+linkgit:git-cherry-pick[1].
+
+Merges have many advantages, so we try to solve as many problems as
+possible with merges alone.  Cherry-picking is still occasionally
+useful; see "Merging upwards" below for an example.
+
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
+
+
+Graduation
+~~~~~~~~~~
+
+As a given feature goes from experimental to stable, it also
+"graduates" between the corresponding branches of the software.
+`git.git` uses the following 'integration branches':
+
+* 'maint' tracks the commits that should go into the next "maintenance
+  release", i.e., update of the last released stable version;
+
+* 'master' tracks the commits that should go into the next release;
+
+* 'next' is intended as a testing branch for topics being tested for
+  stability for master.
+
+There is a fourth official branch that is used slightly differently:
+
+* 'pu' (proposed updates) is an integration branch for things that are
+  not quite ready for inclusion yet (see "Integration Branches"
+  below).
+
+Each of the four branches is usually a direct descendant of the one
+above it.
+
+Conceptually, the feature enters at an unstable branch (usually 'next'
+or 'pu'), and "graduates" to 'master' for the next release once it is
+considered stable enough.
+
+
+Merging upwards
+~~~~~~~~~~~~~~~
+
+The "downwards graduation" discussed above cannot be done by actually
+merging downwards, however, since that would merge 'all' changes on
+the unstable branch into the stable one.  Hence the following:
+
+.Merge upwards
+[caption="Rule: "]
+=====================================
+Always commit your fixes to the oldest supported branch that require
+them.  Then (periodically) merge the integration branches upwards into each
+other.
+=====================================
+
+This gives a very controlled flow of fixes.  If you notice that you
+have applied a fix to e.g. 'master' that is also required in 'maint',
+you will need to cherry-pick it (using linkgit:git-cherry-pick[1])
+downwards.  This will happen a few times and is nothing to worry about
+unless you do it very frequently.
+
+
+Topic branches
+~~~~~~~~~~~~~~
+
+Any nontrivial feature will require several patches to implement, and
+may get extra bugfixes or improvements during its lifetime.
+
+Committing everything directly on the integration branches leads to many
+problems: Bad commits cannot be undone, so they must be reverted one
+by one, which creates confusing histories and further error potential
+when you forget to revert part of a group of changes.  Working in
+parallel mixes up the changes, creating further confusion.
+
+Use of "topic branches" solves these problems.  The name is pretty
+self explanatory, with a caveat that comes from the "merge upwards"
+rule above:
+
+.Topic branches
+[caption="Rule: "]
+=====================================
+Make a side branch for every topic (feature, bugfix, ...). Fork it off
+at the oldest integration branch that you will eventually want to merge it
+into.
+=====================================
+
+Many things can then be done very naturally:
+
+* To get the feature/bugfix into an integration branch, simply merge
+  it.  If the topic has evolved further in the meantime, merge again.
+  (Note that you do not necessarily have to merge it to the oldest
+  integration branch first.  For example, you can first merge a bugfix
+  to 'next', give it some testing time, and merge to 'maint' when you
+  know it is stable.)
+
+* If you find you need new features from the branch 'other' to continue
+  working on your topic, merge 'other' to 'topic'.  (However, do not
+  do this "just habitually", see below.)
+
+* If you find you forked off the wrong branch and want to move it
+  "back in time", use linkgit:git-rebase[1].
+
+Note that the last point clashes with the other two: a topic that has
+been merged elsewhere should not be rebased.  See the section on
+RECOVERING FROM UPSTREAM REBASE in linkgit:git-rebase[1].
+
+We should point out that "habitually" (regularly for no real reason)
+merging an integration branch into your topics -- and by extension,
+merging anything upstream into anything downstream on a regular basis
+-- is frowned upon:
+
+.Merge to downstream only at well-defined points
+[caption="Rule: "]
+=====================================
+Do not merge to downstream except with a good reason: upstream API
+changes affect your branch; your branch no longer merges to upstream
+cleanly; etc.
+=====================================
+
+Otherwise, the topic that was merged to suddenly contains more than a
+single (well-separated) change.  The many resulting small merges will
+greatly clutter up history.  Anyone who later investigates the history
+of a file will have to find out whether that merge affected the topic
+in development.  An upstream might even inadvertently be merged into a
+"more stable" branch.  And so on.
+
+
+Throw-away integration
+~~~~~~~~~~~~~~~~~~~~~~
+
+If you followed the last paragraph, you will now have many small topic
+branches, and occasionally wonder how they interact.  Perhaps the
+result of merging them does not even work?  But on the other hand, we
+want to avoid merging them anywhere "stable" because such merges
+cannot easily be undone.
+
+The solution, of course, is to make a merge that we can undo: merge
+into a throw-away branch.
+
+.Throw-away integration branches
+[caption="Rule: "]
+=====================================
+To test the interaction of several topics, merge them into a
+throw-away branch.  You must never base any work on such a branch!
+=====================================
+
+If you make it (very) clear that this branch is going to be deleted
+right after the testing, you can even publish this branch, for example
+to give the testers a chance to work with it, or other developers a
+chance to see if their in-progress work will be compatible.  `git.git`
+has such an official throw-away integration branch called 'pu'.
+
+
+DISTRIBUTED WORKFLOWS
+---------------------
+
+After the last section, you should know how to manage topics.  In
+general, you will not be the only person working on the project, so
+you will have to share your work.
+
+Roughly speaking, there are two important workflows: merge and patch.
+The important difference is that the merge workflow can propagate full
+history, including merges, while patches cannot.  Both workflows can
+be used in parallel: in `git.git`, only subsystem maintainers use
+the merge workflow, while everyone else sends patches.
+
+Note that the maintainer(s) may impose restrictions, such as
+"Signed-off-by" requirements, that all commits/patches submitted for
+inclusion must adhere to.  Consult your project's documentation for
+more information.
+
+
+Merge workflow
+~~~~~~~~~~~~~~
+
+The merge workflow works by copying branches between upstream and
+downstream.  Upstream can merge contributions into the official
+history; downstream base their work on the official history.
+
+There are three main tools that can be used for this:
+
+* linkgit:git-push[1] copies your branches to a remote repository,
+  usually to one that can be read by all involved parties;
+
+* linkgit:git-fetch[1] that copies remote branches to your repository;
+  and
+
+* linkgit:git-pull[1] that does fetch and merge in one go.
+
+Note the last point.  Do 'not' use 'git-pull' unless you actually want
+to merge the remote branch.
+
+Getting changes out is easy:
+
+.Push/pull: Publishing branches/topics
+[caption="Recipe: "]
+=====================================
+`git push <remote> <branch>` and tell everyone where they can fetch
+from.
+=====================================
+
+You will still have to tell people by other means, such as mail.  (Git
+provides the linkgit:request-pull[1] to send preformatted pull
+requests to upstream maintainers to simplify this task.)
+
+If you just want to get the newest copies of the integration branches,
+staying up to date is easy too:
+
+.Push/pull: Staying up to date
+[caption="Recipe: "]
+=====================================
+Use `git fetch <remote>` or `git remote update` to stay up to date.
+=====================================
+
+Then simply fork your topic branches from the stable remotes as
+explained earlier.
+
+If you are a maintainer and would like to merge other people's topic
+branches to the integration branches, they will typically send a
+request to do so by mail.  Such a request looks like
+
+-------------------------------------
+Please pull from
+    <url> <branch>
+-------------------------------------
+
+In that case, 'git-pull' can do the fetch and merge in one go, as
+follows.
+
+.Push/pull: Merging remote topics
+[caption="Recipe: "]
+=====================================
+`git pull <url> <branch>`
+=====================================
+
+Occasionally, the maintainer may get merge conflicts when he tries to
+pull changes from downstream.  In this case, he can ask downstream to
+do the merge and resolve the conflicts themselves (perhaps they will
+know better how to resolve them).  It is one of the rare cases where
+downstream 'should' merge from upstream.
+
+
+Patch workflow
+~~~~~~~~~~~~~~
+
+If you are a contributor that sends changes upstream in the form of
+emails, you should use topic branches as usual (see above).  Then use
+linkgit:git-format-patch[1] to generate the corresponding emails
+(highly recommended over manually formatting them because it makes the
+maintainer's life easier).
+
+.format-patch/am: Publishing branches/topics
+[caption="Recipe: "]
+=====================================
+* `git format-patch -M upstream..topic` to turn them into preformatted
+  patch files
+* `git send-email --to=<recipient> <patches>`
+=====================================
+
+See the linkgit:git-format-patch[1] and linkgit:git-send-email[1]
+manpages for further usage notes.
+
+If the maintainer tells you that your patch no longer applies to the
+current upstream, you will have to rebase your topic (you cannot use a
+merge because you cannot format-patch merges):
+
+.format-patch/am: Keeping topics up to date
+[caption="Recipe: "]
+=====================================
+`git pull --rebase <url> <branch>`
+=====================================
+
+You can then fix the conflicts during the rebase.  Presumably you have
+not published your topic other than by mail, so rebasing it is not a
+problem.
+
+If you receive such a patch series (as maintainer, or perhaps as a
+reader of the mailing list it was sent to), save the mails to files,
+create a new topic branch and use 'git-am' to import the commits:
+
+.format-patch/am: Importing patches
+[caption="Recipe: "]
+=====================================
+`git am < patch`
+=====================================
+
+One feature worth pointing out is the three-way merge, which can help
+if you get conflicts: `git am -3` will use index information contained
+in patches to figure out the merge base.  See linkgit:git-am[1] for
+other options.
+
+
+SEE ALSO
+--------
+linkgit:gittutorial[7],
+linkgit:git-push[1],
+linkgit:git-pull[1],
+linkgit:git-merge[1],
+linkgit:git-rebase[1],
+linkgit:git-format-patch[1],
+linkgit:git-send-email[1],
+linkgit:git-am[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite.
-- 
tg: (50ea8e5..) t/doc-workflows (depends on: origin/master t/doc-rebase-warn t/doc-rebase-refer)
