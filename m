Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20411F453
	for <e@80x24.org>; Thu, 25 Oct 2018 23:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJZIH2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 04:07:28 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:42128 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeJZIH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 04:07:27 -0400
Received: by mail-io1-f74.google.com with SMTP id d4-v6so5334785ioh.9
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 16:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b8vO50YBsmLkL0nMY7OxbmpOtYnJRHSmdT3806trdv8=;
        b=RWIfHZ7/Z097fqCmpKKs8ujSyctNKcZSSCAMph7KX6RlUi8fnXoU+KlAXSsV0XjNn0
         k6VZjEIaLWkAKcfw4BS6jEfQ0dN6LE0NwH5BK9U2QSyeN9qS7VKshdNousyOA8YJoLKh
         VYpPqvFc5OyCbKo6G9XTuWL19o11vkiZm/aTDC7y5UzPRjxuwNsNyf732mX0ZYarTgLO
         JM1s/OJQMzJNQ2A8lpeYJAFcvw6AnBHRFG3uafBmj4vehC14/A/vlE6pTrp7Y4OC0NZh
         +KcTzzoTJzxuZZFdVLknujAy+WuzhQfEbANFsf0BhQHcAcU/5eA+hWrzzCJPbkw3S3TV
         zuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b8vO50YBsmLkL0nMY7OxbmpOtYnJRHSmdT3806trdv8=;
        b=sjaPnSN8mBF3dp30IQKMO5ATK0aTTiby3im9KdOi3dZiPlZTQmran2sY/fL990vM2K
         bfykFye7KHD1HT0XzCVU4kuU5Bkr9Ir+pqryUOXXBITMSjqhU541nQ6SPk6IHJpIU7Xd
         RszuyPUe8Nz1dlVq2q4xm5Gms16HDXjxt7NtBNK7I9rIWoDpA5ScUTKeEcwC55S84pWX
         oWsZnoPb80mLCilEqxCk5mAo9zo77he0evTwQ3yfqa7HNewZ/qPEXmF85Ul4nufnushh
         4nOjw0AU7vxtCw5j8MM9kbnEMT+9e+oRM1xyiP8SbkSpHSsHF+vQTkWIZ1EtwInO534h
         Amuw==
X-Gm-Message-State: AGRZ1gKoTyGOM9+VzqKFQVuLzm5h+zozT0rQrthw+4ps3fuVFoBKUaWb
        TKaauWpiSKxWp/gLMcLBCrqYVhbeyHIM
X-Google-Smtp-Source: AJdET5dvjlTzynanHztxoSHPTY+NFzDeGQxJDyLFenQGlvxtPKwpFL55M6vNxwSTd0MpxLS2HSi8rZRWu/cx
X-Received: by 2002:a24:648e:: with SMTP id t136-v6mr996224itc.25.1540510369312;
 Thu, 25 Oct 2018 16:32:49 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:32:26 -0700
In-Reply-To: <20181025233231.102245-1-sbeller@google.com>
Message-Id: <20181025233231.102245-6-sbeller@google.com>
Mime-Version: 1.0
References: <20181025233231.102245-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 05/10] submodule: store OIDs in changed_submodule_names
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
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
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
---
 submodule.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6fb0b9d783..e4b494af7b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1127,8 +1127,7 @@ static void calculate_changed_submodule_paths(
 	struct string_list *changed_submodule_names)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
-	const struct string_list_item *name;
+	struct string_list_item *name;
 
 	/* No need to check if there are no submodules configured */
 	if (!submodule_from_path(the_repository, NULL, NULL))
@@ -1145,9 +1144,9 @@ static void calculate_changed_submodule_paths(
 	 * Collect all submodules (whether checked out or not) for which new
 	 * commits have been recorded upstream in "changed_submodule_names".
 	 */
-	collect_changed_submodules(&changed_submodules, &argv);
+	collect_changed_submodules(changed_submodule_names, &argv);
 
-	for_each_string_list_item(name, &changed_submodules) {
+	for_each_string_list_item(name, changed_submodule_names) {
 		struct oid_array *commits = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
@@ -1161,12 +1160,14 @@ static void calculate_changed_submodule_paths(
 		if (!path)
 			continue;
 
-		if (!submodule_has_commits(path, commits))
-			string_list_append(changed_submodule_names,
-					   name->string);
+		if (submodule_has_commits(path, commits)) {
+			oid_array_clear(commits);
+			*name->string = '\0';
+		}
 	}
 
-	free_submodules_oids(&changed_submodules);
+	string_list_remove_empty_items(changed_submodule_names, 1);
+
 	argv_array_clear(&argv);
 	oid_array_clear(&ref_tips_before_fetch);
 	oid_array_clear(&ref_tips_after_fetch);
@@ -1376,7 +1377,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&spf.changed_submodule_names, 1);
+	free_submodules_oids(&spf.changed_submodule_names);
 	return spf.result;
 }
 
-- 
2.19.0

