Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88F5C4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 22:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D75C20774
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 22:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wWc6MgQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgD3W5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 18:57:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60070 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgD3W5G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 18:57:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B6AFBBF8D;
        Thu, 30 Apr 2020 18:57:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EpLp8Dhc5QELhF6h+YFkLuAZsfQ=; b=wWc6Mg
        Qe8nftpzzQuDNHygxVRppY/hOJZMx0pQR9eFUqpHj/Mh6lckHuUh9d6jHZrWN7No
        +A6Y1q9BiGcxv/qXz2lODmPWXJXcZNBW5jVAqi0ksuuLVoxYbIFLJfVINYY0OyFx
        UOdZAFbiAtO+jvmtargLyQsdPwnU1Rq+WNNhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uIms+1JGpNKRjtph7WyM2RxY9/lBUydg
        wtNgwZb+jTwm9lbUm59xuLzL6ay6pff40nbU4ggsTIlGycp1YBnFVw87Xd6AHITc
        mmamBP9aOYdZxgb7huExJ2NCL3Izxwhwbgdq10L/I54UfndjcZS3COXZnvA2NNKp
        8xwEzVqD+F8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82CDEBBF8C;
        Thu, 30 Apr 2020 18:57:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BB44CBBF8A;
        Thu, 30 Apr 2020 18:57:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 00/11] refactor git switch completion
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
Date:   Thu, 30 Apr 2020 15:56:59 -0700
In-Reply-To: <20200425022045.1089291-1-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Fri, 24 Apr 2020 19:20:33 -0700")
Message-ID: <xmqqsggkpop0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7455738-8B35-11EA-873D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> completion support for git switch is subpar for a number of cases. Most
> notable is difference between these two completions:
>
>   $git switch <TAB>
>   Display all 784 possibilities? (y or n)
>   <list of all references and DWIM remotes>
>
>   $git switch --track<TAB>
>   jk-refactor-git-switch-completion master`
> ...

We've discussed that it may be a good idea to make sure that "switch
-c", "checkout -b" and "switch/checkout --orphan" complete the new
branch name the same way, but haven't done anything else.  I'd very
much appreciate to see the patches reviewed by those involved more
in the completion script, before we decide to merge the topic to
'next'.

Thanks.
