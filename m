Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47C631FCA5
	for <e@80x24.org>; Fri, 30 Dec 2016 00:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbcL3ALT (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 19:11:19 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36272 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbcL3ALS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 19:11:18 -0500
Received: by mail-pg0-f68.google.com with SMTP id n5so20294401pgh.3
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 16:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lvdo/howjxKXcdMPS52S38EBQAHw2sf8EYXLpFCWxGQ=;
        b=nBejCtMnl57ks8uddOpVQYzCP/Q4qWvIn0hgPVwDZVVTD1V3xI5vLXb1gtZyxNpK6W
         1Ht9escOKOZNplPsl0EiHnyz6RmKBOVDmsejE0I/QycjkM3C1Z4fJWYAS6x0I4/pHPeI
         BAYYBXBNkjAg36gA94gkIN3/9SGt5El26fy35XOpwjIaRZSa1nH3kryJzf/VwIMvEoIJ
         hwrfKDZyHbXMyTj46v3RIqAuZppU4vj/7zTSs3Z8SKOkv01j/MjiUXWPjEIjZsxjHjWs
         NMx5ao1MjrQ2Ay6G75LC94NWGslQTbmVEdWuhDWB//ROmLrYoC+88tnnh+5Q1Uiif1RM
         8zkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lvdo/howjxKXcdMPS52S38EBQAHw2sf8EYXLpFCWxGQ=;
        b=nF9NI8Lz7FoC2n5xUcPhoa4FlAncW7spYe6NiPvKu0oMVjiL/j/lAjG5worc49QniN
         BOMVhBCDaMJdkLvXCUUQKYMCLIm4RqMasvUQmaZFEAdDXFsPSBI7ZR+5ija+9a6aXkDp
         TElWnzxLErcjaWIbhSijJFBZzCj2v6X+6EANkEe8Ljnn/HELNpmrKhFkmywHoCsp2D1p
         igKY2T1/Fzoe5J8sLiqmw/lNSe45SC5XrZ/agWYKgNokJPgLKTHW60ZGnE4v+ThG5kPP
         ysz1RpiFQmHZB/2joUK6sj3wp44ycpR8bbWgoA2iO0mf9gTtR+3ZpupB7FDg4CQTe6QO
         /+Kg==
X-Gm-Message-State: AIkVDXIYgb7lX7g7U67ZxrSXH5dJ8DEOMEhW2Ig3pvNniAydkTKs6Cuo4LRegJ8kHKRvSQ==
X-Received: by 10.99.9.66 with SMTP id 63mr81028949pgj.84.1483056677192;
        Thu, 29 Dec 2016 16:11:17 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:b9e8:edd:5af8:6423])
        by smtp.gmail.com with ESMTPSA id b71sm107409553pfj.62.2016.12.29.16.11.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Dec 2016 16:11:16 -0800 (PST)
Date:   Thu, 29 Dec 2016 16:11:14 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2] remote helpers: avoid blind fall-back to ".git" when
 setting GIT_DIR
Message-ID: <20161230001114.GB7883@aiede.mtv.corp.google.com>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
 <20161122004421.GA12263@google.com>
 <20161122024102.otlnl6jcrb3pejux@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161122024102.otlnl6jcrb3pejux@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To push from or fetch to the current repository, remote helpers need
to know what repository that is.  Accordingly, Git sets the GIT_DIR
environment variable to the path to the current repository when
invoking remote helpers.

There is a special case it does not handle: "git ls-remote" and "git
archive --remote" can be run to inspect a remote repository without
being run from any local repository.  GIT_DIR is not useful in this
scenario:

- if we are not in a repository, we don't need to set GIT_DIR to
  override an existing GIT_DIR value from the environment.  If GIT_DIR
  is present then we would be in a repository if it were valid and
  would have called die() if it weren't.

- not setting GIT_DIR may cause a helper to do the usual discovery
  walk to find the repository.  But we know we're not in one, or we
  would have found it ourselves.  So in the worst case it may expend
  a little extra effort to try to find a repository and fail (for
  example, remote-curl would do this to try to find repository-level
  configuration).

