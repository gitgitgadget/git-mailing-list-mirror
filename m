Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B17620373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbdCMUJv (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:09:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:62665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753417AbdCMUJs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:09:48 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M24Vr-1byR871d51-00u2Rg; Mon, 13
 Mar 2017 21:09:28 +0100
Date:   Mon, 13 Mar 2017 21:09:26 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v6 00/12] Fix the early config
In-Reply-To: <cover.1489098170.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1489435755.git.johannes.schindelin@gmx.de>
References: <cover.1489098170.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sGhTscA1FPgO0l3BEJ78hqsMK+ay1lH/5YVBSIeLTr4a3bPrkaU
 V5FVts9/AJ8sRJQ63yBGFGp2X2F67/zv3mq7JOQP9oyeCG5PeMSQeyshblhZmJ8InVA9K9Q
 bDbiNGXzGO/v2z+BUCOychU8OuWHx/C43u9l0wSFQIyUsoQkCcJNKuJQtdDuuhqLYiWv3XO
 59KekUIAZRYUbTGrh3C8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cWCugshyF9k=:kCs5XH1Z38dYkDB+6TtA0h
 9rJ88hYuGRP/02Q3UHRKkevVvyVekO3EgrENpZagzjNNFMfAlWf03pgnqipFCQGsxBOYt4Aw3
 rpnLv3lXNkFxQgwYc81pM0paAbf0ssMxDKxKAcaKjqAJYakThr1g3WGbiuTKB9HCgt9N7pQgY
 H4NII5kUisnLY5YtAC+3a/Mcr+Wa2ErY/0xr0r1gA1TCt55QsEXYUJxP+8TvO6WQY+R3zY1W+
 aP2xHbafT0/bOrt8NNO/qCOAs090XGNoac86EvR65eU2bWeFFk55syBBJNQY390dZU+EmIf6c
 axoSz4+IetGtD1rGozPsXFvZ8IFqCULC4TslXTaNivDZvxi+/OsxhP7XV5ZLqJ4f65fx0yp4Y
 5hbkGwh/cVQrTNQ6Y+sNKiaP36jOsR31Jle9dfSDjdPMdciCLjBWjQIg6FP4xg0U9bDX6m0CM
 z8mCCOkaUwIPDeybthJq8Ek8TjViVDiP1L91abzk6vMlWdVgixy4uUzbCy7KpPMdj0AIOm6Y0
 IvNHhQIE6uDvp8Rb/KuK2P5MGWyFgkxeoK7SSnDpqzgPskkbT4K06Qld/TdJ9cGVjIg/voxMq
 i/PCzd8aOaQa7GAUa0xZAVVLFvN+s81R21o27XNyAJr4ENutDj0fW9FvGSlmemMGHCt7f7X/6
 DkfuRd/vNY+K2Xb3YTD5Bug7TZmkQpqpoYQgM3+rhKji2IfTMszgQniJHnypHY34gedMAyCKr
 9OHFolg5Dh2oebC5FkZ7nuFvHWVQSHbJyeTz5xbvjmzZcqitEn8B7uUXYsBLBJPnQaAOop9KK
 QwbBqvv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are an attempt to make Git's startup sequence a bit less
surprising.

The idea here is to refactor setup_git_directory()'s code so that the
underlying .git/ directory discovery can be run without changing any
global state nor the current working directory, and then to use that
functionality also in read_early_config().

My own use case: in the GVFS Git fork, we need to execute pre-command
and post-command hooks before and after *every* Git command. A previous
version of the pre-command/post-command hook support was broken, as it
used run_hook() which implicitly called setup_git_directory() too early.
The discover_git_directory() function (and due to core.hooksPath also
the read_early_config() function) helped me fix this.

Notable notes:

- Even if it can cause surprising problems, `init` and `clone` are not
  special-cased. Rationale: it would introduce technical debt and
  violate the Principle Of Least Astonishment.

- The read_early_config() function does not cache Git directory
  discovery nor read values. This is left for another patch series, if
  it ever becomes necessary.

- The alias handling in git.c could possibly benefit from this work, but
  again, this is a separate topic from the current patch series.

Changes since v5:

- Reworded comment about `gitdir` being relative to `dir` so that it
  does not confuse Junio anymore

- Removed a superfluous `error_code &&` in an if() condition

- Reworded the oneline of 9/11

- Added a new patch at the end that marks the two NEEDSWORK issues that
  Junio identified (but that should not be addressed in this patch
  series, of course, because the entire idea of the early-config work is
  to *preserve* the current behavior of setup_git_directory() while making
  it possible for read_early_config() to reuse the same code paths)


Johannes Schindelin (12):
  t7006: replace dubious test
  setup_git_directory(): use is_dir_sep() helper
  Prepare setup_discovered_git_directory() the root directory
  setup_git_directory_1(): avoid changing global state
  Introduce the discover_git_directory() function
  Make read_early_config() reusable
  read_early_config(): avoid .git/config hack when unneeded
  read_early_config(): really discover .git/
  Add t1309 to test read_early_config()
  setup_git_directory_gently_1(): avoid die()ing
  t1309: document cases where we would want early config not to die()
  setup.c: mention unresolved problems

 cache.h                 |   8 ++
 config.c                |  25 +++++
 pager.c                 |  31 ------
 setup.c                 | 253 +++++++++++++++++++++++++++++++++---------------
 t/helper/test-config.c  |  15 +++
 t/t1309-early-config.sh |  75 ++++++++++++++
 t/t7006-pager.sh        |  18 +++-
 7 files changed, 314 insertions(+), 111 deletions(-)
 create mode 100755 t/t1309-early-config.sh


base-commit: d6db3f216544d05e09159756812ccbcb16861d71
Published-As: https://github.com/dscho/git/releases/tag/early-config-v6
Fetch-It-Via: git fetch https://github.com/dscho/git early-config-v6

Interdiff vs v5:

 diff --git a/setup.c b/setup.c
 index 6733ba5fe82..64f922a9378 100644
 --- a/setup.c
 +++ b/setup.c
 @@ -531,6 +531,7 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
  	ssize_t len;
  
  	if (stat(path, &st)) {
 +		/* NEEDSWORK: discern between ENOENT vs other errors */
  		error_code = READ_GITFILE_ERR_STAT_FAILED;
  		goto cleanup_return;
  	}
 @@ -839,8 +840,8 @@ enum discovery_result {
   * The directory where the search should start needs to be passed in via the
   * `dir` parameter; upon return, the `dir` buffer will contain the path of
   * the directory where the search ended, and `gitdir` will contain the path of
 - * the discovered .git/ directory, if any. This path may be relative against
 - * `dir` (i.e. *not* necessarily the cwd).
 + * the discovered .git/ directory, if any. If `gitdir` is not absolute, it
 + * is relative to `dir` (i.e. *not* necessarily the cwd).
   */
  static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
  							  struct strbuf *gitdir,
 @@ -902,10 +903,10 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
  		if (!gitdirenv) {
  			if (die_on_error ||
  			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
 +				/* NEEDSWORK: fail if .git is not file nor dir */
  				if (is_git_directory(dir->buf))
  					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
 -			} else if (error_code &&
 -				   error_code != READ_GITFILE_ERR_STAT_FAILED)
 +			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
  				return GIT_DIR_INVALID_GITFILE;
  		}
  		strbuf_setlen(dir, offset);

-- 
2.12.0.windows.1.7.g94dafc3b124

