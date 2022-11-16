Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B83C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 21:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiKPVO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiKPVOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 16:14:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E0A43847
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 13:14:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f126-20020a255184000000b006cb2aebd124so17193670ybb.11
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 13:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Q+0/J6CnC+R5HimxEgJzW2uh5w5jytHvoHjuBkkkaQ=;
        b=eaO/ZcLspX+qFdT8aNM6luqon55JM/72/qteOMR80auZYIT4LTjgcOWtph46lwr9rD
         c4wHPrXEn0BtxTutq4T1mNy+jvPC7cFPQeBveRTdr3OU3L6Rwi1jOKSKu21gKqc3/s10
         6LhBTsAzD7Id+8pS3MRwNrbwRCuOfgO7HRjDknHCUnfHMl2bUGjE8ykq++XprTcRjF05
         lrWaFpHCdXmFubAY0S1FSrwuHtCW5JRcvf0YEvhGKopExpNXgTFM7nZeJ/wnUwm7NF6v
         6Ip96OxKyeIVh4Q43iYZL360LXrbf1oxQWg2U4w567Glcq6kMI9uNvIVjlFxRqPTWeYB
         cMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q+0/J6CnC+R5HimxEgJzW2uh5w5jytHvoHjuBkkkaQ=;
        b=2G3Nj1YvRLUzSIXC8bjZ5cUq6uWOoR52AeKS0RVWdnzqGv6vQhtMHS8xeeJusR7NCR
         id8/0HSpYw6NnWpdBfH2167WQyhk6jZC8G6OtpoaXm+RSuSpgV7TBWTKtarpijqZOjPm
         M3PWCDPEmcnZbuPUo58eWrtWnix+gVBm2FUlvwSWyzzZzD7eFftq8JWQ/ORgjadSs0yl
         BhN8pFIjydEPCAGImMtiPReYtAHlrq0/0BNh/iL947Z9rBijOPfcq9jOC+Dy/oIicoMp
         AODZxozBvHp1DkooWmmGdkAhwBJjB+KJPPcR9J02lISEGnqyvFhKm4DsmHXZf0Ab1G4g
         I33A==
X-Gm-Message-State: ANoB5pk3xyEZ1FCSPnPld+VGOKIarxG7uGjV3sMI/6hicntr9FdDf8B4
        QvqDochdkKnnkBbCTSVsNZSCSIHj2slle8caIiaO
X-Google-Smtp-Source: AA0mqf7yggq56QNq2DcIxSk04vUnRXNoFXbnkYfJ8Fu0SraVQK9VUTLzRw/vRXWqf1e3qgHVz/fhL1IPoJMXwy4bZAxM
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a81:2508:0:b0:36d:1171:6f60 with
 SMTP id l8-20020a812508000000b0036d11716f60mr23500007ywl.361.1668633263956;
 Wed, 16 Nov 2022 13:14:23 -0800 (PST)
Date:   Wed, 16 Nov 2022 13:14:18 -0800
In-Reply-To: <Y3Up5Vi75Up8LaGQ@coredump.intra.peff.net>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221116211419.439356-1-jonathantanmy@google.com>
Subject: Re: [RFC][PATCH] object.c: use has_object() instead of repo_has_object_file()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:
> I.e., I'd suggest this patch to remove both calls entirely:
> 
> diff --git a/object.c b/object.c
> index 248530ba7b..a370545405 100644
> --- a/object.c
> +++ b/object.c
> @@ -285,9 +285,8 @@ struct object *parse_object_with_flags(struct repository *r,
>  			return &commit->object;
>  	}
>  
> -	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
> -	    (!obj && repo_has_object_file(r, oid) &&
> -	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
> +	if ((obj && obj->type == OBJ_BLOB) ||
> +	    (!obj && oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
>  		if (!skip_hash && stream_object_signature(r, repl) < 0) {
>  			error(_("hash mismatch %s"), oid_to_hex(oid));
>  			return NULL;
> 
> But there may be some subtlety I'm missing. I'm cc-ing Jonathan Tan, who
> added has_object(), and who added the top call to repo_has_object_file()
> via df11e19648 (rev-list: support termination at promisor objects,
> 2017-12-08).

Thanks for CC-ing me on this. Looking at that commit and the code at that time,
I'm not sure why I added that call either. My best guess is that I was worried
that the streaming interface wouldn't support missing objects, but both then
and now, a call to istream_source() is made before any streaming occurs (which
does perform the lazy fetch).

So yes, I also think that you can remove these calls.
