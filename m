Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E656C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 00:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14195207FF
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 00:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LNZSNAKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgIRAEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 20:04:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56975 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIRAEN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 20:04:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C11989927;
        Thu, 17 Sep 2020 20:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=a7rPu/MCg7jYuPZeHIqqm2QGvNE=; b=LNZSNAKa+Wcsgix+9SCU
        H0CJSQQ+en6dyd3+1bu8sziHD+yEsHsSR/EeXnwaoUesgeh3MKfzGjRQ10EVlOND
        wLdMsGbl0VOr67//DjdoBoGpmCnhePV5cpcbsbOaiiRpa1fUwHud5NE1xN+P9sgV
        Xj3WbcrnkKvzt5fWyYMeIwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=R4NkIfvKI67QkCtrCFAJ3GwnOKlMZV00VYaVmsr7vwudqi
        b1WynQrqn9FlhXfEDdQdFGZ8Dc3YegQViTpztT2aLvgwvYC7LkP9ZLLyKuqcqcuJ
        IjOP6CEYcSb6kYH9A5WZlq1Vxyc2qbGN8VkittBlG9INKKOTOuUd91DqWHWNc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94AA289926;
        Thu, 17 Sep 2020 20:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15EA389923;
        Thu, 17 Sep 2020 20:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] format-patch: cancel useAutoBase if base is invalid
References: <20200916234916.422553-1-jacob.e.keller@intel.com>
        <xmqqr1r1tfil.fsf@gitster.c.googlers.com>
        <CA+P7+xrvbwVevFaCB=cm4mZB4=nFAL2rs4gFgYF85qSopq+dwg@mail.gmail.com>
Date:   Thu, 17 Sep 2020 17:04:10 -0700
Message-ID: <xmqqsgbgne6d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AC49C7E-F942-11EA-86FB-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Sep 16, 2020 at 5:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>
>> > Make get_base_commit detect when useAutoBase is set, and avoid failing
>> > if the base commit is picked up automatically. We still attempt to fail
>> > if --base=auto is explicitly requested on the command line.
>>
>> Makes sense.  I also think we should fail in such a broken base is
>> chosen, when useAutoBase is set by configuration and is not
>> overriden from the command line with an explicit use of --no-base
>> option, because the end-user expects an appropriate base to be used
>> that is computed automatically, but we are failing to find such a
>> base---going ahead silently in such a case would be wrong.
>>
>
> I am not sure if I follow here. The whole point of this patch is that
>
> git config format.useAutoBase true
> git format-patch -1 <old id>
>
> causes failure that is very unexpected, especially if it's been a long
> time since you set useAutoBase.
>
> I do want git format-patch --base=auto <old id> to fail, certainly.

I understand.  And further, I do not think it is a good idea to
silently ignore the configured format.useAutoBase when there is no
command line override.  IOW, we want both to fail, but with a better
message (e.g. "appropriate base not found").

> I wonder if there's a way we can tell when the format patch revisions
> in question make no sense with the automatic base.

Sorry, I don't quite know what you mean---the fact that you are
already getting a cryptic error message means the existing code
already knows, no?


