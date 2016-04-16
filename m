From: Jan Durovec <jan.durovec@gmail.com>
Subject: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Sat, 16 Apr 2016 19:58:00 +0000
Message-ID: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 21:58:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arWM8-0002TO-Ck
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 21:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbcDPT6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 15:58:05 -0400
Received: from a6-246.smtp-out.eu-west-1.amazonses.com ([54.240.6.246]:51256
	"EHLO a6-246.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751451AbcDPT6D (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2016 15:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1460836680;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=w7loJMZbQgJYIEwwZGwSd5XqRBdyRVXPxtA9WZcrbDc=;
	b=KIfWRoN/m7KIChC/U/gfShYNtVSQCKWuM61KXAGp5CNxMTvhWJDSiqWVW+cwW/O9
	ox7QzX15zzeVecpitpDlTAGudfuXieIi/vIuCBlIXP4ZVKkfsg5z+/v6JYd3qiQt5FI
	w+oiKbjgNVKc6ruh0JAbkdZit0INlH3uSTIoOs7Q=
X-SES-Outgoing: 2016.04.16-54.240.6.246
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291734>

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
 t/lib-git-p4.sh        | 10 +++++
 t/t9829-git-p4-jobs.sh | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
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
index f9ae1d7..3907560 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -160,6 +160,16 @@ p4_add_user() {
 	EOF
 }
 
+p4_add_job() {
+	name=$1 &&
+	p4 job -f -i <<-EOF
+	Job: $name
+	Status: open
+	User: dummy
+	Description:
+	EOF
+}
+
 retry_until_success() {
 	timeout=$(($(time_in_seconds) + $RETRY_TIMEOUT))
 	until "$@" 2>/dev/null || test $(time_in_seconds) -gt $timeout
diff --git a/t/t9829-git-p4-jobs.sh b/t/t9829-git-p4-jobs.sh
new file mode 100755
index 0000000..2b9c98c
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
+Add file 1
+[git-p4: depot-paths = "//depot/": change = 1]
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
+Add file 1
+Jobs: TESTJOB-A
+[git-p4: depot-paths = "//depot/": change = 1]
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
+Add file 1
+Jobs: TESTJOB-A TESTJOB-B
+[git-p4: depot-paths = "//depot/": change = 1]
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
