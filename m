Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC7911FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 23:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754767AbdCaXLs (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 19:11:48 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35861 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753986AbdCaXLr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 19:11:47 -0400
Received: by mail-pg0-f50.google.com with SMTP id g2so82617147pge.3
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 16:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FMmBVtrogHdlM1wx6h9+fA/wu1hkgwqrYMIIyeXPVMQ=;
        b=OFtyW3YIUPT34Fql/2I1u21g7O719LGPg7FUvxOrsudnseCdbOBog83ydN97l5wdts
         JMGwEdXK5ydgvh3B+5BBKy8Nogpjsp4D2ccr9B7cWXOn0Edh3kYU6F2lFduDcI5w7Xdz
         Dz8bqd6O89zIIJCowW6QFs+sKr4t8wvDLlgCJXqHdLrBAlDUI5wPWr94cZb8OMqr7bfj
         4/WOIh8rQohmpl61O5XkwBb6cE1VTJ2Gs8ETUg2qu369FRivOJQyg5YiPqbjXQZgbv56
         X9rq3dZ7jIlYGsQaHy09pB4jKXriu9aalvXJlbXxGtw1J7jQpN28tK/FMPDPt87ppZQ7
         q05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FMmBVtrogHdlM1wx6h9+fA/wu1hkgwqrYMIIyeXPVMQ=;
        b=cHVNFilYB2nV3Rz7wtMoAcWMcdfW9poajUFMOn7WeuQZdW6R6ibNp4nK+ySp7tLxJJ
         iZVmt8wJJe5ldob6yMD88uPPXI3yMzU1+K+mGH9B4B7LX+q8eZmoLBCIEIVqzg5hvy7o
         prAP+To2Rd9bCH9sxC45gKXAD9mSRKdpF7vFxpztyUDOpc3UyP7K1WhNfPZkhdOqCJVA
         ezapePPnUPuk0IRLWkDj0503Z+cqBNacp0fMihkTo+gDXdudZA5KpfVHFW6Sory4tlh8
         xe2kSW+vE/kfXZo05LCg9+HY/lOSzIfsvvf0CKaX79D7OI5GfIYX9sEo5xMT0YUaqE+7
         qrug==
X-Gm-Message-State: AFeK/H3aIZ1YeiO3eds/pWW7gbYZBJwSL0e74neq/KF2QSqMPn4DKBSZYbMxStoulaDzkRHP
X-Received: by 10.99.4.2 with SMTP id 2mr5179287pge.238.1491001906359;
        Fri, 31 Mar 2017 16:11:46 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w14sm12438021pgo.37.2017.03.31.16.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 16:11:45 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH] push: propagate push-options with --recurse-submodules
Date:   Fri, 31 Mar 2017 16:11:35 -0700
Message-Id: <20170331231135.195195-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.564.g063fe858b8-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach push --recurse-submodules to propagate push-options recursively to
the pushes performed in the submodules.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c             | 14 +++++++++++---
 submodule.h             |  3 ++-
 t/t5545-push-options.sh | 39 +++++++++++++++++++++++++++++++++++++++
 transport.c             |  3 ++-
 4 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index c52d6634c..3d6d5e62d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -782,7 +782,8 @@ int find_unpushed_submodules(struct sha1_array *commits,
 	return needs_pushing->nr;
 }
 
-static int push_submodule(const char *path, int dry_run)
+static int push_submodule(const char *path, int dry_run,
+			  const struct string_list *push_options)
 {
 	if (add_submodule_odb(path))
 		return 1;
@@ -793,6 +794,12 @@ static int push_submodule(const char *path, int dry_run)
 		if (dry_run)
 			argv_array_push(&cp.args, "--dry-run");
 
+		if (push_options && push_options->nr) {
+			static struct string_list_item *item;
+			for_each_string_list_item(item, push_options)
+				argv_array_pushf(&cp.args, "--push-option=%s",
+						 item->string);
+		}
 		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
@@ -807,7 +814,8 @@ static int push_submodule(const char *path, int dry_run)
 
 int push_unpushed_submodules(struct sha1_array *commits,
 			     const char *remotes_name,
-			     int dry_run)
+			     int dry_run,
+			     const struct string_list *push_options)
 {
 	int i, ret = 1;
 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
@@ -818,7 +826,7 @@ int push_unpushed_submodules(struct sha1_array *commits,
 	for (i = 0; i < needs_pushing.nr; i++) {
 		const char *path = needs_pushing.items[i].string;
 		fprintf(stderr, "Pushing submodule '%s'\n", path);
-		if (!push_submodule(path, dry_run)) {
+		if (!push_submodule(path, dry_run, push_options)) {
 			fprintf(stderr, "Unable to push submodule '%s'\n", path);
 			ret = 0;
 		}
diff --git a/submodule.h b/submodule.h
index 8a8bc49dc..036ce4c5c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -92,7 +92,8 @@ extern int find_unpushed_submodules(struct sha1_array *commits,
 				    struct string_list *needs_pushing);
 extern int push_unpushed_submodules(struct sha1_array *commits,
 				    const char *remotes_name,
-				    int dry_run);
+				    int dry_run,
+				    const struct string_list *push_options);
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 extern int parallel_submodules(void);
 
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 97065e62b..32c513c78 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -142,6 +142,45 @@ test_expect_success 'push options work properly across http' '
 	test_cmp expect actual
 '
 
+test_expect_success 'push options and submodules' '
+	test_when_finished "rm -rf parent" &&
+	test_when_finished "rm -rf parent_upstream" &&
+	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions true &&
+	cp -r upstream parent_upstream &&
+	test_commit -C upstream one &&
+
+	test_create_repo parent &&
+	git -C parent remote add up ../parent_upstream &&
+	test_commit -C parent one &&
+	git -C parent push --mirror up &&
+
+	git -C parent submodule add ../upstream workbench &&
+	git -C parent commit -m "add submoule" &&
+
+	test_commit -C parent/workbench two &&
+	git -C parent add workbench &&
+	git -C parent commit -m "update workbench" &&
+
+	git -C parent push \
+		--push-option=asdf --push-option="more structured text" \
+		--recurse-submodules=on-demand up master &&
+
+	git -C upstream rev-parse --verify master >expect &&
+	git -C parent/workbench rev-parse --verify master >actual &&
+	test_cmp expect actual &&
+
+	git -C parent_upstream rev-parse --verify master >expect &&
+	git -C parent rev-parse --verify master >actual &&
+	test_cmp expect actual &&
+
+	printf "asdf\nmore structured text\n" >expect &&
+	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+	test_cmp expect upstream/.git/hooks/post-receive.push_options &&
+	test_cmp expect parent_upstream/.git/hooks/pre-receive.push_options &&
+	test_cmp expect parent_upstream/.git/hooks/post-receive.push_options
+'
+
 stop_httpd
 
 test_done
diff --git a/transport.c b/transport.c
index 417ed7f19..b1e680881 100644
--- a/transport.c
+++ b/transport.c
@@ -1031,7 +1031,8 @@ int transport_push(struct transport *transport,
 
 			if (!push_unpushed_submodules(&commits,
 						      transport->remote->name,
-						      pretend)) {
+						      pretend,
+						      transport->push_options)) {
 				sha1_array_clear(&commits);
 				die("Failed to push all needed submodules!");
 			}
-- 
2.12.2.564.g063fe858b8-goog

