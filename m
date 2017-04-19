Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37EB6207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 02:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759218AbdDSC3E (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 22:29:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61720 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759215AbdDSC3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 22:29:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 204BE81EB4;
        Tue, 18 Apr 2017 22:29:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7kR8kQ/zSXd9fO4bPKTTsVNXzJU=; b=TbvrBX
        TtCbjVYT/OWj3DclImDsvbVUJJ32OQt5OCULjQdPPp42+pygi//aplq4+jhb3BSP
        hZkYrZpp2MjNQcknHWXT120Dqidfq6CKU3wTQUUv7vbYLs/JYNJ9A+TP3y5OqfVC
        9HJHB4RG4nr2+lb0zRYZIpq83uZ44MqMrtFos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UhSVIV9g4qvgfe0Az6YDo3JH9Ftzu57V
        Lg971P56KKXeiYl/zNhaeDuUj+p8JAjcGfmHtMQRskqhQcEhxvAQAp5XmI9M/z6t
        Jhw0XFrqwiiQB1Muz+buAmK0UaD4Zzj/vjGRozYxp6wevEcdIlv7wXqZSlgQms25
        bXCG/2Qugkg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1878B81EB3;
        Tue, 18 Apr 2017 22:29:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52B2881EB0;
        Tue, 18 Apr 2017 22:29:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Ivanov <ivanov.maxim@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: no MERGE_HEAD after octopus merge failure
References: <CALQ-8C+9dzM0cNCrK-DGiu8fc=UsS11OZbwhXWh_CDGOeGnECA@mail.gmail.com>
Date:   Tue, 18 Apr 2017 19:29:00 -0700
In-Reply-To: <CALQ-8C+9dzM0cNCrK-DGiu8fc=UsS11OZbwhXWh_CDGOeGnECA@mail.gmail.com>
        (Max Ivanov's message of "Tue, 18 Apr 2017 15:26:22 +0100")
Message-ID: <xmqqlgqxceqb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F30721A2-24A7-11E7-B270-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Ivanov <ivanov.maxim@gmail.com> writes:

> I am using git 2.12.0 and it leaves no MERGE_HEAD once octopus merge
> failed with conflicts. Is it intentional? Files have conflicts markers
> and once resolved `git commit` creates just a normal commit, which is
> very inconvenient and confusing.

I suspect you got these lines in the error message, which you didn't
read:

    Automated merge did not work.
    Should not be doing an octopus.

Octopus is designed to be done only for simple conflict-less merges,
because it makes later bisection inherently (read: not fault of the
tool, but a natural consequence of the shape of the resulting
history) less efficient.  It might have been better if we chose to
(1) refuse octopus merge if the working tree before "git merge"
starts is not clean, and(2) automatically run "git reset --hard"
when failing an octopus issuing the above error message.  But we
didn't, so you'd need to do "git reset --hard" and merge the tips
one by one, not making an octopus.


