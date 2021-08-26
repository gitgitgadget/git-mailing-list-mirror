Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CFFC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 20:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16DE61038
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 20:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243586AbhHZU5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 16:57:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61199 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243602AbhHZU5R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 16:57:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99BC1E749B;
        Thu, 26 Aug 2021 16:56:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+pVrbjLC7xNPgdRSmPCryow9EstqJgnMtm5UwO
        qVUJE=; b=We3NiB+vDsgozfEaErMgjCkny7eqElKvPNpW49Qjc9YtIoUbm44NbW
        VSdCSHphaD2M4NdCLDw1sr3NxxiSAy1jpS6y8TL8uL1En8Z9zhB2tX5YJKKFIWFu
        ADVa2+kGuADYh+dEZ/HtMUXYjRiV5b6GoGc/qCIyQKYqLGyLbY55M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9202CE749A;
        Thu, 26 Aug 2021 16:56:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11EC1E7499;
        Thu, 26 Aug 2021 16:56:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v5 03/14] packfile-uri: support for excluding commit
 objects
References: <cover.1629805395.git.dyroneteng@gmail.com>
        <f71b3108428b6ba36667e5e8a311ab8ab973d10c.1629805396.git.dyroneteng@gmail.com>
Date:   Thu, 26 Aug 2021 13:56:26 -0700
In-Reply-To: <f71b3108428b6ba36667e5e8a311ab8ab973d10c.1629805396.git.dyroneteng@gmail.com>
        (Teng Long's message of "Wed, 25 Aug 2021 10:21:47 +0800")
Message-ID: <xmqqfsuwc4cl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14942C18-06B0-11EC-A6AC-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> This commit is used to support the recursive exclusion of a commit
> object, which means that if the exclusion of a commit is configured as
> packfile-uri, the commit itself and all the objects it contains will
> also be recursively excluded.

Whenever you say "which means", e.g. "We do X, which means we do Y",
think twice to see if you do not even have to say X.  In this
particular sentence, I think you can simplify the description
greatly and you do not even have to use the word "recursive".  

Also, because this "exclusion by a commit" does not work like the
usual "reachability" relationship Git users are familiar with, it
would help to highlight what is special that is done here to the
readers.

Taking the above together, along the lines of ...

    When a commit is specified to be excluded as packfile-uri,
    exclude all trees and blobs contained in its top-level tree, as
    well as the commit itself, but not the ancestors of the commit
    and objects that are reachable by them.

or something like that, perhaps.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 5f9ec3566f..63f3aed70a 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1311,11 +1311,14 @@ static int want_object_in_pack_one(struct packed_git *p,
>  static int want_object_in_pack(const struct object_id *oid,
>  			       int exclude,
>  			       struct packed_git **found_pack,
> -			       off_t *found_offset)
> +			       off_t *found_offset,
> +			       struct object *referred_commit)

As the caller is limited to pass commit and no other types of
object, the new parameter should be of type "struct commit", no?
