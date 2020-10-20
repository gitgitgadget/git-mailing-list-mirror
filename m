Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA234C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 23:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACB3223BF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 23:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439277AbgJTXTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 19:19:32 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:22077 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410559AbgJTXTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 19:19:31 -0400
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kV0uc-000AbW-3c; Wed, 21 Oct 2020 00:19:27 +0100
Subject: Re: [PATCH v2 0/8] forbidding symlinked .gitattributes and .gitignore
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005121609.GA2907272@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <6c0a0036-e217-a334-2a74-dd59a4592c1f@iee.email>
Date:   Wed, 21 Oct 2020 00:19:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201005121609.GA2907272@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A rather late comment,

On 05/10/2020 13:16, Jeff King wrote:
> On Mon, Oct 05, 2020 at 03:17:51AM -0400, Jeff King wrote:
>
>> About 2 years ago as part of a security release we made it illegal to
>> have a symlinked .gitmodules file (refusing it both in the index and via
>> fsck). At the time we discussed (on the security list) outlawing
>> symlinks for other .git files in the same way, but we decided not to do
>> so as part of the security release, as it wasn't strictly necessary.

Is this something that should be recorded in the documentation, either as a
simple (sensible) limitation, or explicitly as a security related safety
measure?

I didn't see any changes to the .txt docs in the change list below.

