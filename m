Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEDAC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 04:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8264660233
	for <git@archiver.kernel.org>; Thu, 20 May 2021 04:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhETEr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 00:47:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61290 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhETEr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 00:47:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0AD7C146E2E;
        Thu, 20 May 2021 00:46:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I0m/Ao6OoC+KANP3udO+jqRUtz/0ZIybZWQRfy
        04UB8=; b=k8ucv0lyHL09eML7hQH98FfGsb02rTZQQRJXz4QLTW6JMILEn4yA6I
        d3LkPqbCNGhLzvQa/pmgHp8IHjP13Kherrcdc+cZ+Lnl/l95b2grDYfR7u/qFwdR
        7Ujmwa0Vim5wJH19QlyF8DrNhOCE1aVLQymA/6Pvnlq2vmWxVd9lA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0195F146E2D;
        Thu, 20 May 2021 00:46:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 504A4146E2C;
        Thu, 20 May 2021 00:46:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, avarab@gmail.com
Subject: Re: [PATCH v2 1/3] packfile-uris: support for excluding commit object
References: <cover.1621327467.git.dyroneteng@gmail.com>
        <73e64147b17cb382d34357c913616095b6169650.1621327467.git.dyroneteng@gmail.com>
Date:   Thu, 20 May 2021 13:46:01 +0900
In-Reply-To: <73e64147b17cb382d34357c913616095b6169650.1621327467.git.dyroneteng@gmail.com>
        (Teng Long's message of "Tue, 18 May 2021 16:49:51 +0800")
Message-ID: <xmqqlf8aui5y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4809D106-B926-11EB-9538-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(continuing from yesterday's review)

> @@ -3023,7 +3040,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
>  	struct rev_info *revs = _data;
>  	struct object_info oi = OBJECT_INFO_INIT;
>  	off_t ofs;
> -	enum object_type type;
> +	static enum object_type type;
>  
>  	display_progress(progress_state, ++nr_seen);
>  
> @@ -3031,7 +3048,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
>  		return 0;
>  
>  	ofs = nth_packed_object_offset(p, pos);
> -	if (!want_object_in_pack(oid, 0, &p, &ofs))
> +	if (!want_object_in_pack(oid, type, 0, &p, &ofs))
>  		return 0;
>  
>  	oi.typep = &type;

This change is puzzling.

The first call to this helper will use BSS initialized type to call
want_object_in_pack(), and then after that call says "yes, we want
that object", packed_object_info() gets called to learn what type it
is.  And the second call would use the type of the object we
previously handled, because type is a function scope static.  Or if
we are not that lucky and multiple threads are involved, the type we
pass is from a random and unrelated object some other thread has
called this helper with.

