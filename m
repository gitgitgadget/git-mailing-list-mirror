From: Johan Herland <johan@herland.net>
Subject: [PATCH 4/5] t3200: Add test demonstrating minor regression in 41c21f2
Date: Fri,  6 Sep 2013 12:40:41 +0200
Message-ID: <1378464042-17476-5-git-send-email-johan@herland.net>
References: <1378464042-17476-1-git-send-email-johan@herland.net>
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Per Cederqvist <cederp@opera.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 06 12:41:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHtTt-00009X-IT
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 12:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272Ab3IFKlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 06:41:25 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:43403 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab3IFKlW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 06:41:22 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so2620938lbd.26
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 03:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5+TltRV0X0mihg8aWWIXpa8Juoc5uRp4XdsksZbiq/o=;
        b=VHQ2S2M/ivpQ/VwhcoUo3UlwzBmiCko5VWqfNhgtqxo7KiovvZRIDYU+ZuwnPZEpUF
         7nlv/2td88+W+EypfHCFbP0oUFJZ75yTy6Eh/o7JK/HrpETXPmXY743mhS/Nt6XozP2d
         NcR69PlaUqzaF2+navMVizfUJfTyyndSvkKwNr7LGlUzuCiOxYGyP4hOLkVbCvBz4oGW
         LfANOpUaKuDwKYcatY9FJBgWzMI1pyQSF08OW5bx2nC2UfzvbQyevBDuXmFFtugFLpC1
         Ovmjjn8BC2FKG3E1l5UGbe99dC6/7BXTiUZM0bJB250pZj1JBmd2bLWkAdHjmwUW0f0U
         6mDg==
X-Received: by 10.152.120.37 with SMTP id kz5mr1655101lab.21.1378464080897;
        Fri, 06 Sep 2013 03:41:20 -0700 (PDT)
Received: from localhost.localdomain (c80-216-222-129.bredband.comhem.se. [80.216.222.129])
        by mx.google.com with ESMTPSA id vs11sm1000794lac.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Sep 2013 03:41:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1378464042-17476-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234035>

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

I was not sure where to place this, so I tacked it onto the end of t3200.

Also, I wouldn't mind dropping the whole build/test infrastructure story
from the commit message if the rationale for this kind of setup (and this
patch) can be expressed more concisely.

...Johan

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
