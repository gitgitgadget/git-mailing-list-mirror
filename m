Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65980C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209FD650A9
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCEVjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 16:39:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51439 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhCEVjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 16:39:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3AFD21210DF;
        Fri,  5 Mar 2021 16:39:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E+/j4NnUabALUxe6faVBejvzUSE=; b=WnIb2A
        4OKNjH/GF4zwzra+/0J6AyYF2I7wjJmPI5OL84Dboi8os7sYUSNL1GNOiECZ605B
        Sigb1WXhQlXM2aeP80yCOotbqEldN2GG6sbXoiG0I8ihuMRHyAv832AAGxK9k7vG
        75X/PqdpeDVNjUwtVo0rvUq+MJRmvcd6ZLjmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZQHouLAV6+agkoPONwT2zCv2BBe0Z+vQ
        ShkTk04Pk0R7XLAJBWcblzZQH1QbzEL3oZ+kVYQnXIS92BZWWwDvBNHZ8fXsAXAV
        FzhktITcQhC0rmFKlkya/A6YfPW+Wbo3rbleBLTnsroIbwaJoNbmk5vr9NsFpI2J
        Kj8JZnnrffk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3451F1210DE;
        Fri,  5 Mar 2021 16:39:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6BB191210DB;
        Fri,  5 Mar 2021 16:39:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH v2 1/1] rm: stage submodule removal from '.gitmodules'
 when using '--cached'
References: <20210218184931.83613-1-periperidip@gmail.com>
        <20210222172623.69313-1-periperidip@gmail.com>
        <20210222172623.69313-2-periperidip@gmail.com>
        <xmqqv9ak6iac.fsf@gitster.g> <20210305175816.GA22075@konoha>
Date:   Fri, 05 Mar 2021 13:39:10 -0800
In-Reply-To: <20210305175816.GA22075@konoha> (Shourya Shukla's message of
        "Fri, 5 Mar 2021 23:28:16 +0530")
Message-ID: <xmqqeegt9t6p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39C74CBA-7DFB-11EB-9C60-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <periperidip@gmail.com> writes:

>> Doing so would also mean that you should not have the caller call
>> stage_updated_gitmodules() at all, even in !index_only case.
>> Imagine if the .gitmodules file in the working tree had local
>> changes (e.g. registered a few more submodules, or updated the url
>> field of a few submodules) that are not yet added to the index when
>> "git rm" removed a submodule.  The user does not want them to be in
>> the index yet and "git rm" should not add these unrelated local
>> changes to the index.
>
> Won't this be deviating from the current behaviour of 'git rm'?
> Currently, the above case won't process and the user will be asked to
> stage or undo the mods they made before moving forward.

Ah, adding such safety to ensure that "rm" without "--cached"
(i.e. update both the index and the working tree copies of
.gitmodules) would stop when .gitmodules has a local mod would be a
good idea, on top of the outline you are responding to, I think.

Thanks.
