Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC44CC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 16:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF2323BE3
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 16:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgLIQR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 11:17:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:55598 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbgLIQR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 11:17:56 -0500
Received: (qmail 18209 invoked by uid 109); 9 Dec 2020 16:17:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Dec 2020 16:17:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16432 invoked by uid 111); 9 Dec 2020 16:17:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Dec 2020 11:17:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Dec 2020 11:17:14 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 2/3] config: parse more robust format in GIT_CONFIG_PARAMETERS
Message-ID: <X9D4irohzwFCdx+t@coredump.intra.peff.net>
References: <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we stuff config options into GIT_CONFIG_PARAMETERS, we shell-quote
each one as a single unit, like:

  'section.one=value1' 'section.two=value2'

On the reading side, we de-quote to get the individual strings, and then
parse them by splitting on the first "=" we find. This format is
ambiguous, because an "=" may appear in a subsection. So the config
represented in a file by both:

  [section "subsection=with=equals"]
  key = value

and:

  [section]
  subsection = with=equals.key=value

ends up in this flattened format like:

  'section.subsection=with=equals.key=value'

and we can't tell which was desired. We have traditionally resolved this
by taking the first "=" we see starting from the left, meaning that we
allowed arbitrary content in the value, but not in the subsection.

Let's make our environment format a bit more robust by separately
quoting the key and value. That turns those examples into:

  'section.subsection=with=equals.key'='value'

and:

  'section.subsection'='with=equals.key=value'

respectively, and we can tell the difference between them. We can detect
which format is in use for any given element of the list based on the
presence of the unquoted "=". That means we can continue to allow the
old format to work to support any callers which manually used the old
format, and we can even intermingle the two formats. The old format
wasn't documented, and nobody was supposed to be using it. But it's
likely that such callers exist in the wild, so it's nice if we can avoid
breaking them. Likewise, it may be possible to trigger an older version
of "git -c" that runs a script that calls into a newer version of "git
-c"; that new version would see the intermingled format.

This does create one complication, which is that the obvious format in
the new scheme for

  [section]
  some-bool

is:

  'section.some-bool'

with no equals. We'd mistake that for an old-style variable. And it even
has the same meaning in the old style, but:

  [section "with=equals"]
  some-bool

does not. It would be:

  'section.with=equals=some-bool'

which we'd take to mean:

  [section]
  with = equals=some-bool

in the old, ambiguous style. Likewise, we can't use:

  'section.some-bool'=''

because that's ambiguous with an actual empty string. Instead, we'll
again use the shell-quoting to give us a hint, and use:

  'section.some-bool'=

to show that we have no value.

Note that this commit just expands the reading side. We'll start writing
the new format via "git -c" in a future patch. In the meantime, the
existing "git -c" tests will make sure we didn't break reading the old
format. But we'll also add some explicit coverage of the two formats to
make sure we continue to handle the old one after we move the writing
side over.

And one final note: since we're now using the shell-quoting as a
semantically meaningful hint, this closes the door to us ever allowing
arbitrary shell quoting, like:

  'a'shell'would'be'ok'with'this'.key=value

But we have never supported that (only what sq_quote() would produce),
and we are probably better off keeping things simple, robust, and
backwards-compatible, than trying to make it easier for humans. We'll
continue not to advertise the format of the variable to users, and
instead keep "git -c" as the recommended mechanism for setting config
(even if we are trying to be kind not to break users who may be relying
on the current undocumented format).

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c          | 66 +++++++++++++++++++++++++++++++++++++----------
 t/t1300-config.sh | 52 +++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 14 deletions(-)

diff --git a/config.c b/config.c
index 779487bc2d..fb160c33d2 100644
--- a/config.c
+++ b/config.c
@@ -504,6 +504,57 @@ int git_config_parse_parameter(const char *text,
 	return ret;
 }
 
