From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv20 05/12] run_processes_parallel: treat output of children as byte array
Date: Mon, 29 Feb 2016 11:14:03 -0800
Message-ID: <1456773250-5510-6-git-send-email-sbeller@google.com>
References: <1456773250-5510-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 29 20:14:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTH7-0005dx-NY
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbcB2TO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:14:28 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34492 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbcB2TOY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:14:24 -0500
Received: by mail-pf0-f177.google.com with SMTP id 4so18863900pfd.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YYI8RkGtNYDFW2CDKVbz2pVtkE2AyMKRN2JSeCcrBI8=;
        b=JjlciSH49+N1qbJciXAE4POpTXixXruFfl17tH/WisszorJ3sTCmCk0rqfpiDwdzb4
         qiTZm/dIckWOMuRXh3DDJv5pcnE3DS2DZ2n+pU+HW5hM5PDrmrPkQP9HVqiLu3phYCff
         M/d9SjVia7LpBMrKFbVgR97wtLpIcYY0jGyI/GjPbKRugbKWfwWkmfRw1PIyWVb1bI/+
         2WOnplQVHLhqa6PRCNCQ5HM8XcF0o1A5L3N9l1FZ09FLlcle9nAOznQjyZKlANQcrrCm
         7eE+QoUnEo1B9OFUGbScPaYe3cm2+eYvY3Nwn+ZjFCnbNG/rNMI6qZh2QO2IL54mp3+v
         xHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YYI8RkGtNYDFW2CDKVbz2pVtkE2AyMKRN2JSeCcrBI8=;
        b=RPj4FqPMU0cZiRcBkET5cwuDb7qugFOStW2i1FwU27aCwoF6KKINUP7Yogn6wiJUx1
         1/gMuy+KSntDRVNKpd5FKTgPd4cQrD4ISAR8LzzSF8ZzKXlHEQdr1mu8dBvHDopsIcPO
         ZHrZhDaRbrPxLu4J3efY/psvWXa+hrxzFjuSErdBwK903bDnJ6OS2ieO8FSUYBTcXFCl
         eCSmcVHi6+DSFT6rCU4aAg+s4usCODT+je3nIC/zJqwhmIyxyBzFslp6WHm9BbIGbgAn
         vV9CxySolWEr/7xzSRHm+9KMabo8f8XH/IIhg9nSedWN7urTzDSJ61j/r78jr61jpXfu
         Z5Lw==
X-Gm-Message-State: AD7BkJIK9KY+bO/jKLkyTIn2Xz7VGsSFYQJtUWw0nonKA9dG+a1+avir2LeuCpMdb/Vfj9p5
X-Received: by 10.98.16.86 with SMTP id y83mr24199755pfi.45.1456773263590;
        Mon, 29 Feb 2016 11:14:23 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id x1sm39884036pfi.42.2016.02.29.11.14.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 11:14:22 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.37.gb7b9e8e
In-Reply-To: <1456773250-5510-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287877>

We do not want the output to be interrupted by a NUL byte, so we
cannot use raw fputs. Introduce strbuf_write to avoid having long
arguments in run-command.c.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 38686ff..5f6da82 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -395,6 +395,12 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
 	return cnt;
 }
 
+ssize_t strbuf_write(struct strbuf *sb, FILE *f)
+{
+	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
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
2.7.0.rc0.37.gb7b9e8e
