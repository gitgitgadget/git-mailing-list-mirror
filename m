Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F74D1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfI3BvP (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:51:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40160 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3BvP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:51:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id f7so14987019qtq.7
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 18:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GuBB+1Z30y1D2AQnWS40HJipgE2bRJGCPbGP610hHKQ=;
        b=nU+vo6Ex7J4/qVhkBrA2Lt3GjKGvhncKjgorzYTUW4sICCkwDPyNK0rStYah61k93Y
         kIYQW5OmZbahZiLmNqfIh9SFChqDVygWeoYMFgIv4NxIEHWFplD79YGWKNS0ucOLIrYc
         dIoAVLFnbsQggVUttfBQlVDJrbZR4MrTbtSkxh63Gzc8LF2Zxi77r3BU74YQvajnc6U9
         9n7/SPgohAO2MUySiiJri8B3+eq5snKR8S7BEi0DrhanAOd9QsukJ/E+XUzYYyTosQ2l
         EHUWVJgmjgwUgrpKYFyLOIdolujiwfgWlw5BRd61fIDKMOOskZP6Bu/bSop7RH4RqJKk
         Ss2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GuBB+1Z30y1D2AQnWS40HJipgE2bRJGCPbGP610hHKQ=;
        b=WGUSw4a4pBQ6xJGcp5f9VDn8AngfM5al+Di05LNwYVpLWXmkrwQWKN8FJN2csc7r0p
         L8eVBxNP2jhnqltT9A334ZpwyJA/6HpnQQMyh+Fp5QiSNFJftZGFy0waP/WClRENbBkG
         /sZmyFms5pwwHV1N5R6yvHbavOsi+O6OznCnfF8ij+ntteOXfM+82lQdgpHqLFRNWEmw
         tq9cPefQPxPG8LQCyWT4XsQFP1k6tkadmYpbsstfd9mHlZe2hOSBNhMIgHYmHfa+KPjV
         IYuNfK7neM/Zttz5lpqK5JCyG3CDKLGINIWs040UM9urzQM4wne+kFTOwEmdHRosfutf
         EZ/Q==
X-Gm-Message-State: APjAAAXs3iHlqu+7tC7qlpsSwRkOGkynNOofKD09zTFnRBBM5ex6q9+I
        XxHkaWPPAk+PfLa170QwehZYngzviXY=
X-Google-Smtp-Source: APXvYqxZpbu3COuOBfQ5BNPqrhWtQb7FjzttUdQ0Tgoa815boj0T6DnfECDfblF6hLZGoBzyq8GqZw==
X-Received: by 2002:aed:3be3:: with SMTP id s32mr22422387qte.156.1569808274294;
        Sun, 29 Sep 2019 18:51:14 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id f11sm4706954qkk.76.2019.09.29.18.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 18:51:13 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, jrnieder@gmail.com
Subject: [PATCH v2 01/11] grep: fix race conditions on userdiff calls
Date:   Sun, 29 Sep 2019 22:50:47 -0300
Message-Id: <0f31cb0c126e824008d35d5cba52dd1c3c115c00.1569808052.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569808052.git.matheus.bernardino@usp.br>
References: <cover.1569808052.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-grep uses an internal grep_read_mutex to protect object reading
operations. Similarly, there's a grep_attr_mutex to protect calls to the
gitattributes machinery. However, two of the three functions protected
by the last mutex may also perform object reading, as seen bellow:

- userdiff_get_textconv() > notes_cache_init() >
  notes_cache_match_validity() > lookup_commit_reference_gently() >
  parse_object() > repo_has_object_file() >
  repo_has_object_file_with_flags() > oid_object_info_extended()

- userdiff_find_by_path() > git_check_attr() > collect_some_attrs() >
  prepare_attr_stack() > read_attr() > read_attr_from_index() >
  read_blob_data_from_index() > read_object_file()

As these calls are not protected by grep_read_mutex, there might be race
conditions with other threads performing object reading (e.g. threads
calling fill_textconv() at grep.c:fill_textconv_grep()). To prevent
that, let's make sure to acquire the lock before both of these calls.

Note: this patch might slow down the threaded grep in worktree, for the
sake of thread-safeness. However, in the following patches we should
regain performance by replacing grep_read_mutex for an internal object
reading lock and allowing parallel inflation during object reading.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 grep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index cd952ef5d3..b29946def2 100644
--- a/grep.c
+++ b/grep.c
@@ -1809,7 +1809,9 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		 * is not thread-safe.
 		 */
 		grep_attr_lock();
+		grep_read_lock();
 		textconv = userdiff_get_textconv(opt->repo, gs->driver);
+		grep_read_unlock();
 		grep_attr_unlock();
 	}
 
@@ -2177,8 +2179,11 @@ void grep_source_load_driver(struct grep_source *gs,
 		return;
 
 	grep_attr_lock();
-	if (gs->path)
+	if (gs->path) {
+		grep_read_lock();
 		gs->driver = userdiff_find_by_path(istate, gs->path);
+		grep_read_unlock();
+	}
 	if (!gs->driver)
 		gs->driver = userdiff_find_by_name("default");
 	grep_attr_unlock();
-- 
2.23.0

