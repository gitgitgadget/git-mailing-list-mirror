Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE18C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 00:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1F020809
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 00:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgIPAjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 20:39:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:57010 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbgIONFS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 09:05:18 -0400
Received: (qmail 12225 invoked by uid 109); 15 Sep 2020 13:05:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Sep 2020 13:05:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17783 invoked by uid 111); 15 Sep 2020 13:05:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Sep 2020 09:05:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Sep 2020 09:05:06 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: sub-fetches discard --ipv4|6 option
Message-ID: <20200915130506.GA2839276@coredump.intra.peff.net>
References: <20200914121906.GD4705@pflmari>
 <20200914194951.GA2819729@coredump.intra.peff.net>
 <20200915115025.GA18984@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915115025.GA18984@pflmari>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 15, 2020 at 01:50:25PM +0200, Alex Riesen wrote:

> > So your patch above looks quite sensible (modulo useful bits like a
> > signoff and maybe a test, though I guess the impact of those options
> > is probably hard to cover in our tests).
> 
> I tried to come up with one, but (aside from rather pointless checking of
> option presence in the trace output) failed to.
> 
> Or may be precisely this could be the point of the test: just do a fetch with
> all options we intend to pass down to sub-fetches and check that they are
> indeed present in the invocation of fetch --all/--multiple/--recurse-submodules?

Unfortunately I don't think that accomplishes much, since the main bug
we're worried about is missing options. And it would require somebody
adding the new options to the test, at which point you could just assume
they would add it to add_options_to_argv().

Though I guess we can automatically get the list of options these days.
So perhaps something like:

  subopts=
  for opt in $(git fetch --git-completion-helper)
  do
        case "$opt" in
        # options that we know do not go to sub-fetches
        --all|--jobs|etc...)
                ;;
	# try/match only the positive versions
	--no-*)
	        ;;
	# give a fake value for options with values
	*=)
                subopts="$subopts ${opt}1"
		;;
	# and pass through any boolean options
	*)
                subopts="$subopts $opt"
		;;
        esac
  done
  GIT_TRACE=$PWD/trace.out git fetch --all $subopts
  perl -lne '
    BEGIN { @want = @ARGV; @ARGV = () }
    /run_command: git fetch (.*)/ and $seen{$_}++ for split(/ /, $1);
    END { print for grep { !$seen{$_} } @want }
  ' <trace.out -- $subopts

Except that doesn't quite work, because the parent fetch will complain
about nonsense values (e.g., --filter=1). So it would probably need a
bit more manual intelligence to cover those options. It looks like some
options are mutually exclusive, too (--deepen/--depth), so maybe we'd
need to run an individual "fetch --all" for each option.

I dunno. It's getting pretty complicated. :)

> > It is rather unfortunate that anybody adding new fetch options needs to
> > remember to (maybe) add them to add_options_to_argv() themselves.
> 
> Maybe make add_options_to_argv to go through builtin_fetch_options[] and copy
> the options with a special marker if they were provided?
> And use the word "recursive" in help text as the marker :)

Yeah, that would solve the duplication problem. We could probably add a
"recursive" bit to the parse-options flag variable. Even if
parse-options itself doesn't use it, it could be a convenience for
callers like this one. It is a little inconvenient to set flags there,
just because it usually means ditching our wrapper macros in favor of a
raw struct declaration.

> Sure! Thinking about it, I actually would have preferred to have both: a
> config option and a command-line option. So that I can set --ipv4 in, say,
> ~/.config/git/config file, but still have the option to try --ipv6 from time
> to time to check if the network setup magically fixed itself.
> 
> What would the preferred name for that config option be? fetch.ipv?

It looks like we've got similar options for clone/pull (which are really
fetch under the hood of course) and push. We have the "transfer.*"
namespace which applies to both already. So maybe "transfer.ipversion"
or something?

-Peff
