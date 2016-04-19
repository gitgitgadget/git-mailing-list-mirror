From: Jan Durovec <jan.durovec@gmail.com>
Subject: [PATCH v3 2/2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 19:49:41 +0000
Message-ID: <01020154301239b6-f5b2b329-78f7-43c0-ab5c-2644994511c4-000000@eu-west-1.amazonses.com>
References: <01020154301238e9-9d46ac5b-d6e6-4c44-9d2f-7859e0339158-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 21:49:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asbee-0001fW-Aw
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 21:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbcDSTtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 15:49:45 -0400
Received: from a6-245.smtp-out.eu-west-1.amazonses.com ([54.240.6.245]:40365
	"EHLO a6-245.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750903AbcDSTtn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2016 15:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1461095381;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=aJx+t9edDppMmNtCV4fQl8gIrkrGmXz+HEpB9epeo/c=;
	b=DVqYao1g0s+rhOCsn86qSrxv7AbRHB24+qXULxRUowKel4OS3kupCn6KE2uZGO9X
	h6ZqbMWq2JKERkFiQSQj8uDlDQlyAxYDdbyx7pFSpZrHU+fxwL8gxfV4RKR1o/G/cPs
	YbLNacpQfOOFZXXpug5UcHPKM0KVTlMAvB/MMQk8=
In-Reply-To: <01020154301238e9-9d46ac5b-d6e6-4c44-9d2f-7859e0339158-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.04.19-54.240.6.245
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291915>

When migrating from Perforce to git the information about P4 jobs
associated with P4 changelists is lost.

Having these jobs listed on messages of related git commits enables smooth
migration for projects that take advantage of e.g. JIRA integration
(which uses jobs on Perforce side and parses commit messages on git side).

The jobs are added to the message in the same format as is expected when
migrating in the reverse direction.

Signed-off-by: Jan Durovec <jan.durovec@gmail.com>
---
 git-p4.py              | 12 ++++++
 t/lib-git-p4.sh        |  9 +++++
 t/t9829-git-p4-jobs.sh | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)
 create mode 100755 t/t9829-git-p4-jobs.sh

diff --git a/git-p4.py b/git-p4.py
index 527d44b..8f869d7 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2320,6 +2320,15 @@ def extractFilesFromCommit(self, commit):
             fnum = fnum + 1
         return files
 
+    def extractJobsFromCommit(self, commit):
+        jobs = []
+        jnum = 0
+        while commit.has_key("job%s" % jnum):
+            job = commit["job%s" % jnum]
+            jobs.append(job)
+            jnum = jnum + 1
+        return jobs
+
     def stripRepoPath(self, path, prefixes):
         """When streaming files, this is called to map a p4 depot path
            to where it should go in git.  The prefixes are either
@@ -2665,6 +2674,7 @@ def hasBranchPrefix(self, path):
     def commit(self, details, files, branch, parent = ""):
         epoch = details["time"]
         author = details["user"]
+        jobs = self.extractJobsFromCommit(details)
 
         if self.verbose:
             print('commit into {0}'.format(branch))
@@ -2692,6 +2702,8 @@ def commit(self, details, files, branch, parent = ""):
 
         self.gitStream.write("data <<EOT\n")
         self.gitStream.write(details["desc"])
+        if len(jobs) > 0:
+            self.gitStream.write("\nJobs: %s" % (' '.join(jobs)))
         self.gitStream.write("\n[git-p4: depot-paths = \"%s\": change = %s" %
                              (','.join(self.branchPrefixes), details["change"]))
         if len(details['options']) > 0:
diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 0e59fd1..ce3536e 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -160,6 +160,15 @@ p4_add_user () {
 	EOF
 }
 
+p4_add_job () {
+	p4 job -f -i <<-EOF
+	Job: $1
+	Status: open
+	User: dummy
+	Description:
+	EOF
+}
+
 retry_until_success () {
 	timeout=$(($(time_in_seconds) + $RETRY_TIMEOUT))
 	until "$@" 2>/dev/null || test $(time_in_seconds) -gt $timeout
diff --git a/t/t9829-git-p4-jobs.sh b/t/t9829-git-p4-jobs.sh
new file mode 100755
index 0000000..971aeee
--- /dev/null
+++ b/t/t9829-git-p4-jobs.sh
@@ -0,0 +1,99 @@
+#!/bin/sh
+
+test_description='git p4 retrieve job info'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'add p4 jobs' '
+	(
+		p4_add_job TESTJOB-A &&
+		p4_add_job TESTJOB-B
+	)
+'
+
+test_expect_success 'add p4 files' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		>file1 &&
+		p4 add file1 &&
+		p4 submit -d "Add file 1"
+	)
+'
+
+test_expect_success 'check log message of changelist with no jobs' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git p4 clone --use-client-spec --destination="$git" //depot@all &&
+		cat >expect <<-\EOF &&
+		Add file 1
+		[git-p4: depot-paths = "//depot/": change = 1]
+
+		EOF
+		git log --format=%B >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add TESTJOB-A to change 1' '
+	(
+		cd "$cli" &&
+		p4 fix -c 1 TESTJOB-A
+	)
+'
+
+test_expect_success 'check log message of changelist with one job' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git p4 clone --use-client-spec --destination="$git" //depot@all &&
+		cat >expect <<-\EOF &&
+		Add file 1
+		Jobs: TESTJOB-A
+		[git-p4: depot-paths = "//depot/": change = 1]
+
+		EOF
+		git log --format=%B >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add TESTJOB-B to change 1' '
+	(
+		cd "$cli" &&
+		p4 fix -c 1 TESTJOB-B
+	)
+'
+
+test_expect_success 'check log message of changelist with more jobs' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git p4 clone --use-client-spec --destination="$git" //depot@all &&
+		cat >expect <<-\EOF &&
+		Add file 1
+		Jobs: TESTJOB-A TESTJOB-B
+		[git-p4: depot-paths = "//depot/": change = 1]
+
+		EOF
+		git log --format=%B >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done

--
https://github.com/git/git/pull/225
