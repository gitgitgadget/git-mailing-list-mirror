Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38A3C433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 22:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5FDC61059
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 22:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhCaWGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 18:06:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61188 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhCaWGS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 18:06:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F5D81246EE;
        Wed, 31 Mar 2021 18:06:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=atkAwh7RkqDV
        AnXTSUIYneQ7THM=; b=B3WuRmJlPe3h8tsFh8HYeLP2mXVgZIxrMWccVNEXwCXb
        Qsi/s3CtXCN0tW10hbk4f6wzHKf+AzfUJFj0MlkI4R1szN7dBZ9GuNOU+QSrY5qb
        jJ2A3jCVBkND2SJsUmjtlPhxytga4kHPKaXMBQhERrTCSmIZeQNa5L9OTDQ83gg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pqHjEB
        qf/4KgD++OMMTu2KGrKLEQplKhqHR6aAv5ydpUJCwfwaH0ihezaxJaRnDiM8/UgR
        ovQRzgFoKM0oVSyAZh0FS+61ijG8b2OaRnbDwxtET/8nymWH0eiiCRT3z/LjxvH/
        MledAqQa2vOoSI25hk+ap9nmnbedUXEs5GWMo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 393961246ED;
        Wed, 31 Mar 2021 18:06:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 37B6D1246EA;
        Wed, 31 Mar 2021 18:06:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v8 35/37] git-send-email: use 'git hook run' for
 'sendemail-validate'
References: <20210311021037.3001235-1-emilyshaffer@google.com>
        <20210311021037.3001235-36-emilyshaffer@google.com>
        <87y2esg22j.fsf@evledraar.gmail.com> <YGTt2cNwq3BlpB7n@google.com>
Date:   Wed, 31 Mar 2021 15:06:12 -0700
In-Reply-To: <YGTt2cNwq3BlpB7n@google.com> (Emily Shaffer's message of "Wed,
        31 Mar 2021 14:47:05 -0700")
Message-ID: <xmqqy2e3567f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4F2DEA24-926D-11EB-A0F4-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Fri, Mar 12, 2021 at 10:21:08AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> > +	my $target =3D abs_path($fn);
>> > +	return "rejected by sendemail-validate hook"
>> > +		if system(("git", "hook", "run", "sendemail-validate", "-a",
>> > +				$target));
>>=20
>> I see it's just moving code around, but since we're touching this:
>>=20
>> This conflates the hook exit code with a general failure to invoke it,
>> Perl's system().
>
> Ah, at first I thought you meant "hook exit code vs. failure in 'git
> hook run'" - but I think you are saying "system() can also exit
> unhappily".
>
> I had a look in 'perldoc -f system' like you suggested and saw that in
> addition to $? & 127, it seems like I also should check $? =3D=3D -1
> ("system() couldn't start the child process") and ($? >> 8) (the rc
> from the child hangs out in the top byte). So then it seems like I want
> something like so:
>
>   system("git", "hook", "run", "sendemail-validate",
>           "-j1", "-a", $target);
>
>   return "git-send-email failed to launch hook process: $!"
>           if ($? =3D=3D -1) || ($? & 127))
>   return "git-send-email invoked git-hook run incorrectly"
>           if (($? >> 8) =3D=3D 129);
>   return "Rejected by 'sendemail-validate' hook"
>           if ($? >> 8);
>

The example in "perldoc -f system" distinguishes these two like so:

        if ($? =3D=3D -1) {
                print "failed to execute: $!\n";
        }
        elsif ($? & 127) {
                printf "child died with signal %d, %s coredump\n",
                    ($? & 127), ($? & 128) ? 'with' : 'without';
        }
        else {
                printf "child exited with value %d\n", $? >> 8;
        }

> That seems really verbose, though. I guess ($? >> 8) includes -1 as wel=
l (since
> 0xFF... will meet that conditional), but do we care about the differenc=
e between
> "system() couldn't run my thing" and "my thing returned upset"?

If we classify the failure cases into three using the sample code in
the doc, I think the last one is the only case that we know the
logic in the hook is making a decision for us.  In the first case,
the hook did not even have a chance to decide for us, and in the
second case, the hook died with signal, most likely before it had a
chance to make a decision.  If we want to be conservative (sending
a message out is something you cannot easily undo), then it may make
sense to take the first two failure cases, even though the hook may
have said it is OK to send it out if it ran successfully, as a denial
to be safe, I would think.

Thanks.

