Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511C2C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F68260F6F
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhJZVSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:18:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:47420 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhJZVSe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:18:34 -0400
Received: (qmail 10629 invoked by uid 109); 26 Oct 2021 21:16:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Oct 2021 21:16:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13955 invoked by uid 111); 26 Oct 2021 21:16:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Oct 2021 17:16:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Oct 2021 17:16:09 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "commit-msg" hook unexpectedly called for "git pull
 --no-verify"
Message-ID: <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
References: <YXfwanz3MynCLDmn@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXfwanz3MynCLDmn@pflmari>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 02:11:22PM +0200, Alex Riesen wrote:

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 425950f469..428baea95b 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -84,6 +84,7 @@ static char *opt_edit;
>  static char *cleanup_arg;
>  static char *opt_ff;
>  static char *opt_verify_signatures;
> +static char *opt_no_verify;
>  static int opt_autostash = -1;
>  static int config_autostash;
>  static int check_trust_level = 1;
> @@ -160,6 +161,9 @@ static struct option pull_options[] = {
>  	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
>  		N_("abort if fast-forward is not possible"),
>  		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
> +	OPT_PASSTHRU(0, "no-verify", &opt_no_verify, NULL,
> +		N_("bypass pre-merge-commit and commit-msg hooks"),
> +		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
>  	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
>  		N_("verify that the named commit has a valid GPG signature"),
>  		PARSE_OPT_NOARG),

OK, so we failed to pass through --no-verify, because it got caught as a
prefix of --verify-signatures, since the outer parse-options didn't know
about it. Makes sense, and I suppose this has been broken since
11b6d17801 (pull: pass git-merge's options to git-merge, 2015-06-14).

I was going to ask whether this should be passing through "verify", and
allowing its "no-" variant, but there is no "--verify" in git-merge.
Arguably there should be (for consistency and to countermand an earlier
--no-verify), but that is outside the scope of your fix (sadly if
somebody does change that, they'll have to remember to touch this spot,
too, but I don't think it can be helped).

> +test_expect_success 'git pull --no-verify flag passed to merge' '
> +	test_when_finished "rm -fr src dst actual" &&
> +	git init src &&
> +	test_commit -C src one &&
> +	git clone src dst &&
> +	echo false >dst/.git/hooks/commit-msg &&
> +	chmod +x dst/.git/hooks/commit-msg &&

This script without #! should work portably, I think, though we
generally prefer using the helper (which also handles the chmod):

  write_script dst/.git/hooks/commit-msg <<-\EOF
  false
  EOF

Other than that nit, this looks good to me.

-Peff
