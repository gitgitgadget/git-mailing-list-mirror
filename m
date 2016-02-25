From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv19 05/11] run_processes_parallel: treat output of children as byte array
Date: Thu, 25 Feb 2016 15:48:33 -0800
Message-ID: <1456444119-6934-6-git-send-email-sbeller@google.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
 <1456444119-6934-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:49:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5eh-0008JG-Oq
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbcBYXtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:49:04 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36146 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbcBYXs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:48:59 -0500
Received: by mail-pf0-f178.google.com with SMTP id e127so41126577pfe.3
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mG41uMyzWyfhxVbT6oLmnD6SU9wfr8uOBtckHiLXXZw=;
        b=QhKoXdFP4CxSLqJlHx+WXDgNNkTN10JrQQFOk6k67PeOefjSFEh1LhBlvWz5QXvqUb
         cxkYRetChF/7yy1NwYDM1IEJtq7aj+4rGm+gAayTYkXBgKMFx+sSrrRoUGRByb8mevEc
         ScIivvVaLD/ACiwd9/M+vXYJZAhQtTwcMdoRUo+eYN5abhV4Q95k/tU5Y81Evx7yp6aC
         9cFzFmGU6z1pkn0gvzJyk9kKK1tZYdaHFR9cyRv5ghfh3BBdGpLTQadCMsiMeJw8XtHv
         sYfSd6AuRy+abnIruMVzhM+ken+B7WcxBSjkqXwbcI41ONhUlsyQkQgLtCl/6s+twOFN
         wzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mG41uMyzWyfhxVbT6oLmnD6SU9wfr8uOBtckHiLXXZw=;
        b=VkKV6Dssl4ncriTeFNuzNGcVTxGubJW0WmoFVAnkn0sOCpdFaCHSizlNQcX8WyWY0v
         KA4iZA709fEK38XOorbHo/hjhdCsNWF1S9dx09ufddgZTcIFSnt9nVO3v3LcAsFaNSCw
         6qwkcEWLnsfgbNZ9saqQ0yTppyMY0YmKRN8CSNxl6B0QS6zHR3UeNT5+709uJrlGQ8YT
         BSKiw3SEblkl6E/svs8xqh7/qXlEnWYB0u0buAW3JXE5wFhTT5SEEZTPzzqbMKyQp1cN
         HmdR3lis8ANkXnPfEcbDIuRj55yg9BrxXigwmbDVb2BJv4KGeKJ/80Yq8td4z/je9zkv
         ubOg==
X-Gm-Message-State: AG10YOST05h6Kb1XLTwHdBo8NP+ZFBWNBE13o9DDbodoUiJHD3vRClO6T4qeMeaxN56Xfap8
X-Received: by 10.98.17.92 with SMTP id z89mr67453708pfi.16.1456444133777;
        Thu, 25 Feb 2016 15:48:53 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id y68sm14622484pfi.6.2016.02.25.15.48.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:48:53 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456444119-6934-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287503>

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
2.7.0.rc0.36.g75877e4.dirty
