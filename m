Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCEE22042F
	for <e@80x24.org>; Wed, 16 Nov 2016 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933979AbcKPTTi (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 14:19:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55548 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933799AbcKPTTg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 14:19:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D97B24E4B5;
        Wed, 16 Nov 2016 14:19:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gvb8FMWqw2Hd6lMy39lkvIcbwm0=; b=LxdxCX
        sTOByNc6JSyw9OLYURTlDkcQYURG8zVinE9pxhibuasMHVOpaIiY/u4X4WQNi6/E
        bwtifgbUm1O/xlq/215i2IQiKRrQZPED9+ZDOso5kaFI1nG54eyPRtXqc8+M6CrD
        J81qK/ncdQi9Pzjeo4MttDt4fSXoO3M69xB60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PZsPAc9a4UBguXNenRX1bjpZii+a/B3j
        xIcw0ZSGtURHCYAwp0M9xFegOAPC1hLN2kw8DiwisJoDW4D0rcJIaU8efNeuQi+j
        F+R12y/FOClBAC972af6XKd7rx4DvWx+lK8+hHncbeJgxyAfkte1EzDKHk3q55uZ
        G6dW3i0vFM0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7CA24E4B4;
        Wed, 16 Nov 2016 14:19:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A1E04E4B3;
        Wed, 16 Nov 2016 14:19:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com>
        <20161115010356.GA29602@starla>
        <5BC69AC1-5499-4F73-816A-D8786106D796@gmail.com>
        <xmqqvavotych.fsf@gitster.mtv.corp.google.com>
        <17709AFF-3C2D-4EC0-97DC-BD750F514D0B@gmail.com>
        <xmqqpolvqoka.fsf@gitster.mtv.corp.google.com>
        <2F93C9B4-157C-4F5C-9BD5-A67AA519757A@gmail.com>
Date:   Wed, 16 Nov 2016 11:19:33 -0800
In-Reply-To: <2F93C9B4-157C-4F5C-9BD5-A67AA519757A@gmail.com> (Lars
        Schneider's message of "Wed, 16 Nov 2016 19:47:17 +0100")
Message-ID: <xmqqk2c3p70a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B7A1AF0-AC31-11E6-8873-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 16 Nov 2016, at 19:15, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Lars Schneider <larsxschneider@gmail.com> writes:
>> 
>>>> * You'd need to rein in the maximum parallelism somehow, as you do
>>>>  not want to see hundreds of competing filter processes starting
>>>>  only to tell the main loop over an index with hundreds of entries
>>>>  that they are delayed checkouts.
>>> 
>>> I intend to implement this feature only for the new long running filter
>>> process protocol. OK with you?
>> 
>> Do you mean that a long-running filter process interacting with
>> convert_to_worktree() called from checkout_entry() will be the only
>> codepath that will spawn multiple processes or threads?  
>> 
>> That is fine, but it does not change the fact that you still need to
>> limit the maximum parallelism there.
>
> Filters using the long running protocol are spawned only once by Git. 
> The filter process would get all the smudge requests via the pipe
> protocol and is supposed to manage the parallelism on its own.

Yes, I think we are on the same page.  You need to be careful not to
let the filter process go berserk spawning too many threads or
processes.
