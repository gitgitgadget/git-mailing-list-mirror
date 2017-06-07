Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4B01FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 16:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdFGQGV (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 12:06:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:49728 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbdFGQGR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 12:06:17 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYOkT-1dNMXj2daj-00VCos; Wed, 07
 Jun 2017 18:06:02 +0200
Date:   Wed, 7 Jun 2017 18:06:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/9] Avoid problem where git_dir is set after alias
 expansion
Message-ID: <cover.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RXWrSg8FZf6ZRFBf0BQedZ2Df6ff54hxezytLritZ5ycEnWAKlI
 6O3Xro2U4L7UBfs84LQ59lg/RcNiVeu64ZQEgcErmRJHCjf0WLOahiGqbYI8Q76VdzmfolS
 K9WTPTQi2RPw9W8uet5T3rfCUEXWARCyAAI8YNiSG3Fg5r2ErD9dLCQQQSvfnJuhbYWvG8q
 AX0Hg5Q/cesWEcZHSd0XA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rJ8QVXaRPbk=:xRLRqQaKYQOeLrP0LwsR7b
 pRXksWfdNiAZBoniM724CH3at5Y4+991tW7xNBuD/SbXmyfGUl2dvA6a5+Sv+yhVvG4D10QF9
 gRwnTG1nWJDLSsw7Ai6WXNitKWkB6n9+qUBER4w1DfgXeBLsk8uKoI0/l+4JI0Fb/MVptW5wC
 yk8xTjqTxTDY/XQI9t/8zRgwVnwe/Z2m0dePiIh5fKKpz5HJ6J+2YHK1lCWuZRzeoSQSArs74
 RS4/LbVl/anEKcjp3cmoEE1aOg3ebsFo+uqWQVtVXWtg0mVuxFyPY9z3AxseN92+dFPyqGtTc
 R/Ewn4VpR89jvkdGJi7Y8wyE0L5NnX4LpkXFRM5iaJwxuTfuM9NFmlV/e5rQ0LAlnAZ8O6FgA
 laDZ9IyYwegA2gu9aiQ3GAEHjKD8mCjuVLqVWHFnVHrwcJjkqbvJIYNZ9Hzymdk4YJajH128s
 RV4xMRD0psEytEY4LCihCv2Ze6UyqiTa6FGpEGaG8Z7cYzC8kB2mRVsAaP18W1WSqs6TFDlwO
 4nMNLmaJr0EhwEzhiNu36Eqs9mFfHdVLQf0+rg8SXs/Bb8mhGNm3TDu1g+Xsm4MKz3/wUliaK
 UiHbML8qTOkcxqPBkIk8/7PX3ryv8qA6X00+VBPZpPvS8EfqEsLy8KQQ1mkthCq+tuIPqPUbY
 wZLTZFJ9jBJfPOPweVcVzcFTUJ5GtVkBXRNKca9yj1M41qKQoWpLv3bHborc3QO7TpCl96ZnH
 3ocfVk01bysEk5Jj0dpkvglLWN9A2nqZofoJUC4iuQ0HwZaPpTbClEplT70q08O6/FjsaHZ3d
 OfG9TX7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When expanding an alias in a subdirectory, we setup the git_dir
(gently), read the config, and then restore the "env" (e.g. the current
working directory) so that the command specified by the alias can run
correctly.

What we failed to reset was the git_dir, meaning that in the most common
case, it was now pointing to a .git/ directory *in the subdirectory*.

This problem was identified in the GVFS fork, where a pre-command hook
was introduced to allow pre-fetching missing blobs.

An early quick fix in the GVFS fork simply built on top of the
save_env_before_alias() hack, introducing another hack that saves the
git_dir and restores it after an alias is expanded:

	https://github.com/Microsoft/git/commit/2d859ba3b

That is very hacky, though, and it is much better (although much more
involved, too) to fix this "properly", i.e. by replacing the ugly
save/restore logic by simply using the early config code path.

However, aliases are strange beasts.

When an alias refers to a single Git command (originally the sole
intention of aliases), the current working directory is restored to what
it had been before expanding the alias.

But when an alias starts with an exclamation point, i.e. referring to a
command-line to be interpreted by the shell, the current working
directory is no longer in the subdirectory but instead in the worktree's
top-level directory.

This is even true for worktrees added by `git worktree add`.

But when we are inside the .git/ directory, the current working
directory is *restored* to the subdirectory inside the .git/ directory.

In short, the logic is a bit complicated what is the expected current
working directory after expanding an alias and before actually running
it.

That is why this patch series had to expand the signature of the early
config machinery to return the additional information for aliases'
benefit.


Johannes Schindelin (9):
  discover_git_directory(): avoid setting invalid git_dir
  config: report correct line number upon error
  help: use early config when autocorrecting aliases
  read_early_config(): optionally return the worktree's top-level
    directory
  t1308: relax the test verifying that empty alias values are disallowed
  t7006: demonstrate a problem with aliases in subdirectories
  alias_lookup(): optionally return top-level directory
  Use the early config machinery to expand aliases
  TODO:

 alias.c                | 33 +++++++++++++++++++++-------
 builtin/help.c         |  2 +-
 cache.h                |  7 +++---
 config.c               |  7 +++---
 git.c                  | 59 ++++++--------------------------------------------
 help.c                 |  2 +-
 pager.c                |  4 ++--
 setup.c                | 13 +++++++++--
 t/helper/test-config.c |  2 +-
 t/t1308-config-set.sh  |  4 +++-
 t/t7006-pager.sh       | 11 ++++++++++
 11 files changed, 70 insertions(+), 74 deletions(-)


base-commit: 8d1b10321b20bd2a73a5b561cfc3cf2e8051b70b
Published-As: https://github.com/dscho/git/releases/tag/alias-early-config-v1
Fetch-It-Via: git fetch https://github.com/dscho/git alias-early-config-v1
-- 
2.13.0.windows.1.460.g13f583bedb5

