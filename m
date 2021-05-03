Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B4BC433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF1D7611C9
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhECUnU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 16:43:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:43502 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhECUnT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 16:43:19 -0400
Received: (qmail 7513 invoked by uid 109); 3 May 2021 20:42:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 20:42:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7397 invoked by uid 111); 3 May 2021 20:42:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 16:42:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 16:42:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/9] leftover bits from symlinked gitattributes, etc topics
Message-ID: <YJBgMP9eXq31INyN@coredump.intra.peff.net>
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 01, 2021 at 11:40:52AM -0400, Jeff King wrote:

> A while back, I had a topic[1] that treated symlinked .gitattributes
> (and .gitignore and .mailmap) the same as .gitmodules: forbidding them
> in the index, complaining about them via fsck, etc.
> 
> In the end, we decided not to do that[2], and instead just open the
> files with O_NOFOLLOW instead. As I said in that thread, we could
> salvage some of the cleanups, fsck checks, and docs from the original
> topic. So here that is. (The new topic is in master but not yet
> released; so while this is not strictly a bug-fix for an existing topic,
> it would be good to get especially the doc improvements into the same
> release).

Here's a re-roll with two small fixes: dropping the test_i18ngrep that
Ævar noticed, and taking Eric's wording suggestion for the docs.

I didn't take Ævar's suggestion to expand the line-wrapping fixes
further. I don't mind that happening, but I'd prefer doing it as a
separate series.

