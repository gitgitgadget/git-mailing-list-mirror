Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1862AC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 20:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378753AbiFPUzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378691AbiFPUzD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 16:55:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4655FF2D
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:55:01 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i64so2481590pfc.8
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TSiMlGnlwvWTHMBMlYVFqnW1J7unPGaY/bGt+XemhHw=;
        b=nBXVWczRTTiU/NhKDzYJjifrcwDlM1rR2eg5GHyPd9Qn5WfiqYqTMyUTiWN5QDIQ5I
         hx3POpAaffCygqKnXtAaxoCipkfjjD26FH6FlWkHoEnxvaLKJvLkyPkXH/vWdKCxfI9m
         6IGooDGKjoG9pUi8KB7LD0fWdUVgN4LL1yG+XTzwzPVZ2BBQMW6ftwD04lCAS1xElIUm
         TEaw3Tx+UxFmxf/30cw97umjojIeyQCF8yW6SYIco/ekeeqhGwyhEj3g9HdC4OlHeRkQ
         kWnWgHyXHsw6gCzTBdoauwQTuUmjTroWtheqVqdFDN/LrDEIW9KSk4GFKjhFvor8a7Gn
         B11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSiMlGnlwvWTHMBMlYVFqnW1J7unPGaY/bGt+XemhHw=;
        b=rlwXguIWGCsLhuFhq/J4zrZkSHswzsfIr/Kx79u9g7Nf6uxY+J4J8rlecy1kUYT+Nv
         YXzwyLzdjJTYidW1hGargdoSSnkFxK2iX+EXRTO4nSgerB8Z9m/ZvS+BlWx8D9etd2mN
         qSoT09u9fYkGs3aqtDxm7THfPRLKPptYRtmFtI2JqpDY0b7ilxOielNN1g64ClmQRfKi
         auyKNPN4w2y3Q3YjaZv6V7NZfgJ191AIO2jl5u6FyvALFNtOezfhY/mowdgUTnFXaIWL
         9Zta/ODDkE10xjINdAk9wu87isPVj4JD6NzPVenMveOJ84+03wADRlFlqlQJn4+wWlvC
         icBg==
X-Gm-Message-State: AJIora+pRbQ40K+V5m1v+hmDXG3IlsO38zhl6qUUeIliuxYUfPGOy+50
        wBtjFJTjt4V6hCMFx0x+6wOVdgu7AOI=
X-Google-Smtp-Source: AGRyM1ur8DXlACu3YpP0lLqQ+n6e1EtK2JLqEjWX6r9mhPvIhplkxtyuIzCLss2dkE7CAkfchdy09g==
X-Received: by 2002:a05:6a00:a12:b0:51b:92d7:ec55 with SMTP id p18-20020a056a000a1200b0051b92d7ec55mr6574321pfh.85.1655412900537;
        Thu, 16 Jun 2022 13:55:00 -0700 (PDT)
Received: from JEKELLER-HOME.localdomain ([50.39.231.65])
        by smtp.gmail.com with ESMTPSA id j4-20020aa783c4000000b0051b9e224623sm2249165pfn.141.2022.06.16.13.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:54:59 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
X-Google-Original-From: Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Pavel Rappo <pavel.rappo@gmail.com>
Subject: [PATCH v2 5/5] remote: handle negative refspecs in git remote show
Date:   Thu, 16 Jun 2022 13:54:56 -0700
Message-Id: <20220616205456.19081-6-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616205456.19081-1-jacob.e.keller@intel.com>
References: <20220616205456.19081-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default, the git remote show command will query data from remotes to
show data about what might be done on a future git fetch. This process
currently does not handle negative refspecs. This can be confusing,
because the show command will list refs as if they would be fetched. For
example if the fetch refspec "^refs/heads/pr/*", it still displays the
following:

  * remote jdk19
    Fetch URL: git@github.com:openjdk/jdk19.git
    Push  URL: git@github.com:openjdk/jdk19.git
    HEAD branch: master
    Remote branches:
      master tracked
      pr/1   new (next fetch will store in remotes/jdk19)
      pr/2   new (next fetch will store in remotes/jdk19)
      pr/3   new (next fetch will store in remotes/jdk19)
    Local ref configured for 'git push':
      master pushes to master (fast-forwardable)

Fix this by adding an additional check inside of get_ref_states. Before
adding the ref name to the new_refs list, use omit_name_by_refspec to
see if the ref matches any negative refspecs. This change results in the
following output for git remote show:

  * remote jdk19
    Fetch URL: git@github.com:openjdk/jdk19.git
    Push  URL: git@github.com:openjdk/jdk19.git
    HEAD branch: master
    Remote branches:
      master tracked
      pr/1   skipped
      pr/2   skipped
      pr/3   skipped
    Local ref configured for 'git push':
      master pushes to master (fast-forwardable)

By showing the refs as skipped, it helps clarify that these references
won't actually be fetched. Alternatively, we could simply remove them
entirely.

Add a new test case to cover this functionality.

