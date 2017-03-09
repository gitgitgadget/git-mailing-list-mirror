Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466B8202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbdCIWYD (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:24:03 -0500
Received: from mout.gmx.net ([212.227.15.15]:58935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753015AbdCIWYC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:24:02 -0500
Received: from virtualbox ([37.201.193.18]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgLMU-1caSw82hmQ-00Nm5h; Thu, 09
 Mar 2017 23:23:46 +0100
Date:   Thu, 9 Mar 2017 23:23:44 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v5 00/11] Fix the early config
In-Reply-To: <cover.1488897111.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1489098170.git.johannes.schindelin@gmx.de>
References: <cover.1488897111.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jcJNnqPLBJc6sXdIS4I+taYxO+wgg6QrCtKxpbC/scY/qMfE2fX
 E/zSZLEUQ5Yq8JO1Dhe4bES1IEoqMBOaYWSph98pCPEulfsUp9fZqybWZLlYvI0QdrONnPu
 7JK6aPU+pQSONFV2Mrq/20fNQL5QphEz8MOSYLxm39lHnAGQaq8OM/Ta7n7Qu7vF5swSga/
 tH+fINrKm95TG4/1zkVCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2cTyqN8XC38=:DCNY1+e52nIPoMiyi01IDL
 Nw1kZ0WKqmZA84jbptMH5ql7uB9wRPRzG0f5mZMPprZ99sZaba23Nvcf43nNUY4zVU1KiUUCU
 pNbjz4bebQKoMq8Tqfcrgzt02LKHf2Y/DIWdo8G6XYPy2UpiX6X5gIBjpR0iyUsov4NabmI5k
 Xr35FskRVBIiCSWZpn76B3wPuc9frEXbaAlIdih1vrUSWVcWxdfx2r3rOnqPi3hrJQVTV2Zcz
 ZGebT2mlkjNmA9G3Cdr04JIK4PDgrxkcRRjyqk8zuDd/ahGzUFetk9s1s/PY5h/F/hLVix/PU
 AiM57yaiVxjkRnUfg/3r4mER43znSeVpN1AVbfXyMWUPTGRkaYHp21TexrKPXfUlDKIosXIL9
 uM2C+aLI9gcrjM5njbEt6h5rIDN5IdSAvnqsbm3LfGOReapAuBiTxpD+wWze7q2KhQXNMF+1L
 Ag7eVA8z3mal5SlYDuICD0CReSTXpg3619xxAyMp01erbhUwAIVKIdrcwMm7zvpKeN1fO4lkF
 Ko1a273q+YFOi70yZexONMSn0/zecUNk+7O408eJWKWJsauzKMQTGF4CSCwNu9VJisZZXQV6s
 qs7j8GdsJHNLpCTec9HNB14KY0VzTrE1NRoiw2ZmVe/DCW3q295y334mHL+5hXmTxp3zjg9Pe
 OwuYMLSfrN422PthVy8ngE8EK6qcdHJ8T4t8TlXiC1eVVgKyRgFaTMyvmSDBl8cZSpfzIMCfe
 D/QM916H2ltRLtkW39fmYAkAHrO3eV9SE+vLRRLCc2cPZr/5csrCoAPs309/xd2bDBTCvCE9M
 WWU4hiC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are an attempt to make Git's startup sequence a bit less
surprising.

The idea here is to discover the .git/ directory gently (i.e. without
changing the current working directory, nor any global variables), and
to use it to read the .git/config file early, before we actually called
setup_git_directory() (if we ever do that).

This also allows us to fix the early config e.g. to determine the pager
or to resolve aliases in a non-surprising manner.

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

Changes since v4:

- plugged memory leaks in setup_git_directory() (thanks, Brandon)

- added some tests that demonstrate how early config currently can fail
  in undesired ways

- fixed indentation (this change was snuck into gitster/git's
  js/early-config branch, and I happened to notice the difference by
  pure random chance)


Johannes Schindelin (11):
  t7006: replace dubious test
  setup_git_directory(): use is_dir_sep() helper
  Prepare setup_discovered_git_directory() the root directory
  setup_git_directory_1(): avoid changing global state
  Introduce the discover_git_directory() function
  Make read_early_config() reusable
  read_early_config(): avoid .git/config hack when unneeded
  read_early_config(): really discover .git/
  Test read_early_config()
  setup_git_directory_gently_1(): avoid die()ing
  t1309: document cases where we would want early config not to die()

 cache.h                 |   8 ++
 config.c                |  25 +++++
 pager.c                 |  31 ------
 setup.c                 | 252 +++++++++++++++++++++++++++++++++---------------
 t/helper/test-config.c  |  15 +++
 t/t1309-early-config.sh |  75 ++++++++++++++
 t/t7006-pager.sh        |  18 +++-
 7 files changed, 313 insertions(+), 111 deletions(-)
 create mode 100755 t/t1309-early-config.sh


base-commit: e0688e9b28f2c5ff711460ee8b62077be5df2360
Published-As: https://github.com/dscho/git/releases/tag/early-config-v5
Fetch-It-Via: git fetch https://github.com/dscho/git early-config-v5

Interdiff vs v4:

 diff --git a/setup.c b/setup.c
 index 9118b48590a..b0a28f609e2 100644
 --- a/setup.c
 +++ b/setup.c
 @@ -903,7 +903,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
  			if (die_on_error ||
  			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
  				if (is_git_directory(dir->buf))
 -				    gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
 +					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
  			} else if (error_code &&
  				   error_code != READ_GITFILE_ERR_STAT_FAILED)
  				return GIT_DIR_INVALID_GITFILE;
 @@ -979,7 +979,8 @@ const char *discover_git_directory(struct strbuf *gitdir)
  
  const char *setup_git_directory_gently(int *nongit_ok)
  {
 -	struct strbuf cwd = STRBUF_INIT, dir = STRBUF_INIT, gitdir = STRBUF_INIT;
 +	static struct strbuf cwd = STRBUF_INIT;
 +	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT;
  	const char *prefix;
  
  	/*
 @@ -1027,6 +1028,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
  	case GIT_DIR_HIT_MOUNT_POINT:
  		if (nongit_ok) {
  			*nongit_ok = 1;
 +			strbuf_release(&cwd);
 +			strbuf_release(&dir);
  			return NULL;
  		}
  		die(_("Not a git repository (or any parent up to mount point %s)\n"
 @@ -1044,6 +1047,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
  	startup_info->have_repository = !nongit_ok || !*nongit_ok;
  	startup_info->prefix = prefix;
  
 +	strbuf_release(&dir);
 +	strbuf_release(&gitdir);
 +
  	return prefix;
  }
  
 diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
 index 0c55dee514c..027eca63a3c 100755
 --- a/t/t1309-early-config.sh
 +++ b/t/t1309-early-config.sh
 @@ -47,4 +47,29 @@ test_expect_success 'ceiling #2' '
  	test xdg = "$(cat output)"
  '
  
 +test_with_config ()
 +{
 +	rm -rf throwaway &&
 +	git init throwaway &&
 +	(
 +		cd throwaway &&
 +		echo "$*" >.git/config &&
 +		test-config read_early_config early.config
 +	)
 +}
 +
 +test_expect_success 'ignore .git/ with incompatible repository version' '
 +	test_with_config "[core]repositoryformatversion = 999999" 2>err &&
 +	grep "warning:.* Expected git repo version <= [1-9]" err
 +'
 +
 +test_expect_failure 'ignore .git/ with invalid repository version' '
 +	test_with_config "[core]repositoryformatversion = invalid"
 +'
 +
 +
 +test_expect_failure 'ignore .git/ with invalid config' '
 +	test_with_config "["
 +'
 +
  test_done

-- 
2.12.0.windows.1.7.g94dafc3b124

