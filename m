Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AC9020951
	for <e@80x24.org>; Sat, 18 Mar 2017 00:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbdCRAcd (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 20:32:33 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32974 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbdCRAcb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 20:32:31 -0400
Received: by mail-pf0-f175.google.com with SMTP id e129so5152253pfh.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 17:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hj7nNbtSLFHRZCOSmzvdHXq1auFb/N+NCYC1ug1Npfo=;
        b=SKNE5BSPWjxYMYP4vE1Kxjbr43DJuT6W82glO25QEqspMj0Vl2BkA6ySCY9HSbNSlf
         gpjSNi90h9cBwH8quhh3CFukycAiIOxf1Db9YAwsiTtvpzQJZAGvp5t+pOJt20aU4XlH
         yFrew3caN09EtMKBBna/fU2kEShCwXjtsABVO8A6VgA4U260VIZadhp+DOee4QSJmuKW
         SYSkpsIpfth4LJBNSzAc3bRqzIgu9kx/wP9opr+hkqRSGtYLFrB93vXLTXH/zeOR2DxZ
         OrBCoGC+gVgOLCNoHnuwuVLAI6EdjgHsBnubVkazEo4cr3Z0ax3MpoF3A246Dnfgd4+8
         6s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hj7nNbtSLFHRZCOSmzvdHXq1auFb/N+NCYC1ug1Npfo=;
        b=g5NfdvzSc+AJnRyWav7RoJopD3KKf2+SL9lsmmBwJJADj2jxTf3CjfIdW9R/hza58s
         Gy6208cGNeP+A/o4tK2DlDAMJPrGaLFAgjCAbIhaIK6F4s8oWfEDiMk4K4fz0B+f9/PO
         ItnBGWPT8bbcN5rnwhS+Y9Tx73KrklsNeyuMEBeNPpbaVeIWSNWkCDe9PbTnJvkDX/3J
         p+EARdez5EujJOkEprkSDfw21qTFDKdlStP9me7NDnkioTrDDxs/uV8VMCr6/jW0Zrig
         dLjdxo7T6qjxCmJzr+C/yQaLIKPsB5QgfJFZk1CSiDpAWU/1syivremdqIKpCe4kKcBS
         GZKQ==
X-Gm-Message-State: AFeK/H2iAwblFkITrfW+Q9b+MMa3X9cIq6tbR+b/KJ97O9FyTOdeYO0hvWHK0exNeO6Hyxk5
X-Received: by 10.98.202.195 with SMTP id y64mr19438394pfk.225.1489790305135;
        Fri, 17 Mar 2017 15:38:25 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id d3sm18699763pfc.51.2017.03.17.15.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:38:23 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 07/10] submodule init: initialize active submodules
Date:   Fri, 17 Mar 2017 15:38:02 -0700
Message-Id: <20170317223805.95271-8-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170317223805.95271-1-bmwill@google.com>
References: <20170316222952.53801-1-bmwill@google.com>
 <20170317223805.95271-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach `submodule init` to initialize submodules which have been
configured to be active by setting 'submodule.active' with a pathspec.

Now if no path arguments are given and 'submodule.active' is configured,
`init` will initialize all submodules which have been configured to be
active.  If no path arguments are given and 'submodule.active' is not
configured, then `init` will retain the old behavior of initializing all
submodules.

This allows users to record more complex patterns as it saves retyping
them whenever you invoke update.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-submodule.txt |  4 ++-
 builtin/submodule--helper.c     | 30 ++++++++++++++++++++++
 t/t7400-submodule-basic.sh      | 57 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e05d0cdde..74bc6200d 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -129,7 +129,9 @@ init [--] [<path>...]::
 	repository will be assumed to be upstream.
 +
 Optional <path> arguments limit which submodules will be initialized.
-If no path is specified, all submodules are initialized.
+If no path is specified and submodule.active has been configured, submodules
+configured to be active will be initialized, otherwise all submodules are
+initialized.
 +
 When present, it will also copy the value of `submodule.$name.update`.
 This command does not alter existing information in .git/config.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f38e332c5..65208faa7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -270,6 +270,29 @@ static int module_list_compute(int argc, const char **argv,
 	return result;
 }
 
+static void module_list_active(struct module_list *list)
+{
+	int i;
+	struct module_list active_modules = MODULE_LIST_INIT;
+
+	gitmodules_config();
+
+	for (i = 0; i < list->nr; i++) {
+		const struct cache_entry *ce = list->entries[i];
+
+		if (!is_submodule_initialized(ce->name))
+			continue;
+
+		ALLOC_GROW(active_modules.entries,
+			   active_modules.nr + 1,
+			   active_modules.alloc);
+		active_modules.entries[active_modules.nr++] = ce;
+	}
+
+	free(list->entries);
+	*list = active_modules;
+}
+
 static int module_list(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -420,6 +443,13 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
 		return 1;
 
+	/*
+	 * If there are no path args and submodule.active is set then,
+	 * by default, only initialize 'active' modules.
+	 */
+	if (!argc && git_config_get_value_multi("submodule.active"))
+		module_list_active(&list);
+
 	for (i = 0; i < list.nr; i++)
 		init_submodule(list.entries[i]->name, prefix, quiet);
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c09ce0d4c..fbbe932d1 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1130,5 +1130,62 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup superproject with submodules' '
+	git init sub1 &&
+	test_commit -C sub1 test &&
+	test_commit -C sub1 test2 &&
+	git init multisuper &&
+	git -C multisuper submodule add ../sub1 sub0 &&
+	git -C multisuper submodule add ../sub1 sub1 &&
+	git -C multisuper submodule add ../sub1 sub2 &&
+	git -C multisuper submodule add ../sub1 sub3 &&
+	git -C multisuper commit -m "add some submodules"
+'
+
+cat >expect <<-EOF
+-sub0
+ sub1 (test2)
+ sub2 (test2)
+ sub3 (test2)
+EOF
+
+test_expect_success 'submodule update --init with a specification' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	git -C multisuper_clone submodule update --init . ":(exclude)sub0" &&
+	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule update --init with submodule.active set' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	git -C multisuper_clone config submodule.active "." &&
+	git -C multisuper_clone config --add submodule.active ":(exclude)sub0" &&
+	git -C multisuper_clone submodule update --init &&
+	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule update and setting submodule.<name>.active' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	git -C multisuper_clone config --bool submodule.sub0.active "true" &&
+	git -C multisuper_clone config --bool submodule.sub1.active "false" &&
+	git -C multisuper_clone config --bool submodule.sub2.active "true" &&
+
+	cat >expect <<-\EOF &&
+	 sub0 (test2)
+	-sub1
+	 sub2 (test2)
+	-sub3
+	EOF
+	git -C multisuper_clone submodule update &&
+	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	test_cmp expect actual
+'
 
 test_done
-- 
2.12.0.367.g23dc2f6d3c-goog

