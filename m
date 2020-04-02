Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1FBC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F1420719
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 19:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nTyCVXHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbgDBTqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:46:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59936 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgDBTqc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 15:46:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DACFACCB51;
        Thu,  2 Apr 2020 15:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UhG032f/803mFJbYuqHeGPjTC24=; b=nTyCVX
        HhiU+/awKN/LlHBcngfUSVIU1jsL21AoXbSRnjMoYokMkJSIq65mhjskvAwHc0Xy
        8YlgCvHQ9Iy51TTUZstAAdzBxgq+Cc/rP7leqXbnaHBDV6H5fzGlnkMmMYwclWHh
        K7uhzjeK8e7UWNKeRGwVDnV2oIGZe0AjNTASk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CpxPBOweP7rrQG1uuKEAQ/eNkchc6vI9
        /8h6WDlnZLZ9RI9o7MQcBTFm9YnvKwcLHhIOxYPlgOcy7OWjcn9CfAT9m1wxSIk0
        rFVG8nCddq0bNSU3a3AgA82iGgL4IDKZsYL+grVHd3z3NkXasbXc5k5wRrWrt20q
        g806pnoBCcs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3E4CCCB50;
        Thu,  2 Apr 2020 15:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2A9A1CCB4F;
        Thu,  2 Apr 2020 15:46:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v2 1/2] promisor-remote: accept 0 as oid_nr in function
References: <20200331020418.55640-1-jonathantanmy@google.com>
        <cover.1585854639.git.jonathantanmy@google.com>
        <474eb27d9c136fb69e961546004cfb531d722e2c.1585854639.git.jonathantanmy@google.com>
Date:   Thu, 02 Apr 2020 12:46:26 -0700
In-Reply-To: <474eb27d9c136fb69e961546004cfb531d722e2c.1585854639.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 2 Apr 2020 12:19:16 -0700")
Message-ID: <xmqqblo93c31.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A558E334-751A-11EA-8E40-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> There are 3 callers to promisor_remote_get_direct() that first check if
> the number of objects to be fetched is equal to 0. Fold that check into
> promisor_remote_get_direct(), and in doing so, be explicit as to what
> promisor_remote_get_direct() does if oid_nr is 0 (it returns 0, success,
> immediately).

>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/index-pack.c |  5 ++---
>  diff.c               | 11 +++++------
>  promisor-remote.c    |  3 +++
>  promisor-remote.h    |  8 ++++++++
>  unpack-trees.c       |  5 ++---
>  5 files changed, 20 insertions(+), 12 deletions(-)

Nice simplification.

> +/*
> + * Fetches all requested objects from all promisor remotes, trying them one at
> + * a time until all objects are fetched. Returns 0 upon success, and non-zero
> + * otherwise.

Good.

> + * If oid_nr is 0, this function returns 0 (success) immediately.

Is this worth saying?  If you ask to lazily grab 0 objects, it is
probably clear that no object would be read before the helper
returns.

When oid_nr==0 you are allowed to pass oids==NULL, but otherwise,
oids==NULL would be an error.  Is that the kind of difference you
wanted to point out, I wonder?

> + */
>  int promisor_remote_get_direct(struct repository *repo,
>  			       const struct object_id *oids,
>  			       int oid_nr);
