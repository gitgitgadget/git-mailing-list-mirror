Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB27C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359200AbiELWcc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351769AbiELWca (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:32:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24122A0D32
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:32:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D2DE1368C4;
        Thu, 12 May 2022 18:32:28 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=F0smyXkTJdzk
        JdFqiMPxWVccOjRPmDNcmHLI7r1XoVg=; b=LZ62JU7PqrRFGEegq6ubGr3X7mUK
        U2m/V2yw0faMXFlJmib3NpVxgg4ek7Rn6wbkqqbySCj+U1mvSjOU63jq9m9MVnRc
        67wP3PsHMW0sx+78qgztrY+VJqnUR6kKtQtQP3snTxgX5mhpiGJOcu7SSZNns1x0
        OHolMpMAM7IEOvc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73DFA1368C2;
        Thu, 12 May 2022 18:32:28 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C99111368C0;
        Thu, 12 May 2022 18:32:27 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/4] tests: using custom GIT_EXEC_PATH breaks --valgrind tests
Date:   Thu, 12 May 2022 15:32:15 -0700
Message-Id: <20220512223218.237544-2-gitster@pobox.com>
X-Mailer: git-send-email 2.36.1-338-g1c7f76a54c
In-Reply-To: <20220512223218.237544-1-gitster@pobox.com>
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
 <20220512223218.237544-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 673EB334-D243-11EC-8748-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Fix a regression in b7d11a0f5d2 (tests: exercise the RUNTIME_PREFIX
feature, 2021-07-24) where tests that want to set up and test a "git"
wrapper in $PATH conflicted with the t/bin/valgrind wrapper(s) doing
the same.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0060-path-utils.sh | 4 ++--
 t/test-lib.sh         | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 2fe6ae6a4e..aa35350b6f 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -542,7 +542,7 @@ test_lazy_prereq CAN_EXEC_IN_PWD '
 	./git rev-parse
 '
=20
-test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX works=
' '
+test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PR=
EFIX works' '
 	mkdir -p pretend/bin pretend/libexec/git-core &&
 	echo "echo HERE" | write_script pretend/libexec/git-core/git-here &&
 	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
@@ -550,7 +550,7 @@ test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'R=
UNTIME_PREFIX works' '
 	echo HERE >expect &&
 	test_cmp expect actual'
=20
-test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works' '
+test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/=
 works' '
 	mkdir -p pretend/bin &&
 	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
 	git config yes.path "%(prefix)/yes" &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 531cef097d..7f3d323e93 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1666,6 +1666,7 @@ test -n "$USE_LIBPCRE2" && test_set_prereq PCRE
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 test -n "$SANITIZE_LEAK" && test_set_prereq SANITIZE_LEAK
+test -n "$GIT_VALGRIND_ENABLED" && test_set_prereq VALGRIND
=20
 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
 then
--=20
2.36.1-338-g1c7f76a54c

