Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E94BC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353214AbiALMkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353203AbiALMkH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:40:07 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4925EC061748
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:40:07 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so1655941wmb.1
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tf4bBgpheQuDFjScYhU/zkEK+vphlAWo6l4F22dsxL0=;
        b=dTr6XK8v0tS/FBJg9cqdcUvEuWkV+W0hjWeRoUwOArVM0n55SPKMjlpP8wQTPAAtQv
         AGG8RmtcibvJMOeV8L3KlfkcewwGsDxTQk136xUNci4OYPQZw47p0POOnKLvzXGOR8dy
         yg0Z7gceA/ZlJOS2dGuHJT5UMM+7cb+0P6A8GYGPlFYHWJ7kfp/k98OLcStBkBxWFyb/
         cEcvwtuVgafIQdF0ITY5Zozybi5PHzA398do/HHwlLnFgD3355Ne5zwVlgppWvjDOhtc
         BGfqRFnXYVp+78FtWwaO/JBWjiiMiAUQlQ9eFbNO/I/Ia9KCdZcRZ2Q9EwnxNjCbHPTW
         bRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tf4bBgpheQuDFjScYhU/zkEK+vphlAWo6l4F22dsxL0=;
        b=MV0r8oRzrr7VUVzGLkDF5LprMvyFUPtJ6We8vgYudAZr7qK7ygBPW061n0MnqMqvh3
         Ar8FXjphmyWmEfSp88YMO2c3YcoXlaqMIBLHSkdc8YKs8v7xXKNpJePaDtt36ECxYjFr
         5/pBYHJcSQHcvk3/LOSdWYd0WcUGOLZ0CAN/PnOvZ4Zj9vXLt7PDrFWQE15y1BsD1jW/
         SgQ49e3uhyZ2zQ5Pfdx0mzEfenoAssXai2xbzEQakpNGUdOb41zsC4mRDEscQ8F+aPNp
         eI3y1lL6m+T34Qvnksy3KUtPWX9QZis9OZ3hQt7ZW00UNyv9T61j259HGJmm2Odh95RB
         0Lsw==
X-Gm-Message-State: AOAM531K84EQ765/NslIbFcZ7ML8zbzmF4g7wgBoy4pVMEeW0pzfnhpi
        4w6Olb30PL3Ryk7XMoFFEMhmxx9MW5W7gw==
X-Google-Smtp-Source: ABdhPJxyJKS4JYRkuzlBO60+jl9p300oVQnDkdgHN5NewuiQ/n7BNvXRjBS1K/zreZw9I4ImKfdyHg==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr2250005wmh.42.1641991205509;
        Wed, 12 Jan 2022 04:40:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm5174242wmq.11.2022.01.12.04.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 04:40:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 1/6] object-name tests: add tests for ambiguous object blind spots
Date:   Wed, 12 Jan 2022 13:39:20 +0100
Message-Id: <patch-v7-1.6-28c01b7f8a5-20220111T130811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.848.gb9d3879eb1d
In-Reply-To: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com> <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the tests for ambiguous objects to check how we handle objects
where we return OBJ_BAD when trying to parse them. As noted in [1] we
have a blindspot when it comes to this behavior.

Since we need to add new test data here let's extend these tests to be
tested under SHA-256, in d7a2fc82491 (t1512: skip test if not using
SHA-1, 2018-05-13) all of the existing tests were skipped, as they
rely on specific SHA-1 object IDs.

For these tests it only matters that the first 4 characters of the OID
prefix are the same for both SHA-1 and SHA-256. This uses strings that
I mined, and have the same prefix when hashed with both.

We "test_cmp" the full output to guard against any future regressions,
and because a subsequent commit will tweak it. Showing a diff of how
the output changes is helpful to explain those subsequent commits.

1. https://lore.kernel.org/git/YZwbphPpfGk78w2f@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1512-rev-parse-disambiguation.sh | 79 +++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index b0119bf8bc8..01feeeafb72 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -25,6 +25,85 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+test_cmp_failed_rev_parse () {
+	cat >expect &&
+	test_must_fail git -C "$1" rev-parse "$2" 2>actual.raw &&
+	sed "s/\($2\)[0-9a-f]*/\1.../" <actual.raw >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'ambiguous blob output' '
+	git init --bare blob.prefix &&
+	(
+		cd blob.prefix &&
+
+		# Both start with "dead..", under both SHA-1 and SHA-256
+		echo brocdnra | git hash-object -w --stdin &&
+		echo brigddsv | git hash-object -w --stdin &&
+
+		# Both start with "beef.."
+		echo 1agllotbh | git hash-object -w --stdin &&
+		echo 1bbfctrkc | git hash-object -w --stdin
+	) &&
+
+	test_must_fail git -C blob.prefix rev-parse dead &&
+	test_cmp_failed_rev_parse blob.prefix beef <<-\EOF
+	error: short object ID beef... is ambiguous
+	hint: The candidates are:
+	hint:   beef... blob
+	hint:   beef... blob
+	fatal: ambiguous argument '\''beef...'\'': unknown revision or path not in the working tree.
+	Use '\''--'\'' to separate paths from revisions, like this:
+	'\''git <command> [<revision>...] -- [<file>...]'\''
+	EOF
+'
+
+test_expect_success 'ambiguous loose bad object parsed as OBJ_BAD' '
+	git init --bare blob.bad &&
+	(
+		cd blob.bad &&
+
+		# Both have the prefix "bad0"
+		echo xyzfaowcoh | git hash-object -t bad -w --stdin --literally &&
+		echo xyzhjpyvwl | git hash-object -t bad -w --stdin --literally
+	) &&
+
+	test_cmp_failed_rev_parse blob.bad bad0 <<-\EOF
+	error: short object ID bad0... is ambiguous
+	hint: The candidates are:
+	fatal: invalid object type
+	EOF
+'
+
+test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
+	git init --bare blob.corrupt &&
+	(
+		cd blob.corrupt &&
+
+		# Both have the prefix "cafe"
+		echo bnkxmdwz | git hash-object -w --stdin &&
+		oid=$(echo bmwsjxzi | git hash-object -w --stdin) &&
+
+		oidf=objects/$(test_oid_to_path "$oid") &&
+		chmod 755 $oidf &&
+		echo broken >$oidf
+	) &&
+
+	test_cmp_failed_rev_parse blob.corrupt cafe <<-\EOF
+	error: short object ID cafe... is ambiguous
+	hint: The candidates are:
+	error: inflate: data stream error (incorrect header check)
+	error: unable to unpack cafe... header
+	error: inflate: data stream error (incorrect header check)
+	error: unable to unpack cafe... header
+	hint:   cafe... unknown type
+	hint:   cafe... blob
+	fatal: ambiguous argument '\''cafe...'\'': unknown revision or path not in the working tree.
+	Use '\''--'\'' to separate paths from revisions, like this:
+	'\''git <command> [<revision>...] -- [<file>...]'\''
+	EOF
+'
+
 if ! test_have_prereq SHA1
 then
 	skip_all='not using SHA-1 for objects'
-- 
2.34.1.1373.g062f5534af2

