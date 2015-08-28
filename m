From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/9] run-command: add synced output
Date: Thu, 27 Aug 2015 18:14:51 -0700
Message-ID: <1440724495-708-6-git-send-email-sbeller@google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 03:16:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV8Gr-0001AW-Kh
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 03:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbbH1BPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 21:15:37 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36341 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbbH1BPG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 21:15:06 -0400
Received: by pacgr6 with SMTP id gr6so6675910pac.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 18:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FyWBGnWzCXxEbgUJpc7Ld9cbN/rz1GIPEqrkWkt/Cak=;
        b=Gio1ZGcqICHhqR9mRt9xHAmheq7O8xTnFpaSY+aS8t+0zk/zh+swUpm3kQLLpfjP8Z
         JPItZi0ZOVslxojoh/Fy4uawsODE4Ev/57j3pZNhHIW4DAD9A4qKjxqBDjMuI/z9XL/i
         DIda9z9ov8JJtRbkNBhkBDZ4geIUFcYvUXCyQfPFkxr3d9JVjtIOM5DuY2L8fkus7M3b
         z+ZNoNGIzD4ZrdH0HsVQ0nzn6PCN97U2iGjraet3FlKQMyiRbe8+ZyxKqo6d5wxi6iBd
         wdD9e1D+afwS8iOCyKhr2g390T/zbyjSOMBoeQAUt9M65Tt3o8qeSTT/yH+ynpg2kxVG
         eLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FyWBGnWzCXxEbgUJpc7Ld9cbN/rz1GIPEqrkWkt/Cak=;
        b=ampMY+Zwt9hbJQYvISPfpkb5djfwsZtELUeMclWoQHhp+Q32nlTPnEX8hOZMaOXm7z
         JY3EkYNSL9cKFpf7079C2PNTemLS+nPk6JeBAxCmPyB/KfQMq/hJLn5+1Ih68IT78Am7
         Emrv5pXWRHCuEggIu6FMMVPljzpwm/71q3O5msgR2qwufm3WpZNLDFaSsphzYobQ3giD
         S6bpnw9NBOypn0mSk4AphnsX2Y9BMzH+gQC9Xvy7uY2Oylq6Ts5TzlZIDWmsQ4k0C2pP
         qeJ//FHsDVigeurkLOzLCNnW4KQ7Vko3gpIhNLmqF7z4APYfk93wF1sZddMWsWWok0v3
         dMVA==
X-Gm-Message-State: ALoCoQlqXvhM8eBD4yvamXBhMhN0Y93/QSdcvEzIbKkcuv+bvYpvk1/JrcupBq3vkjpaIvD45ucl
X-Received: by 10.66.66.162 with SMTP id g2mr11008895pat.82.1440724505744;
        Thu, 27 Aug 2015 18:15:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bce4:8b21:c71b:de7e])
        by smtp.gmail.com with ESMTPSA id ip7sm3725381pbc.68.2015.08.27.18.15.04
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 27 Aug 2015 18:15:05 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g5e52b0d
In-Reply-To: <1440724495-708-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276697>

In the last patch we added an easy way to get a thread pool. Now if we
want to run external commands from threads in the thread pool, the output
will mix up between the threads.

To solve this problem we protect the output via a mutex from becoming
garbled. Each thread will try to acquire and directly pipe their output
to the standard output if they are lucky to get the mutex. If they do not
have the mutex each thread will buffer their output.

Example:
Let's assume we have 5 tasks A,B,C,D,E and each task takes a different
amount of time (say `git fetch` for different submodules), then the output
of tasks in sequential order might look like this:

 time -->
 output: |---A---|   |-B-|   |----C-----------|   |-D-|   |-E-|

When we schedule these tasks into two threads, a schedule
and sample output over time may look like this:

thread 1: |---A---|   |-D-|   |-E-|

thread 2: |-B-|   |----C-----------|

output:   |---A---|B|------C-------|ED

