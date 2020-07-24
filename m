Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9013BC433E4
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 01:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7EC22BEA
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 01:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OiRF5wXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgGXBT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 21:19:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65466 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGXBT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 21:19:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45546D65EF;
        Thu, 23 Jul 2020 21:19:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CXdPfGH09gCmeDgRiLOTOl2TAN8=; b=OiRF5w
        XFMAX0iWkLJA4jGEbCdoZo7Y4a8HIN0k4x1wVhhDvrq2hN9x30CaaLldLtJNRxsE
        4Jb36UAnjGOMas1lPM1TDFPO48GCFoXYCA6cdkrrdarEseLiqamAXY23PnNRQR7T
        c3DZCQ3EDaa1TI/nmZiKbfzfs9nyw8YjNx+94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qVnFwXd6b5PCfPPv1wAVjbYhddTQZezx
        etz/0Vkd7EwA7iAQPZ252OCECH0LwumQRIz7HZKm1oEe/2DBcQH2jEMFfKq8rD0h
        vyaNfOjGIrZHJ8+5ECP9ADhCd7pFilcT5wSMduFY67j2LzYzKuwwsFYXNMVJxXee
        vmKZzjQrirs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2CAD9D65EE;
        Thu, 23 Jul 2020 21:19:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 76832D65ED;
        Thu, 23 Jul 2020 21:19:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
        <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
        <20200722074530.GB3306468@coredump.intra.peff.net>
        <xmqqmu3r5umr.fsf@gitster.c.googlers.com>
        <20200723182549.GB3975154@coredump.intra.peff.net>
Date:   Thu, 23 Jul 2020 18:19:19 -0700
In-Reply-To: <20200723182549.GB3975154@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 23 Jul 2020 14:25:49 -0400")
Message-ID: <xmqqk0ytn208.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B409ABE6-CD4B-11EA-B8FE-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> sub flush {
>   print @ours;
>   print "|||||||\n";
>   show_diff(base => \@base, ours => \@ours);
>   print "|||||||\n";
>   show_diff(base => \@base, theirs => \@theirs);
>   print "=======\n";

Before this gets called, "<<<<<<<\n" from the original has been
emitted to the output, so this shows

	<<<<<<<
	version from ours
	|||||||
	output from diff -u base ours
	|||||||
	output from diff -u base theirs
	=======
	version from theirs

   print @theirs;
>   @ours = @base = @theirs = ();
> }

Unfortunately, there is no ">>>>>>>" shown with this code, as $_
seems to get clobbered before the sub returns, so ...

> sub state_theirs {
>   if (/^>{7}/) { flush(); print; $state = \&state_none }
>   else { push @theirs, $_ }
> }

... that "print" does not do what we want it to do.

Localizing the $_ upfront in the show_diff sub should probably be
sufficient.  That is ...

> sub show_diff {
>   my ($pre_name, $pre_data, $post_name, $post_data) = @_;

+  local ($_);

... here.

>
>   my $pre = File::Temp->new;
>   print $pre @$pre_data;

I am debating myself if I want to see the base version between these
two extra diffs.  Perhaps there is no need, as either one of these
two extra diffs should be sufficient to see what was in the base
version.

Thanks.
