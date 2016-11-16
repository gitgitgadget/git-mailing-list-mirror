Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73BBE2042F
	for <e@80x24.org>; Wed, 16 Nov 2016 23:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933562AbcKPXq3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 18:46:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59932 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753478AbcKPXq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 18:46:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A89D650EE6;
        Wed, 16 Nov 2016 18:46:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2JhG5XnhKlPA
        N+ejdUt2z64+vnc=; b=I2+5TCJhj+Y5JxNF5QMda0sKK1ev70R2y+smYLTCnIMf
        O6zgoRZyFJVoRtGmq4VL+lHEDCYcdYkvooqJCfaBPDPP8C2TbeADdDWpEhaNcNsD
        k+as9+MZo0gfHtOOKh2UrKx7jv2MO7xh8iQquCBmtN8IJxRnqJ7nW89RC0C/ZKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=d1rToi
        IEFNc7uTOGyKt5b2bOyLk1pMEl1g9H1e/QHzKGFHrTsg/uViEzDYhodCZ9mXCl2c
        a4teC32tt98AwIQhO1fYvP5aDuqWvBTzl+97aZ+7NZViLjhDqZpppBYPBwFICrDo
        OgrUG27jbekjbsuIMMCVDhwWML0U1ee7CQuFk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F2E850EE5;
        Wed, 16 Nov 2016 18:46:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A1EA50EE4;
        Wed, 16 Nov 2016 18:46:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com>
        <20161115010356.GA29602@starla>
        <5BC69AC1-5499-4F73-816A-D8786106D796@gmail.com>
        <xmqqvavotych.fsf@gitster.mtv.corp.google.com>
        <17709AFF-3C2D-4EC0-97DC-BD750F514D0B@gmail.com>
        <5eb682e8-13cb-67f2-a8a9-ec1fa1d139c6@gmail.com>
Date:   Wed, 16 Nov 2016 15:46:25 -0800
In-Reply-To: <5eb682e8-13cb-67f2-a8a9-ec1fa1d139c6@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 16 Nov 2016 23:41:57
 +0100")
Message-ID: <xmqq37irouni.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3CFF20A-AC56-11E6-9003-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> I intend to implement this feature only for the new long running filte=
r
>> process protocol. OK with you?
>
> If I remember and understand it correctly, current version of long
> running process protocol processes files sequentially, one by one:
> git sends file to filter wholly, and receives response wholly.
>
> In the single-file filter case, git calls filter process as async
> task, in a separate thread, so that one thread feeds the filter,
> and main thread (I think?) reads from it, to avoid deadlocks.
>
> Couldn't something like this be done for long running filter process,
> via protocol extension?

My reading of the message you are responding to is that Lars means
doing so by "implement this feature".  Instead of returning the
filtered bytes, a new protocol lets his filter to say "No result yet
for you to process, ask me later".

