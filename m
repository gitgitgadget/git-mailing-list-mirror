From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] Documentation: add manpage about workflows
Date: Thu, 11 Sep 2008 17:39:45 +0200
Message-ID: <1221147585-5695-1-git-send-email-trast@student.ethz.ch>
References: <1221147525-5589-3-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 17:41:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdoI9-0005jb-8S
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 17:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbYIKPjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 11:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbYIKPjy
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 11:39:54 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:33293 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724AbYIKPjw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 11:39:52 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Sep 2008 17:39:50 +0200
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Sep 2008 17:39:50 +0200
X-Mailer: git-send-email 1.6.0.1.470.g200b
In-Reply-To: <1221147525-5589-3-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 11 Sep 2008 15:39:50.0346 (UTC) FILETIME=[A0A732A0:01C91424]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95614>

This attempts to make a manpage about workflows that is both handy to
point people at it and as a beginner's introduction.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/Makefile         |    2 +-
 Documentation/gitworkflows.txt |  326 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 327 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/gitworkflows.txt

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
index 0000000..3462000
--- /dev/null
+++ b/Documentation/gitworkflows.txt
@@ -0,0 +1,326 @@
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
+This tutorial gives a brief overview of workflows recommended to
+use, and collaborate with, Git.
+
+While the prose tries to motivate each of them, we formulate a set of
+'rules' for quick reference.  Do not always take them literally; you
+should value good reasons higher than following a random manpage to
+the letter.
+
+
+SEPARATE CHANGES
+----------------
+
+As a general rule, you should try to split your changes into small
+logical steps, and commit each of them.  They should be consistent,
+working independently of any later commits, pass the test suite, etc.
+
+To achieve this, try to commit your new work at least every couple
+hours.  You can always go back and edit the commits with `git rebase
+--interactive` to further improve the history before you publish it.
+
+
+MANAGING BRANCHES
+-----------------
+
+In the following, we will assume there are 'developers', 'testers' and
+'users'.  Even if the "Testers" are actually an automated test suite
+and all "Users" are developers themselves, try to think in these terms
+as you follow a software change through its life cycle.
+
+Usually a change evolves in a few steps:
+
+* The developers implement a few iterations until it "seems to work".
+
+* The testers play with it, report bugs, test the fixes, eventually
+  clearing the change for stable releases.
+
+* As the users work with the new feature, they report bugs which will
+  have to be fixed.
+
+In the following sections we discuss some problems that arise from
+such a "change flow", and how to solve them with Git.
+
+We consider a fictional project with (supported) stable branch
+'maint', main testing/development branch 'master' and "bleeding edge"
+branch 'next'.  We collectively call these three branches 'main
+branches'.
+
+
+Merging upwards
+~~~~~~~~~~~~~~~
+
+Since Git is quite good at merges, one should try to use them to
+propagate changes.  For example, if a bug is fixed, you would want to
+apply the corresponding fix to all main branches.
+
+A quick moment of thought reveals that you cannot do this by merging
+"downwards" to older releases, since that would merge 'all' changes.
+Hence the following:
+
+.Merge upwards
+[caption="Rule: "]
+=====================================
+Always commit your fixes to the oldest supported branch that require
+them.  Then (periodically) merge the main branches upwards into each
+other.
+=====================================
+
+This gives a very controlled flow of fixes.  If you notice that you
+have applied a fix to e.g. 'master' that is also required in 'maint',
+you will need to cherry-pick it (using linkgit:git-cherry-pick[1])
+downwards.  This will happen a few times and is nothing to worry about
+unless you do it all the time.
+
+
+Topic branches
+~~~~~~~~~~~~~~
+
+Any nontrivial feature will require several patches to implement, and
+may get extra bugfixes or improvements during its lifetime.  If all
+such commits were in one long linear history chain (e.g. if they were
+all committed directly to, 'master'), it becomes very hard to see how
+they belong together.
+
+The key concept here is "topic branches".  The name is pretty self
+explanatory, with a minor caveat that comes from the "merge upwards"
+rule above:
+
+.Topic branches
+[caption="Rule: "]
+=====================================
+Make a side branch for every topic. Fork it off at the oldest main
+branch that you will eventually want to merge it into.
+=====================================
+
+Many things can then be done very naturally:
+
+* To get the feature/bugfix into a main branch, simply merge it.  If
+  the topic has evolved further in the meantime, merge again.
+
+* If you find you need new features from an 'other' branch to continue
+  working on your topic, merge 'other' to 'topic'.  (However, do not
+  do this "just habitually", see below.)
+
+* If you find you forked off the wrong branch and want to move it
+  "back in time", use linkgit:git-rebase[1].
+
+Note that the last two points clash: a topic that has been merged
+elsewhere should not be rebased.  See the section on RECOVERING FROM
+UPSTREAM REBASE in linkgit:git-rebase[1].
+
+We should point out that "habitually" (regularly for no real reason)
+merging a main branch into your topics--and by extension, merging
+anything upstream into anything downstream on a regular basis--is
+frowned upon:
+
+.Merge to downstream only at well-defined points
+[caption="Rule: "]
+=====================================
+Do not merge to downstream except:
+
+* with a good reason (such as upstream API changes that affect you), or
+
+* at well-defined points such as when an upstream release has been tagged.
+=====================================
+
+Otherwise, the many resulting small merges will greatly clutter up
+history.  Anyone who later investigates the history of a file will
+have to find out whether that merge affected the topic in
+development.  Linus hates it.  An upstream might even inadvertently be
+merged into a "more stable" branch.  And so on.
+
+
+Integration branches
+~~~~~~~~~~~~~~~~~~~~
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
+.Integration branches
+[caption="Rule: "]
+=====================================
+To test the interaction of several topics, merge them into a
+throw-away branch.
+=====================================
+
+If you make it (very) clear that this branch is going to be deleted
+right after the testing, you can even publish this branch, for example
+to give the testers a chance to work with it, or other developers a
+chance to see if their in-progress work will be compatible.
+
+
+SHARING WORK
+------------
+
+After the last section, you should know how to manage topics.  In
+general, you will not be the only person working on the project, so
+you will have to share your work.
+
+Roughly speaking, there are two important workflows.  Their
+distinguishing mark is whether they can be used to propagate merges.
+Medium to large projects will typically employ some mixture of the
+two:
+
+* "Upstream" in the most general sense 'pushes' changes to the
+  repositor(ies) holding the main history.  Everyone can 'pull' from
+  there to stay up to date.
+
+* Frequent contributors, subsystem maintainers, etc. may use push/pull
+  to send their changes upstream.
+
+* The rest -- typically anyone more than one or two levels away from the
+  main maintainer -- send patches by mail.
+
+None of these boundaries are sharp, so find out what works best for
+you.
+
+
+Push/pull
+~~~~~~~~~
+
+There are three main tools that can be used for this:
+
+* linkgit:git-push[1] copies your branches to a remote repository,
+  usually to one that can be read by all involved parties;
+
+* linkgit:git-fetch[1] that copies remote branches to your repository;
+  and
+
+* linkgit:git-pull[1] that is fetch and merge in one go.
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
+If you just want to get the newest copies of the main branches,
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
+branches to the main branches, they will typically send a request to
+do so by mail.  Such a request might say
+
+-------------------------------------
+Please pull from
+    git://some.server.somewhere/random/repo.git mytopic
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
+know better how to react).  It is one of the rare cases where
+downstream 'should' merge from upstream.
+
+
+format-patch/am
+~~~~~~~~~~~~~~~
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
+`git format-patch -M upstream..topic` and send out the resulting files.
+=====================================
+
+See the linkgit:git-format-patch[1] manpage for further usage notes.
+Also you should be aware that the maintainer may impose further
+restrictions, such as "Signed-off-by" requirements.
+
+If the maintainer tells you that your patch no longer applies to the
+current upstream, you will have to rebase your topic (you cannot use a
+merge because you cannot format-patch merges):
+
+.format-patch/am: Keeping topics up to date
+[caption="Recipe: "]
+=====================================
+`git rebase upstream`
+=====================================
+
+You can then fix the conflicts during the rebase.  Presumably you have
+not published your topic other than by mail, so rebasing it is not a
+problem.
+
+If you receive such a patch (as maintainer, or perhaps reader of the
+mailing list it was sent to), save the mail to a file and use
+'git-am':
+
+.format-patch/am: Publishing branches/topics
+[caption="Recipe: "]
+=====================================
+`git am < patch`
+=====================================
+
+One feature worth pointing out is the three-way merge, which can help
+if you get conflicts because of renames: `git am -3` will use index
+information contained in patches to reconstruct a merge base.  See
+linkgit:git-am[1] for other options.
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
+linkgit:git-am[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite.
-- 
1.6.0.1.470.g200b