+static int parse_config_env_list(char *env, config_fn_t fn, void *data)
+{
+	char *cur = env;
+	while (cur && *cur) {
+		const char *key = sq_dequote_step(cur, &cur);
+		if (!key)
+			return error(_("bogus format in %s"),
+				     CONFIG_DATA_ENVIRONMENT);
+
+		if (!cur || isspace(*cur)) {
+			/* old-style 'key=value' */
+			if (git_config_parse_parameter(key, fn, data) < 0)
+				return -1;
+		}
+		else if (*cur == '=') {
+			/* new-style 'key'='value' */
+			const char *value;
+
+			cur++;
+			if (*cur == '\'') {
+				/* quoted value */
+				value = sq_dequote_step(cur, &cur);
+				if (!value || (cur && !isspace(*cur))) {
+					return error(_("bogus format in %s"),
+						     CONFIG_DATA_ENVIRONMENT);
+				}
+			} else if (!*cur || isspace(*cur)) {
+				/* implicit bool: 'key'= */
+				value = NULL;
+			} else {
+				return error(_("bogus format in %s"),
+					     CONFIG_DATA_ENVIRONMENT);
+			}
+
+			if (config_parse_pair(key, value, fn, data) < 0)
+				return -1;
+		}
+		else {
+			/* unknown format */
+			return error(_("bogus format in %s"),
+				     CONFIG_DATA_ENVIRONMENT);
+		}
+
+		if (cur) {
+			while (isspace(*cur))
+				cur++;
+		}
+	}
+	return 0;
+}
+
 int git_config_from_parameters(config_fn_t fn, void *data)
 {
 	const char *env;
@@ -563,22 +614,9 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 
 	env = getenv(CONFIG_DATA_ENVIRONMENT);
 	if (env) {
-		int nr = 0, alloc = 0;
-
 		/* sq_dequote will write over it */
 		envw = xstrdup(env);
-
-		if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
-			ret = error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
-			goto out;
-		}
-
-		for (i = 0; i < nr; i++) {
-			if (git_config_parse_parameter(argv[i], fn, data) < 0) {
-				ret = -1;
-				goto out;
-			}
-		}
+		ret = parse_config_env_list(envw, fn, data);
 	}
 
 out:
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index f157cd217e..bd602e7720 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1294,6 +1294,58 @@ test_expect_success 'git -c is not confused by empty environment' '
 	GIT_CONFIG_PARAMETERS="" git -c x.one=1 config --list
 '
 
+test_expect_success 'GIT_CONFIG_PARAMETERS handles old-style entries' '
+	v="${SQ}key.one=foo${SQ}" &&
+	v="$v  ${SQ}key.two=bar${SQ}" &&
+	v="$v ${SQ}key.ambiguous=section.whatever=value${SQ}" &&
+	GIT_CONFIG_PARAMETERS=$v git config --get-regexp "key.*" >actual &&
+	cat >expect <<-EOF &&
+	key.one foo
+	key.two bar
+	key.ambiguous section.whatever=value
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'GIT_CONFIG_PARAMETERS handles new-style entries' '
+	v="${SQ}key.one${SQ}=${SQ}foo${SQ}" &&
+	v="$v  ${SQ}key.two${SQ}=${SQ}bar${SQ}" &&
+	v="$v ${SQ}key.ambiguous=section.whatever${SQ}=${SQ}value${SQ}" &&
+	GIT_CONFIG_PARAMETERS=$v git config --get-regexp "key.*" >actual &&
+	cat >expect <<-EOF &&
+	key.one foo
+	key.two bar
+	key.ambiguous=section.whatever value
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'old and new-style entries can mix' '
+	v="${SQ}key.oldone=oldfoo${SQ}" &&
+	v="$v ${SQ}key.newone${SQ}=${SQ}newfoo${SQ}" &&
+	v="$v ${SQ}key.oldtwo=oldbar${SQ}" &&
+	v="$v ${SQ}key.newtwo${SQ}=${SQ}newbar${SQ}" &&
+	GIT_CONFIG_PARAMETERS=$v git config --get-regexp "key.*" >actual &&
+	cat >expect <<-EOF &&
+	key.oldone oldfoo
+	key.newone newfoo
+	key.oldtwo oldbar
+	key.newtwo newbar
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'old and new bools with ambiguous subsection' '
+	v="${SQ}key.with=equals.oldbool${SQ}" &&
+	v="$v ${SQ}key.with=equals.newbool${SQ}=" &&
+	GIT_CONFIG_PARAMETERS=$v git config --get-regexp "key.*" >actual &&
+	cat >expect <<-EOF &&
+	key.with equals.oldbool
+	key.with=equals.newbool
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'detect bogus GIT_CONFIG_PARAMETERS' '
 	cat >expect <<-\EOF &&
 	env.one one
-- 
2.29.2.1019.g5c4255ecd5

