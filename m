Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF4EA1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 18:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeJQCFb (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 22:05:31 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:43871 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCFb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 22:05:31 -0400
Received: by mail-ua1-f73.google.com with SMTP id f10so1652046uan.10
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZK0RzDWS+tk5X176hsxHIhH9aiBzhWKC4hPlHVauUH0=;
        b=AbYB1+D0Tf9HbeJhKFciQ6aBGuXhdESY/SxveHcqq08MLcBD0/rVgpCibs5FwhrdsZ
         FKg/nRDbabro3tjSzw183feC220BKokLDIQdIvyn8Ngw9gwOsHGXDWQmHa+h1WwnDHHB
         AA82tGj3Q7Je99TMmG7FInByTPTzk1gQH0pC+KZDkPvrt6mwyY9ifuSNMsHW0b7inOBx
         LL/x7oRe1eHD8IxV0taOhstbfb1whRwxeAGlKHghOIPPRot2y/VJ+mTNODR/sX5NbEG1
         kHYPOpN4G9LVVe3rqHQfqvDIyBECsT7Av5uks+tbCzntv5Yibxxm2M8acXfXRnL1pRNS
         Gm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZK0RzDWS+tk5X176hsxHIhH9aiBzhWKC4hPlHVauUH0=;
        b=SFqik8FP3LkvSZjxoWIoPN+sFgFoupJQcAH8YbrASyUqMPEEuHCulKJK7F9bx948VW
         wqJ5eGKjVZVz46yBk+oahUh5FTog9bF4NUpM+PC4cp40eBt/bCxGg9rb4tyW6+VObvkM
         zfezQ8IZ6wpI/hBt0FzUlRF0V7NBcPhOR6L7w1SOzL17JkYzNzSp6zlRlfK7OR+nWLi8
         iqDITJERCY1dRrFLnsYjVnX6FKNTMCui2SQW8OR8z5Sync6KYupD0Z0CQrGNjlVtPDa8
         NeF6AHQYKimdgX+s5gVA6/GgB0mNCwQbte9yrl+VUJtXSKcnlKRRGEDkSWJociZ9GBlb
         ZvLg==
X-Gm-Message-State: ABuFfogonXB2QBg0ELtsm4Pp+pss/OxR/VwLIhMhnYpF67gUxzNsLjL8
        4g+5nACZAvRrOrIQy0llfK4ASk5O1xwp
X-Google-Smtp-Source: ACcGV61PdcDhNobaY0Ky9xm9gmzxl2oglmbAxgQfLW+Qpvs0Au7bhEUrx4ihV2KIsDd3emhV8i2AgU27RW/1
X-Received: by 2002:a1f:2c49:: with SMTP id s70-v6mr20690353vks.7.1539713631285;
 Tue, 16 Oct 2018 11:13:51 -0700 (PDT)
Date:   Tue, 16 Oct 2018 11:13:23 -0700
In-Reply-To: <20181016181327.107186-1-sbeller@google.com>
Message-Id: <20181016181327.107186-6-sbeller@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 5/9] submodule.c: do not copy around submodule list
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'calculate_changed_submodule_paths' uses a local list to compute the
changed submodules, and then produces the result by copying appropriate
items into the result list.

Instead use the result list directly and prune items afterwards
using string_list_remove_empty_items.

By doing so we'll have access to the util pointer for longer that
contains the commits that we need to fetch, which will be
useful in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6b4cee82bf..cbefe5f54d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1142,8 +1142,7 @@ static void calculate_changed_submodule_paths(
 	struct submodule_parallel_fetch *spf)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
-	const struct string_list_item *name;
+	struct string_list_item *name;
 
 	/* No need to check if there are no submodules configured */
 	if (!submodule_from_path(the_repository, NULL, NULL))
@@ -1160,9 +1159,9 @@ static void calculate_changed_submodule_paths(
 	 * Collect all submodules (whether checked out or not) for which new
 	 * commits have been recorded upstream in "changed_submodule_names".
 	 */
-	collect_changed_submodules(&changed_submodules, &argv);
+	collect_changed_submodules(&spf->changed_submodule_names, &argv);
 
-	for_each_string_list_item(name, &changed_submodules) {
+	for_each_string_list_item(name, &spf->changed_submodule_names) {
 		struct oid_array *commits = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
@@ -1176,12 +1175,14 @@ static void calculate_changed_submodule_paths(
 		if (!path)
 			continue;
 
-		if (!submodule_has_commits(path, commits))
-			string_list_append(&spf->changed_submodule_names,
-					   name->string);
+		if (submodule_has_commits(path, commits)) {
+			oid_array_clear(commits);
+			*name->string = '\0';
+		}
 	}
 
-	free_submodules_oids(&changed_submodules);
+	string_list_remove_empty_items(&spf->changed_submodule_names, 1);
+
 	argv_array_clear(&argv);
 	oid_array_clear(&ref_tips_before_fetch);
 	oid_array_clear(&ref_tips_after_fetch);
@@ -1377,7 +1378,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&spf.changed_submodule_names, 1);
+	free_submodules_oids(&spf.changed_submodule_names);
 	return spf.result;
 }
 
-- 
2.19.0

