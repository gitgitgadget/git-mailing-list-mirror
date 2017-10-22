Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07C821FF72
	for <e@80x24.org>; Sun, 22 Oct 2017 01:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932301AbdJVBMj (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 21:12:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55778 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932271AbdJVBMi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 21:12:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 391359BB3D;
        Sat, 21 Oct 2017 21:12:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uFA2+KgXw1u21dzMHCszSO5xhuM=; b=YEhNZO
        Z8cU6gVQh9qrPSrt4DmV8uCEjvptBdB0MOtcmpl8nNuURr3IkWXktzCAsKt9x0c0
        FdVXR8KVJae41S8XDp4SSEUhsyK5Urd0cXvD2pTkTAn377QpIY3/ZJ8VQY4Wpaez
        pZWGt1SzfIWwLIvkHcu9u5hSiBsPWeiVPB+18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NYT/2fCtl9XyGnnHj6vmfXdqPJFHHJ92
        ONI/ZAHRqmBMiBWBgmQVZmNH1mD35BVJYFR8hkugHrBQmYT5SOhz9/53J1poxXyf
        ZV8j6bY+s0+Z+4C3Gei8KDRQib2HJD4Irz4jPL19fBYwPFJ89sb3f+wdkuOM2dLR
        MlYO5rmisy4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 317B29BB3C;
        Sat, 21 Oct 2017 21:12:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91B3F9BB39;
        Sat, 21 Oct 2017 21:12:37 -0400 (EDT)
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
Subject: Re: [PATCH 4/6] t0021/rot13-filter: add packet_initialize()
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
        <20171019123030.17338-5-chriscool@tuxfamily.org>
Date:   Sun, 22 Oct 2017 10:12:36 +0900
In-Reply-To: <20171019123030.17338-5-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 19 Oct 2017 14:30:28 +0200")
Message-ID: <xmqqvaj8dlyz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17C7F36C-B6C6-11E7-9376-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +sub packet_initialize {
> +	my ($name, $version) = @_;
> +
> +	( packet_txt_read() eq ( 0, $name . "-client" ) )       || die "bad initialize";
> +	( packet_txt_read() eq ( 0, "version=" . $version ) )   || die "bad version";
> +	( packet_bin_read() eq ( 1, "" ) )                      || die "bad version end";

This is not a new issue and it is a bit surprising that nobody
noticed when edcc8581 ("convert: add filter.<driver>.process
option", 2016-10-16) was reviewed, but the above is quite broken.
packet_txt_read() returns a 2-element list, and on the right hand
side of "eq" also has a list with (two, elements), but this takes
the last element of the list on each side, and compares them.  The
elading 0/1 we see above do not matter, which means we do not require
to see a flush at the end of the version---a simple empty string or
an EOF would do, which is definitely not what we want.

	#!/usr/bin/perl
	sub p {
		my ($res, $buf) = @_;
		return ($res, $buf);
	}
	if (p(0, "") eq (-1, 2, 3, "")) { print "ok\n"; }

It is fine to leave the original code broken at this step while we
purely move the lines around, and hopefully this will be corrected
in a later step in the series (I am responding as I read on, so I do
not yet know at which patch that happens in this series).

Thanks.
