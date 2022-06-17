Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AB7C433EF
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 00:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379255AbiFQAUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiFQAUl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 20:20:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CB263387
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 17:20:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x138so2807477pfc.12
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 17:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=He6Owz/zzm4EEe8hJE9G9YQuqvQ/4n8XzVDkspBeYWE=;
        b=JpEMlBOXwYxB+6Xm+OyTS1GTeKOisQb4Qu4Z/2zDSqBOLwtHrUFO/fu9EQuXZgK1aD
         DeNoDneSdYPEE0ZkHr59eGt4MOfuK3Nrx+vRtCjte8H0asG6YVJ6A0C5PsJG9iBR6gmB
         bXxDi2rjjEklYiy/rjrGjH4kgYzvIMmr5jXxktT1iT9TpO5NmRVw5dT6TcZo08PJqKsb
         B/0DU5/b7euGz+nyhGSf3aduWmIkWKO45uWoTOZpDKJZn1T/eGmScVKuvnWHwXuGKtRe
         9H9kw7nORM0M6VaVlNFxPsuZHajaPSPWcV7pirVXKmpIeVf1CsFxET4Dvwbvz6lr4dd9
         TdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=He6Owz/zzm4EEe8hJE9G9YQuqvQ/4n8XzVDkspBeYWE=;
        b=h+WUWWuMU92HejECdl9Pt3CLHRSxLqZON/KyhDnmTAdWSazz84w3X6APQ+e7CqJBPp
         SwdlsH6cntiQE6Z9loL8S2hST5Tmvrtexcy7lcMW83liag4KS+4OU/o7z69zM9Y9o94Q
         XH+vpZA1SpZYEQC+KM+JUCUxOXUiph2Tr3+Vy60wFuV7pMrz54+0m/kRH5qPHbo8J153
         lBvKZj/hVMGqYgm1cS1DXwYdElL0CkNqg+OElTH0Eiyg+uC6CAx9pRea6Y9/bZzPOOzj
         i5aFTP5bkTF1XaRAHQgOVrggUkbanEEqn58iOF8f6UGBXZQFA/31o24lnx3BTmKaNZMX
         dU6w==
X-Gm-Message-State: AJIora9tVPuTcEeLdBJq/HdqtZ0I/ZrxUHXYgrTGlc9jK9saHwDHoJul
        jxGYWUNU25qQrkNkkZMV1ua1BZSyxuA=
X-Google-Smtp-Source: AGRyM1ujyGVaA1kukN5nEHOzvHG5bk0IroNMKoBto/iLaChTWTqRoK89QnHWT9A4GNXXmGgN2m67lw==
X-Received: by 2002:a05:6a00:2286:b0:51c:48b7:a445 with SMTP id f6-20020a056a00228600b0051c48b7a445mr7273865pfe.62.1655425240158;
        Thu, 16 Jun 2022 17:20:40 -0700 (PDT)
Received: from JEKELLER-HOME.localdomain ([50.39.231.65])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b001663165eb16sm2260623plh.7.2022.06.16.17.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 17:20:39 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Pavel Rappo <pavel.rappo@gmail.com>
Subject: [PATCH v3 1/6] remote: handle negative refspecs in git remote show
Date:   Thu, 16 Jun 2022 17:20:31 -0700
Message-Id: <20220617002036.1577-2-jacob.keller@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617002036.1577-1-jacob.keller@gmail.com>
References: <20220617002036.1577-1-jacob.keller@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>

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

Fix this by adding an additional check inside of get_ref_states. If a
ref matches one of the negative refspecs, mark it as skipped instead of
marking it as new or tracked.

With this change, we now report remote branches that are skipped due to
negative refspecs properly:

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
won't actually be fetched.

This does not properly handle refs going stale due to a newly added
negative refspec. In addition, git remote prune doesn't handle that
negative refspec case either. Fixing that requires digging into
get_stale_heads and handling the case of a ref which exists on the
remote but is omitted due to a negative refspec locally.

Add a new test case which covers the functionality above, as well as a
new expected failure indicating the poor overlap with stale refs.

Reported-by: Pavel Rappo <pavel.rappo@gmail.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 builtin/remote.c  | 12 ++++++++++--
 remote.c          |  2 +-
 remote.h          |  6 ++++++
 t/t5505-remote.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d4b69fe77898..d9b8746cb3cb 100644
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
@@ -368,7 +369,9 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 				states->remote->fetch.raw[i]);
 
 	for (ref = fetch_map; ref; ref = ref->next) {
-		if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
+		if (omit_name_by_refspec(ref->name, &states->remote->fetch))
+			string_list_append(&states->skipped, abbrev_branch(ref->name));
+		else if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
 			string_list_append(&states->new_refs, abbrev_branch(ref->name));
 		else
 			string_list_append(&states->tracked, abbrev_branch(ref->name));
@@ -383,6 +386,7 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	free_refs(fetch_map);
 
 	string_list_sort(&states->new_refs);
+	string_list_sort(&states->skipped);
 	string_list_sort(&states->tracked);
 	string_list_sort(&states->stale);
 
@@ -941,6 +945,7 @@ static void clear_push_info(void *util, const char *string)
 static void free_remote_ref_states(struct ref_states *states)
 {
 	string_list_clear(&states->new_refs, 0);
+	string_list_clear(&states->skipped, 0);
 	string_list_clear(&states->stale, 1);
 	string_list_clear(&states->tracked, 0);
 	string_list_clear(&states->heads, 0);
@@ -1035,6 +1040,8 @@ static int show_remote_info_item(struct string_list_item *item, void *cb_data)
 			arg = states->remote->name;
 		} else if (string_list_has_string(&states->tracked, name))
 			arg = _(" tracked");
+		else if (string_list_has_string(&states->skipped, name))
+			arg = _(" skipped");
 		else if (string_list_has_string(&states->stale, name))
 			arg = _(" stale (use 'git remote prune' to remove)");
 		else
@@ -1308,6 +1315,7 @@ static int show(int argc, const char **argv)
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
index fff14e13ed43..0aad0eb4d26c 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -302,6 +302,52 @@ test_expect_success 'show' '
 	)
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
+	test_when_finished "git -C test config --unset-all --fixed-value remote.origin.fetch ^refs/heads/main" &&
+	git -C test config --add remote.origin.fetch ^refs/heads/main &&
+	git -C test remote show origin >output &&
+	test_cmp expect output
+'
+
+cat >expect <<EOF
+* remote origin
+  Fetch URL: $(pwd)/one
+  Push  URL: $(pwd)/one
+  HEAD branch: main
+  Remote branches:
+    main new (next fetch will store in remotes/origin)
+    side stale (use 'git remote prune' to remove)
+  Local branches configured for 'git pull':
+    ahead merges with remote main
+    main  merges with remote main
+  Local refs configured for 'git push':
+    main pushes to main     (local out of date)
+    main pushes to upstream (create)
+EOF
+
+test_expect_failure 'show stale with negative refspecs' '
+	test_when_finished "git -C test config --unset-all --fixed-value remote.origin.fetch ^refs/heads/side" &&
+	git -C test config --add remote.origin.fetch ^refs/heads/side &&
+	git -C test remote show origin >output &&
+	test_cmp expect output
+'
+
 cat >test/expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
-- 
2.36.1

