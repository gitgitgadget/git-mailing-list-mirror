From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv21 05/10] run_processes_parallel: treat output of children as byte array
Date: Mon, 29 Feb 2016 18:07:15 -0800
Message-ID: <1456798040-30129-6-git-send-email-sbeller@google.com>
References: <1456798040-30129-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 03:07:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZj7-00034x-Ud
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 03:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbcCACHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 21:07:50 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36380 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbcCACHd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 21:07:33 -0500
Received: by mail-pa0-f44.google.com with SMTP id yy13so102245966pab.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 18:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2uce6de41vBGePgRT3s0YuTWZ/bH6m4xwylnebL22ew=;
        b=Mbu824qYwdlgFJbhlKrIHPZv2dmzW/yg09L7/E2bCFF8iV9cnZl/iFvVA2A65dGWwL
         ucicO6m/blAqv3Pg380CN6WWlZjApsLuF2BMu0u0hxDlth484siRkG710IBRiZDESaMT
         nWUH9rOTYNIeVaf+WQ89a6Ur+a9yF9Yj9uLL/tZ7X2NOr7gxE7Ow2P2aXxmwBIbTUhkL
         nn5GRpK5o33IW9lTI29CBrZjEZot3vi5AREUqBzYN271Lx+1s6FoZnBS+2S0uDidx7oN
         O64/p3ZLjP2/ZtFs4xYd+I+K+aXC7FYktJcNY7Flj7LPIT/U1GnmXa06yqoJKFzOfbqf
         Ffbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2uce6de41vBGePgRT3s0YuTWZ/bH6m4xwylnebL22ew=;
        b=MrxIkdzYrfZHMijICMIZ+MxHp8saAnSo2gzZG0jFz6O6npKZttjFFis3frVH1HqKlz
         q9l/zn2iyVP1LDhav+zQiIAkTfNWIm2ZPsnhQbEVHDtoIG5pUhwoStRaWaow0ZMhgUV5
         EWubngJCP4iyKVwGSFQla9ojxhY8UDRAktMp6QjhWm7Dh6CzDprXkEaqQC5a8hrJHQnx
         35CAh2QOkF2UoWlkthgOBB4+8kKzBfyekXM5hrKY7pAP3tOx7J+vCdA4hbx8tNHL4HP9
         ADxKxwmjH6urzjg2TpkKg/P2GmnxCiVMu6whaxvmOe4pC1YuMTY6ij3mAPPhkzhzImfG
         j06Q==
X-Gm-Message-State: AD7BkJLvoXiLoHeECt09+2zxQDhMKTV25v65UXS8GJ+QdP5WFYFnqdEQsj+U1jiei863JrtN
X-Received: by 10.66.63.41 with SMTP id d9mr12257025pas.1.1456798052383;
        Mon, 29 Feb 2016 18:07:32 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id 3sm40869874pfn.59.2016.02.29.18.07.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 18:07:31 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.1.g68b4e3f
In-Reply-To: <1456798040-30129-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287989>

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
index 8e3ad07..bdda940 100644
--- a/run-command.c
+++ b/run-command.c
@@ -994,7 +994,7 @@ static void pp_cleanup(struct parallel_processes *pp)
 	 * When get_next_task added messages to the buffer in its last
 	 * iteration, the buffered output is non empty.
 	 */
-	fputs(pp->buffered_output.buf, stderr);
+	strbuf_write(&pp->buffered_output, stderr);
 	strbuf_release(&pp->buffered_output);
 
 	sigchain_pop_common();
@@ -1079,7 +1079,7 @@ static void pp_output(struct parallel_processes *pp)
 	int i = pp->output_owner;
 	if (pp->children[i].state == GIT_CP_WORKING &&
 	    pp->children[i].err.len) {
-		fputs(pp->children[i].err.buf, stderr);
+		strbuf_write(&pp->children[i].err, stderr);
 		strbuf_reset(&pp->children[i].err);
 	}
 }
@@ -1117,11 +1117,11 @@ static int pp_collect_finished(struct parallel_processes *pp)
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
2.8.0.rc0.1.g68b4e3f
