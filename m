Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B910C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 19:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0DA2073C
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 19:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y0H8vuUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfLDTmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:42:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63689 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfLDTmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 14:42:09 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E99998C29;
        Wed,  4 Dec 2019 14:42:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xSSIfIz7A9QTZMmIFo1A0PDNTGk=; b=Y0H8vu
        UzSBYzeNl1yHqzekR1SHnO1koKS5zpwaSxcBridgtmonmmGc44ZpJeJhLXnxBkKP
        bM/dfdqjOCdeLQxhLbnWkqPiySAGOGw8i9giXeOoTwb87VjdsPK72eFbsHd3jEOW
        p6Smjh7IBdVbd53m3IE048ukwufWYNL8lhpgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JNq45zU6Htq9OnjFMm+bMka7wgclKYU3
        MH0F6j1sKsV0YWtc5nR5Ap26RFxZd8ZwKCODyu52IWCB6y98PAyt6oGVaqi7Kpzx
        JiTZxaVkXHEI1wAkdKKfO+LChpopZTxLujkxIsnUq/dg8y/tI7UtKVbY4j8j86bt
        XyqUt18O818=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 272B098C28;
        Wed,  4 Dec 2019 14:42:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A48898C26;
        Wed,  4 Dec 2019 14:42:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG?] ls-files -o now traverses nested repo when given multiple pathspecs
References: <87fti15agv.fsf@kyleam.com>
        <CABPp-BFG3FkTkC=L1v97LUksndkOmCN8ZhNJh5eoNdquE7v9DA@mail.gmail.com>
Date:   Wed, 04 Dec 2019 11:42:02 -0800
In-Reply-To: <CABPp-BFG3FkTkC=L1v97LUksndkOmCN8ZhNJh5eoNdquE7v9DA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 4 Dec 2019 09:30:41 -0800")
Message-ID: <xmqqblsn514l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25E6DE9E-16CE-11EA-9AFB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> C) ls-files -o should NOT traverse into untracked submodules, but
> should at least report their directory name.

I think this probably is the most sensible.  

The top-level directory of a working tree of a repository other than
the current one may exist in the working tree.  It is very tempting
to declare that, unless we know it is a submodule that has the
current repository as its superproject, we should just treat it as a
normal subdirectory without *any* files tracked by the current
repository, which would mean that we pretend that the ".git/" in
that subdirectory is not any special---but that would obviously make
things quite messy (e.g. our "ls-files -o" would descend into the
other project's working tree and even in its .git/ directory), so we
need to special case a directory that has ".git/" in it, whether it
is a submodule for our current repository or not.

Thanks for working on this.  I agree that dir.c traversal has become
messier and messier, especially with its interaction with
submodules.
