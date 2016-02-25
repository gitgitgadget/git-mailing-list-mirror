From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/7] run_processes_parallel: treat output of children as byte array
Date: Wed, 24 Feb 2016 17:41:59 -0800
Message-ID: <1456364525-21190-2-git-send-email-sbeller@google.com>
References: <1456364525-21190-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 02:42:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYkwb-0000DG-5P
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 02:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757042AbcBYBmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 20:42:13 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34144 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbcBYBmK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 20:42:10 -0500
Received: by mail-pa0-f48.google.com with SMTP id fy10so22613003pac.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 17:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dir7MtpBkfZtUMwZBw+6BsXpx6W710Mu6A7JAUZYSIY=;
        b=o4OXRPDz8PEpo47Amf4QuBIazCYrD4zgjM4uXE2IqaTwEvSavdPPS3G5/7DKXXPJD8
         2EDMa7fQP5XqTkKVvrAX6dH1Yr+lOUVloyz8h/vkhJqLvDG5V+R/8uf+J9iTIzjKFCGR
         B7mrDGOztAw811szctdpuCf2SgzTNHLyjbojKN9YY77fXIeAoveeIDJ6vKI8ka049RUZ
         PAZPDqJYiQ33/5BycNVJUwhCLs77OeFkpG7L+JCjsuMXfh7nEzBWiag4FHxeFeaEGduB
         MbcUZR8MXkLDJ+6pEe27x+dl/4pcKDmgfdiH/iWSVUueFiL8kuOqPqnDDbw9kXuxRgis
         q66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dir7MtpBkfZtUMwZBw+6BsXpx6W710Mu6A7JAUZYSIY=;
        b=MWbXNxdK7ssKQcd7z+MEagkA8zoxCad33IGR8H3tAkfqiaMTwRkHFpWRpDpJ9ICs/P
         nbtnGcAYc4U9XnUUjyIc3LIwU/tYDQtWCbK7jGo36x4KfQSaBd3ykGSJcbQL4X6DLvR6
         XUuthHiY6FDiNX3rZNYXf06RmMafxLvhtDWdgT8q0z6CHQLjYWcyWwXbDdzOqJIeERk3
         6z1z0ybaieZstUkqqc3zoRoTsRJnh1nmNtcW1KjpLeBxN6b2n5a0+K46dCDyMreztUOR
         5i1PM/a8GLzu2hr9qas4A4kDumx1Xl4kh17FP+c3fHvQkmW1y0iTrnfTdcU7B5OA9AwU
         irZA==
X-Gm-Message-State: AG10YOT05y1FPN/W4oqJ7t+mn+mkfEpeVD/Gb8BtJ4sx6i1Rga9PhX7qLmz0nrNbvfBqMVLp
X-Received: by 10.66.222.101 with SMTP id ql5mr59582648pac.144.1456364529654;
        Wed, 24 Feb 2016 17:42:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id 3sm7704124pfn.59.2016.02.24.17.42.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 17:42:08 -0800 (PST)
X-Mailer: git-send-email 2.7.2.335.g3f96d05
In-Reply-To: <1456364525-21190-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287301>

We do not want the output to be interrupted by a NUL byte, so we
cannot use raw fputs. Introduce strbuf_write to avoid having long
arguments in run-command.c.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 8 ++++----
 strbuf.c      | 6 ++++++
 strbuf.h      | 6 ++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 51fd72c..1f86728 100644
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
2.7.2.335.g3f96d05
