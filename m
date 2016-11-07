Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A62C2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 20:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbcKGUof (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 15:44:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:39870 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752305AbcKGUoe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 15:44:34 -0500
Received: (qmail 8982 invoked by uid 109); 7 Nov 2016 20:44:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 20:44:33 +0000
Received: (qmail 15700 invoked by uid 111); 7 Nov 2016 20:45:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 15:45:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2016 15:44:31 -0500
Date:   Mon, 7 Nov 2016 15:44:31 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v4 2/2] transport: add protocol policy config option
Message-ID: <20161107204430.z6wrazgad4e7yn66@sigill.intra.peff.net>
References: <1478292933-7873-1-git-send-email-bmwill@google.com>
 <1478547323-47332-1-git-send-email-bmwill@google.com>
 <1478547323-47332-2-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1478547323-47332-2-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2016 at 11:35:23AM -0800, Brandon Williams wrote:

> Previously the `GIT_ALLOW_PROTOCOL` environment variable was used to
> specify a whitelist of protocols to be used in clone/fetch/push
> commands.  This patch introduces new configuration options for more
> fine-grained control for allowing/disallowing protocols.  This also has
> the added benefit of allowing easier construction of a protocol
> whitelist on systems where setting an environment variable is
> non-trivial.
> 
> Now users can specify a policy to be used for each type of protocol via
> the 'protocol.<name>.allow' config option.  A default policy for all
> unconfigured protocols can be set with the 'protocol.allow' config
> option.  If no user configured default is made git, by default, will
> allow known-safe protocols (http, https, git, ssh, file), disallow

A minor nit, but in "If no user configured default is made git, by
default, will..." the second "by default" is redundant. And possibly
misleading. This _is_ the default case, there is no other way to change
it. :)

> +protocol.<name>.allow::
> +	Set a policy to be used by protocol <name> with clone/fetch/push commands.

`<name>` isn't defined here at all.  I still think the list of protocols
should go here, but at the very least, you need to point the user to the
existing list in git(1).

>  `GIT_ALLOW_PROTOCOL`::
> -	If set, provide a colon-separated list of protocols which are
> -	allowed to be used with fetch/push/clone. This is useful to
> -	restrict recursive submodule initialization from an untrusted
> -	repository. Any protocol not mentioned will be disallowed (i.e.,
> -	this is a whitelist, not a blacklist). If the variable is not
> -	set at all, all protocols are enabled.  The protocol names
> -	currently used by git are:
> +	The preferred way to configure allowed protocols is done through the
> +	config interface, though this setting takes precedences.  See

s/precedences/precedence/.

I actually wonder if we should even drop "the preferred way" here. I had
initially thought we would want it just for backwards-compatibility, but
I actually think it is useful in its own right as a shorthand for more
complicated config (and since we have to keep it around effectively
forever anyway, there's no real cost to continuing to call it a feature
versus a deprecated feature).

I'm including a squashable patch at the end of this email with suggested
wording (and which also moves the protocol list).

> +	test_expect_success "clone $desc (env var has precedence)" '
> +		rm -rf tmp.git &&
> +		(
> +			GIT_ALLOW_PROTOCOL=none &&
> +			export GIT_ALLOW_PROTOCOL &&
> +			test_must_fail git -c protocol.$proto.allow=always clone --bare "$url" tmp.git
> +		)
> +	'

This test is a good addition in this round.

I suppose we could test also that GIT_ALLOW_PROTOCOL overrides
protocol.allow, but I'm not sure if there is a point. If git were a
black box, it's a thing I might check, but we know from the design that
this is an unlikely bug (and that the implementation is unlikely to
change in a way to cause it). So I could go either way.

> [...]

The rest of it looks good to me.

Squashable documentation suggestions are below.

-Peff

---
diff --git a/Documentation/config.txt b/Documentation/config.txt
index e89b33f9e..a9dc23f82 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2331,7 +2331,28 @@ protocol.allow::
 --
 
 protocol.<name>.allow::
-	Set a policy to be used by protocol <name> with clone/fetch/push commands.
+	Set a policy to be used by protocol `<name>` with clone/fetch/push
+	commands. See `protocol.allow` above for the available policies.
++
+The protocol names currently used by git are:
++
+--
+  - `file`: any local file-based path (including `file://` URLs,
+	    or local paths)
+
+  - `git`: the anonymous git protocol over a direct TCP
+    connection (or proxy, if configured)
+
+  - `ssh`: git over ssh (including `host:path` syntax,
+    `ssh://`, etc).
+
+  - `http`: git over http, both "smart http" and "dumb http".
+    Note that this does _not_ include `https`; if you want to configure
+    both, you must do so individually.
+
+  - any external helpers are named by their protocol (e.g., use
+    `hg` to allow the `git-remote-hg` helper)
+--
 
 pull.ff::
 	By default, Git does not create an extra merge commit when merging
diff --git a/Documentation/git.txt b/Documentation/git.txt
index c9823e34a..c52cec840 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1150,30 +1150,13 @@ of clones and fetches.
 	cloning a repository to make a backup).
 
 `GIT_ALLOW_PROTOCOL`::
-	The preferred way to configure allowed protocols is done through the
-	config interface, though this setting takes precedences.  See
-	linkgit:git-config[1] for more details.  If set to a colon-separated
-	list of protocols, behave as if `protocol.allow` is set to `never`, and
-	each of the listed protocols has `protocol.<name>.allow` set to
-	`always`.  In other words, any protocol not mentioned will be
-	disallowed (i.e., this is a whitelist, not a blacklist).  The protocol
-	names currently used by git are:
-
-	  - `file`: any local file-based path (including `file://` URLs,
-	    or local paths)
-
-	  - `git`: the anonymous git protocol over a direct TCP
-	    connection (or proxy, if configured)
-
-	  - `ssh`: git over ssh (including `host:path` syntax,
-	    `ssh://`, etc).
-
-	  - `http`: git over http, both "smart http" and "dumb http".
-	    Note that this does _not_ include `https`; if you want both,
-	    you should specify both as `http:https`.
-
-	  - any external helpers are named by their protocol (e.g., use
-	    `hg` to allow the `git-remote-hg` helper)
+	If set to a colon-separated list of protocols, behave as if
+	`protocol.allow` is set to `never`, and each of the listed
+	protocols has `protocol.<name>.allow` set to `always`
+	(overriding any existing configuration). In other words, any
+	protocol not mentioned will be disallowed (i.e., this is a
+	whitelist, not a blacklist). See the description of
+	`protocol.allow` in linkgit:git-config[1] for more details.
 
 `GIT_PROTOCOL_FROM_USER`::
 	Set to 0 to prevent protocols used by fetch/push/clone which are