Philip
>>
>> We publicly revisited the topic in:
>>
>>   https://lore.kernel.org/git/20190114230902.GG162110@google.com/
>>
>> but there were a few fixes needed, and it got forgotten. So here it is
>> again, with those fixes:
>> [...]
> And here's a v2 incorporating feedback from Jonathan. There are no
> substantial changes in the code. Most of the fixes are cosmetic, but the
> tests are beefed up a bit, as well:
>
>  - we now test that ntfs and hfs names are matched via fsck and
>    verify_path() for all file types. The bulk of this is in a new patch
>    5, and the final patches are adjusted to use the new helper.
>
>  - we confirm that read-tree doesn't write the forbidden entry into the
>    index (in addition to seeing that it complains)
>
>  - the test script name is now "bad-dotgitx" instead of the vague
>    "bad-meta-files"
>
>  - whitespace, typo-fixes, clarity, etc; the range diff is below
>
>   [1/8]: fsck_tree(): fix shadowed variable
>   [2/8]: fsck_tree(): wrap some long lines
>   [3/8]: t7415: rename to expand scope
>   [4/8]: t7450: test verify_path() handling of gitmodules
>   [5/8]: t7450: test .gitmodules symlink matching against obscured names
>   [6/8]: t0060: test obscured .gitattributes and .gitignore matching
>   [7/8]: verify_path(): disallow symlinks in .gitattributes and .gitignore
>   [8/8]: fsck: complain when .gitattributes or .gitignore is a symlink
>
>  fsck.c                                        | 79 +++++++++++----
>  read-cache.c                                  | 12 ++-
>  t/helper/test-path-utils.c                    | 41 +++++---
>  t/t0060-path-utils.sh                         | 20 ++++
>  ...le-names.sh => t7450-bad-dotgitx-files.sh} | 99 +++++++++++++------
>  5 files changed, 187 insertions(+), 64 deletions(-)
>  rename t/{t7415-submodule-names.sh => t7450-bad-dotgitx-files.sh} (73%)
>
> 1:  d4c4b98188 ! 1:  78689a44ba fsck_tree(): fix shadowed variable
>     @@ Commit message
>      
>          Let's rename both variables in the function to avoid confusion. This
>          makes the diff a little noisy (e.g., all of the report() calls outside
>     -    the loop wee already correct but need touched), but makes sure we catch
>     -    all cases and will avoid similar confusion in the future.
>     +    the loop were already correct but need to be touched), but makes sure we
>     +    catch all cases and will avoid similar confusion in the future.
>     +
>     +    Note that our test change removes the comment about translation. It was
>     +    arguably confusing since 674ba34038 (fsck: mark strings for translation,
>     +    2018-11-10); we wouldn't translate gitmodulesSymlink, but it did get
>     +    removed by GETTEXT_POISON because that feature eats embedded
>     +    %s characters. But certainly after this patch, when we look for the
>     +    "tree %s: %s" format, we could get foiled by translation.
>      
>          Signed-off-by: Jeff King <peff@peff.net>
>      
>     @@ t/t7415-submodule-names.sh: test_expect_success 'fsck detects symlinked .gitmodu
>      +		tree=$(git mktree <bad-tree) &&
>       
>       		# Check not only that we fail, but that it is due to the
>     - 		# symlink detector; this grep string comes from the config
>     - 		# variable name and will not be translated.
>     +-		# symlink detector; this grep string comes from the config
>     +-		# variable name and will not be translated.
>     ++		# symlink detector
>       		test_must_fail git fsck 2>output &&
>      -		test_i18ngrep gitmodulesSymlink output
>      +		test_i18ngrep "tree $tree: gitmodulesSymlink" output
> 2:  29d0d3af44 = 2:  b1f7ec465c fsck_tree(): wrap some long lines
> 3:  8679f0b2f2 ! 3:  d26ef683fd t7415: rename to expand scope
>     @@ Commit message
>      
>          Signed-off-by: Jeff King <peff@peff.net>
>      
>     - ## t/t7415-submodule-names.sh => t/t7450-bad-meta-files.sh ##
>     + ## t/t7415-submodule-names.sh => t/t7450-bad-dotgitx-files.sh ##
>      @@
>       #!/bin/sh
>       
> 4:  84e58f7f46 ! 4:  493a4c79a3 t7450: test verify_path() handling of gitmodules
>     @@ Commit message
>      
>          Signed-off-by: Jeff King <peff@peff.net>
>      
>     - ## t/t7450-bad-meta-files.sh ##
>     -@@ t/t7450-bad-meta-files.sh: test_expect_success 'index-pack --strict works for non-repo pack' '
>     + ## t/t7450-bad-dotgitx-files.sh ##
>     +@@ t/t7450-bad-dotgitx-files.sh: test_expect_success 'index-pack --strict works for non-repo pack' '
>       	grep gitmodulesName output
>       '
>       
>      -test_expect_success 'fsck detects symlinked .gitmodules file' '
>     -+test_expect_success 'create repo with symlinked .gitmodules file' '
>     ++test_expect_success 'set up repo with symlinked .gitmodules file' '
>       	git init symlink &&
>       	(
>       		cd symlink &&
>     -@@ t/t7450-bad-meta-files.sh: test_expect_success 'fsck detects symlinked .gitmodules file' '
>     +@@ t/t7450-bad-dotgitx-files.sh: test_expect_success 'fsck detects symlinked .gitmodules file' '
>       		{
>       			printf "100644 blob $content\t$tricky\n" &&
>       			printf "120000 blob $target\t.gitmodules\n"
>     @@ t/t7450-bad-meta-files.sh: test_expect_success 'fsck detects symlinked .gitmodul
>      +		cd symlink &&
>       
>       		# Check not only that we fail, but that it is due to the
>     - 		# symlink detector; this grep string comes from the config
>     -@@ t/t7450-bad-meta-files.sh: test_expect_success 'fsck detects symlinked .gitmodules file' '
>     + 		# symlink detector
>     +@@ t/t7450-bad-dotgitx-files.sh: test_expect_success 'fsck detects symlinked .gitmodules file' '
>       	)
>       '
>       
>     -+test_expect_success 'refuse to load symlinked .gitmodule into index' '
>     ++test_expect_success 'refuse to load symlinked .gitmodules into index' '
>      +	test_must_fail git -C symlink read-tree $tree 2>err &&
>     -+	test_i18ngrep "invalid path.*gitmodules" err
>     ++	test_i18ngrep "invalid path.*gitmodules" err &&
>     ++	git -C symlink ls-files >out &&
>     ++	test_must_be_empty out
>      +'
>      +
>       test_expect_success 'fsck detects non-blob .gitmodules' '
> -:  ---------- > 5:  db5e78ff5b t7450: test .gitmodules symlink matching against obscured names
> 5:  e141e49a5b ! 6:  b5962a75a4 t0060: test obscured .gitattributes and .gitignore matching
>     @@ t/helper/test-path-utils.c: static struct test_data dirname_data[] = {
>      +		if (!strcmp("--not", *argv))
>      +			expect = !expect;
>      +		else if (expect != (is_hfs(*argv) || is_ntfs(*argv)))
>     -+			 res = error("'%s' is %s.%s", *argv,
>     -+				     expect ? "not " : "", x);
>     ++			res = error("'%s' is %s.git%s", *argv,
>     ++				    expect ? "not " : "", x);
>      +		else
>     -+			fprintf(stderr, "ok: '%s' is %s.%s\n",
>     ++			fprintf(stderr, "ok: '%s' is %s.git%s\n",
>      +				*argv, expect ? "" : "not ", x);
>      +	}
>      +	return !!res;
>     @@ t/helper/test-path-utils.c: int cmd__path_utils(int argc, const char **argv)
>      -				fprintf(stderr, "ok: '%s' is %s.gitmodules\n",
>      -					argv[i], expect ? "" : "not ");
>      -		return !!res;
>     -+		return check_dotgitx("gitmodules", argv + 2,
>     ++		return check_dotgitx("modules", argv + 2,
>      +				     is_hfs_dotgitmodules,
>      +				     is_ntfs_dotgitmodules);
>      +	}
>      +	if (argc > 2 && !strcmp(argv[1], "is_dotgitignore")) {
>     -+		return check_dotgitx("gitignore", argv + 2,
>     ++		return check_dotgitx("ignore", argv + 2,
>      +				     is_hfs_dotgitignore,
>      +				     is_ntfs_dotgitignore);
>      +	}
>      +	if (argc > 2 && !strcmp(argv[1], "is_dotgitattributes")) {
>     -+		return check_dotgitx("gitattributes", argv + 2,
>     ++		return check_dotgitx("attributes", argv + 2,
>      +				     is_hfs_dotgitattributes,
>      +				     is_ntfs_dotgitattributes);
>       	}
> 6:  d214bbd8ec ! 7:  e4ec698a5b verify_path(): disallow symlinks in .gitattributes and .gitignore
>     @@ Commit message
>          0fc333ba20 (is_hfs_dotgit: match other .git files, 2018-05-02), which
>          were done as part of the series touching .gitmodules.
>      
>     +    No tests yet, as we'll add them in a subsequent patch once we have fsck
>     +    support, too.
>     +
>          Signed-off-by: Jeff King <peff@peff.net>
>      
>       ## read-cache.c ##
>     @@ read-cache.c: int verify_path(const char *path, unsigned mode)
>       						return 0;
>       				}
>       			}
>     -
>     - ## t/t7450-bad-meta-files.sh ##
>     -@@ t/t7450-bad-meta-files.sh: test_expect_success 'git dirs of sibling submodules must not be nested' '
>     - 	test_i18ngrep "is inside git dir" err
>     - '
>     - 
>     -+test_expect_success 'create repo with symlinked .gitattributes file' '
>     -+	git init symlink-attr &&
>     -+	target=$(echo target | git -C symlink-attr hash-object -w --stdin) &&
>     -+	tree=$(
>     -+		printf "120000 blob $target\t.gitattributes\n" |
>     -+		git -C symlink-attr mktree
>     -+	)
>     -+'
>     -+
>     -+test_expect_success 'refuse to load symlinked .gitattributes into index' '
>     -+	test_must_fail git -C symlink-attr read-tree $tree 2>err &&
>     -+	test_i18ngrep "invalid path.*gitattributes" err
>     -+'
>     -+
>     -+test_expect_success 'create repo with symlinked .gitignore file' '
>     -+	git init symlink-ignore &&
>     -+	target=$(echo target | git -C symlink-ignore hash-object -w --stdin) &&
>     -+	tree=$(
>     -+		printf "120000 blob $target\t.gitignore\n" |
>     -+		git -C symlink-ignore mktree
>     -+	)
>     -+'
>     -+
>     -+test_expect_success 'refuse to load symlinked .gitignore into index' '
>     -+	test_must_fail git -C symlink-ignore read-tree $tree 2>err &&
>     -+	test_i18ngrep "invalid path.*gitignore" err
>     -+'
>     -+
>     -+
>     - test_done
> 7:  49423d03b5 ! 8:  58c9ce0f3c fsck: complain when .gitattributes or .gitignore is a symlink
>     @@ Commit message
>          check to fsck, which matches how we handle .gitmodules symlinks, via
>          b7b1fca175 (fsck: complain when .gitmodules is a symlink, 2018-05-04).
>      
>     -    Note that we won't add these to the existing gitmodules block. Its logic
>     -    is a bit more complicated, as we also check the content of non-symlink
>     -    instances we find. But for these new files, there is no content check;
>     -    we're just looking at the name and mode of the tree entry (and we can
>     -    avoid even the complicated name checks in the common case that the mode
>     -    doesn't indicate a symlink).
>     +    Note that we won't add these to the existing gitmodules block. The logic
>     +    for gitmodules is a bit more complicated, as we also check the content
>     +    of non-symlink instances we find. But for these new files, there is no
>     +    content check; we're just looking at the name and mode of the tree entry
>     +    (and we can avoid even the complicated name checks in the common case
>     +    that the mode doesn't indicate a symlink).
>     +
>     +    We can reuse the test helper function we defined for .gitmodules,
>     +    though (and this covers the verify_path() change from the previous
>     +    commit, as well).
>      
>          Signed-off-by: Jeff King <peff@peff.net>
>      
>     @@ fsck.c: static int fsck_tree(const struct object_id *tree_oid,
>       			while (backslash) {
>       				backslash++;
>      
>     - ## t/t7450-bad-meta-files.sh ##
>     -@@ t/t7450-bad-meta-files.sh: test_expect_success 'refuse to load symlinked .gitattributes into index' '
>     - 	test_i18ngrep "invalid path.*gitattributes" err
>     - '
>     + ## t/t7450-bad-dotgitx-files.sh ##
>     +@@ t/t7450-bad-dotgitx-files.sh: check_forbidden_symlink gitmodules vanilla .gitmodules
>     + check_forbidden_symlink gitmodules ntfs ".gitmodules ."
>     + check_forbidden_symlink gitmodules hfs ".${u200c}gitmodules"
>       
>     -+test_expect_success 'fsck detects symlinked .gitattributes file' '
>     -+	test_must_fail git -C symlink-attr fsck 2>err &&
>     -+	test_i18ngrep "tree $tree: gitattributesSymlink" err
>     -+'
>     ++check_forbidden_symlink gitattributes vanilla .gitattributes
>     ++check_forbidden_symlink gitattributes ntfs ".gitattributes ."
>     ++check_forbidden_symlink gitattributes hfs ".${u200c}gitattributes"
>      +
>     - test_expect_success 'create repo with symlinked .gitignore file' '
>     - 	git init symlink-ignore &&
>     - 	target=$(echo target | git -C symlink-ignore hash-object -w --stdin) &&
>     -@@ t/t7450-bad-meta-files.sh: test_expect_success 'refuse to load symlinked .gitignore into index' '
>     - 	test_i18ngrep "invalid path.*gitignore" err
>     - '
>     - 
>     -+test_expect_success 'fsck detects symlinked .gitignore file' '
>     -+	test_must_fail git -C symlink-ignore fsck 2>err &&
>     -+	test_i18ngrep "tree $tree: gitignoreSymlink" err
>     -+'
>     - 
>     - test_done
>     ++check_forbidden_symlink gitignore vanilla .gitignore
>     ++check_forbidden_symlink gitignore ntfs ".gitignore ."
>     ++check_forbidden_symlink gitignore hfs ".${u200c}gitignore"
>     ++
>     + test_expect_success 'fsck detects non-blob .gitmodules' '
>     + 	git init non-blob &&
>     + 	(

