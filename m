Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C5A92021E
	for <e@80x24.org>; Thu,  3 Nov 2016 17:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759584AbcKCRxb (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 13:53:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:38170 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759368AbcKCRxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 13:53:30 -0400
Received: (qmail 4049 invoked by uid 109); 3 Nov 2016 17:53:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 17:53:29 +0000
Received: (qmail 14987 invoked by uid 111); 3 Nov 2016 17:53:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 13:53:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2016 13:53:27 -0400
Date:   Thu, 3 Nov 2016 13:53:27 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Blake Burkhart <bburky@bburky.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103175327.nn2yasvlsxsy22be@sigill.intra.peff.net>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161103002225.GA13369@google.com>
 <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
 <20161103172515.GA182568@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161103172515.GA182568@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2016 at 10:25:15AM -0700, Brandon Williams wrote:

> > So I think this probably needs to be a separate parallel system where
> > each protocol can be white- or black-listed in a context-specific way.
> > Like:
> > 
> >   protocol.X.allow = always | user | never
> 
> It sounds like there is interest for this sort of behavior, it would
> definitely require a larger change than what I initially proposed.  One
> problem I see though is that with this we have support for both a
> blacklist and a whitelist.  Which wins?  Or do we simply generate a
> whitelist of allowed protocols which includes all protocols with allow
> set to 'always' and if it is set to 'never' then it just isn't included
> in the whitelist?

I think trying to combine the two or generate the whitelist from the
more flexible format is a recipe for madness.

I'd design the new system from scratch, and have it kick in _only_ when
GIT_ALLOW_PROTOCOL is not set. That lets existing callers continue to
have the safe behavior until they are ready to move to the new format.

Something like the patch below (which is just for illustration, and not
tested beyond compilation).

> I don't know if I'm sold on a 'user' state just yet, perhaps that's just
> because I view a whitelist or blacklist as well black and white and
> having this user state adds in a gray area.

The lack of understanding the "user" context is what makes the current
system so painful. The only way a caller can influence the system is to
hand over the policy directly: this is allowed, this is not. But systems
like "go get" should not be setting policy. They should be giving us a
hint about the context, and letting git implement the policy.

-- >8 --
diff --git a/transport.c b/transport.c
index d57e8dec2..0d5b382db 100644
--- a/transport.c
+++ b/transport.c
@@ -664,10 +664,69 @@ static const struct string_list *protocol_whitelist(void)
 	return enabled ? &allowed : NULL;
 }
 
+enum protocol_allow_config {
+	PROTOCOL_ALLOW_NEVER,
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
+	    !strcmp(type, "ssh"))
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
