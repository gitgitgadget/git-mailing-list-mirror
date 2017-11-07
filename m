Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BA9720A10
	for <e@80x24.org>; Tue,  7 Nov 2017 01:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934917AbdKGBBB (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 20:01:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51734 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932512AbdKGBA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 20:00:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 412399AC99;
        Mon,  6 Nov 2017 20:00:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2QGG0KQtUV0AEkEvtiojslrPLMQ=; b=CnlO+s
        D4Pnzx34Fzau3XsOo+yL1HvqahOgwMLWyukdL26u10kiU5DYqaaUBT8hkaNAeY8s
        E7LufknjDlZd92b1xASKzfUGL/pLqzJ7yqoaAqjO3w/cAKPycVxU/9usHx+ZKzXv
        ph83XZ3fh0AAgw4tJ7tNgizToaKRZPKWo8Lnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mMTd1sYuMEiXpDC6kbKMokIqIL/fiYoJ
        CDhBKUnZJCz01vbjtDdiWAbd6+Jk7CusF/OKo30TPWPrOVORJ1Y+elAGO71NJldn
        KcAVXu99bUsCgee1yWn8RT7anD+mky8DJefDECE3RC6P06zeDzkgdfiA5Vwpxun+
        p2O4RF+14Jo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 369329AC98;
        Mon,  6 Nov 2017 20:00:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8280F9AC94;
        Mon,  6 Nov 2017 20:00:57 -0500 (EST)
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
Subject: Re: [PATCH v2 1/8] t0021/rot13-filter: fix list comparison
References: <20171105213836.11717-1-chriscool@tuxfamily.org>
        <20171105213836.11717-2-chriscool@tuxfamily.org>
Date:   Tue, 07 Nov 2017 10:00:56 +0900
In-Reply-To: <20171105213836.11717-2-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 5 Nov 2017 22:38:29 +0100")
Message-ID: <xmqqvaimhph3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D1E83F6-C357-11E7-BE78-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +sub packet_compare_lists {
> +	my ($expect, @result) = @_;
> +	my $ix;
> +	if (scalar @$expect != scalar @result) {
> +		return undef;
> +	}
> +	for ($ix = 0; $ix < $#result; $ix++) {
> +		if ($expect->[$ix] ne $result[$ix]) {
> +			return undef;
> +		}
> +	}
> +	return 1;
> +}
> +
>  sub packet_bin_read {
>  	my $buffer;
>  	my $bytes_read = read STDIN, $buffer, 4;
> @@ -110,18 +124,25 @@ sub packet_flush {
>  print $debug "START\n";
>  $debug->flush();
>  
> -( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
> -( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
> -( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";
> +packet_compare_lists([0, "git-filter-client"], packet_txt_read()) ||
> +	die "bad initialize";

For now this should do, but the "packet_compare_lists" may later
want to become more specific to the needs of these callers.  It
tries to be a generic comparison function for list of strings, but
what these callers feed is always two-element tuple, whose first
element is an integer (not just a random thing that can be made into
a string to be compared with "ne") and whose second element is a
string.

