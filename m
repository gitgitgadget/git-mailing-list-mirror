Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ADB61FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 12:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbdFMME3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 08:04:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:51211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752078AbdFMME2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 08:04:28 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZkNy-1dYR7i01Py-00LSlh; Tue, 13
 Jun 2017 14:04:20 +0200
Date:   Tue, 13 Jun 2017 14:04:18 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 0/6] Avoid problem where git_dir is set after alias
 expansion
Message-ID: <cover.1497355444.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BHKoyqtoKuxSi5SMEVXOJAi7eqmCmz4y8Niv1b0zdO5L1S72lVE
 TolPGf6xSKvncYnV+0CrCJn0pDdaPhAW0l1WnfGbgC/PQM0Y52qUlVaqp+tXhVhXad7iLoZ
 jvFW8vGdRYBK1uLDvBza2y+BHCHD6oscYEon92+yHgBhyUFAATKdClNNxg5eZSf5VEGEYfB
 sceXg+2cCzs/muR2gvaUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RYkMlOdI/Ts=:NSiYe4g9IECRnL5W21NUBc
 PtnMO3CC0RseuEFnaBhIjH8FS/7r3jYh/xSnhJYDpiNWtu3wU+vWajRfd2yQknrthapDKkAxM
 eqK4rzYdhlGYQPBsJMDkW7dQBzcmYTImgUnGRcKxuy78fks7beQWeepRHv9xGPTryH/V3Ee50
 VMctzcTtFHtUwgW7alnp4ATAmAzhgo3jlS7Z78VCVJafWVxxyBtrZPpTRkQgCGjgxRogIwhdh
 0qNKK+Mbk6vvZatYHsdWGvRNGj7u96cmnJdbxQ8BmuB2qVaOZe1BamjCi5yr4vKgNSGXa8vMd
 Uv+A2v63diKQX63ma0xsQNK7DvbNalhfDWmyUXAba0xCcrhFHAk2nApRSTaG0eRTt/fNpgges
 xhvzXaoqiGZoWSY/qBG5z+5/csMg9u21k8qU/LxEqdyT0PINiTKltYh+VSGmZqtGkDrL4RI0L
 SK5/aAl390gupEyoRbpdmE19Mjz/l0+ZRRODEXyWE9CmvnoBZRQb6vGx88x6S/jkjOL8aAvEN
 0dAJnKT61xdje5vBsxwD0jEnzFx8ZaYI2DUslCAbqp5oX0q6crLuIFVNvpiirj3Gb0nBQaDIO
 IN5jmv863OAEOYEg+7eGDjM6DzULafcvcx6JrDUrPEKWwMdm8vMXqo6s2JVv7dN+MuS3gCJaW
 pNMw1CLhwbQpX8p5vrph3SEg/T3Ni00kc6tuKAk0SnLpQdSDvX5xf+VpM56/ByQjcWCn5de9D
 NbgKN85Qm7xcXXUqyqCvQFdFbYphQuH/r+xqOgun4V8rf55xyxNDSTZDfq5gc4W7DyHA9E2Yf
 qIwkjZ6
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

Changes since v2:

- fixed tyop in the commit message where "line number" was lacking the
  first "e"

- added a test for the "report line number" fix, and test the `ret` variable
  to be non-negative (instead of zero)

- dropped 'read_early_config(): optionally return the worktree's
  top-level directory' as well as most parts of 'alias_lookup():
  optionally return top-level directory', as we have to run
  setup_git_directory() in the shell alias code path anyway


Johannes Schindelin (6):
  discover_git_directory(): avoid setting invalid git_dir
  config: report correct line number upon error
  help: use early config when autocorrecting aliases
  t1308: relax the test verifying that empty alias values are disallowed
  t7006: demonstrate a problem with aliases in subdirectories
  Use the early config machinery to expand aliases

 alias.c                | 31 +++++++++++++++++++++-------
 config.c               |  3 ++-
 git.c                  | 55 ++++----------------------------------------------
 help.c                 |  2 +-
 setup.c                |  1 +
 t/t1300-repo-config.sh |  6 ++++++
 t/t1308-config-set.sh  |  4 +++-
 t/t7006-pager.sh       | 11 ++++++++++
 8 files changed, 52 insertions(+), 61 deletions(-)


base-commit: 41dd4330a1210003bd702ec4a9301ed68e60864d
Published-As: https://github.com/dscho/git/releases/tag/alias-early-config-v3
Fetch-It-Via: git fetch https://github.com/dscho/git alias-early-config-v3

Interdiff vs v2:
 $(git diff $rebasedtag..$branchname)
-- 
2.13.0.windows.1.460.g13f583bedb5

