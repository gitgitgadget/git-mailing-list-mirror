Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A093920966
	for <e@80x24.org>; Wed, 29 Mar 2017 08:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754471AbdC2IJU (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 04:09:20 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32831 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754231AbdC2IIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 04:08:44 -0400
Received: by mail-wr0-f193.google.com with SMTP id u18so1001554wrc.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J6SlefUMgBvEJqhJ7yg4CEZtCG7xIS5eHswl0q8Erdc=;
        b=oJDri0HZ75eNvd9njv+zS7MEfnWITPwgJfl+giyxmNcpmnManNKseSl91kkhf8RZZw
         vdQKLafmyVt8o7PvdBQJtP1cHH7ZXJrrEXYGjqhhG6Bd0PnEgALnLd6Oo3pCSvdFRPvy
         S4dMaM9bbVweUwRH72HWTKbRbvVyB2UtdBoKt4em6UcoNOBhCh7UVi8/9gNkT0vvrOuI
         VYWfsyF5luHYiRzmpHP8k1qKN6mhG4Ia4SF+cmUKMBGW3gpQno3Bxx7a/85bDoIP7STs
         oze5aj/TeP1P/8FQhF2z22OYFyUxq51+W5O3ZotWL2beiQNLOBkhay7JNfzAL9J2K6y0
         vQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J6SlefUMgBvEJqhJ7yg4CEZtCG7xIS5eHswl0q8Erdc=;
        b=dS5GTlniXraR0htAJJyax4bZD9hoR1gxIAEVp4rSYuX5hzfXkhX6AY+DCWtaPcWfv5
         ipVaR2vhPGv4NqV56eDPfHfO+mETEYbsYldIT+hHMc3icfu+26CVd5ZZ1hA3tATgttyR
         efVHWXhqvpq7KeACynD6jcbY1LFri7uN5qX5DvFNJz+ZPr1q4IoiagR1BbTsGgLevuNr
         o3YVK8iExCq/9eWQYo9zINZSQL/7U1XErDnEi5S9VtIF5RGJL+XFgP9v9Q4d27cZNTIt
         imS8hCLtlWmA2ftCRNaw0To6E4QoFW1dS09BVR4FIc18VcQxJsixm9wVGd6TvshyEB7u
         fJcg==
X-Gm-Message-State: AFeK/H1Y69b/6AcebeauJt8BgoLrqzQ2ytZFRDPXdTso6FbVdLq8yl+H00thKOQaW8uoAg==
X-Received: by 10.223.150.81 with SMTP id c17mr12992071wra.85.1490774922319;
        Wed, 29 Mar 2017 01:08:42 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id c17sm8150629wre.30.2017.03.29.01.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 01:08:41 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] read-cache: avoid git_path() race in freshen_shared_index()
Date:   Wed, 29 Mar 2017 10:08:20 +0200
Message-Id: <20170329080820.8084-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.339.g3df8399f7e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When performing an interactive rebase in split-index mode,
the commit message that one should rework when squashing commits
can contain some garbage instead of the usual concatenation of
both of the commit messages.

When bisecting it appears that 94c9b5af70 (Merge branch
'cc/split-index-config', 2017-03-17) is the first bad commit.

But when rebasing cc/split-index-config on top of the commit it
was merged with, the first bad commit is then c3a0082502
(read-cache: use freshen_shared_index() in read_index_from(),
2017-03-06).

This shows that we should be careful not to use git_path() in
freshen_shared_index(). It is using a shared buffer that can
too easily lead to races.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index e447751823..2f10242c24 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1682,9 +1682,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
  */
 static void freshen_shared_index(char *base_sha1_hex, int warn)
 {
-	const char *shared_index = git_path("sharedindex.%s", base_sha1_hex);
+	char *shared_index = git_pathdup("sharedindex.%s", base_sha1_hex);
 	if (!check_and_freshen_file(shared_index, 1) && warn)
 		warning("could not freshen shared index '%s'", shared_index);
+	free(shared_index);
 }
 
 int read_index_from(struct index_state *istate, const char *path)
-- 
2.12.0.339.g3df8399f7e.dirty

