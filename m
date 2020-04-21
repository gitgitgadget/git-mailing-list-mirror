Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517F7C54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 19:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 305FD2072D
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 19:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EVBr+w3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgDUTQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:16:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61669 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgDUTQz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 15:16:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E243661B2D;
        Tue, 21 Apr 2020 15:16:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UDiDdpVrWw5kUPELu6TiRQpGcsU=; b=EVBr+w
        3gOXJr7OU+MwTEHjeqTh/e9othSqNKgc4FNgqnlzvf+94oviVCi51zq7yygmQM7K
        NU9H9/paw6Cy+a/AlH0ESDDhQoEG2VKyiQKPu386esqZXf0QG7zxNyIC+cj7I7rV
        p0x9eVEHxqxmCd3QyjO0O+rhBQhF9CwTZBeLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AqhBIQowFwMU7bI6RjRHfqPk2nD88+BV
        VacSMpHWxnejIEzrGwnYaWHIQXwqOY7e84iQMVAjVWh4Uouz7yJffAjqYAm0eZd7
        tOMa6RQ4x7nzCikDm+V9eq1ArD7pUwj3d9sLplmVtbmEOQekPIcCq6/UTSsbWay0
        4EhD7zCqnfA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D73A661B2C;
        Tue, 21 Apr 2020 15:16:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6315761B2B;
        Tue, 21 Apr 2020 15:16:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "Dixit\, Ashutosh" <ashutosh.dixit@intel.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Bug in 2.26: git-fetch fetching too many objects?
References: <878siqxiu0.wl-ashutosh.dixit@intel.com>
        <20200421064541.GG96152@google.com>
Date:   Tue, 21 Apr 2020 12:16:51 -0700
In-Reply-To: <20200421064541.GG96152@google.com> (Jonathan Nieder's message of
        "Mon, 20 Apr 2020 23:45:41 -0700")
Message-ID: <xmqqblnkodi4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A829493E-8404-11EA-BC6E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> (+cc: Jonathan Tan, fetch negotiation expert)
> Hi,
>
> Dixit, Ashutosh wrote:
>
>> I am seeing a strange behavior in git-fetch in 2.26. I frequently fetch
>> from a couple of linux kernel remotes (so you will have an idea how big the
>> repo is). I have a different system with 2.20 on which I never see a
>> problem.
> ...
> I suspect this is related to the change that protocol v2 does to use
> stateless-rpc even in stateful protocols.  If my suspicion is correct,
> then the same behavior would show up with protocol v0 over http and
> https as well.

Thanks.  

This is at least the fourth time we hear that v2 may not be ready
for the real-world use.  Perhaps we should revert the default flip
on the maintenance track while we hunt for bugs and improve the
protocol support?

