Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B01C4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 15:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290E1610CC
	for <git@archiver.kernel.org>; Thu, 27 May 2021 15:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhE0P7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 11:59:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:38932 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234071AbhE0P7H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 11:59:07 -0400
Received: (qmail 5111 invoked by uid 109); 27 May 2021 15:57:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 May 2021 15:57:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4106 invoked by uid 111); 27 May 2021 15:57:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 May 2021 11:57:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 May 2021 11:57:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 12/13] send-email: move trivial config handling to Perl
Message-ID: <YK/BbcroFTDXDdIm@coredump.intra.peff.net>
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
 <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
 <patch-12.13-3818000bfba-20210524T074932Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-12.13-3818000bfba-20210524T074932Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 24, 2021 at 09:53:01AM +0200, Ævar Arnfjörð Bjarmason wrote:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 1e9273fd4f5..1ea4d9589d8 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -324,7 +324,11 @@ sub read_config {
>  		my $target = $config_bool_settings{$setting};
>  		my $key = "$prefix.$setting";
>  		next unless exists $known_keys->{$key};
> -		my $v = Git::config_bool(@repo, $key);
> +		my $v = (@{$known_keys->{$key}} == 1 &&
> +			 (defined $known_keys->{$key}->[0] &&
> +			  $known_keys->{$key}->[0] =~ /^(?:true|false)$/s))
> +			? $known_keys->{$key}->[0] eq 'true'
> +			: Git::config_bool(@repo, $key);

Thanks for addressing this. It looks like an undefined value will kick
back to the Git::config_bool() case. That's probably fine, as I'd think
it's relatively rare (and this is all just optimization anyway).

> @@ -353,14 +357,12 @@ sub read_config {
>  		my $key = "$prefix.$setting";
>  		next unless exists $known_keys->{$key};
>  		if (ref($target) eq "ARRAY") {
> -			my @values = Git::config(@repo, $key);
> -			next unless @values;
> +			my @values = @{$known_keys->{$key}};
>  			next if $configured->{$setting}++;
>  			@$target = @values;
>  		}

I do wonder what happens for non-bool values here. I.e., would we return
a list that contains undef? Before your change, the value comes from
Git::config(), and now it comes from our pre-read $known_keys.

It seems fine either way:

  $ git -c sendemail.smtpsslcertpath send-email -1
  error: missing value for 'sendemail.smtpsslcertpath'
  fatal: unable to parse command-line config
  config --path --get sendemail.smtpsslcertpath: command returned error: 128

but I didn't carefully follow all the paths that config can take. So I
raise it only as a potential issue. Your response is hopefully "yes, I
thought of that, and it is fine." :)

-Peff
