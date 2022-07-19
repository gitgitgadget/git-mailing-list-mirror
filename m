Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE9BC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 22:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbiGSWtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 18:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbiGSWtL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 18:49:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1409160532
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 15:49:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8502719DA2C;
        Tue, 19 Jul 2022 18:49:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KpMdCOf3hxAl
        pi5fkyl5FyR3d9iNKOYlIzSK9O7yXkw=; b=SS2z/Vh2xEo6kzVZRmdII9BXIRex
        2h+qwbuYzzI7kGsu5F+gH/TN39zwzy8RvoWQw2GMK4VEHjlU7xGVICu5KMfiuIBj
        xuQcL56X6FxM5qbGXZ0LTA3FKKfHS8K/xeN42RDAkx2akoZa2lWV7k9MpiOs6Q38
        oq1HWl6fndu8j3I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7CABE19DA2B;
        Tue, 19 Jul 2022 18:49:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 133ED19DA2A;
        Tue, 19 Jul 2022 18:49:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/6] merge: fix save_state() to work when there are
 racy-dirty files
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <89e5e633241e45a0c4b18289ab2fafdaabc8191e.1655621424.git.gitgitgadget@gmail.com>
        <CAOLTT8THesUrMtov0L=pHKNfdABYvHeue6OzHre-sQD36=2e=g@mail.gmail.com>
Date:   Tue, 19 Jul 2022 15:49:04 -0700
In-Reply-To: <CAOLTT8THesUrMtov0L=pHKNfdABYvHeue6OzHre-sQD36=2e=g@mail.gmail.com>
        (ZheNing Hu's message of "Mon, 18 Jul 2022 00:28:06 +0800")
Message-ID: <xmqqo7xk7m73.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FE56A85C-07B4-11ED-B3C6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2022=E5=
=B9=B46=E6=9C=8819=E6=97=A5=E5=91=A8=E6=97=A5 14:50=E5=86=99=E9=81=93=EF=BC=
=9A
>>
>> From: Elijah Newren <newren@gmail.com>
>>
>> When there are racy-dirty files, but no files are modified,
>> `git stash create` exits with unsuccessful status.  This causes merge
>> to fail.  Refresh the index first to avoid this problem.

Racily dirty?  Or just being stat-dirty is sufficient to cause the
"stash create" to fail?

> I just want to show what sence will meet this errors:
>
> 1. touch file
> 2. git add file
> 3. git stash push (user may do it before git merge)
> 4. touch file (update file but not update its content)
> 5. git merge (call git stash create and return 1)

I think, from the above reproduction recipe, that the breakage does
not depend on racily-clean index entries (i.e. file touched within
the same timestamp as the last write of the index without changing
their size).  So s/racy-dirty/stat-dirty/ (both on the title and the
body) would be a sufficient fix.

Thanks.
