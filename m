Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A2B72021E
	for <e@80x24.org>; Tue, 22 Nov 2016 07:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752808AbcKVHHX (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 02:07:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62714 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752353AbcKVHHX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 02:07:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E9FF4B19F;
        Tue, 22 Nov 2016 02:07:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g2/ThPJ9HQI8S7FWgI6yJlnemj0=; b=wfLQeu
        15wwBbEtPcxjdH70WamYc/vCn3bfUb2urImFxN19T4eob1P8NZjENhurB5vsQnlj
        8CcvKcC6lK+L7s1cRBYkIg0eXS08xEMYdkP1bUdSiSA9noFnpNnxNJou7O4dqlqQ
        mlBfSvs3so4KYkvrIYhQ8ByCIWxKsSrV1Tybk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wlqdEsy0Olya0WHGBKkE3Eorx3ZvvqDq
        LT3HtMqnbghxy9KO8US0qGtvSAXsWxMl4SRyLwKucjbblfOdfpxluat6Yedj7Ciw
        bkgPjR+sLJDNciG1ak71xnoiwjXQSTxUF6URMSxVQtW65IDmf0aLWEt61eEYLoiX
        ZB88nqM+dpI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 851614B19E;
        Tue, 22 Nov 2016 02:07:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F27A04B19D;
        Tue, 22 Nov 2016 02:07:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 3/3] submodule--helper: add intern-git-dir function
References: <20161121204146.13665-1-sbeller@google.com>
        <20161121204146.13665-4-sbeller@google.com>
        <xmqqy40ch6wp.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kb_4wWs_90AfsT932iPWbCXf6yRq875JUxoRZjUcsBW5A@mail.gmail.com>
Date:   Mon, 21 Nov 2016 23:07:19 -0800
In-Reply-To: <CAGZ79kb_4wWs_90AfsT932iPWbCXf6yRq875JUxoRZjUcsBW5A@mail.gmail.com>
        (Stefan Beller's message of "Mon, 21 Nov 2016 18:09:41 -0800")
Message-ID: <xmqqmvgsf0wo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FB263E8-B082-11E6-B24A-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So I guess we should test a bit more extensively, maybe
>
>     git status >expect
>     git submodule embedgitdirs
>     git status >actual
>     test_cmp expect actual
>     # further testing via
>     test -f ..
>     test -d ..

Something along that line.  "status should succeed" does not tell
the readers what kind of breakage the test is expecting to protect
us from.  If we are expecting a breakage in embed-git-dirs would
somehow corrupt an existing submodule, which would lead to "status"
that is run in the superproject report the submodule differently,
then comparing output before and after the operation may be a
reasonable test.  Going there to the submodule working tree and
checking the health of the repository (of the submodule) may be
another sensible test.

>>  In the
>> extreme, if the failed "git submodule" command did
>>
>>         rm -fr .git ?* && git init
>>
>> wouldn't "git status" still succeed?
>
>     In that particular case you'd get
>     $ git status
>     fatal: Not a git repository (or any parent up to mount point ....)

Even with "&& git init"?  Or you forgot that part?
