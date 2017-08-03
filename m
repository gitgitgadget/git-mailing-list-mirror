Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704BF1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 19:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbdHCTLn (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 15:11:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59276 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751746AbdHCTLm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 15:11:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2DF4A6408;
        Thu,  3 Aug 2017 15:11:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fAB0ZQvy7RnteW4wmUp4To/rm2o=; b=OSSkbr
        ZF7JbeBCkuFHiYk3ZYRpeheMRQsU7fmtuyYydzi9LD6jrJm7dERqoOdiLQHUVPL/
        7z+WI9tn+h+2/vgdHcJU3Ny+wY2F5j4HDijJxs0o9fxp3cmCKrxJamoaZ5WKAPCA
        6tSW3c3WoQM2R2pbVNyvyxSDGMnbdeAFpyYOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oTpAMQJZQGkbEdH/a/XPhpbaDpf5QzhQ
        GXU4zrk862EYbUwjedJIn05JrU/qWvMT8nYHko03a+HAWCSf6Oth1rmL4a7jrkC2
        ONcziXuzTHMTaToPLNcFjStZALlsy/FJZ3K5DBMejjzuuo1CS6qxxZT6CLrrankW
        F7cngs0HQwI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B940EA6407;
        Thu,  3 Aug 2017 15:11:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F301A6406;
        Thu,  3 Aug 2017 15:11:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 04/40] Add Git/Packet.pm from parts of t0021/rot13-filter.pl
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
        <20170803091926.1755-5-chriscool@tuxfamily.org>
Date:   Thu, 03 Aug 2017 12:11:39 -0700
In-Reply-To: <20170803091926.1755-5-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 3 Aug 2017 11:18:50 +0200")
Message-ID: <xmqqo9rwxy8k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94D87488-787F-11E7-A6C2-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This will make it possible to reuse packet reading and writing
> functions in other test scripts.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  perl/Git/Packet.pm | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 perl/Git/Packet.pm
>
> diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
> new file mode 100644
> index 0000000000..aaffecbe2a
> --- /dev/null
> +++ b/perl/Git/Packet.pm
> @@ -0,0 +1,71 @@
> +package Git::Packet;
> +use 5.008;
> +use strict;
> +use warnings;
> +BEGIN {
> +	require Exporter;
> +	if ($] < 5.008003) {
> +		*import = \&Exporter::import;
> +	} else {
> +		# Exporter 5.57 which supports this invocation was
> +		# released with perl 5.8.3
> +		Exporter->import('import');
> +	}
> +}

This is merely me being curious, but do we want this boilerplate,
which we do not use in perl/Git.pm but we do in perl/Git/I18N.pm?

> +our @EXPORT = qw(
> +			packet_bin_read
> +			packet_txt_read
> +			packet_bin_write
> +			packet_txt_write
> +			packet_flush
> +		);
> +our @EXPORT_OK = @EXPORT;

We can see that you made sure that the only thing 05/40 needs to do
is to use this package and remove the definition of these subs,
without having to touch any caller by first updating the original
implementation in 03/40 and then exporting these names in 04/40.
Knowing that the preparation is nicely done already, it is a bit
irritating to see that 05/40 is a separate patch, as we need to
switch between the patches to see if there is any difference between
the original implementation of the subs, and the replacement
implemented in here.  It would have been nicer to have changes in
04/40 and 05/40 in a single patch.

