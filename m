Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E71C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 13:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiAENP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 08:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbiAENP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 08:15:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE763C061784
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 05:15:26 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w20so73938982wra.9
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 05:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BgIsHsTQlsh1wLEtgkO1jr/K48eUuDwMjGB/5ZiToK4=;
        b=gJCovy2Brmhnc1yHpe5telnsAdsVCQo18D7i3Uc7Ozf7WwHHNEXNzbH9nyQ0+8VtwE
         V09gSzlobrUStt38Kl6uTLbjNyHctVqj4lZnrkLeyKKPDPpK1WccezsKkuaagHKh+3ct
         OiHErzl9X5uaxtAlMFdOb4KlEk7XPSB0Wzo+d4RVsO8hgOAvjjYcX5+97fLkoGES7gsd
         GQhprAGij9V+qdcvlh+rQ2y+N4kbqbezlBtJ258FB7yKPRe35BboPjQ59KxpGsP279gE
         /WVDS1xtXvRvLah8t2szqLAmx6NcOyWarSfzqb4zVaiRpVz5ZjyCBscsTowXqx2peG+8
         Vtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BgIsHsTQlsh1wLEtgkO1jr/K48eUuDwMjGB/5ZiToK4=;
        b=fmy8AiOdeAEv/AGRWJqFygHdL4KyZn0oNkjA+2WG7NTxNL9FvlyxfzpZ2atqMKsf9a
         hDsEyEA58O6RHTvS1o3pu43yO9E1ZddJXMRRBOnYk2rGwiHrFhGpFJcWFh6OHuSLVySQ
         IKw4y1Y1gBLGEsSWDqfteKUl75OIKMXxjEPZz1fCH0b1MhJZf4FuGzHn0Pd7mPsKde7+
         13jI1TOif7IIsElnxgmPAdq74dsahXyG9OI7uQd73T8F9EtdzzSXKj9WQq/sOWUa70xo
         cKMZB3AfWrUTiHC07ZO/hFrS/yK5AoQ5FzTEoNtiXJUZ6fG8jSRsY8PHcpzlIHd/UYTl
         zX2g==
X-Gm-Message-State: AOAM533LJcgKdqEdWFHOvVJghZpfRvV4nl3VGmuBCKRkIxjkjBk6y5+z
        MpgumxtGjbU5cTXT2UYSSh0t9qHS7LM=
X-Google-Smtp-Source: ABdhPJwGLy3cqYfh8A1p/d4vIyfN0fsBSoTzkTT8kxGQGCSECejZBkAPeoGP5xIlvnqpHQsCLdY9nw==
X-Received: by 2002:a5d:4fc2:: with SMTP id h2mr46611087wrw.262.1641388525059;
        Wed, 05 Jan 2022 05:15:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5sm42463307wrn.111.2022.01.05.05.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 05:15:24 -0800 (PST)
Message-Id: <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
In-Reply-To: <pull.1105.git.1640181390841.gitgitgadget@gmail.com>
References: <pull.1105.git.1640181390841.gitgitgadget@gmail.com>
From:   "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 13:15:21 +0000
Subject: [PATCH v2 0/2] update-index: refresh should rewrite index in case of racy timestamps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch makes update-index --refresh write the index if it contains racy
timestamps, as discussed at [1].

Changes since v1:

 * main commit message now uses 'git update-index' and the paragraph was
   dropped
 * t/t7508-status.sh: two tests added which capture status racy handling
 * builtin/update-index.c: comment improved
 * t/t2108-update-index-refresh-racy.sh: major overhaul
   * one test case added
   * mtime-manipulations simplified and aligned to t7508
   * code style fixes, as discussed

[1]
https://lore.kernel.org/git/d3dd805c-7c1d-30a9-6574-a7bfcb7fc013@syntevo.com/

Marc Strapetz (2):
  t7508: add tests capturing racy timestamp handling
  update-index: refresh should rewrite index in case of racy timestamps

 builtin/update-index.c               | 11 +++++
 cache.h                              |  1 +
 read-cache.c                         |  2 +-
 t/t2108-update-index-refresh-racy.sh | 64 ++++++++++++++++++++++++++++
 t/t7508-status.sh                    | 28 ++++++++++++
 5 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100755 t/t2108-update-index-refresh-racy.sh


base-commit: dcc0cd074f0c639a0df20461a301af6d45bd582e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1105%2Fmstrap%2Ffeature%2Fupdate-index-refresh-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1105/mstrap/feature/update-index-refresh-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1105

