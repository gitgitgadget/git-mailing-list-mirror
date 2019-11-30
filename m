Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AB0C432C3
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 17:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472D52073C
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 17:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WKdeWDpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfK3Rgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 12:36:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51271 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfK3Rgv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 12:36:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF6443614C;
        Sat, 30 Nov 2019 12:36:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KrWqe8CZLf8eSACVuJf14y4PGXs=; b=WKdeWD
        ptPE0Oc5jNETIkGbmUnz3ewmAzW1SGs/F5u6/Te4LBfQngJDohifqJGN0hNXOxem
        eqSFBg19D7iTJAScSDCJk9+kTdgWac8nfoVbbmY/+vtYLw0c1eeHgvqEfpSCA+B0
        SJpwJLs2SiDVQsiuunF0iU2fVvMDBi0DdnI+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DpKEAVkoIzpKeZ79yErNoN47aGU1G9OA
        QtgkYcYfmDIzN5HTbdEtmvSM/Qmn1/Z8DM48sys5GVE3TdjWWCtID1FXxYXaj4LO
        fFO/DzCafvsT4aRogKYRdun6Ivr1mFSlR3BVhFwkLh7lEQulKKrtae/7r2t9OHhH
        adAHsHlTOkM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7B343614B;
        Sat, 30 Nov 2019 12:36:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C43836149;
        Sat, 30 Nov 2019 12:36:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Colin Stolley <cstolley@runbox.com>, git@vger.kernel.org
Subject: Re: hashmap vs khash? Re: [PATCH] packfile.c: speed up loading lots of packfiles.
References: <20191127222453.GA3765@owl.colinstolley.com>
        <20191128004202.GA25910@dcvr>
Date:   Sat, 30 Nov 2019 09:36:47 -0800
In-Reply-To: <20191128004202.GA25910@dcvr> (Eric Wong's message of "Thu, 28
        Nov 2019 00:42:02 +0000")
Message-ID: <xmqqeexp2rm8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC5EAF86-1397-11EA-A25F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Colin Stolley <cstolley@runbox.com> wrote:
>> When loading packfiles on start-up, we traverse the internal packfile
>> list once per file to avoid reloading packfiles that have already
>> been loaded. This check runs in quadratic time, so for poorly
>> maintained repos with a large number of packfiles, it can be pretty
>> slow.
>
> Cool!  Thanks for looking into this, and I've been having
> trouble in that department with big alternates files.
>
>> Add a hashmap containing the packfile names as we load them so that
>> the average runtime cost of checking for already-loaded packs becomes
>> constant.
>
> Btw, would you have time to do a comparison against khash?
>
> AFAIK hashmap predates khash in git; and hashmap was optimized
> for removal.   Removals don't seem to be a problem for pack
> loading.
>
> I'm interested in exploring the removing of hashmap entirely in
> favor of khash to keep our codebase smaller and easier-to-learn.
> khash shows up more in other projects, and ought to have better
> cache-locality.

Sounds fun ;-) and useful.
