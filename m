Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E08D1F406
	for <e@80x24.org>; Mon,  8 Jan 2018 10:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755951AbeAHKaM convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 8 Jan 2018 05:30:12 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:56575 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754591AbeAHKaL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Jan 2018 05:30:11 -0500
X-IronPort-AV: E=Sophos;i="5.46,330,1511823600"; 
   d="scan'208";a="308044372"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 08 Jan 2018 11:30:09 +0100
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH v2 3/3] send-email: add test for Linux's get_maintainer.pl
In-Reply-To: <CAPig+cQURBQxw69RFyOGKxqyQihTh1c7djsFx3H2MJtWNXKryg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 5 Jan 2018 13:59:27 -0500")
References: <1515092151-14423-1-git-send-email-git@matthieu-moy.fr>
        <1515177413-12526-1-git-send-email-git@matthieu-moy.fr>
        <1515177413-12526-3-git-send-email-git@matthieu-moy.fr>
        <CAPig+cQURBQxw69RFyOGKxqyQihTh1c7djsFx3H2MJtWNXKryg@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Date:   Mon, 08 Jan 2018 11:30:01 +0100
Message-ID: <q7h91sj0od7a.fsf@orange.lip.ens-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Jan 5, 2018 at 1:36 PM, Matthieu Moy <git@matthieu-moy.fr> wrote:
>> From: Alex Bennée <alex.bennee@linaro.org>
>>
>> We had a regression that broke Linux's get_maintainer.pl. Using
>> Mail::Address to parse email addresses fixed it, but let's protect
>> against future regressions.
>>
>> Patch-edited-by: Matthieu Moy <git@matthieu-moy.fr>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
>> ---
>> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
>> @@ -172,6 +172,26 @@ test_expect_success $PREREQ 'cc trailer with various syntax' '
>> +test_expect_success $PREREQ 'setup fake get_maintainer.pl script for cc trailer' "
>> +       write_script expected-cc-script.sh <<-EOF &&
>> +       echo 'One Person <one@example.com> (supporter:THIS (FOO/bar))'
>> +       echo 'Two Person <two@example.com> (maintainer:THIS THING)'
>> +       echo 'Third List <three@example.com> (moderated list:THIS THING (FOO/bar))'
>> +       echo '<four@example.com> (moderated list:FOR THING)'
>> +       echo 'five@example.com (open list:FOR THING (FOO/bar))'
>> +       echo 'six@example.com (open list)'
>> +       EOF
>> +       chmod +x expected-cc-script.sh
>> +"
>> +
>> +test_expect_success $PREREQ 'cc trailer with get_maintainer.pl output' '
>> +       clean_fake_sendmail &&
>> +       git send-email -1 --to=recipient@example.com \
>> +               --cc-cmd="./expected-cc-script.sh" \
>> +               --smtp-server="$(pwd)/fake.sendmail" &&
>
> Aside from the unnecessary (thus noisy) quotes around the --cc-cmd

Indeed, removed.

> value, my one concern is that someone may come along and want to
> "normalize" it to --cc-cmd="$(pwd)/expected-cc-script.sh" for
> consistency with the following --smtp-server line. This worry is
> compounded by the commit message not explaining why these two lines
> differ (one using "./" and one using "$(pwd)/").

Added a note in the commit message.

> An alternative would be to insert a cleanup/modernization
> patch before this one which changes all the "$(pwd)/" to "./",

For --smtp-server, doing so results in a failing tests. I didn't
investigate on why.

> although you'd still want to explain why that's being done (to wit:
> because --cc-cmd behavior with spaces is not well defined). Or,
> perhaps this isn't an issue and my worry is not justified (after all,
> the test will break if someone changes the "./" to "$(pwd)/").

Also, the existing code is written like this: --cc-cmd is always
relative, --stmp-server is always absolute, including when they're used
in the same command:

test_suppress_self () {
[...]
	git send-email --from="$1 <$2>" \
		--to=nobody@example.com \
		--cc-cmd=./cccmd-sed \
		--suppress-cc=self \
		--smtp-server="$(pwd)/fake.sendmail" \

Thanks for your careful review,

-- 
Matthieu Moy
https://matthieu-moy.fr/
