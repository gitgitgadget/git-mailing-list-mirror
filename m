Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8107F20951
	for <e@80x24.org>; Fri, 17 Mar 2017 19:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751222AbdCQTSU (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 15:18:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54368 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751239AbdCQTSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 15:18:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C02876771;
        Fri, 17 Mar 2017 15:17:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=szHCwf9Eh9JODIvKUMdhAzWmEBE=; b=TsT0lf
        qT+MLvkJ9RuHW1uyu8y46CKe6IsbmglwIf6HTknViof60V6+IoHW3svMQEJIBaLs
        xwqib8N1dDz+vdWyMbRJqfGwpsnh/cArwNjPvEb5UTarPriIu4ps02U+sqXh93M0
        c19Yt8V9Ad5h1EfCFHytCv3KCubhQRMYHtuvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c4bI5Qy7IgJj3vj0pm208ZFC2vSY/XDm
        gMUC/yaD41saSTAxLHbGM1CA+UjqiBspBItqamj2cG1VuyXlGP2Yg8n31X/P/C8/
        NAlwNsJOvnjIKtIuJTmJ3YcOVuFJJigkb8TERugElDyhsDxxQR0jekQLxwINPE+L
        tTX/ICmZsy4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13E8F76770;
        Fri, 17 Mar 2017 15:17:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5A2C37676F;
        Fri, 17 Mar 2017 15:17:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/5] setup: allow for prefix to be passed to git commands
References: <20170314221100.24856-1-bmwill@google.com>
        <20170317172257.4690-1-bmwill@google.com>
        <20170317172257.4690-3-bmwill@google.com>
        <CAGZ79kZAZeb5rsL80dty_tRM5SDCAXVq_yATpDQREq_vV4Yj+Q@mail.gmail.com>
Date:   Fri, 17 Mar 2017 12:17:28 -0700
In-Reply-To: <CAGZ79kZAZeb5rsL80dty_tRM5SDCAXVq_yATpDQREq_vV4Yj+Q@mail.gmail.com>
        (Stefan Beller's message of "Fri, 17 Mar 2017 12:07:46 -0700")
Message-ID: <xmqq60j77lx3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D07E616-0B46-11E7-8927-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>         prefix = setup_git_directory_gently_1(nongit_ok);
>> +       env_prefix = getenv(GIT_TOPLEVEL_PREFIX_ENVIRONMENT);
>> +
>> +       if (env_prefix)
>> +               prefix = env_prefix;
>> +
>>         if (prefix)
>>                 setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
>
> so we load that GIT_TOPLEVEL_PREFIX_ENVIRONMENT prefix
> first, such that we essentially copy it into GIT_PREFIX_ENVIRONMENT,
> such that e.g. aliased commands will know about the superprefix, too.

If the aliased commands or anything else spawned from this process
is happy with GIT_PREFIX set to the outside of the current
repository, doing this setenv() is OK.  If you are in ~/dir1, and
your repository is in ~/repos/repo1, and if you somehow had a way
to run your "git" inside ~/repos/repo1 without doing any chdir(2),
then you are essentially setting ../../dir1/ as GIT_PREFIX for that
"git" invocation (this has nothing to do with submodules).

But if your "git" is fine with GIT_PREFIX pointing outside the root
level of the working tree of the current repository like that, do we
even need a separate toplevel prefix environment, I have to wonder?

That is, if this "if TOPLEVEL_PREFIX environment is there, set it to
local variable prefix and export it as GIT_PREFIX" is expected to
work correctly for anything that would inherit that GIT_PREFIX, then
we should be able to invoke the "git" that got TOPLEVEL_PREFIX
without setting that environment, but instead setting the same value
to GIT_PREFIX and we should get the same behaviour, no?