Reported-by: Pavel Rappo <pavel.rappo@gmail.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 builtin/remote.c  | 17 +++++++++++++----
 remote.c          |  2 +-
 remote.h          |  6 ++++++
 t/t5505-remote.sh | 22 ++++++++++++++++++++++
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d4b69fe77898..8d88c21e2e95 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -344,12 +344,13 @@ static void read_branches(void)
 
 struct ref_states {
 	struct remote *remote;
-	struct string_list new_refs, stale, tracked, heads, push;
+	struct string_list new_refs, skipped, stale, tracked, heads, push;
 	int queried;
 };
 
 #define REF_STATES_INIT { \
 	.new_refs = STRING_LIST_INIT_DUP, \
+	.skipped = STRING_LIST_INIT_DUP, \
 	.stale = STRING_LIST_INIT_DUP, \
 	.tracked = STRING_LIST_INIT_DUP, \
 	.heads = STRING_LIST_INIT_DUP, \
@@ -368,10 +369,13 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 				states->remote->fetch.raw[i]);
 
 	for (ref = fetch_map; ref; ref = ref->next) {
-		if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
+		if (omit_name_by_refspec(ref->name, &states->remote->fetch)) {
+			string_list_append(&states->skipped, abbrev_branch(ref->name));
+		} else if (!ref->peer_ref || !ref_exists(ref->peer_ref->name)) {
 			string_list_append(&states->new_refs, abbrev_branch(ref->name));
-		else
+		} else {
 			string_list_append(&states->tracked, abbrev_branch(ref->name));
+		}
 	}
 	stale_refs = get_stale_heads(&states->remote->fetch, fetch_map);
 	for (ref = stale_refs; ref; ref = ref->next) {
@@ -383,6 +387,7 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	free_refs(fetch_map);
 
 	string_list_sort(&states->new_refs);
+	string_list_sort(&states->skipped);
 	string_list_sort(&states->tracked);
 	string_list_sort(&states->stale);
 
@@ -941,6 +946,7 @@ static void clear_push_info(void *util, const char *string)
 static void free_remote_ref_states(struct ref_states *states)
 {
 	string_list_clear(&states->new_refs, 0);
+	string_list_clear(&states->skipped, 0);
 	string_list_clear(&states->stale, 1);
 	string_list_clear(&states->tracked, 0);
 	string_list_clear(&states->heads, 0);
@@ -1033,7 +1039,9 @@ static int show_remote_info_item(struct string_list_item *item, void *cb_data)
 		if (string_list_has_string(&states->new_refs, name)) {
 			fmt = _(" new (next fetch will store in remotes/%s)");
 			arg = states->remote->name;
-		} else if (string_list_has_string(&states->tracked, name))
+		} else if (string_list_has_string(&states->skipped, name))
+			arg = _(" skipped");
+		else if (string_list_has_string(&states->tracked, name))
 			arg = _(" tracked");
 		else if (string_list_has_string(&states->stale, name))
 			arg = _(" stale (use 'git remote prune' to remove)");
@@ -1308,6 +1316,7 @@ static int show(int argc, const char **argv)
 		/* remote branch info */
 		info.width = 0;
 		for_each_string_list(&info.states.new_refs, add_remote_to_show_info, &info);
+		for_each_string_list(&info.states.skipped, add_remote_to_show_info, &info);
 		for_each_string_list(&info.states.tracked, add_remote_to_show_info, &info);
 		for_each_string_list(&info.states.stale, add_remote_to_show_info, &info);
 		if (info.list.nr)
diff --git a/remote.c b/remote.c
index 404e1e0a0ddb..7d68b5632bb5 100644
--- a/remote.c
+++ b/remote.c
@@ -804,7 +804,7 @@ static int refspec_match(const struct refspec_item *refspec,
 	return !strcmp(refspec->src, name);
 }
 
-static int omit_name_by_refspec(const char *name, struct refspec *rs)
+int omit_name_by_refspec(const char *name, struct refspec *rs)
 {
 	int i;
 
diff --git a/remote.h b/remote.h
index dd4402436f1f..448675e11259 100644
--- a/remote.h
+++ b/remote.h
@@ -247,6 +247,12 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
+/*
+ * Check whether a name matches any negative refspec in rs. Returns 1 if the
+ * name matches at least one negative refspec, and 0 otherwise.
+ */
+int omit_name_by_refspec(const char *name, struct refspec *rs);
+
 /*
  * Remove all entries in the input list which match any negative refspec in
  * the refspec list.
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ac5198141e79..06e5cef325c2 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -263,6 +263,28 @@ test_expect_success 'show' '
 	test_cmp expect output
 '
 
+cat >expect <<EOF
+* remote origin
+  Fetch URL: $(pwd)/one
+  Push  URL: $(pwd)/one
+  HEAD branch: main
+  Remote branches:
+    main skipped
+    side tracked
+  Local branches configured for 'git pull':
+    ahead merges with remote main
+    main  merges with remote main
+  Local refs configured for 'git push':
+    main pushes to main     (local out of date)
+    main pushes to upstream (create)
+EOF
+
+test_expect_success 'show with negative refspecs' '
+	test_config -C test --add remote.origin.fetch ^refs/heads/main &&
+	git -C test remote show origin >output &&
+	test_cmp expect output
+'
+
 cat >expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
-- 
2.36.1

