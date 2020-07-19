Return-Path: <SRS0=m+L4=A6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E7FC433E0
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 06:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72BD2073A
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 06:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IveU8nZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGSGHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jul 2020 02:07:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58423 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgGSGHv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jul 2020 02:07:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9778C76FCC;
        Sun, 19 Jul 2020 02:07:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=trY83ajp2T43EO/XFQCZkSUm4j0=; b=IveU8n
        ZOTBgCocy8nhJy+CyQ7qaMm/QWmwDfTOsOXGpu026o2dOrjg60Kb5ZUHyis3XJV6
        sPPGcSXLdXQUCRXPpoixM0Wir0wJrzUYx88qQPaE/SeYJof2iiFVWjbTwC5Les+7
        g5me5pJxCAlb2JVMOpU61DqhbNIXGK5/Yv/4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PU8Lv6/e+WnlDaINqUzes3vbdp4VDPq1
        5FSTPICdt+LEobxZ2CRVTDGpNhvwvx2+1X9EUheraV1qrWulPJe7DRmOBJeXiqcp
        B6THphJdTZ00M+ZiWsNyucyPsIRSMdEM+3EFzTTiG4FZezNzz47GQ7k4EAuvifs8
        VOb1AmmbKHM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E55876FCB;
        Sun, 19 Jul 2020 02:07:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E75E376FCA;
        Sun, 19 Jul 2020 02:07:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] git-send-email: die if sendmail.* config is set
References: <20200718202142.111015-1-sir@cmpwn.com>
        <xmqq8sfgbltq.fsf@gitster.c.googlers.com>
Date:   Sat, 18 Jul 2020 23:07:49 -0700
In-Reply-To: <xmqq8sfgbltq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 18 Jul 2020 13:38:25 -0700")
Message-ID: <xmqqv9ik9gwa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C9F1F56-C986-11EA-BC4E-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Drew DeVault <sir@cmpwn.com> writes:
>
>> I've seen several people mis-configure git send-email on their first
>> attempt because they set the sendmail.* config options - not
>> sendemail.*. This patch detects this mistake and bails out with a
>> friendly warning.
>>
>> Signed-off-by: Drew DeVault <sir@cmpwn.com>
>> ---
>>  Documentation/config/sendemail.txt |  5 +++++
>>  git-send-email.perl                |  8 ++++++++
>>  perl/Git.pm                        | 26 ++++++++++++++++++++++++++
>>  3 files changed, 39 insertions(+)

One more thing.  This should be fairly easy to protect from future
breakages by adding three new tests in t/t9001-send-email.sh script.
One would do something like

	test_config sendmail.program sendmail &&
	test_must_fail git send-email ... >err &&
	test_i18ngrep "found configuration options for .sendmail" err

as a positive test, the second would do

	test_config sendmail.program sendmail &&
	test_config sendemail.forbidsendmailvariables false &&
	git send-email ...

to make sure that escape hatch actually works and then the third
would do something like

	test_config resendmail.program resendmail &&
	git send-email ...

to ensure that only variable whose name begins with "sendmail."
triggers the error.

>> +if ($forbid_sendmail_variables && (scalar Git::config_regexp("sendmail.*")) != 0) {
>
> Judging from the way you wrote the "config_regexp" helper function,
> the above regexp matches "sendmailer.foo", "sendmailed.bar", etc., I
> would think, which probably is not what you intended.  
>
> I guess we can write "sendmail[.].*" or "sendmail\\..*" to ensure
> that we are talking about (literally) "sendmail." followed by
> anything?

I didn't know "git config --get-regexp $regexp" did not anchor the
regular expression to the beginning or to the end.  In this case, we
do want to make sure the "sendmail." substring literally appears at
the very beginning of the variable name, and because "--get-regexp"
does not anchor the regular expression to the end, we do not need to
add an explicit "anything goes", i.e. ".*" after it.

IOW, "^sendmail[.]" is the minimal regexp we want to use.  We cannot
afford to lose the "^" to reject "resendmail.program", and we do not
have to add ".*" that would swallow the rest at the end.

Thanks.

