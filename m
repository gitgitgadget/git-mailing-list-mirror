Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 089181F453
	for <e@80x24.org>; Fri,  5 Oct 2018 13:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeJEUEv (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 16:04:51 -0400
Received: from mail.ao2.it ([92.243.12.208]:44939 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbeJEUEu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 16:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=/XduOMTKlF9WoDmLlIRWrMjOFCgd1YKk2Gr7hBcVkjg=;
        b=Fl05bHeF5ejyHIyY49yxyq0oPcGMxUbEsMQgO4b7zbpw4bZnbjMH15ssOExb/24pp+EbB/mzuav9n+Pu4fOnn2OHeuYMWTy3H1z6titA83sXJLUDWRmhR/9VxuhDZpkv/743WdbgbH1cEDeoppDIgRBGCJYBozKEcUXMWz8Rp1llsy0iPSJqlpQ+ZbCfrM5PoJtBPvh7coTohj5ZDyyjWgOAZrmH7ZxVu8kIcP+Bwhy4c1e7COhsQJa+xFMwLd7WwU3AssgGVzC/fkoqQnYo7vghVc6ycLFynQp23mhmcGk85U73Is7ihl6uNWWXC2I5wuhyUyU8ySiAlBtV2y7qEg==;
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g8PlU-0003BQ-9I; Fri, 05 Oct 2018 15:03:32 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1g8Pnx-00049M-Va; Fri, 05 Oct 2018 15:06:05 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v6 10/10] t/helper: add test-submodule-nested-repo-config
Date:   Fri,  5 Oct 2018 15:06:01 +0200
Message-Id: <20181005130601.15879-11-ao2@ao2.it>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005130601.15879-1-ao2@ao2.it>
References: <20181005130601.15879-1-ao2@ao2.it>
MIME-Version: 1.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test tool to exercise config_from_gitmodules(), in particular for
the case of nested submodules.

Add also a test to document that reading the submoudles config of nested
submodules does not work yet when the .gitmodules file is not in the
working tree but it still in the index.

This is because the git API does not always make it possible access the
object store  of an arbitrary repository (see get_oid() usage in
config_from_gitmodules()).

When this git limitation gets fixed the aforementioned use case will be
supported too.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 Makefile                                     |  1 +
 t/helper/test-submodule-nested-repo-config.c | 30 +++++++++++++++++
 t/helper/test-tool.c                         |  1 +
 t/helper/test-tool.h                         |  1 +
 t/t7411-submodule-config.sh                  | 34 ++++++++++++++++++++
 5 files changed, 67 insertions(+)
 create mode 100644 t/helper/test-submodule-nested-repo-config.c

diff --git a/Makefile b/Makefile
index 13e1c52478..fe8587cd8c 100644
--- a/Makefile
+++ b/Makefile
@@ -737,6 +737,7 @@ TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
+TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
new file mode 100644
index 0000000000..a31e2a9bea
--- /dev/null
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -0,0 +1,30 @@
+#include "test-tool.h"
+#include "submodule-config.h"
+
+static void die_usage(int argc, const char **argv, const char *msg)
+{
+	fprintf(stderr, "%s\n", msg);
+	fprintf(stderr, "Usage: %s <submodulepath> <config name>\n", argv[0]);
+	exit(1);
+}
+
+int cmd__submodule_nested_repo_config(int argc, const char **argv)
+{
+	struct repository submodule;
+
+	if (argc < 3)
+		die_usage(argc, argv, "Wrong number of arguments.");
+
+	setup_git_directory();
+
+	if (repo_submodule_init(&submodule, the_repository, argv[1])) {
+		die_usage(argc, argv, "Submodule not found.");
+	}
+
+	/* Read the config of _child_ submodules. */
+	print_config_from_gitmodules(&submodule, argv[2]);
+
+	submodule_free(the_repository);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b87a8c1f22..3b473bccd8 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -42,6 +42,7 @@ static struct test_cmd cmds[] = {
 	{ "strcmp-offset", cmd__strcmp_offset },
 	{ "string-list", cmd__string_list },
 	{ "submodule-config", cmd__submodule_config },
+	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
 	{ "wildmatch", cmd__wildmatch },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e074957279..3ca351230c 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -38,6 +38,7 @@ int cmd__sigchain(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
+int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
 int cmd__wildmatch(int argc, const char **argv);
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 2cfabb18bc..89690b7adb 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -216,4 +216,38 @@ test_expect_success 'reading submodules config from the current branch when .git
 	)
 '
 
+test_expect_success 'reading nested submodules config' '
+	(cd super &&
+		git init submodule/nested_submodule &&
+		echo "a" >submodule/nested_submodule/a &&
+		git -C submodule/nested_submodule add a &&
+		git -C submodule/nested_submodule commit -m "add a" &&
+		git -C submodule submodule add ./nested_submodule &&
+		git -C submodule add nested_submodule &&
+		git -C submodule commit -m "added nested_submodule" &&
+		git add submodule &&
+		git commit -m "updated submodule" &&
+		echo "./nested_submodule" >expect &&
+		test-tool submodule-nested-repo-config \
+			submodule submodule.nested_submodule.url >actual &&
+		test_cmp expect actual
+	)
+'
+
+# When this test eventually passes, before turning it into
+# test_expect_success, remember to replace the test_i18ngrep below with
+# a "test_must_be_empty warning" to be sure that the warning is actually
+# removed from the code.
+test_expect_failure 'reading nested submodules config when .gitmodules is not in the working tree' '
+	test_when_finished "git -C super/submodule checkout .gitmodules" &&
+	(cd super &&
+		echo "./nested_submodule" >expect &&
+		rm submodule/.gitmodules &&
+		test-tool submodule-nested-repo-config \
+			submodule submodule.nested_submodule.url >actual 2>warning &&
+		test_i18ngrep "nested submodules without %s in the working tree are not supported yet" warning &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.19.0

