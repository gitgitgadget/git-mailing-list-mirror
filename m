Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53894C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA01610A1
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347209AbhESJy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 05:54:57 -0400
Received: from coleridge.oriole.systems ([89.238.76.34]:42450 "EHLO
        coleridge.oriole.systems" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347559AbhESJyT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 05:54:19 -0400
Date:   Wed, 19 May 2021 11:52:35 +0200
From:   Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rev-parse: fix segfault with missing
 --path-format argument
Message-ID: <20210519095235.cydjlj2qoko6xm4v@nabokov.fritz.box>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20210516120449.661636-1-wolf@oriole.systems>
 <20210517080243.10191-1-wolf@oriole.systems>
 <20210517080243.10191-2-wolf@oriole.systems>
 <YKImcgntKHryLLfv@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKImcgntKHryLLfv@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-17 04:16, Jeff King wrote:

> I don't have a strong preference for one or the other. It is maybe
> helpful to diagnose "--path-format" without an equals as an error, as
> your patch would, rather than quietly passing it along as an unknown
> (as the hunk above would). I dunno. That perhaps applies to the rest
> of the options, too. :)

I have a very slight preference for throwing an error: that is what I
expected to happen as a user. At the same time, passing it along as an
unknown seems more consistent with the other options that take equals.
I'm split on this, and would defer to what people here prefer.

Short of fully migrating to the parse-options API, I do not see a
perfect solution for this, especially since there are options that take
optional arguments which are not delimited by equals. These seem to be
sprinkled throughout and all error out if no argument is given.

Here's a small selection:

	Option                   Section in manual        Parser

	--default <arg>          Options for Output       manual
	--prefix <arg>           Options for Output       manual
	--short[=length]         Options for Output       opt_with_value
	--path-format=[..]       Options for Files        opt_with_value
	--git-path <path>        Options for Files        manual
	--disambiguate=<prefix>  Options for Objects      skip_prefix

Out of curiosity I decided to dig around a bit, my hunch being that
arguments without equals are older.

I can trace --default back to 178cb24338 (Add 'git-rev-parse' helper
script, 2005-06-13). That seems to be the very first version of
git-rev-parse.

The first options with equals, --since= et al., were added in c1babb1d65
([PATCH] Teach "git-rev-parse" about date-based cut-offs, 2005-09-20)

The --short option used to be --abbrev, and was added in d50125085a
(rev-parse: --abbrev option., 2006-01-25). Then, quite a bit later, the
second option without equals was added in abc06822af (rev-parse: add
option --resolve-git-dir <path>, 2011-08-15).

--prefix goes back to 12b9d32790 (rev-parse: add --prefix option,
2013-06-16) and --git-path is 557bd833bb (git_path(): be aware of file
relocation in $GIT_DIR, 2014-11-30)

So it turns out that my hunch was not really correct. Maybe there's also
a pattern that I am not seeing. Obviously this has no bearing on the
segfault fix, but is maybe valuable information for a conversion to the
parse-options API down the line. It was also fun to figure out, since I
could not stop thinking about rev-parse having a bunch of different
option semantics.

-- 
Wolfgang
