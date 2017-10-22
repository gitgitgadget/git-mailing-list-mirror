Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46BF91FF72
	for <e@80x24.org>; Sun, 22 Oct 2017 00:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932278AbdJVA6H (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 20:58:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58125 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932269AbdJVA6G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 20:58:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64F819B6E3;
        Sat, 21 Oct 2017 20:58:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HFrnYqNlsx7LjFuZkKtwFNojBxY=; b=dIeZ1+
        Do5JVqgrDqmUFLnI/Hl3Fo6DvL/EBqWS7iPw3yG6uXYW7xEJar8bndmTEjlVKLR/
        0+IBBSurhAYoaOraqWuES4yVX3UV0CEBJlBJPof4vv85EolJGsD3Sa/fhIMMY5fV
        tniVAJlJ5PoECoX4BFs6mjhIa06egUyIuNgVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xF7WrZvNtuI4GMkuHuuwu0XYZHjY2xgA
        VBwHp+sJTFwp/FteuWUDImuz2dbyWtZ6zk9QwqH1vafU5KclhrayWENHUti9yBD9
        zLEjySR2SxO1fq+S94+B7ilqTTEFcFHIZAqc76EOM2ms4Nkf442+i5UUrjRlI0K/
        cvkWXABA448=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A7C79B6E2;
        Sat, 21 Oct 2017 20:58:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF1A29B6E1;
        Sat, 21 Oct 2017 20:58:05 -0400 (EDT)
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
Subject: Re: [PATCH 1/6] t0021/rot13-filter: refactor packet reading functions
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
        <20171019123030.17338-2-chriscool@tuxfamily.org>
Date:   Sun, 22 Oct 2017 09:58:04 +0900
In-Reply-To: <20171019123030.17338-2-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 19 Oct 2017 14:30:25 +0200")
Message-ID: <xmqq4lqsf17n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 101916FC-B6C4-11E7-A1BF-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> To make it possible in a following commit to move packet
> reading and writing functions into a Packet.pm module,
> let's refactor these functions, so they don't handle
> printing debug output and exiting.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t0021/rot13-filter.pl | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> index ad685d92f8..e4495a52f3 100644
> --- a/t/t0021/rot13-filter.pl
> +++ b/t/t0021/rot13-filter.pl
> @@ -60,8 +60,7 @@ sub packet_bin_read {
>  	my $bytes_read = read STDIN, $buffer, 4;
>  	if ( $bytes_read == 0 ) {
>  		# EOF - Git stopped talking to us!
> -		print $debug "STOP\n";
> -		exit();
> +		return ( -1, "" );
>  	}
>  	elsif ( $bytes_read != 4 ) {
>  		die "invalid packet: '$buffer'";
> @@ -85,7 +84,7 @@ sub packet_bin_read {
>  
>  sub packet_txt_read {
>  	my ( $res, $buf ) = packet_bin_read();
> -	unless ( $buf eq '' or $buf =~ s/\n$// ) {
> +	unless ( $res == -1 or $buf eq '' or $buf =~ s/\n$// ) {
>  		die "A non-binary line MUST be terminated by an LF.";
>  	}
>  	return ( $res, $buf );
> @@ -131,7 +130,12 @@ print $debug "init handshake complete\n";
>  $debug->flush();
>  
>  while (1) {
> -	my ( $command ) = packet_txt_read() =~ /^command=(.+)$/;
> +	my ( $res, $command ) = packet_txt_read();
> +	if ( $res == -1 ) {
> +		print $debug "STOP\n";
> +		exit();
> +	}
> +	$command =~ s/^command=//;
>  	print $debug "IN: $command";
>  	$debug->flush();

This was not an issue in the old code which died upon unexpected EOF
inside the lowest-level helper packet_bin_read(), but now you have
one call to packet_bin_read() and many calls to packet_txt_read()
whose return value is not checked for this new condition you are
allowing packet_bin_read() to return.  This step taken alone is a
regression---let's see how the remainder of the series updates the
callers to compensate.

I initially thought that it may be more Perl-ish to return undef or
string instead of returning a 2-element list, but this code needs to
distinguish three conditions (i.e. a normal string that is 0 or more
bytes long, a flush, and an EOF), so that is not sufficient.  Perl
experts on the list still may be able to suggest a better way than
the current one to do so, but that is outside the scope of this
refactoring.

Thanks for starting to work on this.

