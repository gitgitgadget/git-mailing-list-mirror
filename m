Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 810831F859
	for <e@80x24.org>; Wed, 31 Aug 2016 19:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753793AbcHaTfI (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 15:35:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59391 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753384AbcHaTfH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 15:35:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FF2B3B8AB;
        Wed, 31 Aug 2016 15:34:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9wuSHhZoNLWLF5Iu6/ml7UdcYwM=; b=OplRZ5
        6ffFCIifE/7jXEO4QN4qdHicrwxUCW9k0qlkOiIpIQiPrbuyoGrf/2fMlspt1Qwq
        +y2IIuw3BLvjQO5xnd2ep9t7PSE0FKB6dTnxX59y/XIwp0P7UenZSFNBzgopd1Vz
        4w5zq50/KOO3/gv/B3TWGxtdCXDjhM+jvB1F0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M53YDAZ3bgfnjjaYWLRlujM/UYhI0Yi4
        Dz2HSXpFpX6xaScvsTeMEH46TKjMMJvsBGDINeBdjyxNXdAwycYaTKkY50DJ90rM
        iUfQr99MkmykTJLbqBUIXbGVaf9Wfdlr9YuFyNsD/6qNXq8Ug6e2h1igMqEStL7R
        yXWyAdXccPI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2763D3B8AA;
        Wed, 31 Aug 2016 15:34:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A35353B8A9;
        Wed, 31 Aug 2016 15:34:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joe Perches <joe@perches.com>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] git-send-email: Add ability to cc: any "bylines" in the commit message
References: <aa4c9e0b37e70423baa69bc27cc9adda0f152efe.1472669418.git.joe@perches.com>
Date:   Wed, 31 Aug 2016 12:34:10 -0700
In-Reply-To: <aa4c9e0b37e70423baa69bc27cc9adda0f152efe.1472669418.git.joe@perches.com>
        (Joe Perches's message of "Wed, 31 Aug 2016 11:51:19 -0700")
Message-ID: <xmqq4m6020nh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5364A72-6FB1-11E6-A56C-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> Many commits have various forms of bylines similar to

A missing blank line (I can tweak while queuing).

>      "Acked-by: Name <address>" and "Reported-by: Name <address>"
>
> Add the ability to cc: bylines (e.g. Acked-by:) when using git send-email.
>
> This can be suppressed with --suppress-cc=bylines.
> ...
> @@ -307,8 +308,10 @@ Automating
>    patch body (commit message) except for self (use 'self' for that).
>  - 'sob' will avoid including anyone mentioned in Signed-off-by lines except
>     for self (use 'self' for that).
> +- 'bylines' will avoid including anyone mentioned in any "<foo>-by:" lines
> +  in the patch header except for Signed-off-by.

<foo> feels a bit too informal but I don't think of a better
alternative, perhaps other than "*-by:".

> @@ -1545,7 +1545,7 @@ foreach my $t (@files) {
>  	# Now parse the message body
>  	while(<$fh>) {
>  		$message .=  $_;
> -		if (/^(Signed-off-by|Cc): (.*)$/i) {
> +		if (/^(Signed-off-by|Cc|[^\s]+[\w-]by): (.*)$/i) {

I thought you wanted

		if (/^(Signed-off-by|Cc|[\w-]+-by): (.*)$/i) {

instead to avoid "O_=:;fooby: Joe Perches <joe@...>"
>  			chomp;
>  			my ($what, $c) = ($1, $2);
>  			chomp $c;
> @@ -1555,6 +1555,12 @@ foreach my $t (@files) {
>  			} else {
>  				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
>  				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
> +				next if $suppress_cc{'bylines'} and $what !~ /Signed-off-by/i and $what =~ /by$/i;

Having to keep this /by$/i in sync with whatever definition of
bylines is will be error prone.  How about doing it in this way?

	# Now parse the message body
+	my $bypat = r/[\w-]+-by/;
	while (<$fh>) {
        	...
                if (/^(Signed-off-by|Cc|$bypat): (.*)$/i) {
                	...
                        	next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
+				next if $suppress_cc{'bylines'} and
+					$what !~ /^Signed-off-by/i and
+					$what =~ /^$bypat/i;

Other than that, looking good.
