From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 3/3] git p4: notice Jobs lines in git commit messages
Date: Wed,  4 Jul 2012 09:34:20 -0400
Message-ID: <1341408860-26965-4-git-send-email-pw@padd.com>
References: <1341408860-26965-1-git-send-email-pw@padd.com>
Cc: Michael Horowitz <mike@horowitz.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 15:35:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmPjv-0005Ci-MS
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 15:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab2GDNf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 09:35:26 -0400
Received: from honk.padd.com ([74.3.171.149]:54387 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081Ab2GDNfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 09:35:25 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 13A7D1FED;
	Wed,  4 Jul 2012 06:35:24 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7D2BC5A90B; Wed,  4 Jul 2012 09:35:20 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.125.g4a65fea
In-Reply-To: <1341408860-26965-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201007>

P4 has a feature called "jobs" that allows linking changes
to a bug tracking system or other tasks.  When submitting
code, a job name can be specified to mark that this change
is associated with a particular job.

Teach git-p4 to find an optional "Jobs:" line in git commit
messages and use them to make a Jobs section in the p4
change specifitation.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                |  46 ++++++++++++--
 t/t9807-git-p4-submit.sh | 155 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 542c20a..fa44817 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -854,9 +854,34 @@ class P4Submit(Command, P4UserMap):
         if len(p4CmdList("opened ...")) > 0:
             die("You have files opened with perforce! Close them before starting the sync.")
 
-    # replaces everything between 'Description:' and the next P4 submit template field with the
-    # commit message
-    def prepareLogMessage(self, template, message):
+    def separate_jobs_from_description(self, message):
+        """Extract and return a possible Jobs field in the commit
+           message.  It goes into a separate section in the p4 change
+           specification.
+
+           A jobs line starts with "Jobs:" and looks like a new field
+           in a form.  Values are white-space separated on the same
+           line or on following lines that start with a tab.
+
+           This does not parse and extract the full git commit message
+           like a p4 form.  It just sees the Jobs: line as a marker
+           to pass everything from then on directly into the p4 form,
+           but outside the description section.
+           
+           Return a tuple (stripped log message, jobs string)."""
+
+        m = re.search(r'^Jobs:', message, re.MULTILINE)
+        if m is None:
+            return (message, None)
+
+        jobtext = message[m.start():]
+        stripped_message = message[:m.start()].rstrip()
+        return (stripped_message, jobtext)
+
+    def prepareLogMessage(self, template, message, jobs):
+        """Edits the template returned from "p4 change -o" to insert
+           the message in the Description field, and the jobs text in
+           the Jobs field."""
         result = ""
 
         inDescriptionSection = False
@@ -869,6 +894,9 @@ class P4Submit(Command, P4UserMap):
             if inDescriptionSection:
                 if line.startswith("Files:") or line.startswith("Jobs:"):
                     inDescriptionSection = False
+                    # insert Jobs section
+                    if jobs:
+                        result += jobs + "\n"
                 else:
                     continue
             else:
@@ -980,7 +1008,13 @@ class P4Submit(Command, P4UserMap):
         return 0
 
     def prepareSubmitTemplate(self):
-        # remove lines in the Files section that show changes to files outside the depot path we're committing into
+        """Run "p4 change -o" to grab a change specification template.
+           This does not use "p4 -G", as it is nice to keep the submission
+           template in original order, since a human might edit it.
+
+           Remove lines in the Files section that show changes to files
+           outside the depot path we're committing into."""
+
         template = ""
         inFilesSection = False
         for line in p4_read_pipe_lines(['change', '-o']):
@@ -1205,10 +1239,10 @@ class P4Submit(Command, P4UserMap):
 
         logMessage = extractLogMessageFromGitCommit(id)
         logMessage = logMessage.strip()
+        (logMessage, jobs) = self.separate_jobs_from_description(logMessage)
 
         template = self.prepareSubmitTemplate()
-
-        submitTemplate = self.prepareLogMessage(template, logMessage)
+        submitTemplate = self.prepareLogMessage(template, logMessage, jobs)
 
         if self.preserveUser:
            submitTemplate = submitTemplate + ("\n######## Actual user %s, modified after commit\n" % p4User)
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index f23b4c3..d6d588c 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -182,6 +182,161 @@ test_expect_success 'submit rename' '
 	)
 '
 
