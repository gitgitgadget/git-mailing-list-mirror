From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 05/13] run-command: factor out return value computation
Date: Mon, 21 Sep 2015 15:39:11 -0700
Message-ID: <1442875159-13027-6-git-send-email-sbeller@google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:39:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9kM-0006NK-1D
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933064AbbIUWjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:39:37 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35384 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932962AbbIUWja (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:39:30 -0400
Received: by pacfv12 with SMTP id fv12so131214089pac.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mdCLOXL0vJZS1fheQ1oXS8KRxQ8azDb+2OqeleLfNU0=;
        b=azgZoInM+W7xCbQ+YX8DT07zjnoJ4JUwX6dwbXc5P2eyH7PiOM5qoHPlsojlMST3u3
         ehz4nlhnOKJ2YV650SpC0ka7iOCg0TXgQn3gzab7Osg2PedXxpEIIRuW8zcL2+1uXvch
         gWXq8Iux1o6ERd4PNdH2MDHOHV/l5CEqJwZhJO+yaaecc1O9H/7x3awu1Y9jRxDA3kgA
         M7Lv3ENEUEYpyp5zGqUA5+/yWEMt6ccrd0SFtLO07S0Wf6DUQFuLLxhRpCv8oiNUaFaq
         sL4xypdhUX7iqyF4m0sMzLgFzyB3WZnx4rJcnBS/BvHW9hRPYHA0FU8zAisWzNvdcnoU
         3UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mdCLOXL0vJZS1fheQ1oXS8KRxQ8azDb+2OqeleLfNU0=;
        b=grkrcv6eKCW9FMrm3LH0pmddi8UFEZuKTjtNUTGltGiJBsRqsMvdoejwae7RlNUPx5
         SHEI/P6qPQ3Pgx2iw6NQWLAnIjwx38mtSe/W5uHrJ98LwdaXzmnzXkySiJpaLCtHquLe
         jCPeQBJ87sXhZcQ2aRZx7z8USqz1dz0bW6j4Hmq3iDKnZZE5H02vKTD6z23D0HrSeq8N
         mmwsozzgjfxgRuUC2WRSv0ZFH153sp9pDxvsHBW6FZH8dfarBGEWikE9g+e20SRcXjZo
         5H/sqdD1DCMLV20xoMT2cqoRdesTlDt1L/vSYebIyJ3JEs83u5X7rhw2JrLIu+qNQxgk
         KwWQ==
X-Gm-Message-State: ALoCoQlWDX6+WvuFiAXW/R+x7awVKtvwFLzEsBYYjGdx83+zJVtV2ocdzOy6ORmPUO++/vNf0FvO
X-Received: by 10.66.219.102 with SMTP id pn6mr27497327pac.80.1442875170126;
        Mon, 21 Sep 2015 15:39:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:a032:5a54:ea65:75ca])
        by smtp.gmail.com with ESMTPSA id qg2sm24035442pbb.80.2015.09.21.15.39.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 15:39:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.ge015d2a
In-Reply-To: <1442875159-13027-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278339>

We will need computing the return value in a later patch without the
wait.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 54 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/run-command.c b/run-command.c
index 28e1d55..674e348 100644
--- a/run-command.c
+++ b/run-command.c
@@ -232,6 +232,35 @@ static inline void set_cloexec(int fd)
 		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
 
+static int determine_return_value(int wait_status,
+				  int *result,
+				  int *error_code,
+				  const char *argv0)
+{
+	if (WIFSIGNALED(wait_status)) {
+		*result = WTERMSIG(wait_status);
+		if (*result != SIGINT && *result != SIGQUIT)
+			error("%s died of signal %d", argv0, *result);
+		/*
+		 * This return value is chosen so that code & 0xff
+		 * mimics the exit code that a POSIX shell would report for
+		 * a program that died from this signal.
+		 */
+		*result += 128;
+	} else if (WIFEXITED(wait_status)) {
+		*result = WEXITSTATUS(wait_status);
+		/*
+		 * Convert special exit code when execvp failed.
+		 */
+		if (*result == 127) {
+			*result = -1;
+			*error_code = ENOENT;
+		}
+	} else
+		return -1;
+	return 0;
+}
+
 static int wait_or_whine(pid_t pid, const char *argv0)
 {
 	int status, code = -1;
@@ -244,29 +273,10 @@ static int wait_or_whine(pid_t pid, const char *argv0)
 	if (waiting < 0) {
 		failed_errno = errno;
 		error("waitpid for %s failed: %s", argv0, strerror(errno));
-	} else if (waiting != pid) {
-		error("waitpid is confused (%s)", argv0);
-	} else if (WIFSIGNALED(status)) {
-		code = WTERMSIG(status);
-		if (code != SIGINT && code != SIGQUIT)
-			error("%s died of signal %d", argv0, code);
-		/*
-		 * This return value is chosen so that code & 0xff
-		 * mimics the exit code that a POSIX shell would report for
-		 * a program that died from this signal.
-		 */
-		code += 128;
-	} else if (WIFEXITED(status)) {
-		code = WEXITSTATUS(status);
-		/*
-		 * Convert special exit code when execvp failed.
-		 */
-		if (code == 127) {
-			code = -1;
-			failed_errno = ENOENT;
-		}
 	} else {
-		error("waitpid is confused (%s)", argv0);
+		if (waiting != pid
+		   || (determine_return_value(status, &code, &failed_errno, argv0) < 0))
+			error("waitpid is confused (%s)", argv0);
 	}
 
 	clear_child_for_cleanup(pid);
-- 
2.5.0.275.ge015d2a