So A will be perceived as it would run normally in
the single threaded version of foreach. As B has finished
by the time the mutex becomes available, the whole buffer
will just be dumped into the standard output. This will be
perceived by the user as just a 'very fast' operation of B.
Once that is done, C takes the mutex, and flushes the piled
up buffer to standard output. In case the it is a
git command, we have a nice progress display, which will just
look like the first half of C happend really quickly.

Notice how E and D are put out in a different order than the
original as the new parallel foreach doesn't care about the
order.

So this way of output is really good for human consumption,
as it only changes the timing, not the actual output.

For machine consumption the output needs to be prepared in
the tasks, by either having a prefix per line or per block
to indicate whose tasks output is displayed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 run-command.h | 18 ++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/run-command.c b/run-command.c
index 3d37f8c..bac4367 100644
--- a/run-command.c
+++ b/run-command.c
@@ -556,17 +556,77 @@ int finish_command(struct child_process *cmd)
 }
 
 int run_command(struct child_process *cmd)
+#ifdef NO_PTHREADS
 {
 	int code;
 
 	if (cmd->out < 0 || cmd->err < 0)
 		die("BUG: run_command with a pipe can cause deadlock");
 
+	if (cmd->sync_buf)
+		xwrite(cmd->out, cmd->sync_buf->buf, cmd->sync_buf->len);
+
 	code = start_command(cmd);
 	if (code)
 		return code;
 	return finish_command(cmd);
 }
+#else
+{
+	int code, lock_acquired;
+
+	if (!cmd->sync_mutex) {
+		if (cmd->out < 0 || cmd->err < 0)
+			die("BUG: run_command with a pipe can cause deadlock");
+
+		if (cmd->sync_buf)
+			xwrite(cmd->out, cmd->sync_buf->buf, cmd->sync_buf->len);
+	} else {
+		if (cmd->out < 0)
+			die("BUG: run_command with a pipe can cause deadlock");
+
+		if (!cmd->stdout_to_stderr)
+			die("BUG: run_command with sync_mutex not supported "
+			    "without stdout_to_stderr set");
+
+		if (!cmd->sync_buf)
+			die("BUG: Must pass a buffer when specifying "
+			    "to sync output");
+	}
+
+	code = start_command(cmd);
+	if (code)
+		return code;
+
+	if (cmd->sync_mutex) {
+		while (1) {
+			char buf[1024];
+			ssize_t len = xread(cmd->err, buf, sizeof(buf));
+			if (len < 0)
+				die("Read from command failed");
+			else if (len == 0)
+				break;
+			else
+				strbuf_add(cmd->sync_buf, buf, len);
+
+			if (!lock_acquired
+			    && !pthread_mutex_trylock(cmd->sync_mutex))
+				lock_acquired = 1;
+			if (lock_acquired) {
+				fputs(cmd->sync_buf->buf, stderr);
+				strbuf_reset(cmd->sync_buf);
+			}
+		}
+		if (!lock_acquired)
+			pthread_mutex_lock(cmd->sync_mutex);
+
+		fputs(cmd->sync_buf->buf, stderr);
+		pthread_mutex_unlock(cmd->sync_mutex);
+	}
+
+	return finish_command(cmd);
+}
+#endif
 
 int run_command_v_opt(const char **argv, int opt)
 {
diff --git a/run-command.h b/run-command.h
index 176a5b2..0df83c9 100644
--- a/run-command.h
+++ b/run-command.h
@@ -43,6 +43,24 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
 	unsigned clean_on_exit:1;
+#ifndef NO_PTHREAD
+	/*
+	 * In a threaded environment running multiple commands from different
+	 * threads would lead to garbled output as the output of different
+	 * commands would mix.
+	 * If this mutex is not NULL, the output of `err` is only done when
+	 * holding the mutex. If the mutex cannot be acquired, the output
+	 * will be buffered until the mutex can be acquired.
+	 */
+	pthread_mutex_t *sync_mutex;
+#endif
+	/*
+	 * The sync_buf will be used to buffer the output while the mutex
+	 * is not acquired. It can also contain data before being passed into
+	 * run_command, which will be output together with the output of
+	 * the child.
+	 */
+	struct strbuf *sync_buf;
 };
 
 #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
-- 
2.5.0.264.g5e52b0d
