Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AC6C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 15:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF6C60F91
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 15:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbhH0PQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 11:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhH0PQT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 11:16:19 -0400
Received: from host1.jankratochvil.net (host1.jankratochvil.net [IPv6:2a02:2b88:6:3b57::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8B7C061757
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 08:15:28 -0700 (PDT)
Received: from host1.jankratochvil.net (localhost [127.0.0.1])
        by host1.jankratochvil.net (8.16.1/8.16.1) with ESMTPS id 17RFFGFM571090
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 17:15:16 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 host1.jankratochvil.net 17RFFGFM571090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jankratochvil.net;
        s=default; t=1630077316;
        bh=2PD25CDwIAj8ql971ve0PIFGcd79PqQmeIAly6ZAEwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oI0qy+ChQsK86J0km4gvJMNRLlUYmAX28QIPI8MZfwSaJMfL59Jd8qkDigsPNDgyg
         OYxtY5NCCehx+A4MimZSTulGzIE104ZjGQUKcDMkBnM4ZVwHOi68iWBZNfgTIulvvw
         XDERO0CctWc8XuccUfHiJwcwVW7QudrIy2lgEEx8=
Received: (from lace@localhost)
        by host1.jankratochvil.net (8.16.1/8.16.1/Submit) id 17RFFF8m571089;
        Fri, 27 Aug 2021 17:15:15 +0200
Date:   Fri, 27 Aug 2021 17:15:15 +0200
From:   Jan Kratochvil <jan@jankratochvil.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: bugreport: git apply -3 confusing "lacks the necessary blob"
Message-ID: <YSkBg3lBAZ2pxCP2@host1.jankratochvil.net>
References: <YR1OszUm08BMAE1N@host1.jankratochvil.net>
 <73a31988-d298-0168-43d5-849f91366d7d@gmail.com>
 <xmqqtujkui9v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtujkui9v.fsf@gitster.g>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Aug 2021 19:40:12 +0200, Junio C Hamano wrote:
> But I think Jan is talking about the case where users get a patch
> that lacks the "index" information out of other people's "diff"
> implementation and try to "apply -3" without realizing that it is
> not Git's "diff" output.

For example from Phabricator:
	https://reviews.llvm.org/file/data/3ceoc32b3yv43vk3nw4q/PHID-FILE-lfeeh2qu4vrngdcwwudo/D107456.diff


> Perhaps something like the attached patch would be a good start.

Do you plan to check it in?


Thanks,
Jan Kratochvil


> diff --git i/apply.c w/apply.c
> index 44bc31d6eb..9972ada57e 100644
> --- i/apply.c
> +++ w/apply.c
> @@ -3566,6 +3566,8 @@ static int try_threeway(struct apply_state *state,
>  	/* Preimage the patch was prepared for */
>  	if (patch->is_new)
>  		write_object_file("", 0, blob_type, &pre_oid);
> +	else if (!*patch->old_oid_prefix && !*patch->new_oid_prefix)
> +		return error(_("cannot 'apply -3' a patch without the index line"));
>  	else if (get_oid(patch->old_oid_prefix, &pre_oid) ||
>  		 read_blob_object(&buf, &pre_oid, patch->old_mode))
>  		return error(_("repository lacks the necessary blob to perform 3-way merge."));
