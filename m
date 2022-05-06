Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADDFC433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 21:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444553AbiEFVrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 17:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348985AbiEFVrj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 17:47:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2F46FA1B
        for <git@vger.kernel.org>; Fri,  6 May 2022 14:43:54 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BE381878CA;
        Fri,  6 May 2022 17:43:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GzFquTIeh/knOjLFxK7FPXCj5IChkkOvuboz7b
        6kE5A=; b=mwucrzYZJ2jAIlrx47YO3fzdze58Bv3UwtVkCMYqYb7DujB+FdK10W
        DhV7DB132PlDIf2kxe+JWxJjtINcwUt7F/eLQlEh55V+gfBE5oXmwdtyImWc7hUd
        7LxDfjc8ziKZVCnF+BJzq+z+bnk3GJ7Wxb/x0OdPzK+g30KA4v7KQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 645541878C9;
        Fri,  6 May 2022 17:43:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0FD5D1878C8;
        Fri,  6 May 2022 17:43:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running
 with sudo
References: <20220428033544.68188-1-carenas@gmail.com>
        <20220428105852.94449-1-carenas@gmail.com>
        <20220428105852.94449-4-carenas@gmail.com>
        <xmqq7d79du6c.fsf@gitster.g>
        <5493b2f1-e59d-d91d-ac21-47c93d2996f2@gmail.com>
        <xmqq7d79gjre.fsf@gitster.g>
        <CAPUEspibV6LKVAGpUPBoDYWvF7cjBJUJOSMDzLY6ErMF8s-Eng@mail.gmail.com>
Date:   Fri, 06 May 2022 14:43:48 -0700
In-Reply-To: <CAPUEspibV6LKVAGpUPBoDYWvF7cjBJUJOSMDzLY6ErMF8s-Eng@mail.gmail.com>
        (Carlo Arenas's message of "Fri, 6 May 2022 10:50:04 -0700")
Message-ID: <xmqq1qx6jq0b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DA4A28E-CD85-11EC-BC49-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> Since I am renaming it anyway as part of this topic with RFC v4, would
> it be a good idea to require both?
>
> I see the "IKNOWHATIAMDOING" not as a normal GIT_TEST flag, but as a
> "here be dragons!" warning, and I later found that I either
> misremembered it being enabled in the CI, or it was dropped with one
> of those refactors we do often there.
>
> My RFC v4 includes a new nice looking GIT_TEST variable as suggested
> by Phillip which I am also enabling in the CI to hopefully make it
> even more clear that this is only meant to run there, but sadly that
> also means that this patch will likely have a conflict when merged
> upwards.

This must build from the older mainteance tracks like maint-2.30, so
let's keep the changes to absolute minimum, especially since that
will become the base for any further usability tweaks (in an earlier
round you suggested to cover "doas", and other changes may want to
be applied but all of them should be deferred to later changes).

I actually think 1/3 and 3/3 are OK.  Are there remaining issues in
these two patches (which only are tests)?

As to 2/3, I think the code is basically already fine, but a
simplification like the following on top would be a good idea.

 * The callers do not care how errno is modified by the call made
   into extract_id_from_env(); we are potentially clobbering errno
   by calling getenv(), lstat(), geteuid(), etc, and we have no
   "preserve errno as the caller had" around them.  So let's lose
   the saved_errno thing.

 * We clear errno before making strtoul() call, so any non-zero
   errno must have happeneed in strtoul(), which includes ERANGE.
   There is no point chekcing the returned value env_id; if it is
   ULONG_MAX but errno is 0, then the SUDO_UID legitimately is
   naming a user whose UID is that special value, and it is not an
   indication of an overflow.

With the change squashed in, [2/3] can have 

Reviewed-by: Junio C Hamano <gitster@pobox.com>

Thanks.

 git-compat-util.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git c/git-compat-util.h w/git-compat-util.h
index dfdd3e4f81..43c9cd0b48 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -413,14 +413,11 @@ static inline void extract_id_from_env(const char *env, uid_t *id)
 	if (real_uid && *real_uid) {
 		char *endptr;
 		unsigned long env_id;
-		int saved_errno = errno;
 
 		errno = 0;
 		env_id = strtoul(real_uid, &endptr, 10);
-		if (!errno && !*endptr && env_id <= (uid_t)-1)
+		if (!*endptr && !errno)
 			*id = env_id;
-
-		errno = saved_errno;
 	}
 }
 
