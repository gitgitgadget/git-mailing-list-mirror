From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4] Support updating working trees when pushing into non-bare
 repos
Date: Wed, 26 Nov 2014 21:21:32 +0100 (CET)
Message-ID: <cover.1417033080.git.johannes.schindelin@gmx.de>
References: <cover.1415876330.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 26 21:21:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtj5q-0005LI-1q
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 21:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbaKZUVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 15:21:37 -0500
Received: from mout.gmx.net ([212.227.15.15]:50206 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbaKZUVg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 15:21:36 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MDQI1-1Xhr8K1gZZ-00Gms9;
 Wed, 26 Nov 2014 21:21:33 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1415876330.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:6OV+mZuSbkbD2fSzhyXRi81PyrliHpK2U+eCKgAsCmllC9HOCus
 NF+YzuWhvAtQmiFx7S1Z+429R3RgiUbDQ1MMw7kRKoAp/t2SVqiuA3K9rZsfJ6kS5HyibTq
 z1dxkEieEMrQxZab6ZGfyKVdroyJcryAdhfBFxruTRoeV4VmfpHqDNcyzPRLX3SKR0ghNz+
 KeVRAk26RhLEl3/YYQ7/w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260299>

This patch "series" adds support for a new receive.denyCurrentBranch setting
to update the working directory (which must be clean, i.e. there must not be
any uncommitted changes) when pushing into the current branch.

The scenario in which the 'updateInstead' setting became a boon in this
developer's daily work is when trying to get a bug fix from a Windows
computer, a virtual machine, or when getting a bug fix from a user's machine
onto his main machine (in all of those cases it is only possible to connect
via ssh in one direction, but not in the reverse direction). It also comes
in handy when updating a live web site via push (in which case a clean
working directory is an absolute must).

As to the name 'updateInstead': since I do not want the option to perform
the equivalent of a checkout (where staged changes would be okay), I stuck
to the name I use in all of my $HOME/.gitconfigs. Hopefully you don't
mind.

Interdiff vs v3 below the diffstat

Johannes Schindelin (1):
  Add another option for receive.denyCurrentBranch

 Documentation/config.txt |  7 ++++
 builtin/receive-pack.c   | 94 ++++++++++++++++++++++++++++++++++++++++++++++--
 t/t5516-fetch-push.sh    | 21 +++++++++++
 3 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c384515..0519073 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2133,7 +2133,9 @@ receive.denyCurrentBranch::
 Another option is "updateInstead" which will update the working
 directory (must be clean) if pushing into the current branch. This option is
 intended for synchronizing working directories when one side is not easily
-accessible via ssh (e.g. inside a VM).
+accessible via interactive ssh (e.g. a live web site, hence the requirement
+that the working directory be clean). This mode also comes in handy when
+developing inside a VM to test and fix code on different Operating Systems.
 
 receive.denyNonFastForwards::
 	If set to true, git-receive-pack will deny a ref update which is
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 836720f..1b05e4e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -736,7 +736,10 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 static const char *update_worktree(unsigned char *sha1)
 {
 	const char *update_refresh[] = {
-		"update-index", "--ignore-submodules", "--refresh", NULL
+		"update-index", "--ignore-submodules", "--refresh", "-q", NULL
+	};
+	const char *diff_files[] = {
+		"diff-files", "--quiet", "--ignore-submodules", "--", NULL
 	};
 	const char *diff_index[] = {
 		"diff-index", "--quiet", "--cached", "--ignore-submodules",
@@ -767,6 +770,19 @@ static const char *update_worktree(unsigned char *sha1)
 
 	/* run_command() does not clean up completely; reinitialize */
 	child_process_init(&child);
+	child.argv = diff_files;
+	child.env = env.argv;
+	child.dir = work_tree;
+	child.no_stdin = 1;
+	child.stdout_to_stderr = 1;
+	child.git_cmd = 1;
+	if (run_command(&child)) {
+		argv_array_clear(&env);
+		return "Working directory not clean";
+	}
+
+	/* run_command() does not clean up completely; reinitialize */
+	child_process_init(&child);
 	child.argv = diff_index;
 	child.env = env.argv;
 	child.no_stdin = 1;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index ba002a9..b8df39c 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1343,8 +1343,12 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 	(cd testrepo &&
 		git update-index --refresh &&
 		git diff-files --quiet &&
-		git diff-index --cached HEAD --
-	)
+		git diff-index --cached HEAD -- &&
+		echo changed > path2 &&
+		git add path2
+	) &&
+	test_commit fourth path2 &&
+	test_must_fail git push testrepo master
 '
 
 test_done

-- 
2.0.0.rc3.9669.g840d1f9
