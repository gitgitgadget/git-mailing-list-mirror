Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F65C83F12
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 14:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjH1Omf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 10:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjH1OmU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 10:42:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC79A1
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 07:42:17 -0700 (PDT)
Received: (qmail 29120 invoked by uid 109); 28 Aug 2023 14:42:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 14:42:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32402 invoked by uid 111); 28 Aug 2023 14:42:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 10:42:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 10:42:15 -0400
From:   Jeff King <peff@peff.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/log.c: prepend "RFC" on --rfc
Message-ID: <20230828144215.GA2537587@coredump.intra.peff.net>
References: <20230828125132.25144-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828125132.25144-1-sir@cmpwn.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2023 at 02:50:34PM +0200, Drew DeVault wrote:

> Rather than replacing the configured subject prefix (either through the
> git config or command line) entirely with "RFC PATCH", this change
> prepends RFC to whatever subject prefix was already in use.
> 
> This is useful, for example, when a user is working on a repository that
> has a subject prefix considered to disambiguate patches:
> 
> 	git config format.subjectPrefix 'PATCH my-project'
> 
> Prior to this change, formatting patches with --rfc would lose the
> 'my-project' information.

This sounds like a good change to me. It would be backwards-incompatible
for anybody expecting:

  git format-patch --subject=foo --rfc

to override the --subject line, but that seems rather unlikely.

> Implementation note: this introduces a small memory leak, but freeing it
> requires a non-trivial amount of refactoring and some dubious choices
> that I was not sure of for a small patch; and it seems like memory leaks
> in this context are tolerated anyway from a perusal of the existing
> code.

We do have a lot of small leaks like this, but we've been trying to
clean them up slowly. There's some infrastructure in the test suite for
marking scripts as leak-free, but t4014 is not yet there, so this
won't cause CI to complain at this point.

It is tempting while we are here and thinking about it to put in an easy
hack, like storing the allocated string in a static variable.

>  static int rfc_callback(const struct option *opt, const char *arg, int unset)
>  {
> +	int n;
> +	char *prefix;
> +	const char *prev;
> +
>  	BUG_ON_OPT_NEG(unset);
>  	BUG_ON_OPT_ARG(arg);
> -	return subject_prefix_callback(opt, "RFC PATCH", unset);
> +
> +	prev = ((struct rev_info *)opt->value)->subject_prefix;
> +	assert(prev != NULL);
> +	n = snprintf(NULL, 0, "RFC %s", prev);
> +	assert(n > 0);
> +	prefix = xmalloc(n + 1);
> +	n = snprintf(prefix, n + 1, "RFC %s", prev);
> +	assert(n > 0);
> +
> +	return subject_prefix_callback(opt, prefix, unset);
>  }

We try to avoid manually computing string sizes like this, since it's
error-prone and can be subject to integer overflow attacks (not in this
case, but every instance makes auditing harder). You can use xstrfmt()
instead.

Coupled with the leak-hack from above, maybe just:

diff --git a/builtin/log.c b/builtin/log.c
index db3a88bfe9..579c3a2419 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1476,9 +1476,19 @@ static int subject_prefix_callback(const struct option *opt, const char *arg,
 
 static int rfc_callback(const struct option *opt, const char *arg, int unset)
 {
+	/*
+	 * "avoid" leak by holding on to a reference to the memory, since we
+	 * need the string for the lifetime of the process anyway
+	 */
+	static char *prefix;
+
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
-	return subject_prefix_callback(opt, "RFC PATCH", unset);
+
+	free(prefix);
+	prefix = xstrfmt("RFC %s", ((struct rev_info *)opt->value)->subject_prefix);
+
+	return subject_prefix_callback(opt, prefix, unset);
 }
 
 static int numbered_cmdline_opt = 0;

The rest of the patch (docs and tests) looked good to me.
