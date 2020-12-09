Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E86C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 16:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC04A23BE3
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 16:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbgLIQVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 11:21:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:55616 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731881AbgLIQVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 11:21:09 -0500
Received: (qmail 18333 invoked by uid 109); 9 Dec 2020 16:20:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Dec 2020 16:20:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16482 invoked by uid 111); 9 Dec 2020 16:20:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Dec 2020 11:20:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Dec 2020 11:20:26 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 3/3] config: store "git -c" variables using more robust format
Message-ID: <X9D5SnXca2rGnJFl@coredump.intra.peff.net>
References: <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit added a new format for $GIT_CONFIG_PARAMETERS which
is able to robustly handle subsections with "=" in them. Let's start
writing the new format. Unfortunately, this does much less than you'd
hope, because "git -c" itself has the same ambiguity problem! But it's
still worth doing:

  - we've now pushed the problem from the inter-process communication
    into the "-c" command-line parser. This would free us up to later
    add an unambiguous format there (e.g., separate arguments like "git
    --config key value", etc).

  - for --config-env, the parser already disallows "=" in the
    environment variable name. So:

      git --config-env section.with=equals.key=ENVVAR

    will robustly set section.with=equals.key to the contents of
    $ENVVAR.

The new test shows the improvement for --config-env.

Signed-off-by: Jeff King <peff@peff.net>
---
One other side effect I just noticed is that we're very aggressive about
trimming leading and trailing whitespace in the old-style format, but
the new one will store values verbatim. IMHO that's better overall, but
we might consider a preparatory patch to remove that trimming
explicitly.

 config.c          | 52 ++++++++++++++++++++++++++++++++++++++++-------
 t/t1300-config.sh |  8 ++++++++
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index fb160c33d2..04029e45dc 100644
--- a/config.c
+++ b/config.c
@@ -333,38 +333,76 @@ int git_config_include(const char *var, const char *value, void *data)
 	return ret;
 }
 
-void git_config_push_parameter(const char *text)
+static void git_config_push_split_parameter(const char *key, const char *value)
 {
 	struct strbuf env = STRBUF_INIT;
 	const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
 	if (old && *old) {
 		strbuf_addstr(&env, old);
 		strbuf_addch(&env, ' ');
 	}
-	sq_quote_buf(&env, text);
+	sq_quote_buf(&env, key);
+	strbuf_addch(&env, '=');
+	if (value)
+		sq_quote_buf(&env, value);
 	setenv(CONFIG_DATA_ENVIRONMENT, env.buf, 1);
 	strbuf_release(&env);
 }
 
+void git_config_push_parameter(const char *text)
+{
+	const char *value;
+
+	/*
+	 * When we see:
+	 *
+	 *   section.subsection=with=equals.key=value
+	 *
+	 * we cannot tell if it means:
+	 *
+	 *   [section "subsection=with=equals"]
+	 *   key = value
+	 *
+	 * or:
+	 *
+	 *   [section]
+	 *   subsection = with=equals.key=value
+	 *
+	 * We parse left-to-right for the first "=", meaning we'll prefer to
+	 * keep the value intact over the subsection. This is historical, but
+	 * also sensible since values are more likely to contain odd or
+	 * untrusted input than a section name.
+	 *
+	 * A missing equals is explicitly allowed (as a bool-only entry).
+	 */
+	value = strchr(text, '=');
+	if (value) {
+		char *key = xmemdupz(text, value - text);
+		git_config_push_split_parameter(key, value + 1);
+		free(key);
+	} else {
+		git_config_push_split_parameter(text, NULL);
+	}
+}
+
 void git_config_push_env(const char *spec)
 {
-	struct strbuf buf = STRBUF_INIT;
+	char *key;
 	const char *env_name;
 	const char *env_value;
 
 	env_name = strrchr(spec, '=');
 	if (!env_name)
 		die("invalid config format: %s", spec);
+	key = xmemdupz(spec, env_name - spec);
 	env_name++;
 
 	env_value = getenv(env_name);
 	if (!env_value)
 		die("config variable missing for '%s'", env_name);
 
-	strbuf_add(&buf, spec, env_name - spec);
-	strbuf_addstr(&buf, env_value);
-	git_config_push_parameter(buf.buf);
-	strbuf_release(&buf);
+	git_config_push_split_parameter(key, env_value);
+	free(key);
 }
 
 static inline int iskeychar(int c)
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index bd602e7720..e06961767f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1413,6 +1413,14 @@ test_expect_success 'git -c and --config-env override each other' '
 	test_cmp expect actual
 '
 
+test_expect_success '--config-env handles keys with equals' '
+	echo value=with=equals >expect &&
+	ENVVAR=value=with=equals git \
+		--config-env=section.subsection=with=equals.key=ENVVAR \
+		config section.subsection=with=equals.key >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git config handles environment config pairs' '
 	GIT_CONFIG_COUNT=2 \
 		GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="foo" \
-- 
2.29.2.1019.g5c4255ecd5
