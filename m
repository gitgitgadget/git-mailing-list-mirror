From: Patrick Reynolds <patrick.reynolds@github.com>
Subject: [PATCH] unblock and unignore SIGPIPE
Date: Fri, 15 Aug 2014 00:29:25 -0500
Message-ID: <1408080565-33234-1-git-send-email-patrick.reynolds@github.com>
Cc: Patrick Reynolds <patrick.reynolds@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 07:29:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIA57-0005k6-KR
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 07:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbaHOF3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 01:29:38 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:41754 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbaHOF3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 01:29:37 -0400
Received: by mail-qg0-f46.google.com with SMTP id z60so1867448qgd.5
        for <git@vger.kernel.org>; Thu, 14 Aug 2014 22:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/8tzlhn17tcpmczqbM8ceEzIP93I/SPRCwv8Bqr9DMg=;
        b=d6Ij4bKMEPTDgVKbfgpJjf9MyPvsd9EumDU4Eo6hQMfekexaCf3C8oOK1xXa4nS3ly
         qT4qS8aPv5e5biMvZizAEndYEntvrx2NAYl8AcG5Oo0S12oixq/oe4ktTpiJWQOGYp1S
         o0QQDLaaNJiuR63282mj/7qPM6qqtFoolshqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/8tzlhn17tcpmczqbM8ceEzIP93I/SPRCwv8Bqr9DMg=;
        b=FZSuKBOq5zqVLoc5diWhd+F9Pl08CAg/ttF/eWMKasDAaB2UcwRhn/Wrx5esa9Fa66
         gSSv/P5rWe+7ISmQZsiUOCXFgqlOQY1IFkn+NYa58KEzEC1HzunZEJlVQDpbZh5X/EQD
         av5hQNlM48nkLwCxXzKJLCMXlO7qUP3EQi1X8QYvZwhOvXn3jGnJnwwaruAr9JlTAcxG
         ntijOE645AQHv79DSwdWpk78HnseeLBDzYOsSGzWfc/XjZrZlMgWsJsiUffe3cYWXpz4
         /ZKZsc/hDxvidVHpey7E8ZCAF0Idzs6z6uIjzXBKCchvr8V2WKySFio28h2Q1YQh7qre
         x0Iw==
X-Gm-Message-State: ALoCoQndpnhTongR2KkpSvYWAIJrWTe169Da1AJRwQrtA6G3j7WCJS9VZHcAnlEvGqxbylEINC/b
X-Received: by 10.140.96.85 with SMTP id j79mr23688256qge.5.1408080576466;
        Thu, 14 Aug 2014 22:29:36 -0700 (PDT)
Received: from localhost.localdomain (ip68-1-72-35.pn.at.cox.net. [68.1.72.35])
        by mx.google.com with ESMTPSA id j3sm7829948qgj.48.2014.08.14.22.29.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Aug 2014 22:29:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255280>

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
---
 cache.h            |  1 +
 git.c              |  5 +++++
 setup.c            | 11 +++++++++++
 t/t0012-sigpipe.sh | 27 +++++++++++++++++++++++++++
 4 files changed, 44 insertions(+)
 create mode 100755 t/t0012-sigpipe.sh

diff --git a/cache.h b/cache.h
index fcb511d..0a89fc1 100644
--- a/cache.h
+++ b/cache.h
@@ -463,6 +463,7 @@ extern int set_git_dir_init(const char *git_dir, const char *real_git_dir, int);
 extern int init_db(const char *template_dir, unsigned int flags);
 
 extern void sanitize_stdfds(void);
+extern void sanitize_signals(void);
 extern int daemonize(void);
 
 #define alloc_nr(x) (((x)+16)*3/2)
diff --git a/git.c b/git.c
index 9c49519..d6b221b 100644
--- a/git.c
+++ b/git.c
@@ -611,6 +611,11 @@ int main(int argc, char **av)
 	 */
 	sanitize_stdfds();
 
+	/*
+	 * Make sure we aren't ignoring or blocking SIGPIPE.
+	 */
+	sanitize_signals();
+
 	git_setup_gettext();
 
 	trace_command_performance(argv);
diff --git a/setup.c b/setup.c
index 0a22f8b..7aa4b01 100644
--- a/setup.c
+++ b/setup.c
@@ -865,3 +865,14 @@ int daemonize(void)
 	return 0;
 #endif
 }
+
+/* un-ignore and un-block SIGPIPE */
+void sanitize_signals(void)
+{
+	sigset_t unblock;
+
+	sigemptyset(&unblock);
+	sigaddset(&unblock, SIGPIPE);
+	sigprocmask(SIG_UNBLOCK, &unblock, NULL);
+	signal(SIGPIPE, SIG_DFL);
+}
diff --git a/t/t0012-sigpipe.sh b/t/t0012-sigpipe.sh
new file mode 100755
index 0000000..213cde3
--- /dev/null
+++ b/t/t0012-sigpipe.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='check handling of SIGPIPE'
+. ./test-lib.sh
+
+test_expect_success 'create blob' '
+	test-genrandom foo 16384 >file &&
+	git add file
+'
+
+large_git () {
+	for i in $(test_seq 1 100); do
+		git diff --staged --binary || return $?
+	done
+}
+
+test_expect_success 'git dies with SIGPIPE' '
+	OUT=$( ((large_git; echo $? 1>&3) | true) 3>&1 )
+	test "$OUT" -eq 141
+'
+
+test_expect_success 'git dies with SIGPIPE even if parent ignores it' '
+	OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | true) 3>&1 )
+	test "$OUT" -eq 141
+'
+
+test_done
-- 
2.0.1