Range-diff vs v1:

 -:  ----------- > 1:  7d58f806111 t7508: add tests capturing racy timestamp handling
 1:  8f9618a44c5 ! 2:  dfeabf6af15 update-index: refresh should rewrite index in case of racy timestamps
     @@ Metadata
       ## Commit message ##
          update-index: refresh should rewrite index in case of racy timestamps
      
     -    update-index --refresh and --really-refresh should force writing of the
     -    index file if racy timestamps have been encountered, as status already
     -    does [1].
     +    'git update-index --refresh' and '--really-refresh' should force writing
     +    of the index file if racy timestamps have been encountered, as
     +    'git status' already does [1].
      
     -    Note that calling update-index still does not guarantee that there will
     -    be no more racy timestamps afterwards (the same holds true for status):
     +    Note that calling 'git update-index --refresh' still does not guarantee
     +    that there will be no more racy timestamps afterwards (the same holds
     +    true for 'git status'):
      
     -    - calling update-index immediately after touching and adding a file may
     -      still leave racy timestamps if all three operations occur within the
     -      racy-tolerance (usually 1 second unless USE_NSEC has been defined)
     +    - calling 'git update-index --refresh' immediately after touching and
     +      adding a file may still leave racy timestamps if all three operations
     +      occur within the racy-tolerance (usually 1 second unless USE_NSEC has
     +      been defined)
      
     -    - calling update-index for timestamps which are set into the future
     -      will leave them racy
     +    - calling 'git update-index --refresh' for timestamps which are set into
     +      the future will leave them racy
      
          To guarantee that such racy timestamps will be resolved would require to
          wait until the system clock has passed beyond these timestamps and only
          then write the index file. Especially for future timestamps, this does
          not seem feasible because of possibly long delays/hangs.
      
     -    Both --refresh and --really-refresh may in theory be used in
     -    combination with --unresolve and --again which may reset the
     -    "active_cache_changed" flag. There is no difference of whether we
     -    write the index due to racy timestamps or due to other
     -    reasons, like if --really-refresh has detected CE_ENTRY_CHANGED in
     -    refresh_cache(). Hence, we will set the "active_cache_changed" flag
     -    immediately after calling refresh_cache().
     -
          [1] https://lore.kernel.org/git/d3dd805c-7c1d-30a9-6574-a7bfcb7fc013@syntevo.com/
      
          Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
     @@ builtin/update-index.c: static int refresh(struct refresh_params *o, unsigned in
       	read_cache();
       	*o->has_errors |= refresh_cache(o->flags | flag);
      +	if (has_racy_timestamp(&the_index)) {
     -+		/* For racy timestamps we should set active_cache_changed immediately:
     -+		 * other callbacks may follow for which some of them may reset
     -+		 * active_cache_changed. */
     ++		/*
     ++		 * Even if nothing else has changed, updating the file
     ++		 * increases the chance that racy timestamps become
     ++		 * non-racy, helping future run-time performance.
     ++		 * We do that even in case of "errors" returned by
     ++		 * refresh_cache() as these are no actual errors.
     ++		 * cmd_status() does the same.
     ++		 */
      +		active_cache_changed |= SOMETHING_CHANGED;
      +	}
       	return 0;
     @@ t/t2108-update-index-refresh-racy.sh (new)
      +
      +test_description='update-index refresh tests related to racy timestamps'
      +
     ++TEST_PASSES_SANITIZE_LEAK=true
      +. ./test-lib.sh
      +
     -+reset_mtime() {
     -+	test-tool chmtime =$(test-tool chmtime --get .git/fs-tstamp) $1
     -+}
     -+
     -+update_assert_unchanged() {
     -+	local ts1=$(test-tool chmtime --get .git/index) &&
     -+	git update-index $1 &&
     -+	local ts2=$(test-tool chmtime --get .git/index) &&
     -+	[ $ts1 -eq $ts2 ]
     ++reset_files () {
     ++	echo content >file &&
     ++	echo content >other &&
     ++	test-tool chmtime =1234567890 file &&
     ++	test-tool chmtime =1234567890 other
      +}
      +
     -+update_assert_changed() {
     -+	local ts1=$(test-tool chmtime --get .git/index) &&
     -+	test_might_fail git update-index $1 &&
     -+	local ts2=$(test-tool chmtime --get .git/index) &&
     -+	[ $ts1 -ne $ts2 ]
     ++update_assert_changed () {
     ++	test-tool chmtime =1234567890 .git/index &&
     ++	test_might_fail git update-index "$1" &&
     ++	test-tool chmtime --get .git/index >.git/out &&
     ++	! grep ^1234567890 .git/out
      +}
      +
      +test_expect_success 'setup' '
     -+	touch .git/fs-tstamp &&
     -+	test-tool chmtime -1 .git/fs-tstamp &&
     -+	echo content >file &&
     -+	reset_mtime file &&
     -+
     -+	git add file &&
     ++	reset_files &&
     ++	# we are calling reset_files() a couple of times during tests;
     ++	# test-tool chmtime does not change the ctime; to not weaken
     ++	# or even break our tests, disable ctime-checks entirely
     ++	git config core.trustctime false &&
     ++	git add file other &&
      +	git commit -m "initial import"
      +'
      +
      +test_expect_success '--refresh has no racy timestamps to fix' '
     -+	reset_mtime .git/index &&
     -+	test-tool chmtime +1 .git/index &&
     -+	update_assert_unchanged --refresh
     ++	reset_files &&
     ++	test-tool chmtime =1234567891 .git/index &&
     ++	git update-index --refresh &&
     ++	test-tool chmtime --get .git/index >.git/out &&
     ++	grep ^1234567891 .git/out
      +'
      +
      +test_expect_success '--refresh should fix racy timestamp' '
     -+	reset_mtime .git/index &&
     ++	reset_files &&
      +	update_assert_changed --refresh
      +'
      +
      +test_expect_success '--really-refresh should fix racy timestamp' '
     -+	reset_mtime .git/index &&
     ++	reset_files &&
      +	update_assert_changed --really-refresh
      +'
      +
     -+test_expect_success '--refresh should fix racy timestamp even if needs update' '
     ++test_expect_success '--refresh should fix racy timestamp if other file needs update' '
     ++	reset_files &&
     ++	echo content2 >other &&
     ++	test-tool chmtime =1234567890 other &&
     ++	update_assert_changed --refresh
     ++'
     ++
     ++test_expect_success '--refresh should fix racy timestamp if racy file needs update' '
     ++	reset_files &&
      +	echo content2 >file &&
     -+	reset_mtime file &&
     -+	reset_mtime .git/index &&
     ++	test-tool chmtime =1234567890 file &&
      +	update_assert_changed --refresh
      +'
      +

-- 
gitgitgadget