+#
+# Converting git commit message to p4 change description, including
+# parsing out the optional Jobs: line.
+#
+test_expect_success 'simple one-line description' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo desc2 >desc2 &&
+		git add desc2 &&
+		cat >msg <<-EOF &&
+		One-line description line for desc2.
+		EOF
+		git commit -F - <msg &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit &&
+		change=$(p4 -G changes -m 1 //depot/... | \
+		         marshal_dump change) &&
+		# marshal_dump always adds a newline
+		p4 -G describe $change | marshal_dump desc | sed \$d >pmsg &&
+		test_cmp msg pmsg
+	)
+'
+
+test_expect_success 'description with odd formatting' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo desc3 >desc3 &&
+		git add desc3 &&
+		(
+			printf "subject line\n\n\tExtra tab\nline.\n\n" &&
+			printf "Description:\n\tBogus description marker\n\n" &&
+			# git commit eats trailing newlines; only use one
+			printf "Files:\n\tBogus descs marker\n"
+		) >msg &&
+		git commit -F - <msg &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit &&
+		change=$(p4 -G changes -m 1 //depot/... | \
+		         marshal_dump change) &&
+		# marshal_dump always adds a newline
+		p4 -G describe $change | marshal_dump desc | sed \$d >pmsg &&
+		test_cmp msg pmsg
+	)
+'
+
+make_job() {
+	name="$1" &&
+	tab="$(printf \\t)" &&
+	p4 job -o | \
+	sed -e "/^Job:/s/.*/Job: $name/" \
+	    -e "/^Description/{ n; s/.*/$tab job text/; }" | \
+	p4 job -i
+}
+
+test_expect_success 'description with Jobs section at end' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo desc4 >desc4 &&
+		git add desc4 &&
+		echo 6060842 >jobname &&
+		(
+			printf "subject line\n\n\tExtra tab\nline.\n\n" &&
+			printf "Files:\n\tBogus files marker\n" &&
+			printf "Junk: 3164175\n" &&
+			printf "Jobs: $(cat jobname)\n"
+		) >msg &&
+		git commit -F - <msg &&
+		git config git-p4.skipSubmitEdit true &&
+		# build a job
+		make_job $(cat jobname) &&
+		git p4 submit &&
+		change=$(p4 -G changes -m 1 //depot/... | \
+		         marshal_dump change) &&
+		# marshal_dump always adds a newline
+		p4 -G describe $change | marshal_dump desc | sed \$d >pmsg &&
+		# make sure Jobs line and all following is gone
+		sed "/^Jobs:/,\$d" msg >jmsg &&
+		test_cmp jmsg pmsg &&
+		# make sure p4 knows about job
+		p4 -G describe $change | marshal_dump job0 >job0 &&
+		test_cmp jobname job0
+	)
+'
+
+test_expect_success 'description with Jobs and values on separate lines' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo desc5 >desc5 &&
+		git add desc5 &&
+		echo PROJ-6060842 >jobname1 &&
+		echo PROJ-6060847 >jobname2 &&
+		(
+			printf "subject line\n\n\tExtra tab\nline.\n\n" &&
+			printf "Files:\n\tBogus files marker\n" &&
+			printf "Junk: 3164175\n" &&
+			printf "Jobs:\n" &&
+			printf "\t$(cat jobname1)\n" &&
+			printf "\t$(cat jobname2)\n"
+		) >msg &&
+		git commit -F - <msg &&
+		git config git-p4.skipSubmitEdit true &&
+		# build two jobs
+		make_job $(cat jobname1) &&
+		make_job $(cat jobname2) &&
+		git p4 submit &&
+		change=$(p4 -G changes -m 1 //depot/... | \
+		         marshal_dump change) &&
+		# marshal_dump always adds a newline
+		p4 -G describe $change | marshal_dump desc | sed \$d >pmsg &&
+		# make sure Jobs line and all following is gone
+		sed "/^Jobs:/,\$d" msg >jmsg &&
+		test_cmp jmsg pmsg &&
+		# make sure p4 knows about the two jobs
+		p4 -G describe $change >change &&
+		(
+			marshal_dump job0 <change &&
+			marshal_dump job1 <change
+		) | sort >jobs &&
+		cat jobname1 jobname2 | sort >expected &&
+		test_cmp expected jobs
+	)
+'
+
+test_expect_success 'description with Jobs section and bogus following text' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo desc6 >desc6 &&
+		git add desc6 &&
+		echo 6060843 >jobname &&
+		(
+			printf "subject line\n\n\tExtra tab\nline.\n\n" &&
+			printf "Files:\n\tBogus files marker\n" &&
+			printf "Junk: 3164175\n" &&
+			printf "Jobs: $(cat jobname)\n" &&
+			printf "MoreJunk: 3711\n"
+		) >msg &&
+		git commit -F - <msg &&
+		git config git-p4.skipSubmitEdit true &&
+		# build a job
+		make_job $(cat jobname) &&
+		test_must_fail git p4 submit 2>err &&
+		test_i18ngrep "Unknown field name" err
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.11.1.125.g4a65fea
