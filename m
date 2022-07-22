Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72192C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 19:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiGVTlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 15:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbiGVTlI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 15:41:08 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42864643EE
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 12:41:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9319819B2B1;
        Fri, 22 Jul 2022 15:41:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=H8rfCGVZzXB4
        B8pYt1Q6b7omu05OK2qWyX0aTFY03c8=; b=jKPDNXW/YBQOu8ymqTflQ/tL5j8P
        Ma16JpRk0bXz78tNr8gslyCEIgnfMsMDui4+q+bjkeyW6OmICUqLtydumO+dxnCG
        7lJaXg6Ga1dih/BWvsxKlHx8xS9hcveGUSlaUAqX7IDi4WsEuvCvN6CwbsUucpSF
        OW7MCbPxwi5+B88=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8CB1319B2B0;
        Fri, 22 Jul 2022 15:41:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 36F4D19B2AF;
        Fri, 22 Jul 2022 15:41:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Tao Klerks <tao@klerks.biz>
Subject: Re: git write-tree segfault with core.untrackedCache true and
 nonexistent index
References: <YtrdPguYs3a3xekv@kitenet.net>
        <20220722192559.718264-1-martin.agren@gmail.com>
Date:   Fri, 22 Jul 2022 12:41:01 -0700
In-Reply-To: <20220722192559.718264-1-martin.agren@gmail.com> ("Martin
        =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 22 Jul 2022 21:25:59 +0200")
Message-ID: <xmqq35etc4vm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 387856C8-09F6-11ED-90CB-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> I can't help but think that e6a653554b was just unlucky enough to
> dereference `istate->repo` and that the real issue is that we're missin=
g
>
> 	if (!istate->repo)
> 		istate->repo =3D the_repository;
>
> in some strategic place a fair bit earlier. It seems to me like the dif=
f
> below is just papering over the real bug. It's not obvious to me where
> that check would want to go, though. Tao, do you have an idea?

I am not Tao, but thanks for starting to analyze the real issue.

It seems that there are two public entry points to dir.c API that
end up calling new_untracked_cache_flags().

One is read_directory(), which is the only caller of
validate_untracked_cache() that calls new_untracked_cache_flags().
The callers of read_directory() are supposed to give istate, and it
is quite unlikely they are throwing an istate with NULL in
istate->repo, simply because read_directory() already makes abundant
use of istate->repo.

The other one is add_untracked_cache().

Perhaps backtrace to see where the istate came from would quickly
reveal where the real issue lies?

Thanks.


