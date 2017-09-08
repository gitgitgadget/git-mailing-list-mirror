Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B034C20286
	for <e@80x24.org>; Fri,  8 Sep 2017 00:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbdIHAqk (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 20:46:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57894 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753334AbdIHAqj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 20:46:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 206C893285;
        Thu,  7 Sep 2017 20:46:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l7ug/ODKWDBY/0yyQaGtTL6kkdE=; b=rGzauD
        fp6H3sfa9+t23P2jm9omyCDH/VYR6zYVISOq8ha/bhSn4EDra1yqZBL8qILlEJ2f
        l/qT9Alsnr9OCVW84+V6Kz9rTKvAVHtQR9fuJdOQELSlSWJFlFNyqxSj9wqLjj33
        T0LBXT3wjJFvRlEPdGS1QVx1HRD6/d6QCWyak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cheMs1CJO/vZV+FmrS68KvSWBMgvB2Zr
        XTRdBRwu51naXVoS0+tNb0cWOnZDdqxD+aTqi13FFCeG7tjhunW13eahLnUPxZGN
        bwe5T3aZrKwDiYzqldjnnu3ZUTR/vvVrvSyiIYkFlmxv5kcKN8a6Y2AEd5lXtQLt
        L61MY8vZI6o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15CC793284;
        Thu,  7 Sep 2017 20:46:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6046293283;
        Thu,  7 Sep 2017 20:46:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Subject: Re: [PATCH] refs: make sure we never pass NULL to hashcpy
References: <20170904200504.15249-1-t.gummerer@gmail.com>
        <xmqqh8wgaa7s.fsf@gitster.mtv.corp.google.com>
        <CAMy9T_ED1KBqkE9GCHrOrt0frnYAx1vka7Xx1DrXmjJBNNKahw@mail.gmail.com>
Date:   Fri, 08 Sep 2017 09:46:36 +0900
In-Reply-To: <CAMy9T_ED1KBqkE9GCHrOrt0frnYAx1vka7Xx1DrXmjJBNNKahw@mail.gmail.com>
        (Michael Haggerty's message of "Thu, 7 Sep 2017 09:26:35 +0200")
Message-ID: <xmqqvaku10gj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B9BC62A-942F-11E7-9F36-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I did just realize one thing: `ref_transaction_update()` takes `flags`
> as an argument and alters it using
>
>>         flags |= (new_sha1 ? REF_HAVE_NEW : 0) | (old_sha1 ? REF_HAVE_OLD : 0);
>
> Perhaps gcc is *more* intelligent than we give it credit for, and is
> actually worried that the `flags` argument passed in by the caller
> might *already* have one of these bits set. In that case
> `ref_transaction_add_update()` would indeed be called incorrectly.
> Does the warning go away if you change that line to
>
>>         if (new_sha1)
>>                 flags |=REF_HAVE_NEW;
>>         else
>>                 flags &= ~REF_HAVE_NEW;
>>         if (old_sha1)
>>                 flags |=REF_HAVE_OLD;
>>         else
>>                 flags &= ~REF_HAVE_OLD;
>
> ? This might be a nice change to have anyway, to isolate
> `ref_transaction_update()` from mistakes by its callers.

I understand "drop HAVE_NEW bit if new_sha1 is NULL" part, but not
the other side "add HAVE_NEW if new_SHA1 is not NULL"---doesn't the
NEW/OLD flag exist exactly because some callers pass the address of
an embedded oid.hash[] or null_sha1, instead of NULL, when one side 
does not exist?  So new|old being NULL is a definite signal that we
need to drop HAVE_NEW|OLD, but the reverse may not be true, no?  Is
it OK to overwrite null_sha1[] that is passed from some codepaths?

ref_transaction_create and _delete pass null_sha1 on the missing
side, while ref_transaction_verify passes NULL, while calling
_update().  Should this distinction affect how _add_update() gets
called?

