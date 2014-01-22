From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 07/11] git p4 test: do not pollute /tmp
Date: Wed, 22 Jan 2014 17:47:25 -0500
Message-ID: <1390430849-11436-7-git-send-email-pw@padd.com>
References: <20140122224421.GB4047@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 23:49:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W66c6-00067e-Ki
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 23:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991AbaAVWtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 17:49:33 -0500
Received: from honk.padd.com ([74.3.171.149]:41859 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370AbaAVWtc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 17:49:32 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 1CFFB712D;
	Wed, 22 Jan 2014 14:49:32 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8DA52200AB; Wed, 22 Jan 2014 17:49:29 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <20140122224421.GB4047@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240878>

Generating the submit template for p4 uses tempfile.mkstemp(),
which by default puts files in /tmp.  For a test that fails,
possibly on purpose, this is not cleaned up.  Run with TMPDIR
pointing into the trash directory so the temp files go away
with the test results.

To do this required some other minor changes.  First, the editor
is launched using system(editor + " " + template_file), using
shell expansion to build the command string.  This doesn't work
if editor has a space in it.  And is generally unwise as it's
easy to fool the shell into doing extra work.  Exec the args
directly, without shell expansion.

Second, without shell expansion, the trick of "P4EDITOR=:" used
in the tests doesn't work.  Use a real command, true, as the
non-interactive editor for testing.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                          | 2 +-
 t/lib-git-p4.sh                    | 8 +++++++-
 t/t9805-git-p4-skip-submit-edit.sh | 6 ++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 3a20d15..f0a327d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1220,7 +1220,7 @@ class P4Submit(Command, P4UserMap):
             editor = os.environ.get("P4EDITOR")
         else:
             editor = read_pipe("git var GIT_EDITOR").strip()
-        system(editor + " " + template_file)
+        system([editor, template_file])
 
         # If the file was not saved, prompt to see if this patch should
         # be skipped.  But skip this verification step if configured so.
diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 4ff2bb1..5aa8adc 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -48,7 +48,7 @@ P4DPORT=$((10669 + ($testid - $git_p4_test_start)))
 P4PORT=localhost:$P4DPORT
 P4CLIENT=client
 P4USER=author
-P4EDITOR=:
+P4EDITOR=true
 unset P4CHARSET
 export P4PORT P4CLIENT P4USER P4EDITOR P4CHARSET
 
@@ -57,6 +57,12 @@ cli="$TRASH_DIRECTORY/cli"
 git="$TRASH_DIRECTORY/git"
 pidfile="$TRASH_DIRECTORY/p4d.pid"
 
+# git p4 submit generates a temp file, which will
+# not get cleaned up if the submission fails.  Don't
+# clutter up /tmp on the test machine.
+TMPDIR="$TRASH_DIRECTORY"
+export TMPDIR
+
 start_p4d() {
 	mkdir -p "$db" "$cli" "$git" &&
 	rm -f "$pidfile" &&
diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
index ff2cc79..8931188 100755
--- a/t/t9805-git-p4-skip-submit-edit.sh
+++ b/t/t9805-git-p4-skip-submit-edit.sh
@@ -17,7 +17,7 @@ test_expect_success 'init depot' '
 	)
 '
 
-# this works because EDITOR is set to :
+# this works because P4EDITOR is set to true
 test_expect_success 'no config, unedited, say yes' '
 	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
@@ -90,7 +90,9 @@ test_expect_success 'no config, edited' '
 		cd "$git" &&
 		echo line >>file1 &&
 		git commit -a -m "change 5" &&
-		P4EDITOR="" EDITOR="\"$TRASH_DIRECTORY/ed.sh\"" git p4 submit &&
+		P4EDITOR="$TRASH_DIRECTORY/ed.sh" &&
+		export P4EDITOR &&
+		git p4 submit &&
 		p4 changes //depot/... >wc &&
 		test_line_count = 5 wc
 	)
-- 
1.8.5.2.364.g6ac45cd
