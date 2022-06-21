Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146E4C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 07:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346671AbiFUHRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 03:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346040AbiFUHRH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 03:17:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D64186D5
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 00:17:05 -0700 (PDT)
Received: (qmail 30684 invoked by uid 109); 21 Jun 2022 07:17:05 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Jun 2022 07:17:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Tue, 21 Jun 2022 03:17:04 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
        git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH v2] t5510: replace 'origin' with URL more carefully (was
 Re: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1)
Message-ID: <YrFwcL2dRS/v7xAw@coredump.intra.peff.net>
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
 <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
 <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
 <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
 <484a330e-0902-6e1b-8189-63c72dcea494@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <484a330e-0902-6e1b-8189-63c72dcea494@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20, 2022 at 06:20:07PM -0400, Derrick Stolee wrote:

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 4620f0ca7fa..c255a77e18a 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -853,7 +853,9 @@ test_configured_prune_type () {
>  		then
>  			new_cmdline=$cmdline_setup
>  		else
> -			new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
> +			new_cmdline=$(printf "%s" "$cmdline" |
> +					sed -e "s~origin ~'$remote_url' ~g" \
> +					    -e "s~ origin~ '$remote_url'~g")
>  		fi

Doesn't this introduce a new problem if $remote_url contains a tilde?
Unlikely, but I thought the point of the exercise was defending against
funny paths.

Getting this bullet-proof with sed is tricky, I think. I didn't follow
all the other logic that that might need fixed, but handling this in
perl is easy by passing the string on the command line, like:

  printf "%s" "$cmdline" |
  perl -pe '
    BEGIN { $url = shift }
    s[origin(?!/)]['\''$url'\'']g;
  ' "$remote_url"

For that matter, using printf and "perl -p" is a little silly, since we
know there is only a single string to modify. Perhaps:

  perl -e '
    my ($cmdline, $url) = @ARGV;
    $cmdline =~ s[origin(?!/)]['\''$url'\'']g;
    print $cmdline;
  ' -- "$cmdline" "$remote_url"

And then further changes are easy:

  - you could replace the ad-hoc "I hope single quotes are enough"
    quoting of $url with a real regex

  - you can define $sq inside the perl script to avoid the gross '\''
    quoting (or even avoid it entirely with quotemeta)

So perhaps something like:

  perl -e '
    my ($cmdline, $url) = @ARGV;
    $cmdline =~ s[origin(?!/)][quotemeta($url)]ge;
    print $cmdline;
  ' -- "$cmdline" "$remote_url"

I don't mean to golf on this forever, but I wanted to show something
concrete since you said you don't know perl well. I just think moving to
sed introduces more opportunities for errors here, not fewer. :)

-Peff
