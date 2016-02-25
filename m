From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv18 05/11] run_processes_parallel: treat output of children as byte array
Date: Thu, 25 Feb 2016 15:08:22 -0800
Message-ID: <1456441708-13512-6-git-send-email-sbeller@google.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
 <1456441708-13512-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:09:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ52A-0008Fv-M0
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbcBYXJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:09:14 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33110 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbcBYXJG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:09:06 -0500
Received: by mail-pa0-f50.google.com with SMTP id fl4so39756663pad.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mG41uMyzWyfhxVbT6oLmnD6SU9wfr8uOBtckHiLXXZw=;
        b=ameAjbNEtasHMduB5wpbhX2AtmGawhgKomfq2/HFNFA2xO2ZQx3i/RthCfJSuarvff
         ZfPBy/gVQHTTvtAu9InR6A/fhVOKWzxmu36+zalW5Ie/yzLknsPJY+NNAaLJ3yxIDfpk
         oCW9/YmUXqDFiSTBSVLvqCdIgBtL8OKZ2Jw77CgGeDExFLim1QDkAa0VITWZFTewIcaU
         sbz402Dqxq+52CUoUMT3eNugee3AQK9asrUPo4zJu8qRhJmcwcrpomKZlcJS9Gu+8s01
         xXxDHqv6t6mbsIKhCa821z8NupcTxMgcF7JC+6RsSYgggJvhF32QZtoPbYJU8SHhpPKh
         XgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mG41uMyzWyfhxVbT6oLmnD6SU9wfr8uOBtckHiLXXZw=;
        b=YSAvYrDSn3s8Q5mIJahwZKrLk1ZbB1o0xHFx4knXlzx+fNzVkBH4p4Uj+U5LADj/wO
         4t168DFnO67IyD3KLSxKeei9yE5VzdbeDiyIumThvWWDSA2m1GfxsxK6AqEdI+Vt1LPV
         CYF6j9r0MkEpRaYOZSNq3WCEsmTM8Q6XUbLK3dn1SNwkeEa3kcoGIto0uhRv1eadFhuN
         YqCJYWErdbKoaNTc1KOiqSmtxtI8bWTIPx/HCc7RtBJtVic3MIoe482DQCV5p3E3vvnx
         +z0ZD5kOHAMnddRPyluEc7lVO79ssUamxOo6hOQBsyDEy0cg9USxf+aAncSilKiHUhZX
         0n+A==
X-Gm-Message-State: AG10YORX4RYLizpdwRpXxxcq+uMVCqTQ3yOq+ldPwuovypCW4EK8jZ5YjT0Ae3sIuIto1+wX
X-Received: by 10.66.102.104 with SMTP id fn8mr67027919pab.129.1456441744644;
        Thu, 25 Feb 2016 15:09:04 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id w12sm14487022pfa.79.2016.02.25.15.09.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:09:04 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456441708-13512-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287476>

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
