Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E259C6FA82
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 00:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiIMAPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 20:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiIMAPi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 20:15:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7331ADA7
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 17:15:34 -0700 (PDT)
Received: (qmail 29406 invoked by uid 109); 13 Sep 2022 00:15:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Sep 2022 00:15:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19631 invoked by uid 111); 13 Sep 2022 00:15:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Sep 2022 20:15:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Sep 2022 20:15:33 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] chainlint: colorize problem annotations and test
 delimiters
Message-ID: <Yx/LpUglpjY5ZNas@coredump.intra.peff.net>
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2022 at 11:04:48PM +0000, Eric Sunshine via GitGitGadget wrote:

> @@ -585,12 +585,14 @@ sub check_test {
>  	my $parser = TestParser->new(\$body);
>  	my @tokens = $parser->parse();
>  	return unless $emit_all || grep(/\?![^?]+\?!/, @tokens);
> +	my $c = main::fd_colors(1);
>  	my $checked = join(' ', @tokens);
>  	$checked =~ s/^\n//;
>  	$checked =~ s/^ //mg;
>  	$checked =~ s/ $//mg;
> +	$checked =~ s/(\?![^?]+\?!)/$c->{bold}$c->{red}$1$c->{reset}/mg;
>  	$checked .= "\n" unless $checked =~ /\n$/;
> -	push(@{$self->{output}}, "# chainlint: $title\n$checked");
> +	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
>  }

Nice, this ended up much simpler than I feared. I thought we'd have to
touch each spot that added an annotation, and then deal with the
internal text matching (like the one in the hunk above). Being able to
do it centrally on output is much nicer.

> +my @NOCOLORS = (bold => '', reset => '', blue => '', green => '', red => '');
> +my %COLORS = ();
> +sub get_colors {
> +	return \%COLORS if %COLORS;
> +	if (exists($ENV{NO_COLOR}) ||
> +	    system("tput sgr0 >/dev/null 2>&1") != 0 ||
> +	    system("tput bold >/dev/null 2>&1") != 0 ||
> +	    system("tput setaf 1 >/dev/null 2>&1") != 0) {
> +		%COLORS = @NOCOLORS;
> +		return \%COLORS;
> +	}
> +	%COLORS = (bold  => `tput bold`,
> +		   reset => `tput sgr0`,
> +		   blue  => `tput setaf 4`,
> +		   green => `tput setaf 2`,
> +		   red   => `tput setaf 1`);
> +	chomp(%COLORS);
> +	return \%COLORS;
> +}

This is a lot of new processes. Should be OK in the run-once-for-all-tests
mode. It does make me wonder how much time regular test-lib.sh spends
doing these tput checks for every script (at least it's not every
snippet!).

It feels like we could build a color.sh snippet once and then include it
in each script. But maybe that is dumb, since you could in theory build
in one terminal and then run in another. Unlikely, but it shows that
file dependencies are a mismatch. I guess a better match would be
stuffing it into the environment before starting all of the tests.

> [...]

I ran this on my pre-fixup state where I had a half-dozen linter checks.
It's _so_ much more readable. Thanks for working on it.

-Peff
