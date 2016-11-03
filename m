Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F78F2021E
	for <e@80x24.org>; Thu,  3 Nov 2016 18:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758064AbcKCSYc (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 14:24:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:38215 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757251AbcKCSYb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 14:24:31 -0400
Received: (qmail 5999 invoked by uid 109); 3 Nov 2016 18:24:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 18:24:31 +0000
Received: (qmail 15373 invoked by uid 111); 3 Nov 2016 18:24:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 14:24:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2016 14:24:28 -0400
Date:   Thu, 3 Nov 2016 14:24:28 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Blake Burkhart <bburky@bburky.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103182428.j3r574evsk7ypfie@sigill.intra.peff.net>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161103002225.GA13369@google.com>
 <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
 <20161103172515.GA182568@google.com>
 <20161103175327.nn2yasvlsxsy22be@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161103175327.nn2yasvlsxsy22be@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2016 at 01:53:27PM -0400, Jeff King wrote:

> I'd design the new system from scratch, and have it kick in _only_ when
> GIT_ALLOW_PROTOCOL is not set. That lets existing callers continue to
> have the safe behavior until they are ready to move to the new format.
> 
> Something like the patch below (which is just for illustration, and not
> tested beyond compilation).

Here's that same patch with a few tweaks:

  - it changes git-submodule to use the new, more flexible system (which
    also gets a it a lot more test coverage)

  - it tweaks two tests which use the "ext" helper to enable it (since
    it's blacklisted by default; I have mixed feelings on that, but I
    see why Blake wants it, as it would have protected things like "go
    get" out of the box).

  - it adds "file://" as a known-good protocol, even for submodules,
    which matches the current code.  I am not sure if this is reasonable
    or not. A malicious repository probably can't do much by pointing
    you to cloning your own repo as a submodule unless you then _also_
    run some arbitrary code to expose it, at which point it's generally
    game-over anyway.

    And I'd expect automated services (like GitHub Pages) to already
    have a cut-down whitelist via GIT_ALLOW_PROTOCOL (and I happen to
    know that it goes).

So this seems like a reasonable direction to me. It obviously needs
documentation and tests. Arguably there should be a fallback "allow"
value when a protocol is not mentioned in the config so that you could
convert the default from "user" to "never" if you wanted your config to
specify a pure whitelist.

Without that, I think we'd want to keep GIT_ALLOW_PROTOCOL for the truly
paranoid (though we should keep it indefinitely either way for backwards
compatibility).

Do you have interest in picking this up and running with it?

-Peff

diff --git a/git-submodule.sh b/git-submodule.sh
index a024a135d..0a477b4c9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -21,14 +21,10 @@ require_work_tree
 wt_prefix=$(git rev-parse --show-prefix)
 cd_to_toplevel
 
-# Restrict ourselves to a vanilla subset of protocols; the URLs
-# we get are under control of a remote repository, and we do not
-# want them kicking off arbitrary git-remote-* programs.
-#
-# If the user has already specified a set of allowed protocols,
-# we assume they know what they're doing and use that instead.
-: ${GIT_ALLOW_PROTOCOL=file:git:http:https:ssh}
-export GIT_ALLOW_PROTOCOL
+# Tell the rest of git that any URLs we get don't come
+# directly from the user, so it can apply policy as appropriate.
+GIT_PROTOCOL_FROM_USER=0
+export GIT_PROTOCOL_FROM_USER
 
 command=
 branch=
diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index bc44ac36d..75c570adc 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -4,6 +4,7 @@ test_description='fetch/push involving ref namespaces'
 . ./test-lib.sh
 
 test_expect_success setup '
+	git config --global protocol.ext.allow user &&
 	test_tick &&
 	git init original &&
 	(
diff --git a/t/t5802-connect-helper.sh b/t/t5802-connect-helper.sh
index b7a7f9d58..c6c266187 100755
--- a/t/t5802-connect-helper.sh
+++ b/t/t5802-connect-helper.sh
@@ -4,6 +4,7 @@ test_description='ext::cmd remote "connect" helper'
 . ./test-lib.sh
 
 test_expect_success setup '
+	git config --global protocol.ext.allow user &&
 	test_tick &&
 	git commit --allow-empty -m initial &&
 	test_tick &&
diff --git a/transport.c b/transport.c
index d57e8dec2..cd603fbf5 100644
--- a/transport.c
+++ b/transport.c
@@ -664,10 +664,70 @@ static const struct string_list *protocol_whitelist(void)
 	return enabled ? &allowed : NULL;
 }
 
+enum protocol_allow_config {
+	PROTOCOL_ALLOW_NEVER = 0,
+	PROTOCOL_ALLOW_USER_ONLY,
+	PROTOCOL_ALLOW_ALWAYS
+};
+
+static enum protocol_allow_config parse_protocol_config(const char *key,
+							const char *value)
+{
+	if (!strcasecmp(value, "always"))
+		return PROTOCOL_ALLOW_ALWAYS;
+	else if (!strcasecmp(value, "never"))
+		return PROTOCOL_ALLOW_NEVER;
+	else if (!strcasecmp(value, "user"))
+		return PROTOCOL_ALLOW_USER_ONLY;
+
+	/* XXX maybe also interpret git_config_bool() here? */
+	die("unknown value for config '%s': %s", key, value);
+}
+
+static enum protocol_allow_config get_protocol_config(const char *type)
+{
+	char *key = xstrfmt("protocol.%s.allow", type);
+	char *value;
+
+	if (!git_config_get_string(key, &value)) {
+		enum protocol_allow_config ret =
+			parse_protocol_config(key, value);
+		free(key);
+		free(value);
+		return ret;
+	}
+	free(key);
+
+	/* known safe */
+	if (!strcmp(type, "http") ||
+	    !strcmp(type, "https") ||
+	    !strcmp(type, "git") ||
+	    !strcmp(type, "ssh") ||
+	    !strcmp(type, "file"))
+		return PROTOCOL_ALLOW_ALWAYS;
+
+	/* known scary; err on the side of caution */
+	if (!strcmp(type, "ext"))
+		return PROTOCOL_ALLOW_NEVER;
+
+	/* unknown; let them be used only directly by the user */
+	return PROTOCOL_ALLOW_USER_ONLY;
+}
+
 int is_transport_allowed(const char *type)
 {
-	const struct string_list *allowed = protocol_whitelist();
-	return !allowed || string_list_has_string(allowed, type);
+	const struct string_list *whitelist = protocol_whitelist();
+	if (whitelist)
+		return string_list_has_string(whitelist, type);
+
+	switch (get_protocol_config(type)) {
+	case PROTOCOL_ALLOW_ALWAYS:
+		return 1;
+	case PROTOCOL_ALLOW_NEVER:
+		return 0;
+	case PROTOCOL_ALLOW_USER_ONLY:
+		return git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
+	}
 }
 
 void transport_check_allowed(const char *type)
