Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E259B1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 23:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933743AbcLGXfl (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 18:35:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52068 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933757AbcLGXfj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 18:35:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78C4C56968;
        Wed,  7 Dec 2016 18:34:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CioduHoWzFmJgRqoWt0zPFEBLkY=; b=hqzK/f
        3Heb6f+RXwtGIE4GzXKUsVTQgjS75jt1wNwll4CZjplGIbgx57oz7v+DHGBKhw46
        QPQJmUKPsd3Z9GdXV4HUh0/+Xv8KsIHeCtm+YcJKGJZBc72JzkAz6r1INOvDPdUS
        nctNPKlNO8qVdUp8NuKU/GrLbXVoXcJMj9m+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dtd8utvJ9V7d8eNWCWIlPII8c6g4n8OD
        U16wrPcKCQ+111QP/KsMsEhjow4DMjnFnldSso5197+DijyDktjWVmKjc6efyx7P
        N5BgDgZouXMC8j5uXHf2+vwXL09SkeIE4CepMmbnm+XRD+QF1TjiJn9Byn86R9Gw
        qwqdpNJKr70=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EFD556967;
        Wed,  7 Dec 2016 18:34:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BDF2156966;
        Wed,  7 Dec 2016 18:34:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCHv5 0/5] submodule embedgitdirs
References: <20161207210157.18932-1-sbeller@google.com>
        <xmqqzik7v04b.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 07 Dec 2016 15:34:44 -0800
In-Reply-To: <xmqqzik7v04b.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 07 Dec 2016 14:35:16 -0800")
Message-ID: <xmqqeg1juxd7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC808A40-BCD5-11E6-BDC0-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> v5:
>> * Add another layer of abstraction, i.e. the relocate_git_dir is only about 
>>   moving a git dir of one repository. The submodule specific stuff (e.g.
>>   recursion into nested submodules) is in submodule.{c,h}
>>   
>>   This was motivated by reviews on the series of checkout aware of submodules
>>   building on top of this series, as we want to directly call the embed-git-dirs
>>   function without the overhead of spawning a child process.
>
> OK.  Comparing the last steps between this round and the previous
> one, I do think the separation of the responsibility among helpers
> is much more reasonable in this version, where:
>
>  - submodule_embed_git_dir() is given a single path and is
>    responsible for that submodule itself, which is done by calling
>    submodule_embed_git_dir_for_path() on itself, and its
>    sub-submodules, which is done by spawning the helper recursively
>    with appropriate super-prefix;
>
>  - submodule_embed_git_dir_for_path() computes where the given path
>    needs to be moved to using the knowledge specific to the
>    submodule subsystem, and asks relocate_gitdir() to perform the
>    actual relocation;
>
>  - relocate_gitdir() used to do quite a lot more, but now it is only
>    about moving an existing .git directory elsewhere and pointing to
>    the new location with .git file placed in the old location.
>
> I would have called the second helper submodule_embed_one_git_dir(),
> but that is a minor detail.
>
> Very nicely done.

One thing that is not so nice from the code organization point of
view is that "dir.c" now needs to include "submodule.h" because it
wants to call connect_work_tree_and_git_dir().

I wonder if that function belongs to dir.c or worktree.c not
submodule.c; I do not see anything that is submodule specific about
what the function does.
