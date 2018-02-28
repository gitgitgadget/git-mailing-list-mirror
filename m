Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3EF41F404
	for <e@80x24.org>; Wed, 28 Feb 2018 19:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933303AbeB1TIa (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 14:08:30 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43310 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932716AbeB1TI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 14:08:28 -0500
Received: by mail-wr0-f193.google.com with SMTP id u49so3563417wrc.10
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 11:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=prQneit6WTuIEJ2GV5w8PnZJvuBVk5cEoarGz5KQ0as=;
        b=qj1bUW+hUbKUnHJhkJy7C+yckuTCs9A3IRYp+z5gquLBW895pAkHoM96C3NXSpqSqw
         GuMWBBrdNV3jCQCrHC/QuMCHqJEkoX4c6VPmP8ptcfDr/HHDvASkhkTfvKqZUtr4J2A3
         S8G+USVVr9Jn1+CQ+9NJaV3Z2huAB6lkK/8LuOdFrluA8ubXTKf7+kxDmcoIGZkoNQlq
         sPdc2b8SCbN1PYHlsv0HclWqIl3j7HF1hAainwtN/RbrGIbNNyOrX1JKi3lSEAFumHB9
         285fjDhXL+NghUCpZ/giUUg0EyHaD3pV65xsq6CLEpthTH3S1V1MbgKS9rECfFptGW6w
         60Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=prQneit6WTuIEJ2GV5w8PnZJvuBVk5cEoarGz5KQ0as=;
        b=XMVBw9FLIEGFJPn7khBM64vfz8/hKSFi98hfpAEbEyYC3SOg1xajoIVpgOtfEHrzo/
         kf3Od5tPYGVxBZ9FlyoRtA6vSFPu3FaRmVyT9/Gl1Az4u3WaT+QG1utzkglkRqDehAtZ
         N1oQ34HgclYLi3ZTt/J99oNSAaheerUZk2KZiXM1zpASsHG7m7keblMb0YnrLa9M29mj
         o10MWSOIUhjoGNTsUonO2OBd2ylGp01RG+/iB6sg3VvDJaRRZ5of4g0Xew3rlzWvCMFU
         eZ5NWVDBC8pqAiTJtw3xnnmqG/GcXk/a3Ac7nS+Bt6zpBeFCCFGvu9VkWu1pKKHzxSLj
         6/Sg==
X-Gm-Message-State: APf1xPDDN3jBZsht2r05RduEXUNES471AZyuT9PMs+9ZkDv1MM8VxGZB
        EU4WBbQ0cJR5mgYc/bYI00ox1FOf
X-Google-Smtp-Source: AH8x225pyvkjeEA5/0MAjOd3r1y4INjjsU+chHiU0kyRxg9NkMtSC7ZGFfsY5jshRgdwRPOe+WqlwA==
X-Received: by 10.223.168.46 with SMTP id l43mr18206327wrc.118.1519844907066;
        Wed, 28 Feb 2018 11:08:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id p76sm2832609wmb.19.2018.02.28.11.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Feb 2018 11:08:26 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 5/5] sequencer: do not roll back lockfile unnecessarily
Date:   Wed, 28 Feb 2018 20:07:58 +0100
Message-Id: <baaa7016b8812ca99d922c14547e23082bb6acba.1519843916.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1519843916.git.martin.agren@gmail.com>
References: <CAN0heSqmWAN=rCO8busGtb0xNPiB5H_jkL664qH8xasPq1Sy0A@mail.gmail.com> <cover.1519843916.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If `commit_lock_file()` or `hold_lock_file_for_update()` fail, there is
no need to call `rollback_lock_file()` on the lockfile. It doesn't hurt
either, but it does make different callers in this file inconsistent,
which might be confusing.

While at it, remove a trailing '.' from a recurring error message.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 sequencer.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e6bac4692a..0e6d04e4ce 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -303,10 +303,8 @@ static int write_message(const void *buf, size_t len, const char *filename,
 		rollback_lock_file(&msg_file);
 		return error_errno(_("could not write eol to '%s'"), filename);
 	}
-	if (commit_lock_file(&msg_file) < 0) {
-		rollback_lock_file(&msg_file);
-		return error(_("failed to finalize '%s'."), filename);
-	}
+	if (commit_lock_file(&msg_file) < 0)
+		return error(_("failed to finalize '%s'"), filename);
 
 	return 0;
 }
@@ -1585,10 +1583,8 @@ static int save_head(const char *head)
 	ssize_t written;
 
 	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
-	if (fd < 0) {
-		rollback_lock_file(&head_lock);
+	if (fd < 0)
 		return error_errno(_("could not lock HEAD"));
-	}
 	strbuf_addf(&buf, "%s\n", head);
 	written = write_in_full(fd, buf.buf, buf.len);
 	strbuf_release(&buf);
@@ -1597,10 +1593,8 @@ static int save_head(const char *head)
 		return error_errno(_("could not write to '%s'"),
 				   git_path_head_file());
 	}
-	if (commit_lock_file(&head_lock) < 0) {
-		rollback_lock_file(&head_lock);
-		return error(_("failed to finalize '%s'."), git_path_head_file());
-	}
+	if (commit_lock_file(&head_lock) < 0)
+		return error(_("failed to finalize '%s'"), git_path_head_file());
 	return 0;
 }
 
@@ -1724,7 +1718,7 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 			todo_list->buf.len - offset) < 0)
 		return error_errno(_("could not write to '%s'"), todo_path);
 	if (commit_lock_file(&todo_lock) < 0)
-		return error(_("failed to finalize '%s'."), todo_path);
+		return error(_("failed to finalize '%s'"), todo_path);
 
 	if (is_rebase_i(opts)) {
 		const char *done_path = rebase_path_done();
-- 
2.16.2.246.ga4ee44448f

