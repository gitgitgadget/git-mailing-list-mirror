From: Patrick Reynolds <patrick.reynolds@github.com>
Subject: [PATCH v2] unblock and unignore SIGPIPE
Date: Thu, 18 Sep 2014 11:57:09 -0500
Message-ID: <1411059429-23868-1-git-send-email-patrick.reynolds@github.com>
Cc: Patrick Reynolds <patrick.reynolds@github.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 18:57:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUf1R-0008FD-56
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 18:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbaIRQ53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 12:57:29 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:43648 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbaIRQ52 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 12:57:28 -0400
Received: by mail-qg0-f51.google.com with SMTP id e89so1449360qgf.24
        for <git@vger.kernel.org>; Thu, 18 Sep 2014 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=halvqpo63gS8MckjbikIcPmlewn5ybgy7rZ80bi0uus=;
        b=KG5UNqZiGhwcX0hLOy/cB9BAvLHUryCgeea8fwGVwSfIU9YIOth5AKCWg2Y3JcJN6V
         Wh2cUfVcblep9xBa+q8Zawvqsd83qC3agua8pxxcyjeAkMONgkd/OdWX0Agm1KmFgCFq
         pKOZ5K1uLBQyQQAphao7Wr0PyUsCdMVHEJy+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=halvqpo63gS8MckjbikIcPmlewn5ybgy7rZ80bi0uus=;
        b=LfSOW5KEeuPSr4LkjaDYtaDujcO01nhz8H7/I0nhG8VPGE67eBON4pDF8sWcksHsk4
         3BTAMyD2WiyGsvl+Qq4tqFnvvM1TwLy4/MBNgDnW2YNYWtd1c5fEJl+w08THxq842lls
         GzCJJf7bkLAUfQYATN8dIu2LP4q4ZfWBNLmLkF3xoClXYqb/RYhZndGUhBIo/3+6TF5v
         5fz/CpaQAH6SwaMkVP+d0MGTwwYi0lxzI9S8SSb0rMSse9JSWr88oL0lkmhiv6+fSx0O
         TDp4WsXPXc4nCeBDvOJQCng2wfc2ZLYNR0iKcSkX//uuVhJ30HP20JjU9VGQVn8xqdRu
         4PyQ==
X-Gm-Message-State: ALoCoQnsOx98r8NrwWfP1azyY0mzLI3v6lrLOWmIOPuXe7OApNQ0S7CqNt+ICSJaQtdTRxMjjuMH
X-Received: by 10.224.161.11 with SMTP id p11mr10846783qax.40.1411059447455;
        Thu, 18 Sep 2014 09:57:27 -0700 (PDT)
Received: from localhost.localdomain (ip68-1-72-35.pn.at.cox.net. [68.1.72.35])
        by mx.google.com with ESMTPSA id l4sm6750189qad.41.2014.09.18.09.57.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Sep 2014 09:57:26 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257265>

Blocked and ignored signals -- but not caught signals -- are inherited
across exec.  Some callers with sloppy signal-handling behavior can call
git with SIGPIPE blocked or ignored, even non-deterministically.  When
SIGPIPE is blocked or ignored, several git commands can run indefinitely,
ignoring EPIPE returns from write() calls, even when the process that
called them has gone away.  Our specific case involved a pipe of git
diff-tree output to a script that reads a limited amount of diff data.

In an ideal world, git would never be called with SIGPIPE blocked or
ignored.  But in the real world, several real potential callers, including
Perl, Apache, and Unicorn, sometimes spawn subprocesses with SIGPIPE
ignored.  It is easier and more productive to harden git against this
mistake than to clean it up in every potential parent process.

Signed-off-by: Patrick Reynolds <patrick.reynolds@github.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
1. Merged Junio's work from pu: moved restore_sigpipe_to_default into
git.c and restyled the new tests.
2. Moved the new tests into t0005.  This meant switching back to `git
diff` as our data generator, as the sample repo in t0005 doesn't have any
files for `git ls-files` to output.
3. Squashed.

 git.c              | 22 ++++++++++++++++++++++
 t/t0005-signals.sh | 22 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/git.c b/git.c
index 210f1ae..0f03d56 100644
--- a/git.c
+++ b/git.c
@@ -593,6 +593,26 @@ static int run_argv(int *argcp, const char ***argv)
 	return done_alias;
 }
 
+/*
+ * Many parts of Git have subprograms communicate via pipe, expect the
+ * upstream of the pipe to die with SIGPIPE and the downstream process
+ * even knows to check and handle EPIPE correctly.  Some third-party
+ * programs that ignore or block SIGPIPE for their own reason forget
+ * to restore SIGPIPE handling to the default before spawning Git and
+ * break this carefully orchestrated machinery.
+ *
+ * Restore the way SIGPIPE is handled to default, which is what we
+ * expect.
+ */
+static void restore_sigpipe_to_default(void)
+{
+	sigset_t unblock;
+
+	sigemptyset(&unblock);
+	sigaddset(&unblock, SIGPIPE);
+	sigprocmask(SIG_UNBLOCK, &unblock, NULL);
+	signal(SIGPIPE, SIG_DFL);
+}
 
 int main(int argc, char **av)
 {
@@ -612,6 +632,8 @@ int main(int argc, char **av)
 	 */
 	sanitize_stdfds();
 
+	restore_sigpipe_to_default();
+
 	git_setup_gettext();
 
 	trace_command_performance(argv);
diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index 981437b..638a355 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -27,4 +27,26 @@ test_expect_success !MINGW 'signals are propagated using shell convention' '
 	test_expect_code 143 git sigterm
 '
 
+large_git () {
+	for i in $(test_seq 1 100)
+	do
+		git diff --cached --binary || return
+	done
+}
+
+test_expect_success 'create blob' '
+	test-genrandom foo 16384 >file &&
+	git add file
+'
+
+test_expect_success 'a constipated git dies with SIGPIPE' '
+	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 )
+	test "$OUT" -eq 141
+'
+
+test_expect_success 'a constipated git dies with SIGPIPE even if parent ignores it' '
+	OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 )
+	test "$OUT" -eq 141
+'
+
 test_done
-- 
2.0.1
