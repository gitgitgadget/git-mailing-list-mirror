Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE50C433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 20:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351869AbiD1UoZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 28 Apr 2022 16:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiD1UoY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 16:44:24 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEA55AA61
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 13:41:07 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23SKf4mj027538
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Apr 2022 16:41:05 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "=?utf-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?=" <carenas@gmail.com>,
        <git@vger.kernel.org>
References: <20220428033544.68188-1-carenas@gmail.com>        <20220428105852.94449-1-carenas@gmail.com>        <20220428105852.94449-4-carenas@gmail.com>        <xmqq7d79du6c.fsf@gitster.g>        <000001d85b39$9d5cfc90$d816f5b0$@nexbridge.com> <xmqqbkwleypf.fsf@gitster.g>
In-Reply-To: <xmqqbkwleypf.fsf@gitster.g>
Subject: RE: [PATCH v2 3/3] t: add tests for safe.directory when running with sudo
Date:   Thu, 28 Apr 2022 16:40:59 -0400
Organization: Nexbridge Inc.
Message-ID: <000701d85b40$4819baf0$d84d30d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEhoH1klsquz/XrUeoh6UIeie+nGgNSFEhJAdygO20BcR/rTQHiUZcMAthTgKKuGGpT4A==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 28, 2022 4:32 PM, Junio C Hamano wrote:
>To: rsbecker@nexbridge.com
>Cc: 'Carlo Marcelo Arenas Belón' <carenas@gmail.com>; git@vger.kernel.org
>Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running with sudo
>
><rsbecker@nexbridge.com> writes:
>
>>>> +test_lazy_prereq SUDO '
>>>> +	is_root sudo &&
>>>> +	! sudo grep -E '^[^#].*secure_path' /etc/sudoers '
>>
>> /etc/sudoers is not standard although usual. This path should come
>> from a knob somewhere. We can't run this test on our x86 system anyway
>> - no access to root or sudo even though it is installed. Also,
>> /etc/sudoers is typically secured 0600 so the grep will fail even if
>> is_root passes - and I'm worried about the portability of is_root,
>> which is mostly Linux.
>
>True.
>
>On a box I happen to be using, the grep gives me
>
>    Defaults secure_path=/usr/sbin:/usr/bin:/sbin:/bin
>
>and makes the prereq fail.  Which is sort-of expected, and I understand why this
>check is here, but I suspect that any sane and sensible installations would
>reinitialize the path to a fairly restricted one with the mechanism, so we wouldn't
>be testing this on majority of places, I am afraid.
>
>What we really care is that we use the same PATH as the test environment uses,
>including "we want to test the binary we just built" (or "at the specified path",
>when GIT_TEST_INSTALLED is in effect).  I wonder what the right way to carry
>$PATH and other environment variables down to whatever "sudo" in the test
>runs.
>
>    $ foo=foobla; export foo
>    $ sudo sh -c set | grep foo; echo $?
>    1
>
>so resetting PATH from an environment we export, e.g.
>
>    USE_THIS_PATH=$PATH sudo sh -c '
>	PATH=$USE_THIS_PATH
>	... invoke our git normally here  ...
>	git status
>    '
>
>would not work X-<.  Worse yet, other environment variables such as
>GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME that we set in our tests may
>probably be cleared before "sudo" runs any test command, so rejecting an
>installaion whose "sudo" resets PATH with the above check is probably insufficient
>to give our tests a reasonable envionment to run in.
>
>>>Overall, I like the simplicity and clarity of "do not start this test
>>>as 'root'" in the previous round much better.
>>>
>>>But other than that, the test coverage given by this patch looks quite sensible.
>
>So, I unfortunately have to strike the last sentence from my earlier response.  The
>tests do mean well, but I doubt they would work in the way the good intentions
>planned them to work.

sudo on my machines is very specific that it does not preserve much of the environment. This causes all kinds of DLL load issues too. We rarely can build regression test suites that include sudo testing. More than that, it is general policy that password-less sudo is frowned upon, so I'm pretty sure we cannot run this test. When we run the git test suite, it is done by a user who is, by design, excluded from the sudoers file because regression tests happen in a sandbox.

