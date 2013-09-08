From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 4/5] t3200: Add test demonstrating minor regression in 41c21f2
Date: Sun,  8 Sep 2013 22:58:14 +0200
Message-ID: <1378673895-23127-5-git-send-email-johan@herland.net>
References: <1378464042-17476-1-git-send-email-johan@herland.net>
 <1378673895-23127-1-git-send-email-johan@herland.net>
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Per Cederqvist <cederp@opera.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 08 22:58:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIm47-00039V-6j
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 22:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311Ab3IHU6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 16:58:34 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:49493 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab3IHU6c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 16:58:32 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so4380188lab.30
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 13:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=USZzbaN6e5hwy87zgnw5tPyyT5cVRhK8N7VcRrSFsoA=;
        b=VUanDec89lXACN6izeLeM9ff41tTJFdGbpycYa9rWNnE0B1aI11qWmIdVb9EKcMDAg
         b81susir4yX6QCF/bI2Mw2/wkW4mCwQ21QtKIawJ9qK+Oso7t4KyOMIGwlmMddTwCoUM
         vSS8NLEd6kcboAiKBdyFAEFiroGw/ZoVoCzQJeTU8GYfuA/RK29Y0tbos6NOFFPSG5sx
         J0esDSyQPHCc8pmB6kNy/2U75d+hOc8w0lYQ5nwKLtGlQAaTU1tN+6B6OlDuUHD2z9sI
         mdhfdOSYjAlXQosVLdefOuc10EF4q42M8GVU6qWqn9ARy02m0dgAIfKsnzjdNcUle1+T
         UAVA==
X-Received: by 10.152.8.12 with SMTP id n12mr13265136laa.10.1378673910814;
        Sun, 08 Sep 2013 13:58:30 -0700 (PDT)
Received: from beta.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPSA id vo1sm4292384lbb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 13:58:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1378673895-23127-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234267>

In 41c21f2 (branch.c: Validate tracking branches with refspecs instead of
refs/remotes/*), we changed the rules for what is considered a valid tracking
branch (a.k.a. upstream branch). We now use the configured remotes and their
refspecs to determine whether a proposed tracking branch is in fact within
the domain of a remote, and we then use that information to deduce the
upstream configuration (branch.<name>.remote and branch.<name>.merge).

However, with that change, we also check that - in addition to a matching
refspec - the result of mapping the tracking branch through that refspec
(i.e. the corresponding ref name in the remote repo) happens to start with
"refs/heads/". In other words, we require that a tracking branch refers to
a _branch_ in the remote repo.

Now, consider that you are e.g. setting up an automated building/testing
infrastructure for a group of similar "source" repositories. The build/test
infrastructure consists of a central scheduler, and a number of build/test
"slave" machines that perform the actual build/test work. The scheduler
monitors the group of similar repos for changes (e.g. with a periodic
"git fetch"), and triggers builds/tests to be run on one or more slaves.
Graphically the changes flow between the repos like this:

  Source #1 -------v          ----> Slave #1
                             /
  Source #2 -----> Scheduler -----> Slave #2
                             \
  Source #3 -------^          ----> Slave #3

        ...                           ...

The scheduler maintains a single Git repo with each of the source repos set
up as distinct remotes. The slaves also need access to all the changes from
all of the source repos, so they pull from the scheduler repo, but using the
following custom refspec:

  remote.origin.fetch = "+refs/remotes/*:refs/remotes/*"

This makes all of the scheduler's remote-tracking branches automatically
available as identical remote-tracking branches in each of the slaves.

Now, consider what happens if a slave tries to create a local branch with
one of the remote-tracking branches as upstream:

  git branch local_branch --track refs/remotes/source-1/some_branch

Git now looks at the configured remotes (in this case there is only "origin",
pointing to the scheduler's repo) and sees refs/remotes/source-1/some_branch
matching origin's refspec. Mapping through that refspec we find that the
corresponding remote ref name is "refs/remotes/source-1/some_branch".
However, since this remote ref name does not start with "refs/heads/", we
discard it as a suitable upstream, and the whole command fails.

This patch adds a testcase demonstrating this failure by creating two
source repos ("a" and "b") that are forwarded through a scheduler ("c")
to a slave repo ("d"), that then tries create a local branch with an
upstream. See the next patch in this series for the exciting conclusion
to this story...

Reported-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3200-branch.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 8f6ab8e..4031693 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -871,4 +871,38 @@ test_expect_success '--merged catches invalid object names' '
 	test_must_fail git branch --merged 0000000000000000000000000000000000000000
 '
 
+test_expect_failure 'tracking with unexpected .fetch refspec' '
+	git init a &&
+	(
+		cd a &&
+		test_commit a
+	) &&
+	git init b &&
+	(
+		cd b &&
+		test_commit b
+	) &&
+	git init c &&
+	(
+		cd c &&
+		test_commit c &&
+		git remote add a ../a &&
+		git remote add b ../b &&
+		git fetch --all
+	) &&
+	git init d &&
+	(
+		cd d &&
+		git remote add c ../c &&
+		git config remote.c.fetch "+refs/remotes/*:refs/remotes/*" &&
+		git fetch c &&
+		git branch --track local/a/master remotes/a/master &&
+		test "$(git config branch.local/a/master.remote)" = "c" &&
+		test "$(git config branch.local/a/master.merge)" = "refs/remotes/a/master" &&
+		git rev-parse --verify a >expect &&
+		git rev-parse --verify local/a/master >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
1.8.3.GIT
