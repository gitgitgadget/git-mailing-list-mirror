Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 714 invoked by uid 111); 30 Oct 2008 03:48:23 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 29 Oct 2008 23:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbYJ3DsQ (ORCPT <rfc822;peff@peff.net>);
	Wed, 29 Oct 2008 23:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbYJ3DsQ
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 23:48:16 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:42117 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539AbYJ3DsP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 23:48:15 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 4FF6D21D157; Thu, 30 Oct 2008 16:48:13 +1300 (NZDT)
Received: from localhost.localdomain (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	by mail.utsl.gen.nz (Postfix) with ESMTP id 91DDD21D147;
	Thu, 30 Oct 2008 16:48:06 +1300 (NZDT)
From:	Sam Vilain <sam@vilain.net>
To:	git@vger.kernel.org
Cc:	Sam Vilain <samv@vilain.net>, Sam Vilain <sam@vilain.net>
Subject: [PATCH] Documentation: add a planning document for the next CLI revamp
Date:	Wed, 29 Oct 2008 20:48:05 -0700
Message-Id: <1225338485-11046-1-git-send-email-sam@vilain.net>
X-Mailer: git-send-email debian.1.5.6.1
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Old-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5

From: Sam Vilain <samv@vilain.net>

For cross-command CLI changes to be effective, they need to be
cohesively planned.  Add a planning document for this next set of
changes.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 Some suggestions, which have been briefly scanned over by some of the
 (remaining @4pm) GitTogether attendees.

 Please keep it constructive! :)

 Documentation/cli-revamp.txt |  135 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 135 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/cli-revamp.txt

diff --git a/Documentation/cli-revamp.txt b/Documentation/cli-revamp.txt
new file mode 100644
index 0000000..980ea07
--- /dev/null
+++ b/Documentation/cli-revamp.txt
@@ -0,0 +1,135 @@
+GIT command line revamp
+=======================
+
+This design document is designed for review and critique over planned
+direction for changing the command set used by git, rather than
+reviewing and critiquing individual changes.
+
+In general, old commands will be grandfathered for a year or longer,
+and all plumbing commands will still work as originally designed.
+
+Please bear in mind when critiquing that each of these changes might
+themselves have a progressive implementation, for instance the new
+behaviour being optional initially.
+
+Please try to be positive with your comments; let's try to come up
+with solutions and not argue about the details of the solutions
+presented until those details are submitted.  In particular, critical
+comments that do not acknowledge the presence of a problem are
+worthless at this stage.
+
+Add/rm/reset/checkout/revert
+----------------------------
+
+Many find these confusing.
+
+  * 'git stage' would do what 'git add' does now.
+
+  * 'git unstage' would do what 'git reset --' does now
+
+  * 'git status' would encourage the user to use
+    'git diff --staged' to see staged changes as a patch
+
+  * 'git commit' with no changes should give useful information about
+    using 'git stage', 'git commit -a' or 'git commit filename ...'
+
+  * 'git add' and 'git rm': no change
+
+  * 'git update-index' considered plumbing, not changed
+
+  * 'git revert' deprecated in favour of 'git cherry-pick --revert'
+
+  * 'git undo' would do what 'git checkout HEAD --' does now
+
+  * 'git checkout branch' would, if there is a remote branch called
+    'branch' on exactly one remote, do what
+    'git checkout -b branch thatremote/branch' does now.  If it is
+    ambiguous, it would be an error, forcing the explicit notation.
+
+  * 'git branch --switch' : alternative to checkout
+
+
+Push/pull
+---------
+
+These commands are asymmetric, and this seems mostly historical.
+
+  * 'git push --matching' does what 'git push' does today (without
+    explicit configuration)
+
+  * 'git push' with no ref args and no 'push =' configuration does
+    what:
+    'git push origin $(git symbolic-ref HEAD | sed "s!refs/heads/!!")'
+    does today.  ie, it only pushes the current branch.
+    If a branch was defined in branch.<name>.push, push to that ref
+    instead of the matching one.  If there is no matching ref, and
+    there is a branch.<name>.merge, push back there.
+
+  * 'git pull' behaviour unchanged
+
+  * 'git push' to checked out branch of non-bare repository not
+    allowed without special configuration.  Configuration available
+    that allows working directory to be updated, known caveats
+    notwithstanding.  Ideally, it would refuse only in situations
+    where a broken working copy would be left (because you couldn't
+    fix it), and work when it can be known to be safe.
+
+
+Informational
+-------------
+
+  * 'git branch' should default to '--color=auto -v'
+
+  * 'git tag -l' should show more information
+
+
+Working with patches
+--------------------
+
+  * 'git send-email' should prompt for all SMTP-related information
+    about sending e-mail when it is running with no configuration.
+    Because these days /usr/lib/sendmail is rarely configured
+    correctly.
+
+  * other git send-email functionality which has bitten people -
+    particularly building the recipient list - should prompt for
+    confirmation until configured to be automatic.
+
+  * 'git am -3' the default; with global option to make it not the
+    default for those that prefer the speed of -2
+
+
+Submodules
+----------
+
+  * submodules should be able to refer to symbolic ref names, svn
+    style - in the .gitmodules file.  The actual commit used is still
+    recorded in the index.
+
+  * when switching branches, if the checked out revision of a submodule
+    changes, then it should be switched as well
+
+  * 'git submodule update' should be able to be triggered when
+    switching branches (but not be the default behaviour)
+
+
+Others
+------
+
+  * 'git export' command that does what
+    'git archive --format=tar --prefix=dir | tar x' does now
+
+  * conflicted merges should point the user immediately to
+    'git mergetool' and mention you need to use 'git stage' to mark
+    resolved files and 'git commit' when done.
+
+  * 'git init --server' (or similar) should do everything required for
+    exporting::
+----
+chmod -R a+rX
+touch git-daemon-export-ok
+git gc
+git update-server-info
+chmod u+x .git/hooks/post-update
+git config core.sharedrepository=1
+----
-- 
debian.1.5.6.1

