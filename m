Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52257200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 21:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932328AbcL0V4Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 16:56:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58326 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932298AbcL0V4X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 16:56:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAE145BDAD;
        Tue, 27 Dec 2016 16:55:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D9Vb+hPwm4iaHqUmcMh2Q2mFeLo=; b=tW8i2r
        rzjCCWMublozb9hQwL1s4aJa2qP160jdJ/8B+9Ro1+Xo5Kb/R4bPZn+d3RQGqJ0H
        wYwVpD03B4xPoLoAuKVCW+W8tQqK7R2HKsuujhLhczOXlm1xCxRolkeiifB78HQM
        9QS7Ko6a4fFvnHe/Wl/hZGkhgERqc2tijZoYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UeCx7k9bJDRY058JYgVK4KJyyZaxQLZJ
        GgY8E/qQKcFMyUhYzCs6sodBa1qEhhwpdRU0KX9JJwB3xDK2DBCtljifs2cKGoVK
        YUY3R86fxxBzK/aij7yb0ZM6XJqPXEMB2j94FXVwBztgLdzN6Lsibd/IxJBTsxCp
        +OpcfA8sb2s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1EB05BDAC;
        Tue, 27 Dec 2016 16:55:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 639295BDAA;
        Tue, 27 Dec 2016 16:55:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        David Turner <David.Turner@twosigma.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv5 4/4] rm: absorb a submodules git dir before deletion
References: <20161220232012.15997-1-sbeller@google.com>
        <20161220232012.15997-5-sbeller@google.com>
        <xmqqmvfich2e.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaRY0x+31-UiiBU1iBXGKAgeTRSSjvN0isd7jdg-Y7_rQ@mail.gmail.com>
        <CAGZ79kZLk2bNj2Z_PFfo9KzODn8nSihDLdLuKvpSPodR9Eg-4w@mail.gmail.com>
Date:   Tue, 27 Dec 2016 13:55:32 -0800
In-Reply-To: <CAGZ79kZLk2bNj2Z_PFfo9KzODn8nSihDLdLuKvpSPodR9Eg-4w@mail.gmail.com>
        (Stefan Beller's message of "Tue, 27 Dec 2016 10:26:37 -0800")
Message-ID: <xmqqeg0t6nqj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30E8ACF6-CC7F-11E6-A621-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>>> @@ -358,9 +331,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>>>>                       oidclr(&oid);
>>>>               if (check_local_mod(&oid, index_only))
>>>>                       exit(1);
>>>> -     } else if (!index_only) {
>>>> -             if (check_submodules_use_gitfiles())
>>>> -                     exit(1);
>>>>       }
>>>>
>>>
>>> Hmph.  It may be a bit strange to see an "index-only" remove to
>>> touch working tree, no?  Yet submodules_absorb_gitdir_if_needed() is
>>> unconditionally called above, which feels somewhat unexpected.
>> ...
> Well scratch that.
> is_staging_gitmodules_ok only checks for the .gitmodules file and not
> for the submodule itself (the submodule is not an argument to that function)
>
> The actual answer is found in check_local_mod called via
>
>     if (!force) {
>         struct object_id oid;
>         if (get_oid("HEAD", &oid))
>             oidclr(&oid);
>         if (check_local_mod(&oid, index_only))
>             exit(1);
>     }

OK, that happens way before this loop starts finding submodules and
removing them, so we can say that the latter is well protected.

Thanks.
