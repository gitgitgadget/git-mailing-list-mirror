Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28F320958
	for <e@80x24.org>; Thu, 30 Mar 2017 03:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932476AbdC3Dce (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 23:32:34 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32953 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932113AbdC3Dcd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 23:32:33 -0400
Received: by mail-qk0-f194.google.com with SMTP id p22so4755168qka.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 20:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lXfL0Yh70Ebz8OsOEiu1KzM3PfOicSjzk1fZjtgzASM=;
        b=HenfVGi0bTjaBhU9QOMKB1jmPJfXIJGlerRaEox/Gvd6v9Zro4EcZNavSC0mBTYnMT
         85ehbr1IJQIfCM9OAzYEPmocAnrR7YZAXxSilT4HNlS/cJYx8JlFpV82nOSDIpkvz6n3
         C1gdndd4L1eMAghX7GlKhUa0vcK7VOCtr9VVow7jzhJYm3RsP0OF+h3XJ8cPBdNxFm9Y
         yf30pzdFccNNQtv3Ajh8vTKCmDvmgPZbarWfS3rg2Ml39dNJDIpNa3NDiqBE41ysWz0a
         7h1pO4uvAwx+LDykLl2T7qadV7h505voUlI/ceeZ4uev6069HWhEprnP0PzObBDCY1kU
         Ll+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lXfL0Yh70Ebz8OsOEiu1KzM3PfOicSjzk1fZjtgzASM=;
        b=TlWIBKySytn+EnvwcIREKJSJsvlw075e/n964U1TFjNJ3CFLShPKiBWePb2Dz++leG
         4Qwt0qPMClgLHA3TRLRJWg3T+hLAF5cR1nPVdzqonNFwOb8/xbN3uCep3dCmUjebIPVu
         sjXvSc1oWAPjiw1iDnOxgNzP3p7un2+vZEv1ifAJl+yZ/T6FQooW5haW67SlaWSFSR4J
         ckcgDU0OAy+phJxPd/AoYDCYJfkuljuvAOr4LQ3ywJc/0/ZVetMdXN8r4Mn0UjrICVF7
         JjnRH913XEQfnoyodsiwRVht4vo5G/jgyej2FMun3eMsn5OFpHDCT/iSlNqkwdULftRU
         4nNA==
X-Gm-Message-State: AFeK/H30SShRbu6APTvx2DI22SQ9cqXAACjSfitR3DTo4qjEWjSr9c1LSV/PUP9kQLkAgA==
X-Received: by 10.55.21.5 with SMTP id f5mr4214673qkh.9.1490844752134;
        Wed, 29 Mar 2017 20:32:32 -0700 (PDT)
Received: from localhost.localdomain ([201.52.189.180])
        by smtp.gmail.com with ESMTPSA id d136sm624095qke.32.2017.03.29.20.32.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 20:32:31 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v5 2/6] dir_iterator: refactor state machine model
Date:   Thu, 30 Mar 2017 00:32:06 -0300
Message-Id: <1490844730-47634-3-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "initialized" member of dir_iterator_level. Replace its
functionality with a DIR_STATE_PUSH state in the
dir_iterator_level.dir_state enum.

This serves to remove a redundant property in the dir_iterator_level
struct and ease comprehension of the state machine's behavior.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 dir-iterator.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index ce8bf81..3ac984b 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -4,8 +4,6 @@
 #include "dir-iterator.h"

 struct dir_iterator_level {
-	int initialized;
-
 	DIR *dir;

 	/*
@@ -20,6 +18,7 @@ struct dir_iterator_level {
 	 * iteration and also iterated into):
 	 */
 	enum {
+		DIR_STATE_PUSH,
 		DIR_STATE_ITER,
 		DIR_STATE_RECURSE
 	} dir_state;
@@ -55,8 +54,10 @@ static inline void push_dir_level(struct dir_iterator_int *iter, struct dir_iter
 	level->dir_state = DIR_STATE_RECURSE;
 	ALLOC_GROW(iter->levels, iter->levels_nr + 1,
 		   iter->levels_alloc);
+
+	/* Push a new level */
 	level = &iter->levels[iter->levels_nr++];
-	level->initialized = 0;
+	level->dir_state = DIR_STATE_PUSH;
 }

 static inline int pop_dir_level(struct dir_iterator_int *iter)
@@ -97,7 +98,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			&iter->levels[iter->levels_nr - 1];
 		struct dirent *de;

-		if (!level->initialized) {
+		if (level->dir_state == DIR_STATE_PUSH) {
 			/*
 			 * Note: dir_iterator_begin() ensures that
 			 * path is not the empty string.
@@ -112,8 +113,6 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 					iter->base.path.buf, strerror(errno));
 				/* Popping the level is handled below */
 			}
-
-			level->initialized = 1;
 		} else if (S_ISDIR(iter->base.st.st_mode)) {
 			if (level->dir_state == DIR_STATE_ITER) {
 				/*
@@ -215,7 +214,7 @@ struct dir_iterator *dir_iterator_begin(const char *path)
 	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);

 	iter->levels_nr = 1;
-	iter->levels[0].initialized = 0;
+	iter->levels[0].dir_state = DIR_STATE_PUSH;

 	return dir_iterator;
 }
--
2.7.4 (Apple Git-66)

