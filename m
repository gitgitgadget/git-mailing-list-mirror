Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57113C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08838613B1
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhD0VTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 17:19:02 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:41370 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235440AbhD0VTB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 17:19:01 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 9D98780590;
        Tue, 27 Apr 2021 17:18:14 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v3 00/30] subtree: clean up, improve UX
Date:   Tue, 27 Apr 2021 15:17:18 -0600
Message-Id: <20210427211748.2607474-1-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174525.3937858-1-lukeshu@lukeshu.com>
References: <20210426174525.3937858-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

The diff between v1 and v2 is largely stylistic.  The only
non-stylistic changes are fixing the tests to use `test_must_fail`
instead of `!`, and re-thinking the commit about fussing with PATH.

The diff between v2 and v3 contains a few stylistic changes, but the
meat of it is that it fixes a bug with `--squash` and `--rejoin` being
used together, and that it fixes a mistake in the man page.

Ostensibly, this patch set is about improving various aspects of `git
subtree`'s user interface (and it is!), but it's also mostly about
setting the foundation and being "batch 1" of a bunch more changes to
subtree that I'm getting queued up.  So please forgive the large
amount of churn in the leading clean-up commits, I promise that
there's more work coming on top of it (we've discovered lots of ways
to break the "subtree split" algorithm, and come up with fixes for
most of them).  In the mean-time, I do think that the UX improvements
in this patchset are already worth it themselves.

 - The first 11 commits improve subtree's tests, largely around the
   code-quality of the tests, but a few of the commits do actually
   improve what's being tested.

 - The middle 12 commits improve the code-quality of subtree's
   implementation.

 - The final 7 commits improve various aspects of subtree's user
   experience, from readability of the debug output, to documentation,
   to option flag handling.

The very last commit is likely to be a little objectionable--it makes
some option flag parsing more strict, so there will probably be worry
that the change breaks existing users.  However, it's being strict
about arg combinations that were always invalid, the difference is
that now it reports that to the users and bails.  Those users were
already broken, they just didn't know it.  `git subtree` should tell
them.

Luke Shumaker (30):
  .gitignore: Ignore /git-subtree
  subtree: t7900: update for having the default branch name be 'main'
  subtree: t7900: use test-lib.sh's test_count
  subtree: t7900: use consistent formatting
    v2:
     - Also normalize on `test X` instead of `[ X ]`.
     - Also normalize on `>FILENAME` with no spaces.
     - Fix a few if statements with `if` and `then` on the same line
       that I missed in v1.
    v3:
     - Consistently put the `do` of a loop on its own line.
  subtree: t7900: comment subtree_test_create_repo
    v2:
     - Also switch the few uses of vanilla test_create_repo over to
       subtree_test_create_repo.  In v1 this was erroneously included
       in a different commit.
  subtree: t7900: use 'test' for string equality
  subtree: t7900: delete some dead code
  subtree: t7900: fix 'verify one file change per commit'
    v2:
     - Fix whitespace.
  subtree: t7900: rename last_commit_message to last_commit_subject
  subtree: t7900: add a test for the -h flag
  subtree: t7900: add porcelain tests for 'pull' and 'push'
    v2:
     - Don't switch unrelated uses of vanilla test_create_repo over to
       subtree_test_create_repo; this has been moved to happen in an
       earlier commit.
     - Fix whitespace.
  subtree: don't have loose code outside of a function
    v2:
     - Include rationale in the the commit message.
  subtree: more consistent error propagation
  subtree: drop support for git < 1.7
    v2:
     - Include rationale in the the commit message.
  subtree: use `git merge-base --is-ancestor`
  subtree: use git-sh-setup's `say`
  subtree: use more explicit variable names for cmdline args
  subtree: use "$*" instead of "$@" as appropriate
    v2:
     - Improve the commit message with quoting and clearer
       explanation.
  subtree: don't fuss with PATH
    v2:
     - This commit changed entirely.  In v1 it changed how git-subtree
       adjusts the PATH.  In v2, it removes any fussing with the PATH,
       and in its place adds a pre-flight sanity check that it doesn't
       need to fuss with the PATH.
    v3:
     - Fix capitalization in the commit message.
  subtree: use "^{commit}" instead of "^0"
  subtree: parse revs in individual cmd_ functions
  subtree: remove duplicate check
  subtree: add comments and sanity checks
    v2:
     - Expand on the the commit message.
     - Fix capitalization in one of the comments.
  subtree: don't let debug and progress output clash
    v2:
     - Reword the commit message to be clearer.
     - Add comments to the code.
     - Flip the `if` and `else` cases around, so that the comments
       read better.
  subtree: have $indent actually affect indentation
  subtree: give the docs a once-over
    v2:
     - behaviour -> behavior
    v3:
     - Trim trailing whitespace.
     - Fix the man page saying "--ignore-join" instead of "--ignore-joins".
  subtree: allow --squash to be used with --rejoin
    v2:
     - In the added tests, use `test_must_fail` instead of `!`, as
       appropriate.
    v3:
     - Style: Put the `then` of an `if/then` on its own line.
     - Fix a bug (and add a test) where the resulting commits confuse a
       subsequent `git subtree merge --squash`.
  subtree: allow 'split' flags to be passed to 'push'
    v2:
     - In the added tests, use `test_must_fail` instead of `!`, as
       appropriate.
  subtree: push: allow specifying a local rev other than HEAD
  subtree: be stricter about validating flags

 .gitignore                         |    1 +
 contrib/subtree/git-subtree.sh     |  642 +++++++-----
 contrib/subtree/git-subtree.txt    |  192 ++--
 contrib/subtree/t/t7900-subtree.sh | 1450 ++++++++++++++++++----------
 contrib/subtree/todo               |    6 +-
 5 files changed, 1425 insertions(+), 866 deletions(-)

-- 
2.31.1

Happy hacking,
~ Luke Shumaker
