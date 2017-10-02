Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D927F202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 03:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbdJBDhP (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 23:37:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53755 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751148AbdJBDhO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 23:37:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D077B93481;
        Sun,  1 Oct 2017 23:37:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fvYeoshaIS3X
        SDJ/QLwWhOP+BNg=; b=QBkB1f6U4RG7mWrwxAlsIm/XzEmlklb4ipmW99M7PMTG
        1SeJAF/wq4rgL7M7uhJvGPHQ5qz/QCJ7Fokb4+lQ+3GEeA+AJcHSe59eKpfzY4SX
        LeFXdmhPA7SEPzpLviG3K+AZ1em5mpnDg2qU8A8L5N4EBafz/Q7AfcHQ6btIaTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WHaY69
        4xWStK+1Q1/MM+15wYGRi8HCN5bTUEJoEdHMunh3//f9DHRb8yEZWmjp8mt6Jr9i
        gN+xHwB8hjVB5Fa/DFwS5lcCSmBYy6XtVE31H8s6oZneoxuH83wGZJhybE78JVC+
        XAgj+QkqHlAe3Xip5odR8TC9WKkWHUrTnJ4dc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C93E09347F;
        Sun,  1 Oct 2017 23:37:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 463899347E;
        Sun,  1 Oct 2017 23:37:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/11] treewide: prefer lockfiles on the stack
References: <cover.1506862824.git.martin.agren@gmail.com>
        <f241038eeed0f5f8bb346b394495356c20884a39.1506862824.git.martin.agren@gmail.com>
Date:   Mon, 02 Oct 2017 12:37:09 +0900
In-Reply-To: <f241038eeed0f5f8bb346b394495356c20884a39.1506862824.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 1 Oct 2017 16:56:03
 +0200")
Message-ID: <xmqqlgkuqkyi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F965D87E-A722-11E7-80DE-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> diff --git a/builtin/diff.c b/builtin/diff.c
> index 7e3ebcea3..91995965d 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -203,17 +203,16 @@ static int builtin_diff_combined(struct rev_info =
*revs,
> =20
>  static void refresh_index_quietly(void)
>  {
> -	struct lock_file *lock_file;
> +	struct lock_file lock_file =3D LOCK_INIT;
>  	int fd;
> =20
> -	lock_file =3D xcalloc(1, sizeof(struct lock_file));
> -	fd =3D hold_locked_index(lock_file, 0);
> +	fd =3D hold_locked_index(&lock_file, 0);
>  	if (fd < 0)
>  		return;
>  	discard_cache();
>  	read_cache();
>  	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
> -	update_index_if_able(&the_index, lock_file);
> +	update_index_if_able(&the_index, &lock_file);
>  }

This is not a show-stopper for this patch series, but just something
I noticed, something that used to be unavoidable in the old world
order that requires us to leak lockfiles, but now it becomes more
obvious.

update_index_if_able() calls write_lock_index() with the COMMIT_LOCK
option, but it does so conditionally.  When it does not make the call,
the lockfile is left behind to be cleaned up by the atexit() handler,
but when it does, it is closed and released.

Perhaps update_index_if_able() needs to be further cleaned up to
always release the resource held by the lockfile structure?  Its
caller cannot differentiate (and more importantly, its caller does
not want to care) if the _if_able call actually has updated the
index or not and act differently afterwards.

