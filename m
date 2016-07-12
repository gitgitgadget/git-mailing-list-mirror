Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB70A1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 19:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbcGLTzF (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 15:55:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64550 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750933AbcGLTzD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 15:55:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA4AC2AB8C;
	Tue, 12 Jul 2016 15:54:56 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ErWj2i9g9983
	yCwZ3cKdVWcRKMc=; b=wUgz97XK9hTV1e0w3ilf3YlGtUDdX+wHecUu2TRgeNnD
	8qIlp+c6E4GLZcIMTHVN7MBLkI+AB455L+MlIp7FsJUSDUw34GPH7YOAGz4gPuVB
	lxOThYQXUgOusbsRK7whYWXH8Ghu4unjEUS6fvCLCeryGGtQVKQfl4mMj7jwA4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vC6cPg
	cnDT3MCguDEqMG/Z7ngLXTZKqpEenaWwmlJJp0z7nR3KWNy/Gl00XArjlpD9dUFj
	Ram6BhKI4toVL19jTPyw14DE64+Jwe3WzOK7p9MfMu9PRpv5JO7UkGxHCumxIb1J
	+tpoRgiY7jrkJa5yXT/ndUimfzQa40qWHyOis=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C35FC2AB8B;
	Tue, 12 Jul 2016 15:54:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AA4D2AB8A;
	Tue, 12 Jul 2016 15:54:56 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
	<1467100876-2803-1-git-send-email-tboegi@web.de>
	<xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
	<62eb3d75-126e-427b-8701-d490e80e3501@web.de>
	<xmqq8txlvwip.fsf@gitster.mtv.corp.google.com>
	<574692d1-c8ae-9c2f-6b99-a01545b15051@telia.com>
	<xmqqa8huvmpv.fsf@gitster.mtv.corp.google.com>
	<c36fe487-b8dc-9767-7fae-bee513dac0b2@web.de>
	<xmqqr3b5p9v0.fsf@gitster.mtv.corp.google.com>
	<2cbf12a6-2dca-8180-323b-f79638aa03bd@web.de>
	<xmqqmvlsm6hu.fsf@gitster.mtv.corp.google.com>
	<f78fa94d-abd2-05a2-c411-15e2ffdb7dae@web.de>
	<xmqqoa68kl7n.fsf@gitster.mtv.corp.google.com>
	<xmqqk2gvlur5.fsf@gitster.mtv.corp.google.com>
	<xmqqinwc7xbb.fsf@gitster.mtv.corp.google.com>
	<51079140-98c8-ee0c-72d2-af5c348c19fd@web.de>
Date:	Tue, 12 Jul 2016 12:54:54 -0700
In-Reply-To: <51079140-98c8-ee0c-72d2-af5c348c19fd@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 12 Jul 2016 04:23:47
 +0200")
Message-ID: <xmqqa8hm4ooh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 81D24D8C-486A-11E6-A9E2-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

>> How do things look at this point?  This version is what I ended up
>> queuing in 'pu', but I took your "Thanks" in $gmane/299120 to only
>> mean "Thanks for feeding some ideas to help me move forward", not
>> necessarily "Tnanks that looks like the right approach." yet, so
>> right now both topics are stalled and waiting for an action from
>> you.
> Yes, the code looks good to me.
> And the commit message does explain what is going on.
>
> For my taste, these 3 lines don't explain too much,may be remove them ?
>> The test update was taken from a series by Torsten Bögershausen
>> that attempted to fix this with a different approach (which was a
>> lot more intrusive).

OK. I wanted to make sure the resulting log message not only gives
you credit for the test portion of the change, but also for the fact
that you thought long and hard about the issue.  I'll tone it down
by removing "(which was...)" part.

> So thanks for your efforts, ack from my side.

Thanks.
