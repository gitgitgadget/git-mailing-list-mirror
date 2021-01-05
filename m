Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1744C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 22:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8770D22E00
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 22:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbhAEWz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 17:55:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54357 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbhAEWz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 17:55:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 200FBAC60C;
        Tue,  5 Jan 2021 17:55:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vobMx9ucgSqsTnLIBBWqiqgjigs=; b=Sq7ejB
        dmHeAMMF5RTRyckai2UbGe+lJLSWkHNrJOrljiD7IfyNJrLIM0+ysHDQPO95dbho
        DoQJ8qZGdxdRAtqGRePjDItfqmhiAwLvkU+rJWiPmVcnRnLzt4bmBH62/0se/4Uq
        e4x5dFUZke2tllSA7jiQajPytmB+Cu7XiBBaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LKFcDNFt7zWtdgeP5ukGExueIGFfWu9i
        YD5EZyEs+M0gTrsf5qGcxseNZ7frP65uihw9UZ1mnMTKCt6+JLR4SPzu3QZrjcgc
        2MM6EILgdCk7RqhRPrBjFLrrTc3Q9XGGbGsgRLlHnvqwZT+KTJ+eBDixX0Gu3DIt
        jlpmZ1JsLrI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17757AC60B;
        Tue,  5 Jan 2021 17:55:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94307AC60A;
        Tue,  5 Jan 2021 17:55:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Utku <ugultopu@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to get the branch HEAD points to using a plumbing command?
References: <132D030A-AAD3-4EFC-9858-7EA39503A746@gmail.com>
Date:   Tue, 05 Jan 2021 14:55:12 -0800
In-Reply-To: <132D030A-AAD3-4EFC-9858-7EA39503A746@gmail.com> (Utku's message
        of "Tue, 5 Jan 2021 10:09:47 -0500")
Message-ID: <xmqqy2h7xacv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1212B752-4FA9-11EB-985E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Utku <ugultopu@gmail.com> writes:

> My question is, is there a "better" (more idiomatic, less
> "expensive", etc.) way of doing it using only one plumbing
> command? This solution is OK but it is more work than just
> matching one line with a regular expression. The reason I want to
> do this using only plumbing commands is because I think that
> plumbing command interface would be more stable than the format
> (organization, structure) of files under the `.git/` directory
> across Git versions. Please correct me if I'm wrong in this idea
> as well.

The "HEAD" pointer can be a symbolic link, not a text file with
"ref: refs/heads/..." in it, and any approach that works directly
with "cat .git/HEAD" would be incorrect, unless it does a stat on
.git/HEAD first to see if it is a symlink.  And such implementation
details can change over time.

So you are right to seek a solution that hides such details from
you, i.e. a Git command, to do so.  It does not have to be plumbing,
though.

The orthodox answer would be to use "git symbolic-ref".  When you
want to learn which underlying ref a symbolic ref is pointing at,
that is the tool designed to answer that question.
