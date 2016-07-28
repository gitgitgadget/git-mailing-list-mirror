Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92A41F858
	for <e@80x24.org>; Thu, 28 Jul 2016 22:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbcG1WOy (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 18:14:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751448AbcG1WOx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 18:14:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6112A3064D;
	Thu, 28 Jul 2016 18:14:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MOfxCine0h/6XaEApDmrPzHBPsg=; b=UlUmAX
	jz+ROHo53SJQXc/z7O1JfdIgQe/E+/bIeNdJgQYfa3Cs55O3R/T4DtErsxtIKx8n
	5sZGb4iPAqMdZcgOSkdqVL0w4wGA7tOv7ktvnQ6/+EUufXp3SUkxyXXu2mptjCKy
	izsSnWH3hsLXvjQhtrMNgfMQOTE96SO14R0Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kaZ24rGi7yb7t4QlNdlIkoFQ9uPq9Udn
	CazAuQYE7pSluQiAtGXFuJSRNN0qCmJdvisl479Ng7+u8Sd7Oe/+KaZ2Ka9/vp3w
	96EUuMuLRkULVcqYyNXUNWeBN6/dOQJrQEN2PK5QKIyfwVv4mCrqX/MPsV9chHNy
	a7v4S8390ao=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 591F73064C;
	Thu, 28 Jul 2016 18:14:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA90E3064B;
	Thu, 28 Jul 2016 18:14:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
References: <20160728211149.GA371@x>
	<xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
	<20160728215603.GA22865@sigill.intra.peff.net>
Date:	Thu, 28 Jul 2016 15:14:48 -0700
In-Reply-To: <20160728215603.GA22865@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 28 Jul 2016 17:56:03 -0400")
Message-ID: <xmqq4m79qujr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3F54D52-5510-11E6-8E8D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> ...  What is most worrysome is the latter
>> half of the last sentence.  Is it really "should not be", or is it
>> merely "use of this option is just a waste of time, as you would get
>> exactly the same result anyway"?  If it is the latter, that is fine.
>
> It does what you want, and omits the in-body header when it would be
> redundant.

OK, then I would no longer be worried about that one.

> I think the original reason I did not make "--from" the default is that
> I was worried about breaking consumers which do not know how to handle
> in-body headers.

That's a fair concern.

So going back to Josh's original problem description:

    While git-send-email knows how to change the patch mails to use your own
    address as "From:" and add a "From:" line to the body for the author,
    any other tool used to send emails doesn't do that.

I wonder how these "any other tool" (that reads the format-patch
output, i.e. mbox file with one mail per file each, and sends each
as a piece of e-mail, without paying attention who you, the tool's
user, are and blindly send them with the original "From:" and other
headers intact in the header part of the message) are used in the
wild to send patch submissions.  /usr/bin/mail or /usr/bin/Mail
would not be among them, as I suspect they would place everything in
the body part, and the would do so without stripping the "From "
line that exists before each e-mail message.


