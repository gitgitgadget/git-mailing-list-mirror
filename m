Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA1F1F856
	for <e@80x24.org>; Thu,  8 Sep 2016 21:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758923AbcIHVax (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 17:30:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51359 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758092AbcIHVax (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 17:30:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C41AA3BF5B;
        Thu,  8 Sep 2016 17:30:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nm7dM8WAH8hDQSzgEAzOLnhpFzE=; b=Ws+MFG
        mwOBRFa7vWm4h8C65P65in34ZQr+JinNUPX6vP9Jwn/dTSCns7d3ON4NEGR57RnM
        7/Hx4f7fqWYRfwo7UUN6pStBrz4FYloig8LzmZY0RLXUemzuBa5GcdxdwZ0TceCJ
        gEn0NaWIQZSxXGUv6U1WQGTRfhPFGelhd0/Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BqTA3CVOL8dtwidenCV9qjdNi2bzBZsc
        dxFa9vdh3fwIJhvAg4U1rJIzvujy77w8ogMQh2ORzwIqhdUdorm+yZAQbxYS6vBT
        zVFUlaKiz5QVjK4z1XqWj8viWurkgnCiYSHhEOJFoMITRMZakAo3rv28V/Uy2BjJ
        Ho15T+My5rQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBE683BF5A;
        Thu,  8 Sep 2016 17:30:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E10D3BF59;
        Thu,  8 Sep 2016 17:30:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Use the newly-introduced regexec_buf() function
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
        <cover.1473319844.git.johannes.schindelin@gmx.de>
        <324ecba64eb0436988aca846fb444eafda290d13.1473319844.git.johannes.schindelin@gmx.de>
        <alpine.DEB.2.20.1609080954010.129229@virtualbox>
        <20160908081024.yku2xlb3jj4rplkp@sigill.intra.peff.net>
        <20160908081446.zlcmz6ci4cw4vc2e@sigill.intra.peff.net>
        <20160908083509.ygh4flpunyyp4hua@sigill.intra.peff.net>
        <ac0f3441-d28f-fc5c-0273-f614b2cd4e07@ramsayjones.plus.com>
        <20160908195300.votzp3ysxewc2mip@sigill.intra.peff.net>
Date:   Thu, 08 Sep 2016 14:30:49 -0700
In-Reply-To: <20160908195300.votzp3ysxewc2mip@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 8 Sep 2016 15:53:00 -0400")
Message-ID: <xmqq8tv2f59y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8409F694-760B-11E6-9D00-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> commit f96e5673 ("grep: use REG_STARTEND for all matching if available",
>> 22-05-2010) introduced this test and expects ".. NUL characters themselves
>> are not matched in any way". With the native library on cygwin they are
>> matched, with the compat/regex they are not. Indeed, if you use the system
>> 'grep' command (rather than 'git grep'), then it will also not match ... :-D
>> 
>> Slightly off topic, but ...
>
> Hmm. So it sounds like the "regmatch" in grep.c could go away in favor
> of Johannes's regexec_buf(), and cygwin ought to be using NO_REGEX.

Sounds like a plan.
