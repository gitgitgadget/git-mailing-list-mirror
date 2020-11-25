Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317BCC83010
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 10:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11DF206E0
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 10:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgKYKlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 05:41:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:41938 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728906AbgKYKlP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 05:41:15 -0500
Received: (qmail 9290 invoked by uid 109); 25 Nov 2020 10:41:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Nov 2020 10:41:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28104 invoked by uid 111); 25 Nov 2020 10:41:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Nov 2020 05:41:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 25 Nov 2020 05:41:14 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 0/2] config: allow specifying config entries via
 envvar pairs
Message-ID: <X740yqoYIhrqsNRE@coredump.intra.peff.net>
References: <cover.1606214397.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1606214397.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 11:50:46AM +0100, Patrick Steinhardt wrote:

>     - I've changed priorities. The envvars are treated as command-level
>       and as such override all values configured in files. But any
>       explicit `git -c key=value` will now override these envvars.

That ordering makes sense. Those get passed through the environment,
too, but at some point there is a process where your new ones are in the
environment and the "-c" ones are on the command-line.

I do still think that a "--config-env" option solves your problem in a
much simpler way (especially in terms of interface we expose to users
that we'll be locked into forever). I sketched out the solution below if
it's of interest (and I'd be happy to polish it up, or hand it off to
you if so). But if you're unconvinced, I'll stop mentioning it.

diff --git a/config.c b/config.c
index 8f324ed3a6..d8cf6a5d6b 100644
--- a/config.c
+++ b/config.c
@@ -345,6 +345,27 @@ void git_config_push_parameter(const char *text)
 	strbuf_release(&env);
 }
 
+void git_config_push_env(const char *spec)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *env_name;
+	const char *env_value;
+
+	env_name = strchr(spec, '=');
+	if (!env_name)
+		return; /* die or warn? */
+	env_name++;
+
+	env_value = getenv(env_name);
+	if (!env_value)
+		return; /* die or warn? */
+
+	strbuf_add(&buf, spec, env_name - spec);
+	strbuf_addstr(&buf, env_value);
+	git_config_push_parameter(buf.buf);
+	strbuf_release(&buf);
+}
+
 static inline int iskeychar(int c)
 {
 	return isalnum(c) || c == '-';
diff --git a/config.h b/config.h
index 91cdfbfb41..d05651c96c 100644
--- a/config.h
+++ b/config.h
@@ -138,6 +138,7 @@ int git_config_from_mem(config_fn_t fn,
 int git_config_from_blob_oid(config_fn_t fn, const char *name,
 			     const struct object_id *oid, void *data);
 void git_config_push_parameter(const char *text);
+void git_config_push_env(const char *spec);
 int git_config_from_parameters(config_fn_t fn, void *data);
 void read_early_config(config_fn_t cb, void *data);
 void read_very_early_config(config_fn_t cb, void *data);
diff --git a/git.c b/git.c
index 4b7bd77b80..342f2fb0c9 100644
--- a/git.c
+++ b/git.c
@@ -254,6 +254,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			git_config_push_parameter((*argv)[1]);
 			(*argv)++;
 			(*argc)--;
+		} else if (skip_prefix(cmd, "--config-env=", &cmd)) {
+			git_config_push_env(cmd);
 		} else if (!strcmp(cmd, "--literal-pathspecs")) {
 			setenv(GIT_LITERAL_PATHSPECS_ENVIRONMENT, "1", 1);
 			if (envchanged)
