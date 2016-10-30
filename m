Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D38F02021E
	for <e@80x24.org>; Sun, 30 Oct 2016 08:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbcJ3IQm (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Oct 2016 04:16:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58331 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751320AbcJ3IQl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2016 04:16:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A3FE40B5D;
        Sun, 30 Oct 2016 04:16:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wUGSZPm6jlQXfbHjbwuxTzoZuTs=; b=HN1DM8
        Y75AgrUeBu6fUleMGcedNdXfTm6AHsv9MgaBLPVtfL0m6TBOdV6Vll3X+P9zsaR+
        uYlZ284DWIltd5fdQRhDcSbuIAssyr/j5Y9PCZJ1EpgTi5EVybcb8Fww1PYtCnuS
        hpaZw9N/vsulfLvpR1squq6eaKbCkAy2W5a/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s29MAzJvNUhfMbxUFlhmjCZ3i6l2YAOl
        h0CYTSXZMlbRUvcsnqPil2rQIFY90kA98ZgWZCBbZWVMknCwmzXG7TF3J0L/Ro2Q
        OeBuXWUAykXKq+KNfpPj0sYubbd8oZ+FLizHHUzOdx1Hz1P4FOrJ5xkFxGRxzQ4W
        z/ssRksWPM4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B13D40B5A;
        Sun, 30 Oct 2016 04:16:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB15C40B58;
        Sun, 30 Oct 2016 04:16:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jon Loeliger <jdl@jdl.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: Fetch/push lets a malicious server steal the targets of "have" lines
References: <1477690790.2904.22.camel@mattmccutchen.net>
        <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com>
        <1477692961.2904.36.camel@mattmccutchen.net>
        <xmqq7f8sx8lg.fsf@gitster.mtv.corp.google.com>
        <E1c0XaZ-0007Ab-QI@mylo.jdl.com>
Date:   Sun, 30 Oct 2016 01:16:37 -0700
In-Reply-To: <E1c0XaZ-0007Ab-QI@mylo.jdl.com> (Jon Loeliger's message of "Sat,
        29 Oct 2016 12:38:39 -0500")
Message-ID: <xmqqpomiuu8q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EFB51FC-9E79-11E6-B2FB-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jon Loeliger <jdl@jdl.com> writes:

> Is there an existing protocol provision, or an extension to
> the protocol that would allow a distrustful client to say to
> the server, "Really, you have Y2?  Prove it."

There is not, but I do not think it would be an effective solution.

The issue is not the lack of protocol support, but how to determine
that the other side needs such a proof for Y2 but not for other
commits.  How does your side know what makes Y2 special and why does
yout side think they should not have Y2?

Once you know how to determine Y2 is special, that knowledge can be
used to abort the "push" before even starting.  When you are pushing
back the 'master' and that 'master' reaches Y2, which must be kept
secret, you shouldn't be pushing that 'master' to them, whether they
claim to have Y2 or not.

I think the above is just a different way to say what Peff just said
(paraphrasing, do not push what is secret).
