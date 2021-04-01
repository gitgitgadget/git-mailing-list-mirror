Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDE8C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AC06100C
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhDAS6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:58:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52860 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237187AbhDASz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 14:55:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6073612BA8D;
        Thu,  1 Apr 2021 14:55:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QGQ9zaBsQ79KXbwnzoZKDJe2+x4=; b=xkycFN
        eiK91Qc0gHlKIVnkNZtJqnI2rcNBYfXEE1GSzDe4RBHiXrOQ2oksTPACBUPa0tHE
        nSus6vH7tT+zRiRXNtFwXp27VJqHw6g7QIgZq3ItLsmxPr6H1zG8oWiWfXnaIIQP
        47rHac8mp0JuC1o1jm1UW3AOe/TYjcUzjD+Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IvBRERrhfma8qhWgD5WFdWibmjaG0qYp
        PzikXXrvOPLn9ErWYEtcjasKFfAQIwb5XG3jL5NkWTGOW33MQIQx6usgbIfBwCtC
        sIhThc8OFvDIp172ivvwBDFh80i0+hVaHocNwU8rsbVj9WtfUKLFVft0rLT7Udxq
        9rOGmLX0S5k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A30312BA8C;
        Thu,  1 Apr 2021 14:55:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6BB3712BA8B;
        Thu,  1 Apr 2021 14:55:50 -0400 (EDT)
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
        <xmqqy2e3567f.fsf@gitster.g> <YGYMG3mArYSeMr9D@google.com>
Date:   Thu, 01 Apr 2021 11:55:48 -0700
In-Reply-To: <YGYMG3mArYSeMr9D@google.com> (Emily Shaffer's message of "Thu, 1
        Apr 2021 11:08:27 -0700")
Message-ID: <xmqqr1jt3kcr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E07C1524-931B-11EB-93D4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> If we classify the failure cases into three using the sample code in
>> the doc, I think the last one is the only case that we know the
>> logic in the hook is making a decision for us.  In the first case,
>> the hook did not even have a chance to decide for us, and in the
>> second case, the hook died with signal, most likely before it had a
>> chance to make a decision.  If we want to be conservative (sending
>> a message out is something you cannot easily undo), then it may make
>> sense to take the first two failure cases, even though the hook may
>> have said it is OK to send it out if it ran successfully, as a denial
>> to be safe, I would think.
>
> Yeah, I tend to agree. In that case I think you are saying: "Please
> split the first case into two and differentiate launch failure from
> signal, but otherwise continue to return all these cases as errors and
> halt the email."

Not exactly.  I do not have a strong opinion either way to split the
first two cases apart or lump them together.  If I were pressed, I
probably would vote for the latter.

The doc's example classfies into three and I think that
classification is logical:

 * Lumping the first two together would make sense with respect to
   deciding what to do when we see a failure. The first two are
   "hook failed to approve or disapprove" case, while the last one
   is "the hook actively disapproved".  The former is not under
   hook's control.

 * Further, treating a failure even from the first "hook failed to
   approve or disapprove" as a signal to stop sending would be more
   conservative.

 * Which leads us to say, with respect to deciding what to do, any
   failure just stops the program from sending.

It is a separate matter how to phrase the diagnoses and hints for
recovery.  It could be that sendmail-validate hook failed to run due
to a simple misconfiguration (e.g. because it lacked the executable
bit).  Giving an error message with strerr would be helpful for the
"hook failed to approve or disapprove" case.

