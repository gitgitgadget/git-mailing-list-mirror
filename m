Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867F4C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F4B61181
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhHFQgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 12:36:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50862 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbhHFQgr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 12:36:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DC18E148669;
        Fri,  6 Aug 2021 12:36:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iQrmdhxOh/xnXABVNjCx4w55Nk/Y5wW9/48OO0
        ssLE0=; b=SRh63oKC+8ETSEoyGwiAB04srxyFY6FW1I3PX7cV1EKtx07Pf5/krp
        uq60gkgSD+CMSjS97uhlf9GsyyUXYJJT6LaQbdq+1C7hGQP1Jx4Zsfq89XggTSAI
        vZZdZhBazk4dp+HozSoaCROEKrJKhl61KHKFi+0fZ4jEPslf8Y+So=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D3BD3148668;
        Fri,  6 Aug 2021 12:36:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 29A6D148666;
        Fri,  6 Aug 2021 12:36:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [GSoC] [PATCH v2 4/9] dir: libify and export helper functions
 from clone.c
References: <20210805071917.29500-1-raykar.ath@gmail.com>
        <20210805074054.29916-1-raykar.ath@gmail.com>
        <20210805074054.29916-5-raykar.ath@gmail.com>
        <xmqqim0jk4qx.fsf@gitster.g> <m235rmvnc1.fsf@gmail.com>
Date:   Fri, 06 Aug 2021 09:36:27 -0700
In-Reply-To: <m235rmvnc1.fsf@gmail.com> (Atharva Raykar's message of "Fri, 06
        Aug 2021 16:42:30 +0530")
Message-ID: <xmqq1r76jzsk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 733EACF2-F6D4-11EB-B2FD-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> Naming things is hard...

Absolutely.

> Maybe the right phrase would be 'target directory'? We are creating a
> target directory name by looking at the "humanish" part of the Git URL.
>
> I think the intention of all callers of this function is to get a
> "default" directory name which will be used as the target of some
> operation in the absence of the user providing one.
>
> So maybe the name could be: 'guess_target_dir_from_git_url()'

I have no immediate objection to the name.  

Just to see how people (including you) may react to a name from a
completely different line of thinking, let me throw this, though.

How does git_url_basename() sound?  

Instead of saying what we'd use it for (i.e. as the name for the
directory getting created), we say what we compute.  We take a
URL-looking thing that is used by Git, and we compute something like
basename() but that is tailored for Git (e.g. unlike "basename
a/b/c.git" that yields "c.git", we give "c" for "a/b/c.git".
Likewise "<scheme>://a/b/c/.git" won't yield ".git", we compute
"c").

Having said that, I think guess_target_dir_from_git_url() is clear
enough.

> This would make sense for any operation now or in the future that wants
> to reuse this functionality.

That is mostly for you to decide.   I can help you sanity check the
proposed name(s) with existing callers, but you'd be a better judge
for callers you'll be adding ;-)
