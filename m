Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FBEC54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39DD92073A
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TRmAjKV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgDWUkx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:40:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57267 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgDWUkx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 16:40:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A8DD1CD504;
        Thu, 23 Apr 2020 16:40:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xdeDp87Xvf66GwetwRVe09EJaqk=; b=TRmAjK
        V3k8UFlDQ5+wgUVtL6QP06k67+xJTALgNIB/M+cArlxXTNGE0sq7iBuFX2OXFZ37
        IcpmDjmRKrlOOhEUXbX4Y6n06kmo2TSR3hzaU1ENR2KaT7Jmj1mcZW5VUhE5Jj2I
        FXBu+qah86yFRIOxTbbyQIqh29hKzbDqydct8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jcgW5cz4770aHGm0jKgVu2lCtQ6y674k
        Quffx91IbC2o4G5wwwB+CgOoZIwKuQukpuyyDkw64lVWEsf7xGxzV0150Tps/DDT
        zpaZ/Cu3I7V+dqPMhynw3k1Iu/qfqzCYws7O0fgB0D+0/735Y9NgtJiG2BRRcVUu
        hL6cJ7Cq7uo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1BFECD503;
        Thu, 23 Apr 2020 16:40:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F1BC9CD502;
        Thu, 23 Apr 2020 16:40:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH v2 2/2] shallow.c: use '{commit,rollback}_shallow_file'
References: <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
        <20200423180905.195407-1-jonathantanmy@google.com>
Date:   Thu, 23 Apr 2020 13:40:47 -0700
In-Reply-To: <20200423180905.195407-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 23 Apr 2020 11:09:05 -0700")
Message-ID: <xmqqr1weey0g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7065E84-85A2-11EA-82C7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Replace each instance of 'commit_lock_file' and 'rollback_lock_file'
>> with 'commit_shallow_file' and 'rollback_shallow_file' when the lock
>> being held is over the '.git/shallow' file.
>
> I think Jonathan Nieder already covered 1/2 so I'll just close the loop
> on this patch. There was one potential issue in that a previous version
> of this patch also called reset_repository_shallow() in
> setup_alternate_shallow(), but this version does not. But after looking
> into it, this looks fine - setup_alternate_shallow() deals with a
> passed-in alternate_shallow_file variable, which is different from the
> r->parsed_objects->alternate_shallow_file that is_repository_shallow()
> uses to set the global variables. (I might have confused the two during
> earlier reviews.) Also, setup_alternate_shallow() is called either
> before any shallow processing (empirically demonstrating that no
> resetting is needed in this case, because it has been working), or right
> before a commit or rollback of the lock file (so the global variables
> are being reset anyway, so we do not need to call
> reset_repository_shallow()).
>
> So,
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

Thanks for a review.

And of course, thanks Taylor.  Will queue.
