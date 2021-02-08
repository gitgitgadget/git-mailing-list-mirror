Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B3AC433E6
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 18:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C447064E6C
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 18:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhBHSi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 13:38:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51662 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbhBHSig (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 13:38:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4929A6496;
        Mon,  8 Feb 2021 13:37:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C4VXRON602rsk4asL7Ufxr4nctA=; b=Ia7f2A
        Fls3rDA0U/v7WxCEBOdCMg6ueDiF90BgwwqMskCJT97YGPxQqW8IZbtlnT5v0EEl
        WgbswkeO1GjDq1CCYVjD+lwMPJNWpTiECrL9ShAUtS0x8u4XFR3XOnuaCcL0zkCd
        PKKp3ypMdvpxiDJH3AiNVonI2Al70g99IUtnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d+5D1ojRpD0Ey0WkgRSo1Z7DHhqrv8eF
        DriF5OuedISLbPhhm6GWZgFsA9FWCZoELpBP9jEHj1IPD56mptzygDJwcDAfjUBD
        X3ACjUOCDNnM0h4kW5PXL+JUe6WXHl0mRYFh2aHEeVXNiFThsqwE8X0Eab6ZnmoW
        yNVnURrUuzE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A9BBA6495;
        Mon,  8 Feb 2021 13:37:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 24019A6494;
        Mon,  8 Feb 2021 13:37:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     christian.couder@gmail.com, levraiphilippeblain@gmail.com,
        peff@peff.net, Johannes.Schindelin@gmx.de,
        derrickstolee@github.com, git@vger.kernel.org
Subject: Re: [RFC] [BUDFIX] 'git rm --cached <submodule>' does not stage the
 changed .gitmodules
References: <20210207144144.GA42182@konoha>
        <xmqq1rdr8yl2.fsf@gitster.c.googlers.com>
        <20210208072337.GA7955@konoha>
Date:   Mon, 08 Feb 2021 10:37:46 -0800
In-Reply-To: <20210208072337.GA7955@konoha> (Shourya Shukla's message of "Mon,
        8 Feb 2021 12:53:37 +0530")
Message-ID: <xmqqpn1a5rt1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD4FFDFC-6A3C-11EB-8D3B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <periperidip@gmail.com> writes:

> On 07/02 11:30, Junio C Hamano wrote:
>> Shourya Shukla <periperidip@gmail.com> writes:
>> 
>> > So, my question is, do we need to fix this to make sure that the changed
>> > '.gitmodules' is staged?
>> 
>> When "--cached" is given, the user is asking the module to be
>> removed ONLY from the index, without removing it from the working
>> tree, no?
>> 
>> So I think ".gitmodules" in the working tree should not be touched
>> at all.
>> 
>> Removing the entry for the module from the ".gitmodules" registered
>> in the index, when a submodule registered in the index, might be
>> desirable, and what you say here
>> 
>> > And its entry is not removed from the file. What should be done about
>> > this? I would appreciate your opinions.
>> 
>> may be related to it.
>> 
>> But I doubt it is a good idea to let "git rm" be the one touching
>> ".gitmodules" either in the index or in the working tree for that to
>> happen.
>
> We can remove the entry of the SM from the '.gitmodules' at least no?
> Since the SM won't be relevant to us. At the end an empty '.gitmodules'
> file would stand.

I agree that .gitmodules needs to be modified in the index (but not
in the working tree) to make things consistent in the worldview of
"git submodule" subsystem.  I am just saying that I doubt "git rm"
is a good place to perform an operation that is required only by the
particular kind of submodule design (namely, "git submodule" that
works with ".gitmodules"), as I said below.

>> The reason I am hesitant to teach anything about ".gitmodules" to
>> the basic level tools like "add", "rm" is because ...
> ...
> Hmmmm.. You are correct here. But, won't we be replicating the
> functionality of 'git rm [--options] <submodule>' when we create another
> new command say 'git submodule rm [--options] <submodule>'.

Well, that is what I meant by "'git submodule rm [--cached]' may use
"git rm [--cached]" internally as a building block".  

When a better design of submodule subsystem appears, it might or
might not use ".gitmodules", but when it wants to remove the
submodule only from the index, it would do so by internally calling
"git rm --cached" to implement that part of the feature, in addition
to its own bookkeeping.

It won't be a replication of the functionality---dealing with the
index and working tree would be done by "git rm" called by "git
submodule rm".
