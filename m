Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE26C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8357720767
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L++Xp7rB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDVSPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:15:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61575 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgDVSPh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 14:15:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E2DEC5BE36;
        Wed, 22 Apr 2020 14:15:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7bhrnIldODxc+p8L2rv9hc9FGb4=; b=L++Xp7
        rBuc7K5GzFzmotXtIjeq/qZ0qua7UrXVA5Iaza9FMsy6sCUOd0lova4xrdGWWLhq
        VhqyqtFY7zi09E/zZHoNFcyfC67ilIdIDJdiHK1Ph2yMZ3qMTB62jdo+BszSVBbq
        YxtjMGuW05mW93mR5nEMdiWzm1VveYojm4MGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tkZPJVdNeSCuygshjVDeuAl/OZ3bp/N4
        QVMC+sokznejv9Z4J9/r3C8Vk6YSca3D/xnRj3/pdK6BTDiLuGHstzpDnhjb6hFc
        JZkZDhspmIr/KaUzlc1Tmf3ohlTNiWTlRU+K3llBCMSGqg/RFklin78gaCjNTYfI
        YJAeGxzmvKg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D75F65BE35;
        Wed, 22 Apr 2020 14:15:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 40C4F5BE32;
        Wed, 22 Apr 2020 14:15:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, newren@gmail.com,
        jrnieder@gmail.com, dstolee@microsoft.com
Subject: Re: [PATCH] shallow.c: use 'reset_repository_shallow' when appropriate
References: <8d295389ea43c6b7e008514067b7af6eacba64a5.1587492422.git.me@ttaylorr.com>
        <20200422180245.196132-1-jonathantanmy@google.com>
Date:   Wed, 22 Apr 2020 11:15:33 -0700
In-Reply-To: <20200422180245.196132-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 22 Apr 2020 11:02:45 -0700")
Message-ID: <xmqqy2qnidyy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 423C2954-84C5-11EA-9794-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> @@ -414,6 +414,7 @@ void prune_shallow(unsigned options)
>>  	} else {
>>  		unlink(git_path_shallow(the_repository));
>>  		rollback_lock_file(&shallow_lock);
>> +		reset_repository_shallow(the_repository);
>>  	}
>>  	strbuf_release(&sb);
>>  }
>
> The "if" part (not quoted here) commits the shallow lock file, and thus
> possibly modifies (or creates) the shallow file, so I think we need to
> put reset_repository_shallow() outside the whole "if" block. I have done
> that in the patch after the scissors.

Is there any rollback_lock_file() or commit_lock_file() call on the
shallow lock file in the files involved in this patch that does not
need a call to reset_repository_shallow() left after your work?

What I am trying to get at is if it would be safer to have a pair of
thin wrapper for rolling back or committing a new version of new
shallow file, e.g. rollback_shallow_file() + commit_shallow_file(),
and replace calls to {rollback,commit}_lock_file() with calls to
them.
