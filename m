Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFB0C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B8F6128B
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhDWTnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:43:16 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:35072 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhDWTnP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:43:15 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 2F5F080590;
        Fri, 23 Apr 2021 15:42:34 -0400 (EDT)
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
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH 00/30] subtree: clean up, improve UX
Date:   Fri, 23 Apr 2021 13:42:00 -0600
Message-Id: <20210423194230.1388945-1-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

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

As a final question, would it be all right to amend CI to run the
subtree tests?  And if so, what would be the best way to do it?  For
my own testing, I just made the following edit to the main Makefile,
but I'm not sure it's the mos appropriate approach:

    --- a/Makefile
    +++ b/Makefile
    @@ -2836,6 +2836,7 @@
     
     test: all
            $(MAKE) -C t/ all
    +       $(MAKE) -C contrib/subtree/ test
     
     perf: all
            $(MAKE) -C t/perf/ all

The first two commits are about getting that to pass.  I'd prefer to
avoid that type of bitrot in the future.

Luke Shumaker (30):
  .gitignore: Ignore /git-subtree
  subtree: t7900: update for having the default branch name be 'main'
  subtree: t7900: use test-lib.sh's test_count
  subtree: t7900: use consistent formatting
  subtree: t7900: comment subtree_test_create_repo
  subtree: t7900: use 'test' for string equality
  subtree: t7900: delete some dead code
  subtree: t7900: fix 'verify one file change per commit'
  subtree: t7900: rename last_commit_message to last_commit_subject
  subtree: t7900: add a test for the -h flag
  subtree: t7900: add porcelain tests for 'pull' and 'push'
  subtree: don't have loose code outside of a function
  subtree: more consistent error propagation
  subtree: drop support for git < 1.7
  subtree: use `git merge-base --is-ancestor`
  subtree: use git-sh-setup's `say`
  subtree: use more explicit variable names for cmdline args
  subtree: use $* instead of $@ as appropriate
  subtree: give `$(git --exec-path)` precedence over `$PATH`
  subtree: use "^{commit}" instead of "^0"
  subtree: parse revs in individual cmd_ functions
  subtree: remove duplicate check
  subtree: add comments and sanity checks
  subtree: don't let debug and progress output clash
  subtree: have $indent actually affect indentation
  subtree: give the docs a once-over
  subtree: allow --squash to be used with --rejoin
  subtree: allow 'split' flags to be passed to 'push'
  subtree: push: allow specifying a local rev other than HEAD
  subtree: be stricter about validating flags

 .gitignore                         |    1 +
 contrib/subtree/git-subtree.sh     |  613 +++++++-----
 contrib/subtree/git-subtree.txt    |  184 ++--
 contrib/subtree/t/t7900-subtree.sh | 1421 ++++++++++++++++++----------
 4 files changed, 1363 insertions(+), 856 deletions(-)

-- 
2.31.1

Happy hacking,
~ Luke Shumaker
