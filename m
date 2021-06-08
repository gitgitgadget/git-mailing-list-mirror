Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF14C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 05:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA4B61246
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 05:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhFHFJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 01:09:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62961 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhFHFJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 01:09:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E8CB1440D3;
        Tue,  8 Jun 2021 01:07:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zdHT0+9/TPLRFTTAxvpGOpSdVrofCGcfUqfwJP
        mRckQ=; b=D2TL7pUjIuQd8rtdUYWvVzE7UcoxDaTdVkM+CjdTFSBdvlunbELT+t
        bLoxp2NWWt4ro4kxeYHttJzfcIPTNgD2GBlbj9DzjILtUxjTaiUr003sfl+/zQdm
        oYRwWrJuRl8nw+bHSVnMrICa2VzGFH5m9qii30o7a2aXQ9twO7Ypk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4723E1440D2;
        Tue,  8 Jun 2021 01:07:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 933CF1440D0;
        Tue,  8 Jun 2021 01:07:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/6] [GSOC] ref-filter: add %(raw) atom
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
        <0efed9435b59098f3ad928acd46c3c7e9f13677d.1622884415.git.gitgitgadget@gmail.com>
Date:   Tue, 08 Jun 2021 14:07:28 +0900
In-Reply-To: <0efed9435b59098f3ad928acd46c3c7e9f13677d.1622884415.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Sat, 05 Jun 2021 09:13:30
        +0000")
Message-ID: <xmqqa6o1q6zz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D29E8AE-C817-11EB-984D-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
>  {
>  	struct atom_value *va, *vb;
> @@ -2389,10 +2452,30 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
>  	} else if (s->sort_flags & REF_SORTING_VERSION) {
>  		cmp = versioncmp(va->s, vb->s);
>  	} else if (cmp_type == FIELD_STR) {
> -		int (*cmp_fn)(const char *, const char *);
> -		cmp_fn = s->sort_flags & REF_SORTING_ICASE
> -			? strcasecmp : strcmp;
> -		cmp = cmp_fn(va->s, vb->s);
> +		if (va->s_size == ATOM_VALUE_S_SIZE_INIT &&
> +		    vb->s_size == ATOM_VALUE_S_SIZE_INIT) {
> +			int (*cmp_fn)(const char *, const char *);
> +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
> +				? strcasecmp : strcmp;
> +			cmp = cmp_fn(va->s, vb->s);
> +		} else {
> +			int (*cmp_fn)(const void *, const void *, size_t);
> +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
> +				? memcasecmp : memcmp;
> +			size_t a_size = va->s_size == ATOM_VALUE_S_SIZE_INIT ?
> +					strlen(va->s) : va->s_size;
> +			size_t b_size = vb->s_size == ATOM_VALUE_S_SIZE_INIT ?
> +					strlen(vb->s) : vb->s_size;

This breaks -Wdecl-after-stmt.  A possible fix below.

diff --git a/ref-filter.c b/ref-filter.c
index 46aec291de..648f9cabff 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2459,13 +2459,13 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 				? strcasecmp : strcmp;
 			cmp = cmp_fn(va->s, vb->s);
 		} else {
-			int (*cmp_fn)(const void *, const void *, size_t);
-			cmp_fn = s->sort_flags & REF_SORTING_ICASE
+			size_t a_size = va->s_size == ATOM_VALUE_S_SIZE_INIT
+					? strlen(va->s) : va->s_size;
+			size_t b_size = vb->s_size == ATOM_VALUE_S_SIZE_INIT
+					? strlen(vb->s) : vb->s_size;
+			int (*cmp_fn)(const void *, const void *, size_t) =
+				s->sort_flags & REF_SORTING_ICASE
 				? memcasecmp : memcmp;
-			size_t a_size = va->s_size == ATOM_VALUE_S_SIZE_INIT ?
-					strlen(va->s) : va->s_size;
-			size_t b_size = vb->s_size == ATOM_VALUE_S_SIZE_INIT ?
-					strlen(vb->s) : vb->s_size;
 
 			cmp = cmp_fn(va->s, vb->s, b_size > a_size ?
 				     a_size : b_size);