Range-diff (a little hard to read because the one-line change in the
tests percolates through several commits, and the two-word changes in
the docs caused rewrapping):

 1:  c91ce2ed34 =  1:  c91ce2ed34 t7415: remove out-dated comment about translation
 2:  99fe934110 =  2:  99fe934110 fsck_tree(): fix shadowed variable
 3:  9695e4370c =  3:  9695e4370c fsck_tree(): wrap some long lines
 4:  2cf9839145 =  4:  2cf9839145 t7415: rename to expand scope
 5:  ad18686096 !  5:  1664953e71 t7450: test verify_path() handling of gitmodules
    @@ t/t7450-bad-git-dotfiles.sh: test_expect_success 'fsck detects symlinked .gitmod
      
     +test_expect_success 'refuse to load symlinked .gitmodules into index' '
     +	test_must_fail git -C symlink read-tree $tree 2>err &&
    -+	test_i18ngrep "invalid path.*gitmodules" err &&
    ++	grep "invalid path.*gitmodules" err &&
     +	git -C symlink ls-files >out &&
     +	test_must_be_empty out
     +'
 6:  9691fb8d5c !  6:  41000ce022 t7450: test .gitmodules symlink matching against obscured names
    @@ t/t7450-bad-git-dotfiles.sh: test_expect_success 'index-pack --strict works for
     -
     -test_expect_success 'refuse to load symlinked .gitmodules into index' '
     -	test_must_fail git -C symlink read-tree $tree 2>err &&
    --	test_i18ngrep "invalid path.*gitmodules" err &&
    +-	grep "invalid path.*gitmodules" err &&
     -	git -C symlink ls-files >out &&
     -	test_must_be_empty out
     -'
    @@ t/t7450-bad-git-dotfiles.sh: test_expect_success 'index-pack --strict works for
     +			    -c core.protectntfs \
     +			    -c core.protecthfs \
     +			    read-tree $tree 2>err &&
    -+		test_i18ngrep "invalid path.*$name" err &&
    ++		grep "invalid path.*$name" err &&
     +		git -C $dir ls-files -s >out &&
     +		test_must_be_empty out
     +	'
 7:  670705dca2 =  7:  58efbbbbb6 t0060: test ntfs/hfs-obscured dotfiles
 8:  422162a7ae =  8:  aeff66bf1e fsck: warn about symlinked dotfiles we'll open with O_NOFOLLOW
 9:  f1b226ca4f !  9:  a8f9255d9b docs: document symlink restrictions for dot-files
    @@ Documentation/gitattributes.txt: to:
     +NOTES
     +-----
     +
    -+Note that Git does not follow symbolic links when accessing a
    -+`.gitattributes` file in the working tree. This keeps behavior
    -+consistent when the file is accessed from the index or a tree versus
    -+from the filesystem.
    ++Git does not follow symbolic links when accessing a `.gitattributes`
    ++file in the working tree. This keeps behavior consistent when the file
    ++is accessed from the index or a tree versus from the filesystem.
      
      EXAMPLES
      --------
    @@ Documentation/gitignore.txt: not tracked by Git remain untracked.
      To stop tracking a file that is currently tracked, use
      'git rm --cached'.
      
    -+Note that Git does not follow symbolic links when accessing a
    -+`.gitignore` file in the working tree. This keeps behavior consistent
    -+when the file is accessed from the index or a tree versus from the
    -+filesystem.
    ++Git does not follow symbolic links when accessing a `.gitignore` file in
    ++the working tree. This keeps behavior consistent when the file is
    ++accessed from the index or a tree versus from the filesystem.
     +
      EXAMPLES
      --------
    @@ Documentation/gitmailmap.txt: this would also match the 'Commit Name <commit&#64
     +NOTES
     +-----
     +
    -+Note that Git does not follow symbolic links when accessing a `.mailmap`
    -+file in the working tree. This keeps behavior consistent when the file
    -+is accessed from the index or a tree versus from the filesystem.
    ++Git does not follow symbolic links when accessing a `.mailmap` file in
    ++the working tree. This keeps behavior consistent when the file is
    ++accessed from the index or a tree versus from the filesystem.
     +
      EXAMPLES
      --------
    @@ Documentation/gitmodules.txt: submodule.<name>.shallow::
     +NOTES
     +-----
     +
    -+Note that Git does not allow the `.gitmodules` file within a working
    -+tree to be a symbolic link, and will refuse to check out such a tree
    -+entry. This keeps behavior consistent when the file is accessed from the
    -+index or a tree versus from the filesystem, and helps Git reliably
    -+enforce security checks of the file contents.
    ++Git does not allow the `.gitmodules` file within a working tree to be a
    ++symbolic link, and will refuse to check out such a tree entry. This
    ++keeps behavior consistent when the file is accessed from the index or a
    ++tree versus from the filesystem, and helps Git reliably enforce security
    ++checks of the file contents.
      
      EXAMPLES
      --------

  [1/9]: t7415: remove out-dated comment about translation
  [2/9]: fsck_tree(): fix shadowed variable
  [3/9]: fsck_tree(): wrap some long lines
  [4/9]: t7415: rename to expand scope
  [5/9]: t7450: test verify_path() handling of gitmodules
  [6/9]: t7450: test .gitmodules symlink matching against obscured names
  [7/9]: t0060: test ntfs/hfs-obscured dotfiles
  [8/9]: fsck: warn about symlinked dotfiles we'll open with O_NOFOLLOW
  [9/9]: docs: document symlink restrictions for dot-files

 Documentation/gitattributes.txt               |   6 +
 Documentation/gitignore.txt                   |   4 +
 Documentation/gitmailmap.txt                  |   7 ++
 Documentation/gitmodules.txt                  |   8 ++
 cache.h                                       |   1 +
 fsck.c                                        |  84 ++++++++++---
 fsck.h                                        |   3 +
 path.c                                        |   5 +
 t/helper/test-path-utils.c                    |  46 +++++--
 t/t0060-path-utils.sh                         |  30 +++++
 ...ule-names.sh => t7450-bad-git-dotfiles.sh} | 116 +++++++++++++-----
 utf8.c                                        |   5 +
 utf8.h                                        |   1 +
 13 files changed, 255 insertions(+), 61 deletions(-)
 rename t/{t7415-submodule-names.sh => t7450-bad-git-dotfiles.sh} (70%)

-Peff
