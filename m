Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A53C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjCVQSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCVQSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:18:45 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25A16E96
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:18:34 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id l9so10160233iln.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679501913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Hiiah/I+TezeWdpqXJAP0bn3YCF4n8XSIgXUD3nJ18=;
        b=RTSEaGr1eNIOGLH3aLEf/nmFbSgiD3r2e55XnavnpT0aig9fmFC8z+PuPvl5szTE7C
         CFtoq9w4DmcL2DPbXlHVUxDG9v87Bm5QE458+2/0xJnKTR8RR9F60bX1HwBpVyphJVRW
         tngvAxF53lXZyHr+Z77z4XXAktr/7R9sjx7UtEhGQwfaz+Qsrqu+H8GUhg4YwCKO4cec
         toZY0m3lWUD13gGQvOK+8l/Patx+DQhTdXj5D+NuSUqhYKTpd9YFKj35QkC7trcVSqoo
         tYUMWmXKOMSFeymm710y8UJXhe4YpHLepAn0am7o6KkSliJmsQCXwiFqCwa6YD7eZ0zX
         d7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679501913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Hiiah/I+TezeWdpqXJAP0bn3YCF4n8XSIgXUD3nJ18=;
        b=cCjbTOe5r5gOIv5BcDnVr2Qql9PLXOWzhv9Q300WS7Fu4ksFxF9KOVByazo1Z07C2j
         pE9EoztPhd9cqaRVOEoAhKYEwt4mitKlXnkXzfV67VDGov9sH/iI+KCCcgaqlZc6zjdI
         aPHelbmQo6C585MqRly0+MWdrqcqJQe2LOz+QinHn6dUpkzczNz+xvAGJvuZzci0cdh/
         9cFNt8kWS6jkqB4zPs0FdIuMc+8wZiGS7Lr39JAf1msqMuiRSU9uxN+hoI1xVS3V3K5m
         iFgP6Jkq7+J4pRndr7Pf310SmhbstnxcZRlpmrZ6uFOpM7qAtsOBvqoQMwrZHWN61uN5
         oLEg==
X-Gm-Message-State: AO0yUKWafG0r3UFuvss/Ckan88pxaIjQIR50SPC/MnyVNESlMgXmoZyk
        wNP7o6kOSTTW4cG219tuf5t21v8yEwg=
X-Google-Smtp-Source: AK7set9V7GTjkIKmsMGCdiutRgaChWuhDSCt+MSZjatv6+zSg1e68sVmtPppNuuQ47vIL8te8grJfw==
X-Received: by 2002:a92:dd0d:0:b0:323:66a:be1d with SMTP id n13-20020a92dd0d000000b00323066abe1dmr4891801ilm.25.1679501913633;
        Wed, 22 Mar 2023 09:18:33 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id q18-20020a056e02107200b0032304e1814bsm4460129ilj.40.2023.03.22.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:18:33 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v7 0/2] diff-files: integrate with sparse index
Date:   Wed, 22 Mar 2023 12:18:18 -0400
Message-Id: <20230322161820.3609-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230320205241.105476-1-cheskaqiqi@gmail.com>
References: <20230320205241.105476-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Changes since v6:

1. Fix word wrap in commit message.

2. Use  'mkdir -p folder1' since full-checkout already have folder1.

3. Use `--stat` to ignore file creation time differences in unrefreshed
index.

4. In 'diff-files with pathspec outside sparse definition' add 
'git diff-files "folder*/a" to show that the result is the same with a 
wildcard pathspec.

5. Create an 'ensure_expanded' to handle silent failures.


Shuqi Liang (2):
  t1092: add tests for `git diff-files`
  diff-files: integrate with sparse index

 builtin/diff-files.c                     |  8 ++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 98 ++++++++++++++++++++++++
 3 files changed, 108 insertions(+)

