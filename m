Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910B9EE499B
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 23:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242829AbjHRXh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 19:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242790AbjHRXhl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 19:37:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E82A30DF
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 16:37:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E7AC29CE1;
        Fri, 18 Aug 2023 19:37:38 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=N6ej98JkVt9EwBMfn4xIdlXtq
        acyZTJBWM1ADnj/oDA=; b=IAyH9UG1Uzn5jJrsYFKapEDcZHZkBNRrk1luLSBRG
        xWZS3WOb3AiD7A/3yt1IN59QO615kPfxTm9CKeB1FxA3m+YGm0S+TnX9apChECPK
        oSq5bFUD8gIrlPzEINbuUzda9IgpZcBbGV3G+e5RBKYFa+DK8h1Fp2K2XqmbwolO
        64=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8821A29CE0;
        Fri, 18 Aug 2023 19:37:38 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4505E29CDF;
        Fri, 18 Aug 2023 19:37:35 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 3/3] test-tool: retire "index-version"
Date:   Fri, 18 Aug 2023 16:37:29 -0700
Message-ID: <20230818233729.2766281-4-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-rc2-7-gf9972720e9
In-Reply-To: <20230818233729.2766281-1-gitster@pobox.com>
References: <20230818233729.2766281-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 3586A37A-3E20-11EE-8CB6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As "git update-index --show-index-version" can do the same thing,
the test-tool lost its reason to exist.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                              |  1 -
 t/helper/test-index-version.c         | 15 ---------------
 t/helper/test-tool.c                  |  1 -
 t/helper/test-tool.h                  |  1 -
 t/t1600-index.sh                      |  2 +-
 t/t1700-split-index.sh                |  2 +-
 t/t2104-update-index-skip-worktree.sh |  6 +++---
 7 files changed, 5 insertions(+), 23 deletions(-)
 delete mode 100644 t/helper/test-index-version.c

diff --git a/Makefile b/Makefile
index e440728c24..5323c76aa0 100644
--- a/Makefile
+++ b/Makefile
@@ -808,7 +808,6 @@ TEST_BUILTINS_OBJS +=3D test-hash-speed.o
 TEST_BUILTINS_OBJS +=3D test-hash.o
 TEST_BUILTINS_OBJS +=3D test-hashmap.o
 TEST_BUILTINS_OBJS +=3D test-hexdump.o
-TEST_BUILTINS_OBJS +=3D test-index-version.o
 TEST_BUILTINS_OBJS +=3D test-json-writer.o
 TEST_BUILTINS_OBJS +=3D test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS +=3D test-match-trees.o
diff --git a/t/helper/test-index-version.c b/t/helper/test-index-version.=
c
deleted file mode 100644
index a06c45c1f8..0000000000
--- a/t/helper/test-index-version.c
+++ /dev/null
@@ -1,15 +0,0 @@
-#include "test-tool.h"
-#include "cache.h"
-
-int cmd__index_version(int argc UNUSED, const char **argv UNUSED)
-{
-	struct cache_header hdr;
-	int version;
-
-	memset(&hdr,0,sizeof(hdr));
-	if (read(0, &hdr, sizeof(hdr)) !=3D sizeof(hdr))
-		return 0;
-	version =3D ntohl(hdr.hdr_version);
-	printf("%d\n", version);
-	return 0;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index abe8a785eb..621ac3dd10 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -38,7 +38,6 @@ static struct test_cmd cmds[] =3D {
 	{ "hashmap", cmd__hashmap },
 	{ "hash-speed", cmd__hash_speed },
 	{ "hexdump", cmd__hexdump },
-	{ "index-version", cmd__index_version },
 	{ "json-writer", cmd__json_writer },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "match-trees", cmd__match_trees },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ea2672436c..a641c3a81d 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -32,7 +32,6 @@ int cmd__getcwd(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
 int cmd__hash_speed(int argc, const char **argv);
 int cmd__hexdump(int argc, const char **argv);
-int cmd__index_version(int argc, const char **argv);
 int cmd__json_writer(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__match_trees(int argc, const char **argv);
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 9368d82f7d..62e7fd1596 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -118,7 +118,7 @@ test_index_version () {
 		fi &&
 		git add a &&
 		echo $EXPECTED_OUTPUT_VERSION >expect &&
-		test-tool index-version <.git/index >actual &&
+		git update-index --show-index-version >actual &&
 		test_cmp expect actual
 	)
 }
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index b4ab166369..a7b7263b35 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -43,7 +43,7 @@ test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
 	git update-index --split-index &&
 	test-tool dump-split-index .git/index >actual &&
-	indexversion=3D$(test-tool index-version <.git/index) &&
+	indexversion=3D$(git update-index --show-index-version) &&
=20
 	# NEEDSWORK: Stop hard-coding checksums.
 	if test "$indexversion" =3D "4"
diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index=
-skip-worktree.sh
index b8686aabd3..0bab134d71 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -39,7 +39,7 @@ test_expect_success 'setup' '
 '
=20
 test_expect_success 'index is at version 2' '
-	test "$(test-tool index-version < .git/index)" =3D 2
+	test "$(git update-index --show-index-version)" =3D 2
 '
=20
 test_expect_success 'update-index --skip-worktree' '
@@ -48,7 +48,7 @@ test_expect_success 'update-index --skip-worktree' '
 '
=20
 test_expect_success 'index is at version 3 after having some skip-worktr=
ee entries' '
-	test "$(test-tool index-version < .git/index)" =3D 3
+	test "$(git update-index --show-index-version)" =3D 3
 '
=20
 test_expect_success 'ls-files -t' '
@@ -61,7 +61,7 @@ test_expect_success 'update-index --no-skip-worktree' '
 '
=20
 test_expect_success 'index version is back to 2 when there is no skip-wo=
rktree entry' '
-	test "$(test-tool index-version < .git/index)" =3D 2
+	test "$(git update-index --show-index-version)" =3D 2
 '
=20
 test_done
--=20
2.42.0-rc2-7-gf9972720e9

