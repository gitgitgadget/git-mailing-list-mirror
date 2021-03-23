Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A560C433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 19:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B4F619A3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 19:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhCWTEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 15:04:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62046 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhCWTEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 15:04:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D5C51219D1;
        Tue, 23 Mar 2021 15:04:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SZLtNYMrdKVQ82C3lLHNJynIfLU=; b=rwWzMf
        lvQNspM+FasN/feZLDY6lrhrgD48xMbh7q3mx7xNiXmMljsND8uWeegunc0wdrL1
        Fn7JvWJyeyfscI5CEoEE2wIz5nIipM1WbGRzOb3MgfpjYEibeE5TzofIA+tigyc7
        muLTkvxrNrKYsh7C6fYp41QrgpsJyQdSj0NaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EJzGW+r6CMTGPkgzmJFUys6ovEpQi3q9
        S0DtwksN6Ia2nRYcQHYKOHQRvfKtAwyMuq8QmJogbyEwPYoUrQ7mgjwgZpD5+39N
        9KnhfGknFMa8zgDOqxRobibPOMF85FaOb+HPQ3d0MdPoX/29zG1u8VUdn7K3dG6q
        hjrxfZh+/TU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3589E1219D0;
        Tue, 23 Mar 2021 15:04:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 79A9E1219CC;
        Tue, 23 Mar 2021 15:04:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linu Cherian <linuc.decode@gmail.com>
Cc:     git@vger.kernel.org, Linu Cherian <lcherian@marvell.com>
Subject: Re: Query on managing the order of commits in git merge
References: <CAAHhmWjLAO7EBEvcizFd1otDJDq8yesaA3FyDEYPWpuSLuy=Kw@mail.gmail.com>
Date:   Tue, 23 Mar 2021 12:04:08 -0700
In-Reply-To: <CAAHhmWjLAO7EBEvcizFd1otDJDq8yesaA3FyDEYPWpuSLuy=Kw@mail.gmail.com>
        (Linu Cherian's message of "Wed, 24 Mar 2021 00:04:49 +0530")
Message-ID: <xmqqft0l3d5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CD3169C-8C0A-11EB-B8BC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linu Cherian <linuc.decode@gmail.com> writes:

> A has the following commits,
> A ---> 1---2---3--4
>
> We do have another branch B, which is forked out of A and our
> features/fixes has been added
> on top of A.
> B ---->1 --2--3--4--5--6
>
>
> At a later stage, we sync branch A to the remote upstream branch
> and it becomes,
> A --> 1--2--3--4--7--8
>
> Now, when we merge A to B, the order in which the commits are merged
> into can be different based on date of commit. CMIIW
>
> Like, case 1:
>
> B --> 1--2--3--4--5--6--7--8--M
>
> case 2:
>
> B-->1--2--3--4--7--8--5--6--M
>
> where M is the merge commit.

Neither is showing you made a merge.  If you try gitk (or "git log
--oneline --graph"), you'll see that a merge does not result in a
single strand of pearls like the above.

I think your merge is working perfectly correctly, without
butchering the order each branch had its commits, and adding a
single merge commit 'M' that is a child of the commits at the tip of
these two branches.  It's just the order of commits you see when you
tell the tool to show them linearly (e.g. "log" without "--graph").

There are "--topo-order" etc. options that you can influence the
display order of the "log" output.


