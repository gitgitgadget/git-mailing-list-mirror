Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90931FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 20:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbdBNUgk (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 15:36:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:55289 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751749AbdBNUgi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 15:36:38 -0500
Received: (qmail 18816 invoked by uid 109); 14 Feb 2017 20:36:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 20:36:22 +0000
Received: (qmail 6350 invoked by uid 111); 14 Feb 2017 20:36:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 15:36:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 15:36:19 -0500
Date:   Tue, 14 Feb 2017 15:36:19 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] remote helpers: avoid blind fall-back to ".git" when
 setting GIT_DIR
Message-ID: <20170214203619.62plnss65mdwf3na@sigill.intra.peff.net>
References: <20170214203117.xnln6ahb3l32agqb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214203117.xnln6ahb3l32agqb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

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

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I dropped this down to a single test instance, and used the nongit
helper to shorten it.

Possible patches on top:

  - if we want to test this across more protocols, we can. I'm not sure
    I see all that much value in it, given that we know the source of
    the bug.

    We probably _should_ have some kind of standard test-battery that
    hits all protocols, or at the very least hits both dumb/smart http.
    But waiting for that may be making the perfect the enemy of the
    good. So I'm OK with doing it piece-wise for now if people really
    feel we need to cover more protocols.

  - Jonathan's original had some nice remote-ext tests, but they were
    sufficiently complex that they should be spun into their own patch
    with more explanation.

 t/t5550-http-fetch-dumb.sh | 9 +++++++++
 transport-helper.c         | 5 +++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index aeb3a63f7..b69ece1d6 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -34,6 +34,15 @@ test_expect_success 'clone http repository' '
 	test_cmp file clone/file
 '
 
+test_expect_success 'list refs from outside any repository' '
+	cat >expect <<-EOF &&
+	$(git rev-parse master)	HEAD
+	$(git rev-parse master)	refs/heads/master
+	EOF
+	nongit git ls-remote "$HTTPD_URL/dumb/repo.git" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'create password-protected repository' '
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/" &&
 	cp -Rf "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
diff --git a/transport-helper.c b/transport-helper.c
index 91aed35eb..e4fd98238 100644
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
2.12.0.rc1.479.g59880b11e
