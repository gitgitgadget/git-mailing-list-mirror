Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82771F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 04:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeKZOzW (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 09:55:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60728 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeKZOzW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 09:55:22 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CEB510DA40;
        Sun, 25 Nov 2018 23:02:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aLiJzMFLbeXl/5Qfmy2ykOFyPZY=; b=u0vxns
        sEuP5msajbYiEj2d7c7Ia/CY3RNvS5urJHq5wLdJxBuG2Mcj355M73B5ndNvHWgT
        OsDm235TFfAgYqvmu9rwV7Tkx5IB6RQrxOYdNiEUvSHSLtX5YAkSQNpKB76hQFmt
        Ap8OEjSeER19R5z/2nS2n0oUAwiti73o3o+Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HGItdFgaLTQrgxl03t4mFI1iwQ9T8GrJ
        K5A8eHIU10HkotbGv1UJsDlEmbhr3fB7kxlIcPkddx3iPUTCqgjRctKfqB3NwvVb
        dGftIxJLnslOBVmUEB/KiJOWvYuhIzFSbJcKuIHKkZK5RlMP6xP/EBNhFUG1taVr
        czpLo/zkcg8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6561210DA3F;
        Sun, 25 Nov 2018 23:02:32 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2CAB10DA3D;
        Sun, 25 Nov 2018 23:02:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Frank =?utf-8?Q?Sch=C3=A4fer?= <fschaefer.oss@googlemail.com>,
        git@vger.kernel.org
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the ending of the removed line is CR+LF
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
        <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
        <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
        <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
        <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
        <30442f9c-a1cb-4635-d8e3-a301d94a56fd@kdbg.org>
Date:   Mon, 26 Nov 2018 13:02:30 +0900
In-Reply-To: <30442f9c-a1cb-4635-d8e3-a301d94a56fd@kdbg.org> (Johannes Sixt's
        message of "Sun, 25 Nov 2018 22:39:44 +0100")
Message-ID: <xmqqr2f8zdt5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 191C0BFE-F130-11E8-A145-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> But incorrect whitespace is never highlighted in removed lines, why
> should CR be an exception?
> ...
> Same here for other cases, for example
> 
> -something<SP>
> +something
>
> will not have on obvious indicator that whitespace was corrected.

All correct, but misses one point in Frank's original report, which
observed

	-something
	+something_new^M

with ^M highlighted for whitespace error.  The highlighting is
correct.  But notice lack of caret-em on the preimage line?

It turns out that we show something like this

    <RED>-something<RESET> CR LF

for the preimage line, while showing something like this

    <GREEN>+something_new<RESET><BG-RED> CR <RESET> LF

for the postimage line.  

Because CR on the postimage line, thanks to highlighting, appears
alone separate from the LF, it is shown as two-letter caret-em
sequence to the user.

On the other hand, because CR and LF appear next to each other on
the preimage line, the pager and/or the terminal behaves as if CR is
not even there and that is where Frank's complaint comes from, I think.

The code is doing the right thing by showing CR, but it is hidden by
the pager and/or the terminal.
