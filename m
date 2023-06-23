Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66CBEB64DD
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 21:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjFWVdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 17:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjFWVdK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 17:33:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDFABA
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 14:33:08 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1B0319507;
        Fri, 23 Jun 2023 17:33:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qvTW8Zo38f+HoxYhhIL8JJ26K46pGy9/WbV24n
        PA8Wo=; b=v3BJVhOGd666oSt2oJvi/6XtydB+2pU9G59muhFolSi1F8k4BybTEp
        Jb3Aye22zmFiv8UbI3rls6vH1wVHF10A/ejfxRSUzET7A2ZdLz5spSOOvSPkEd9X
        0Oji43EUv7F7wcNn1ZQN53186IdTLzjXSUTkrFUXMbWCJvKf3mtp8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C95CF19506;
        Fri, 23 Jun 2023 17:33:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E2F5519505;
        Fri, 23 Jun 2023 17:33:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 10/12] config.c: remove config_reader from configsets
References: <20230623205729.3258822-1-jonathantanmy@google.com>
Date:   Fri, 23 Jun 2023 14:33:01 -0700
In-Reply-To: <20230623205729.3258822-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 23 Jun 2023 13:57:29 -0700")
Message-ID: <xmqqjzvtampe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8886ABCC-120D-11EE-97B4-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> @@ -2429,11 +2427,7 @@ static int configset_add_value(const struct key_value_info *kvi_p,
>>  	l_item->e = e;
>>  	l_item->value_index = e->value_list.nr - 1;
>>  
>> -	if (reader->source->name) {
>> -		kvi_from_source(reader->source, kvi_p->scope, kv_info);
>> -	} else {
>> -		kvi_from_param(kv_info);
>> -	}
>> +	memcpy(kv_info, kvi_p, sizeof(struct key_value_info));
>>  	si->util = kv_info;
>>  
>>  	return 0;
>
> Ah, I remember seeing this memcpy from the previous round, but forgot to
> comment on it (I only commented on another instance, [1]).

Yeah, I noticed this and recalled seeing a comment on structure
assignment.  As both are pointers,

    *kv_info = *kvi_p;

would sufficiently stand out to notify us that we are doing a
not-trivial assignment here, and would avoid (slight) risks of typos
by type checking.

> Other than that, up to here looks good.
>
> [1] https://lore.kernel.org/git/20230601233550.429921-1-jonathantanmy@google.com/
>  
