From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv17 05/11] run_processes_parallel: treat output of children as byte array
Date: Wed, 24 Feb 2016 19:06:52 -0800
Message-ID: <1456369618-18127-6-git-send-email-sbeller@google.com>
References: <1456369618-18127-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 04:07:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYmHF-000116-EH
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 04:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759900AbcBYDHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 22:07:18 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34975 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759880AbcBYDHL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 22:07:11 -0500
Received: by mail-pa0-f41.google.com with SMTP id ho8so24507011pac.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 19:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9RTs5uhTxsrwKu9rEALRD/eHVRm7NWJq86Sf7sczmZE=;
        b=n9ypk4YWmT3q2TyERDrGuCeB59iQ73J6YwxUBpP6LG0lMPIwTiHeJZ60Sw5+ndbEiP
         8Mt/2//IzxYF7DNxxL/5rh2p+9ddOvjesuK2m3cMG51MqO68EJOaJ0ERbYClny+qdtbf
         AlQPtUdNDhCjfUI0tmkCJC6hBrWMN+OAH6WRwTFZgKkhb7B3W1HW9Im6pWGc2J8jH1Pb
         aVp/WRBtXWy+fDAxkds4Wf9TuMcmJEbU+rqukm7qcd4EkfcqY3oIhzkouwmj7oub5CjN
         S92ZfHj8RuM7vuYdiJ/Rx8qmKULt+o08AWTAOpyDUHuKLuqOiOytPjZQ+2Ttqnb2nu9w
         Z0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9RTs5uhTxsrwKu9rEALRD/eHVRm7NWJq86Sf7sczmZE=;
        b=CHeeTr7Ke4CBPblZyIR4k5ZfXEpsfajw7FY2gXfVS9vJijI4Wbia068avRRaqgiRJ3
         M3VFGVPbi7VYT6NhE1UrcCyMFaMTA0jdemXMYTJ5zwLAcXsaSSh63r0ooo305YkOad9l
         HHzRw26WMspQdUNY64j+XV5opP/kaGD6kUQA4lOHa0f0vCkwJH5YQ5lBtYnOQ5uNn+dQ
         KWulHf9HHOjoEc98wsULZbp4S0+RgRvcwNnMKYCCm5BwGA0iL8y66WjshVrnx+xMmPgn
         pnRft11QThtvXxHGTEhpvkBeeO3qw3NkIexqVua2uV+EcWhPOgK6u9yBWzex4Zk3OEwm
         A2iw==
X-Gm-Message-State: AG10YOTfVL3UMM0yBw/MygBsrnAfWdhmurIgcH62En0/k3dWXXO9y4P2cAGAo2dxuv2n98PC
X-Received: by 10.66.222.101 with SMTP id ql5mr60007708pac.144.1456369630625;
        Wed, 24 Feb 2016 19:07:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id ud10sm7975560pab.27.2016.02.24.19.07.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 19:07:10 -0800 (PST)
X-Mailer: git-send-email 2.7.2.373.g1655498.dirty
In-Reply-To: <1456369618-18127-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287321>

We do not want the output to be interrupted by a NUL byte, so we
cannot use raw fputs. Introduce strbuf_write to avoid having long
arguments in run-command.c.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 8 ++++----
 strbuf.c      | 6 ++++++
 strbuf.h      | 6 ++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 51fd72c..2f8f222 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1011,7 +1011,7 @@ static void pp_cleanup(struct parallel_processes *pp)
 	 * When get_next_task added messages to the buffer in its last
 	 * iteration, the buffered output is non empty.
 	 */
-	fputs(pp->buffered_output.buf, stderr);
+	strbuf_write(&pp->buffered_output, stderr);
 	strbuf_release(&pp->buffered_output);
 
 	sigchain_pop_common();
@@ -1097,7 +1097,7 @@ static void pp_output(struct parallel_processes *pp)
 	int i = pp->output_owner;
 	if (pp->children[i].state == GIT_CP_WORKING &&
 	    pp->children[i].err.len) {
-		fputs(pp->children[i].err.buf, stderr);
+		strbuf_write(&pp->children[i].err, stderr);
 		strbuf_reset(&pp->children[i].err);
 	}
 }
@@ -1135,11 +1135,11 @@ static int pp_collect_finished(struct parallel_processes *pp)
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 			strbuf_reset(&pp->children[i].err);
 		} else {
-			fputs(pp->children[i].err.buf, stderr);
+			strbuf_write(&pp->children[i].err, stderr);
 			strbuf_reset(&pp->children[i].err);
 
 			/* Output all other finished child processes */
-			fputs(pp->buffered_output.buf, stderr);
+			strbuf_write(&pp->buffered_output, stderr);
 			strbuf_reset(&pp->buffered_output);
 
 			/*
diff --git a/strbuf.c b/strbuf.c
index 38686ff..71345cd 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -395,6 +395,12 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
 	return cnt;
 }
 
+ssize_t strbuf_write(struct strbuf *sb, FILE *f)
+{
+	return fwrite(sb->buf, 1, sb->len, f);
+}
+
+
 #define STRBUF_MAXLINK (2*PATH_MAX)
 
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
diff --git a/strbuf.h b/strbuf.h
index 2bf90e7..d4f2aa1 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -387,6 +387,12 @@ extern ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint
 extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
 
 /**
+ * Write the whole content of the strbuf to the stream not stopping at
+ * NUL bytes.
+ */
+extern ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
+
+/**
  * Read a line from a FILE *, overwriting the existing contents
  * of the strbuf. The second argument specifies the line
  * terminator character, typically `'\n'`.
-- 
2.7.2.373.g1655498.dirty
