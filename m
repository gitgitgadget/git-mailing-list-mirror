Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA36D20954
	for <e@80x24.org>; Thu,  7 Dec 2017 15:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbdLGPbL (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 10:31:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56490 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753413AbdLGPbK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 10:31:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E1B9BFA15;
        Thu,  7 Dec 2017 10:31:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KdIWiPcQ4H5TJaQdWzPrVX3o7CU=; b=TuL45K
        krIqOgm/PPoTeo7xdViTfZjU8O/tg9bvtySAJ2J5Uaubrrla8eND0Y2/T6PcdcsV
        e6VbklPOQBn62/xs5yVcGHSmBGebVGNaiIDZICsXoCPCEXZiXlS2CfxG+E/bZBk1
        8G2Jq5UXwJOPOoF1mYZOJt7rpMe/hVJzCeURc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LQhQb8UqF71Ear2vQbiXhqM//xqzi12Z
        aDbTWxuExu5CGle4L+AxRXX4w8w/7y9cjdyfKQ8S/tFEMMRPguWDV/r4rO1+CymU
        pJJxZns0JlwGx0iAn1NAqAbdL8EapJnG5br4uDG2UG1mLJpcTeyzonmXhDdWNLgx
        0dGEQ1p9rtY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45EA6BFA14;
        Thu,  7 Dec 2017 10:31:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7870BBFA13;
        Thu,  7 Dec 2017 10:31:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elazar Leibovich <elazar.leibovich@oracle.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        idan brown <idan.brown@oracle.com>,
        Liran Alon <liran.alon@oracle.com>,
        Eyal Moscovici <eyal.moscovici@oracle.com>,
        nikita.leshchenko@oracle.com
Subject: Re: Unfortunate interaction between git diff-index and fakeroot
References: <0190ae30-b6c8-2a8b-b1fb-fd9d84e6dfdf@oracle.com>
Date:   Thu, 07 Dec 2017 07:31:08 -0800
In-Reply-To: <0190ae30-b6c8-2a8b-b1fb-fd9d84e6dfdf@oracle.com> (Elazar
        Leibovich's message of "Thu, 7 Dec 2017 11:03:57 +0200")
Message-ID: <xmqqzi6ueern.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6436B6E-DB63-11E7-A4AB-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elazar Leibovich <elazar.leibovich@oracle.com> writes:

> We noticed some unexpected behavior of git, when running git commands under
> fakeroot, and then running another command without fakeroot.
>
> When running, e.g., git status, or git describe --dirty, git can
> update the index file.

Correct.  fakeroot would report that the files that are actually
owned by the user who is running fakeroot are owned by root; the
cached stat information in the index would be "corrected" to say
that they are owned by root.  So once the index is refreshed like
so, things will become consistent.

> The unexpected result is:
>
> "fakeroot git status" updates the index, and the index now says all files
> are owned by uid:0.

You should learn to expect it; that is how fakeroot works.

> "git diff-index --name-only HEAD" is used to test if the git tree is dirty
> without fakeroot, concluding all files have changed, since their owner UID
> is changed.

The lower-level plumbing diff-* commands are meant to be used by
scripts that refresh the index once upfront.

If you are using "diff-index" for the "is the tree dirty?" check
without running "update-index --refresh", then you are not using
the command correctly.
