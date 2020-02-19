Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ED2C34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03415206F4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lXmNLprr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgBSTTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:19:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53314 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgBSTTN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 14:19:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 749833D73D;
        Wed, 19 Feb 2020 14:19:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aOzIDXzA0bFv1lhuB7gK6T2xwuo=; b=lXmNLp
        rrD+h9EuldDTPsy7GYpITjoqO89EBpYPIja1L00VHBMo/5VA79ZGaO9+ScbmMVY8
        20Jt5WNDDIxI5OqNnS6iw+oO4jjOoauvVeaFNNx/yZBBSKku/6Kzv+PQ5JH6Qt2C
        MV3ivo9l0nTBuA6d3JTVRgEVqQgwoFx7jVl0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ga+qNCch+KMM4pcO5fTnckJ+JPARpE7T
        Qazq4oz+3hIxmVEzqHRhdeXXytFqSfjwBEMRe2vQvzbUEYkaMlIJzbyEMekHCjeA
        PCIRVvpxpcuCpE2uZjuTkOViW4nX82pqXcP8E8kAWN0s7RLpUqbNGuIswABqw//f
        xVFaD3JNXvo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 635293D73C;
        Wed, 19 Feb 2020 14:19:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F2EC3D73B;
        Wed, 19 Feb 2020 14:19:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     pbonzini@redhat.com
Cc:     git@vger.kernel.org, bfields@redhat.com
Subject: Re: [PATCH 2/4] am: convert "resume" variable to a struct
References: <20200219161352.13562-1-pbonzini@redhat.com>
        <20200219161352.13562-3-pbonzini@redhat.com>
Date:   Wed, 19 Feb 2020 11:19:09 -0800
In-Reply-To: <20200219161352.13562-3-pbonzini@redhat.com>
        (pbonzini@redhat.com's message of "Wed, 19 Feb 2020 17:13:50 +0100")
Message-ID: <xmqqv9o2e66q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4F40926-534C-11EA-AA1B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pbonzini@redhat.com writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> This will allow stashing the submode of --show-current-patch.  Using
> a struct will allow accessing both fields from outside cmd_am (through
> container_of).
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  builtin/am.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 8181c2aef3..a89e1a96ed 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2118,7 +2118,7 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
>  	return 0;
>  }
>  
> -enum resume_mode {
> +enum resume_type {
>  	RESUME_FALSE = 0,
>  	RESUME_APPLY,
>  	RESUME_RESOLVED,
> @@ -2128,6 +2128,10 @@ enum resume_mode {
>  	RESUME_SHOW_PATCH
>  };
>  
> +struct resume_mode {
> +	enum resume_type mode;
> +};
> +
>  static int git_am_config(const char *k, const char *v, void *cb)
>  {
>  	int status;
> @@ -2145,7 +2149,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>  	int binary = -1;
>  	int keep_cr = -1;
>  	int patch_format = PATCH_FORMAT_UNKNOWN;
> -	enum resume_mode resume = RESUME_FALSE;
> +	struct resume_mode resume = { . mode = RESUME_FALSE };

I do not think it makes a difference to compilers, but it seems that
existing code spells this without SP between dot and the field name.

> +	struct resume_mode resume = { .mode = RESUME_FALSE };

The rest of the patch is quite straight-forward update that looks
correct.

Thanks.
