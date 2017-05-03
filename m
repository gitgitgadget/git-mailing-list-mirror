Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20689207B3
	for <e@80x24.org>; Wed,  3 May 2017 03:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbdECD3y (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 23:29:54 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36678 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbdECD3t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 23:29:49 -0400
Received: by mail-yw0-f182.google.com with SMTP id l18so79311781ywh.3
        for <git@vger.kernel.org>; Tue, 02 May 2017 20:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b6VSt23Zs9fGQu11tfTdjkSU2tgFl9NyTXozELlrcyg=;
        b=E7yLx/CXJxikht+c9bv7rbH3MDeLqUMlJ+c6dRqsZ0USUj3NvZfNzwevrtI49xKXAX
         zHK6oga4oHYiWDx2GUcOOrAqOI/0lZGMBovtZ6VC5KsT9yUPV9Ygr/7PbWCP/EnOXWEw
         u9SQ5AncorOChfePcbnRwddG5ZxOE1+wu3dOBooWG3Zs1VFpK3ieLGumZzc1dGwrJgEE
         wRxHyUSbS2lv9f5NjUPcSW075/09/7TUWVy11uRA22dcTU1uvokTxowFzv/MVsOTRFgE
         CYIWrjYun44o2zf+Dzs/Wv8Kkr2DiMSN9cB74+VJSu8jtTUSEoP7wtfrQdxmPJogrlzz
         DHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b6VSt23Zs9fGQu11tfTdjkSU2tgFl9NyTXozELlrcyg=;
        b=M7YG2S0uG/108PwvMO8ac5WTpItBG0wiQnrfaPIJT5trBP/u5JNGzHVFtu8KTIKL64
         LoaA+siGjUvR5A9ylJ/sCfv63coGyJ/3ml9cQN2C+7+oReuwokKIE6UGp05iebj9yiyQ
         YJy67BC0Iran+eEQEIRb6aa/g8xcqWU+BMpyO2mlkpkAjo7REYWoRMVUoxFQrDNedhaw
         AnsvAvdVzVYYPDtU6QRRCJMCU3QClNdDPuOLzv+K+zBEmJBWDRl3jAkYFR4cWk1PTIhV
         XyqmZ8+ndE2FOt9fbxAE3UGYRDurVHSlTX6VhL35M6rlfKyuc2nY1T/fZRo3buAzreKF
         oAmA==
X-Gm-Message-State: AN3rC/6E1+3EMJ5kFjHd/AX+DVaAwyC7pLjUtozz2WeI1jhgGfyJQK6n
        mdqUx0ZNFhjlVQ==
X-Received: by 10.129.196.71 with SMTP id s7mr30272967ywj.256.1493782188296;
        Tue, 02 May 2017 20:29:48 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.23])
        by smtp.gmail.com with ESMTPSA id v3sm11329586ywi.79.2017.05.02.20.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 May 2017 20:29:47 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH 6/7] builtin/clean: teach clean -d to skip dirs containing ignored files
Date:   Tue,  2 May 2017 22:29:31 -0500
Message-Id: <20170503032932.16043-7-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <xmqqshkof6jd.fsf@gitster.mtv.corp.google.com>
 <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is an implicit assumption that a directory containing only
untracked and ignored files should itself be considered untracked. This
makes sense in use cases where we're asking if a directory should be
added to the git database, but not when we're asking if a directory can
be safely removed from the working tree; as a result, clean -d would
assume that an "untracked" directory containing ignored files could be
deleted.

To get around this, we teach clean -d to collect ignored files and skip
over so-called "untracked" directories if they contain any ignored
files.
---
 builtin/clean.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index d861f836a..368e19427 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -859,7 +859,7 @@ static void interactive_main_loop(void)
 
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
-	int i, res;
+	int i, j, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
@@ -911,6 +911,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				  " refusing to clean"));
 	}
 
+	if (remove_directories)
+		dir.flags |= DIR_SHOW_IGNORED_TOO;
+
 	if (force > 1)
 		rm_flags = 0;
 
@@ -932,7 +935,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	fill_directory(&dir, &pathspec);
 
-	for (i = 0; i < dir.nr; i++) {
+	for (j = i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		int matches = 0;
 		struct stat st;
@@ -954,10 +957,27 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		    matches != MATCHED_EXACTLY)
 			continue;
 
+		// skip any dir.entries which contains a dir.ignored
+		for (; j < dir.ignored_nr; j++) {
+			if (cmp_name(&dir.entries[i],
+						&dir.ignored[j]) < 0)
+				break;
+		}
+		if ((j < dir.ignored_nr) &&
+				check_contains(dir.entries[i], dir.ignored[j])) {
+			continue;
+		}
+
 		rel = relative_path(ent->name, prefix, &buf);
 		string_list_append(&del_list, rel);
 	}
 
+	for (i = 0; i < dir.nr; i++)
+		free(dir.entries[i]);
+
+	for (i = 0; i < dir.ignored_nr; i++)
+		free(dir.ignored[i]);
+
 	if (interactive && del_list.nr > 0)
 		interactive_main_loop();
 
-- 
2.12.2

