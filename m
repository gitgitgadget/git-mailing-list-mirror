Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF5E1F461
	for <e@80x24.org>; Sun, 19 May 2019 18:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfESSjC (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 14:39:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:33552 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729713AbfESSjC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 14:39:02 -0400
Received: (qmail 20831 invoked by uid 109); 19 May 2019 05:12:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 19 May 2019 05:12:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28089 invoked by uid 111); 19 May 2019 05:13:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 19 May 2019 01:13:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 May 2019 01:12:19 -0400
Date:   Sun, 19 May 2019 01:12:19 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] clone: avoid storing URL passwords in config
Message-ID: <20190519051218.GB19434@sigill.intra.peff.net>
References: <20190519050724.GA26179@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190519050724.GA26179@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you clone a URL with a password, like:

  git clone https://user:pass@example.com/repo.git

we'll write that literal URL, including the password into .git/config.
This can lead to accidentally disclosing it, since .git/config isn't
generally assumed to be a secret. In particular, it's very prone to
accidentally exposing by a webserver:

  1. It's actually _in_ the repo directory, and it's not uncommon for
     people to clone (or copy) the contents to a web-accessible
     directory.

  2. The filesystem permissions are not restrictive. So cloning as user
     "bob" would usually produce a config file readable by user "httpd".

Let's strip the password out before storing it. There are two things to
note:

  - we must (and do) retain the username here. Both as a convenience so
    the user does not have to input it again, but also because
    credential helpers use it as part of the lookup key (which matters
    if you use two different usernames with the same host).

  - since we don't record the password anywhere, a follow-up fetch will
    fail. This is a regression for some workflows, of course, but one
    we'll fix in a future commit. For now we'll warn the user about
    what's happening and add a failing test to show the problem.

Idea-stolen-from: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jeff King <peff@peff.net>
---
If we stop here, we probably ought to be pointing users at credential
helpers in the advice. I didn't bother here, because the next commit
ends up rewriting most of this advice anyway.

 builtin/clone.c            | 24 ++++++++++++++++++++++--
 t/t5550-http-fetch-dumb.sh | 12 ++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index ffdd94e8f6..15fffc3268 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -891,10 +891,18 @@ static int dir_exists(const char *path)
 	return !stat(path, &sb);
 }
 
+static const char sanitized_url_advice[] = N_(
+"The URL you provided to Git contains a password. It will be\n"
+"used to clone the repository, but to avoid accidental disclosure\n"
+"the password will not be recorded. Further fetches from the remote\n"
+"may require you to provide the password interactively.\n"
+);
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
 	const char *repo_name, *repo, *work_tree, *git_dir;
+	char *sanitized_repo;
 	char *path, *dir;
 	int dest_exists;
 	const struct ref *refs, *remote_head;
@@ -1079,9 +1087,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
+	sanitized_repo = transport_strip_url(repo, 0);
+	if (strcmp(repo, sanitized_repo)) {
+		warning(_("omitting password while storing URL in on-disk config"));
+		advise(_(sanitized_url_advice));
+	}
 	strbuf_addf(&key, "remote.%s.url", option_origin);
-	git_config_set(key.buf, repo);
+	git_config_set(key.buf, sanitized_repo);
 	strbuf_reset(&key);
+	FREE_AND_NULL(sanitized_repo);
 
 	if (option_no_tags) {
 		strbuf_addf(&key, "remote.%s.tagOpt", option_origin);
@@ -1098,7 +1112,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		    branch_top.buf);
 	refspec_append(&remote->fetch, default_refspec.buf);
 
-	transport = transport_get(remote, remote->url[0]);
+	/*
+	 * Override remote->url here, since that will be the sanitized version
+	 * we wrote to the config. If there was a password, we need to use the
+	 * version that has it (and if there isn't, the two are identical
+	 * anyway).
+	 */
+	transport = transport_get(remote, repo);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
 	transport->family = family;
 
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index b811d89cfd..d8c85f3126 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -64,6 +64,18 @@ test_expect_success 'http auth can use user/pass in URL' '
 	expect_askpass none
 '
 
+test_expect_success 'username is retained in URL, password is not' '
+	git -C clone-auth-none config remote.origin.url >url &&
+	grep user url &&
+	! grep pass url
+'
+
+test_expect_failure 'fetch of password-URL clone uses stored auth' '
+	set_askpass wrong &&
+	git -C clone-auth-none fetch &&
+	expect_askpass none
+'
+
 test_expect_success 'http auth can use just user in URL' '
 	set_askpass wrong pass@host &&
 	git clone "$HTTPD_URL_USER/auth/dumb/repo.git" clone-auth-pass &&
-- 
2.22.0.rc0.583.g23d90da2b3