So leave GIT_DIR unset in this case.  This makes GIT_DIR easier to
understand for remote helper authors and makes transport code less of
a special case for repository discovery.

Noticed using b1ef400e (setup_git_env: avoid blind fall-back to
".git", 2016-10-20) from 'next':

 $ cd /tmp
 $ git ls-remote https://kernel.googlesource.com/pub/scm/git/git
 fatal: BUG: setup_git_env called without repository

While at it, add some tests for other variables in the environment of
commands run by git-remote-ext.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:

> So yeah, I think this is the extent of the change needed.

Thanks.  Here's the patch again, now with commit messages and a test.
Thanks for the analysis and sorry for the slow turnaround.

Sincerely,
Jonathan

 t/t5550-http-fetch-dumb.sh  | 15 ++++++++
 t/t5551-http-fetch-smart.sh | 15 ++++++++
 t/t5570-git-daemon.sh       | 15 ++++++++
 t/t5802-connect-helper.sh   | 84 ++++++++++++++++++++++++++++++++++++++++++++-
 transport-helper.c          |  5 +--
 5 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index aeb3a63f7c..a86fca3e6c 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -34,6 +34,21 @@ test_expect_success 'clone http repository' '
 	test_cmp file clone/file
 '
 
+test_expect_success 'list refs from outside any repository' '
+	cat >expect <<-EOF &&
+	$(git rev-parse master)	HEAD
+	$(git rev-parse master)	refs/heads/master
+	EOF
+	mkdir lsremote-root &&
+	(
+		GIT_CEILING_DIRECTORIES=$(pwd) &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd lsremote-root &&
+		git ls-remote "$HTTPD_URL/dumb/repo.git" >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'create password-protected repository' '
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/" &&
 	cp -Rf "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 6e5b9e42fb..7ba894f0f4 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -163,6 +163,21 @@ test_expect_success 'redirects send auth to new location' '
 	expect_askpass both user@host auth/smart/repo.git
 '
 
+test_expect_success 'list refs from outside any repository' '
+	cat >expect <<-EOF &&
+	$(git rev-parse master)	HEAD
+	$(git rev-parse master)	refs/heads/master
+	EOF
+	mkdir lsremote-root &&
+	(
+		GIT_CEILING_DIRECTORIES=$(pwd) &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd lsremote-root &&
+		git ls-remote "$HTTPD_URL/smart/repo.git" >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'disable dumb http on server' '
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
 		config http.getanyfile false
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 225a022e8a..4573d98e6c 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -35,6 +35,21 @@ test_expect_success 'clone git repository' '
 	test_cmp file clone/file
 '
 
+test_expect_success 'list refs from outside any repository' '
+	cat >expect <<-EOF &&
+	$(git rev-parse master)	HEAD
+	$(git rev-parse master)	refs/heads/master
+	EOF
+	mkdir lsremote-root &&
+	(
+		GIT_CEILING_DIRECTORIES=$(pwd) &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd lsremote-root &&
+		git ls-remote "$GIT_DAEMON_URL/repo.git" >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'fetch changes via git protocol' '
 	echo content >>file &&
 	git commit -a -m two &&
diff --git a/t/t5802-connect-helper.sh b/t/t5802-connect-helper.sh
index c6c2661878..7232032cd2 100755
--- a/t/t5802-connect-helper.sh
+++ b/t/t5802-connect-helper.sh
@@ -3,6 +3,10 @@
 test_description='ext::cmd remote "connect" helper'
 . ./test-lib.sh
 
+escape_spaces () {
+	echo "$*" | sed -e "s/ /% /g"
+}
+
 test_expect_success setup '
 	git config --global protocol.ext.allow user &&
 	test_tick &&
@@ -19,7 +23,7 @@ test_expect_success setup '
 '
 
 test_expect_success clone '
-	cmd=$(echo "echo >&2 ext::sh invoked && %S .." | sed -e "s/ /% /g") &&
+	cmd=$(escape_spaces "echo >&2 ext::sh invoked && %S ..") &&
 	git clone "ext::sh -c %S% ." dst &&
 	git for-each-ref refs/heads/ refs/tags/ >expect &&
 	(
@@ -70,6 +74,84 @@ test_expect_success 'update backfilled tag without primary transfer' '
 	test_cmp expect actual
 '
 
+test_expect_success 'GIT_EXT_SERVICE for clone, ls-remote, push, archive' '
+	rm -rf dst &&
+	>actual &&
+	cat >expect <<-\EOF &&
+	git-upload-pack
+	git-upload-pack
+	git-receive-pack
+	git-upload-archive
+	EOF
+	git archive HEAD >expect.tar &&
+	cmd=$(escape_spaces "echo >>actual \$GIT_EXT_SERVICE && %S .") &&
+
+	git clone "ext::sh -c $cmd" dst &&
+	git ls-remote "ext::sh -c $cmd" &&
+	test_when_finished "git update-ref -d refs/heads/newbranch" &&
+	git push "ext::sh -c $cmd" master:newbranch &&
+	git archive --remote="ext::sh -c $cmd" HEAD >actual.tar &&
+
+	test_cmp expect actual &&
+	test_cmp expect.tar actual.tar
+'
+
+test_expect_success 'GIT_EXT_SERVICE_NOPREFIX for clone, ls-remote, push, archive' '
+	rm -rf dst &&
+	>actual &&
+	cat >expect <<-\EOF &&
+	upload-pack
+	upload-pack
+	receive-pack
+	upload-archive
+	EOF
+	git archive HEAD >expect.tar &&
+	cmd=$(escape_spaces "echo >>actual \$GIT_EXT_SERVICE_NOPREFIX && %S .") &&
+
+	git clone "ext::sh -c $cmd" dst &&
+	git ls-remote "ext::sh -c $cmd" &&
+	test_when_finished "git update-ref -d refs/heads/newbranch" &&
+	git push "ext::sh -c $cmd" master:newbranch &&
+	git archive --remote="ext::sh -c $cmd" HEAD >actual.tar &&
+
+	test_cmp expect actual &&
+	test_cmp expect.tar actual.tar
+'
+
+test_expect_success 'GIT_DIR is set to the enclosing repo for ls-remote' '
+	git rev-parse --git-dir >expect &&
+	cmd=$(escape_spaces "echo \$GIT_DIR >actual && %S .") &&
+	git ls-remote "ext::sh -c $cmd" &&
+	test_cmp expect actual
+'
+
+test_expect_success 'GIT_DIR is set to the enclosing repo for archive' '
+	git rev-parse --git-dir >expect &&
+	git archive HEAD >expect.tar &&
+	cmd=$(escape_spaces "echo \$GIT_DIR >actual && %S .") &&
+	git archive --remote="ext::sh -c $cmd" HEAD >actual.tar &&
+	test_cmp expect actual &&
+	test_cmp expect.tar actual.tar
+'
+
+test_expect_success 'GIT_DIR is not set if there is no enclosing repo' '
+	rm -rf subdir &&
+	>actual &&
+	printf "%s\n" unset unset >expect &&
+	git archive HEAD >expect.tar &&
+
+	mkdir subdir &&
+	cmd=$(escape_spaces "echo \${GIT_DIR-unset} >>../actual && %S ..") &&
+	(
+		GIT_CEILING_DIRECTORIES=$(pwd) &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd subdir &&
+		git ls-remote "ext::sh -c $cmd" &&
+		git archive --remote="ext::sh -c $cmd" HEAD >../actual.tar
+	) &&
+	test_cmp expect actual &&
+	test_cmp expect.tar actual.tar
+'
 
 test_expect_success 'set up fake git-daemon' '
 	mkdir remote &&
diff --git a/transport-helper.c b/transport-helper.c
index 91aed35ebb..e4fd982383 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -124,8 +124,9 @@ static struct child_process *get_helper(struct transport *transport)
 	helper->git_cmd = 0;
 	helper->silent_exec_failure = 1;
 
-	argv_array_pushf(&helper->env_array, "%s=%s", GIT_DIR_ENVIRONMENT,
-			 get_git_dir());
+	if (have_git_dir())
+		argv_array_pushf(&helper->env_array, "%s=%s",
+				 GIT_DIR_ENVIRONMENT, get_git_dir());
 
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
-- 
2.11.0.355.g1ede815

