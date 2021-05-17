Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7020C43460
	for <git@archiver.kernel.org>; Mon, 17 May 2021 08:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998B56108D
	for <git@archiver.kernel.org>; Mon, 17 May 2021 08:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbhEQIT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 04:19:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:56068 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235597AbhEQISo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 04:18:44 -0400
Received: (qmail 4501 invoked by uid 109); 17 May 2021 08:16:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 May 2021 08:16:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26492 invoked by uid 111); 17 May 2021 08:16:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 May 2021 04:16:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 May 2021 04:16:50 -0400
From:   Jeff King <peff@peff.net>
To:     Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rev-parse: fix segfault with missing
 --path-format argument
Message-ID: <YKImcgntKHryLLfv@coredump.intra.peff.net>
References: <20210516120449.661636-1-wolf@oriole.systems>
 <20210517080243.10191-1-wolf@oriole.systems>
 <20210517080243.10191-2-wolf@oriole.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210517080243.10191-2-wolf@oriole.systems>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 10:02:42AM +0200, Wolfgang Müller wrote:

> Calling "git rev-parse --path-format" without an argument segfaults
> instead of giving an error message. Commit fac60b8925 (rev-parse: add
> option for absolute or relative path formatting, 2020-12-13) added the
> argument parsing code but forgot to handle NULL.
> 
> Returning an error makes sense here because there is no default value we
> could use. Add a test case to verify.
> 
> Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
> ---
>  builtin/rev-parse.c  | 2 ++
>  t/t1500-rev-parse.sh | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 85bad9052e..7af8dab8bc 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -759,6 +759,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				continue;
>  			}
>  			if (opt_with_value(arg, "--path-format", &arg)) {
> +				if (!arg)
> +					die("--path-format requires an argument");
>  				if (!strcmp(arg, "absolute")) {
>  					format = FORMAT_CANONICAL;
>  				} else if (!strcmp(arg, "relative")) {

This looks like a fine solution, but I do think this code using
opt_with_value() is a bit of a curiosity in the first place. I looked at
the other callers (because I wanted to see if there were similar
problems), and they are all cases where the argument is truly optional
(so matching "--foo" or "--foo=bar" is correct, and matching "--foo bar"
would be actively wrong).

For cases where the argument is not optional, we seem to use
skip_prefix(), like:

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c4263404bd..9553cc7c10 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -760,7 +760,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					show(arg);
 				continue;
 			}
-			if (opt_with_value(arg, "--path-format", &arg)) {
+			if (skip_prefix(arg, "--path-format=", &arg)) {
 				if (!strcmp(arg, "absolute")) {
 					format = FORMAT_CANONICAL;
 				} else if (!strcmp(arg, "relative")) {

I don't have a strong preference for one or the other. It is maybe
helpful to diagnose "--path-format" without an equals as an error, as
your patch would, rather than quietly passing it along as an unknown (as
the hunk above would). I dunno. That perhaps applies to the rest of the
options, too. :)

(In an ideal world, we would probably match "--path-format <arg>" here,
as our usual parse-options API does. But that is a much bigger change).

-Peff