Range-diff against v6:
1:  2a994e60bc ! 1:  e2dcf9921e t1092: add tests for `git diff-files`
    @@ Metadata
      ## Commit message ##
         t1092: add tests for `git diff-files`
     
    -    Before integrating the 'git diff-files' builtin
    -    with the sparse index feature, add tests to
    -    t1092-sparse-checkout-compatibility.sh to ensure it currently works
    -    with sparse-checkout and will still work with sparse index
    -    after that integration.
    +    Before integrating the 'git diff-files' builtin with the sparse index
    +    feature, add tests to t1092-sparse-checkout-compatibility.sh to ensure
    +    it currently works with sparse-checkout and will still work with sparse
    +    index after that integration.
     
    -    When adding tests against a sparse-checkout
    -    definition, we test two modes: all changes are
    -    within the sparse-checkout cone and some changes are outside
    -    the sparse-checkout cone.
    +    When adding tests against a sparse-checkout definition, we test two
    +    modes: all changes are within the sparse-checkout cone and some changes
    +    are outside the sparse-checkout cone.
     
    -    In order to have staged changes outside of
    -    the sparse-checkout cone, make a directory called 'folder1' and
    -    copy `a` into 'folder1/a'. 'folder1/a' is identical to `a` in the base
    -    commit. These make 'folder1/a' in the index, while leaving it outside of
    -    the sparse-checkout definition. Test 'folder1/a'being present on-disk
    +    In order to have staged changes outside of the sparse-checkout cone,
    +    make a directory called 'folder1' and copy `a` into 'folder1/a'.
    +    'folder1/a' is identical to `a` in the base commit. These make
    +    'folder1/a' in the index, while leaving it outside of the
    +    sparse-checkout definition. Test 'folder1/a'being present on-disk
         without modifications, then change content inside 'folder1/a' in order
         to test 'folder1/a' being present on-disk with modifications.
     
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep sparse direc
     +	test_all_match git diff-files deep/*
     +'
     +
    -+test_expect_failure 'diff-files with pathspec outside sparse definition' '
    ++test_expect_success 'diff-files with pathspec outside sparse definition' '
     +	init_repos &&
     +
     +	test_sparse_match test_must_fail git diff-files folder2/a &&
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep sparse direc
     +	# Add file to the index but outside of cone for sparse-checkout cases.
     +	# Add file to the index without sparse-checkout cases to ensure all have 
     +	# same output.
    -+	run_on_all mkdir folder1 &&
    ++	run_on_all mkdir -p folder1 &&
     +	run_on_all cp a folder1/a &&
     +
     +	# file present on-disk without modifications
    -+	test_all_match git diff-files &&
    -+	test_all_match git diff-files folder1/a &&
    ++	# use `--stat` to ignore file creation time differences in
    ++	# unrefreshed index
    ++	test_all_match git diff-files --stat &&
    ++	test_all_match git diff-files --stat folder1/a &&
    ++	test_all_match git diff-files --stat "folder*/a" &&
     +
     +	# file present on-disk with modifications
     +	run_on_all ../edit-contents folder1/a &&
     +	test_all_match git diff-files &&
    -+	test_all_match git diff-files folder1/a
    ++	test_all_match git diff-files folder1/a &&
    ++	test_all_match git diff-files "folder*/a" 
     +'
     +
      test_done
2:  ac730e372d ! 2:  fb8edaf583 diff-files: integrate with sparse index
    @@ Commit message
         <pathspec> contains wildcard that may need a full-index or the
         <pathspec> is simply outside of sparse-checkout definition.
     
    -    Remove full index requirement for `git diff-files`
    -    and add test to ensure the index only expanded when necessary
    -    in `git diff-files`.
    +    Remove full index requirement for `git diff-files`.Create an
    +    'ensure_expanded' to handle silent failures. Add test to
    +    ensure the index only expanded when necessary in `git diff-files`.
     
         The `p2000` tests demonstrate a ~96% execution time reduction for 'git
         diff-files' and a ~97% execution time reduction for 'git diff-files'
    @@ builtin/diff-files.c: int cmd_diff_files(int argc, const char **argv, const char
     +
     +	if (pathspec_needs_expanded_index(the_repository->index, &rev.diffopt.pathspec))
     +		ensure_full_index(the_repository->index);
    -+		
    ++
      	result = run_diff_files(&rev, options);
      	result = diff_result_code(&rev.diffopt, result);
      cleanup:
    @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git checkout-index -f --all
      test_done
     
      ## t/t1092-sparse-checkout-compatibility.sh ##
    -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'diff-files with pathspec outside sparse definition' '
    - 	test_all_match git diff-files folder1/a
    +@@ t/t1092-sparse-checkout-compatibility.sh: ensure_not_expanded () {
    + 	test_region ! index ensure_full_index trace2.txt
    + }
    + 
    ++ensure_expanded () {
    ++	rm -f trace2.txt &&
    ++	if test -z "$WITHOUT_UNTRACKED_TXT"
    ++	then
    ++		echo >>sparse-index/untracked.txt
    ++	fi &&
    ++
    ++	if test "$1" = "!"
    ++	then
    ++		shift &&
    ++		test_must_fail env \
    ++			GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
    ++			git -C sparse-index "$@" \
    ++			>sparse-index-out \
    ++			2>sparse-index-error || return 1
    ++	else
    ++		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
    ++			git -C sparse-index "$@" \
    ++			>sparse-index-out \
    ++			2>sparse-index-error || return 1
    ++	fi &&
    ++	test_region index ensure_full_index trace2.txt
    ++}
    ++
    + test_expect_success 'sparse-index is not expanded' '
    + 	init_repos &&
    + 
    +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff-files with pathspec outside sparse definition' '
    + 	test_all_match git diff-files "folder*/a" 
      '
      
     +test_expect_success 'diff-files pathspec expands index when necessary' '
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'diff-files with p
     +	run_on_all ../edit-contents deep/a &&
     +	
     +	# pathspec that should expand index
    -+	! ensure_not_expanded diff-files "*/a" &&
    -+	test_must_be_empty sparse-index-err &&
    -+
    -+	! ensure_not_expanded diff-files "**a" &&
    -+	test_must_be_empty sparse-index-err
    ++	ensure_expanded diff-files "*/a" &&
    ++	ensure_expanded diff-files "**a" 
     +'
     +
     +test_expect_success 'sparse index is not expanded: diff-files' '
-- 
2.39.0

