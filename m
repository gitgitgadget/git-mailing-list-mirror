Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7401B1FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 17:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754294AbcLORtu (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 12:49:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60586 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754255AbcLORtt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 12:49:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 194B8575CB;
        Thu, 15 Dec 2016 12:49:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IqJ2qHarSMho5mW1mdbBB0x5apY=; b=wuuZxW
        tNFQoL2Qg+T+vgTPJ0ZhshyxYqrI16MNJ5fRqI8NSN6B5RQRY2LND+Uj+lDQWHIm
        IJ6bQwSnAacKvyfQs1PZELcygPk7iHtFH5UmXsFc0DMWpc2By01YwoXWDrDpYQPU
        nOoblWqs8CKHu5TcYWOmyqFcpDqIgayXzKRpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tQ7z1ewk1kwuZfy0FSviRrccNKYJMKIz
        bLfYnGfmZVo4njdv8LeS4zAj1RTziP5lZ7zCc+zM9424r031XLtO2WzBo/cDVOH8
        i4Uf7k1/eJQA7TSkR+Hz0UUxzL6+U/gOYzbhNeVoX0wnmmyKiDxy0DpceDtZeekG
        xW4c+e7/Cq4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11248575CA;
        Thu, 15 Dec 2016 12:49:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79E39575C7;
        Thu, 15 Dec 2016 12:49:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] fix pushing to //server/share/dir on Windows
References: <2ff2613c-47da-a780-5d38-93e16cb16328@kdbg.org>
        <20161214173034.inbyakdykjv5j7ua@sigill.intra.peff.net>
        <787a421b-8b7a-14c5-768f-06c3dc183cf4@kdbg.org>
        <c8501e28-db8a-5b6e-717c-5bda1e63c2e7@web.de>
        <20161215110155.it7ptkbju5etmnpn@sigill.intra.peff.net>
Date:   Thu, 15 Dec 2016 09:49:46 -0800
In-Reply-To: <20161215110155.it7ptkbju5etmnpn@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 15 Dec 2016 06:01:55 -0500")
Message-ID: <xmqq8trhw091.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEACD19A-C2EE-11E6-8581-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't have an opinion either way on what Windows would want, but note
> that the function already _does_ convert separators to slashes. With
> Johannes's original patch, you'd end up with a mix, like:
>
>   \\server\share/dir1/file
>
> So this conversion is really just retaining the original behavior, and
> making it consistent throughout the path.

>
> Which isn't to say that the function as it currently exists isn't a
> little bit buggy. :)
>
> One of the points of normalizing, though, is that Git can then do
> textual comparisons between the output. So I think there's value in
> having a canonical internal representation, even if the OS could handle
> more exotic ones.

E.g. the log message of d53c2c6738 ("mingw: fix t9700's assumption
about directory separators", 2016-01-27) says the two kinds of
slashes are equivalent over there, but the patch text ends up doing
exactly that normalization.

5ca6b7bb47 ("config --show-origin: report paths with forward
slashes", 2016-03-23) is an example of us trying to normalize in
order to give consistent output to the users.

Having said all that, I do not have an opinion either way on what
Windows would want, either ;-)

