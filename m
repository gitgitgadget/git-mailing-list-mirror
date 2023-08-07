Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0F4C001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 16:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjHGQOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjHGQOT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 12:14:19 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE0B10CE
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 09:14:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9518A2FF80;
        Mon,  7 Aug 2023 12:14:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h5zQ0GpqJYL5lGIj9DAv2wxgT3NqWFGA4z6q/H
        YyTwM=; b=h82AOtL5yyWJTbjiv+WAFoXb6iuYkgfDeKlCJ45O4QOPtyPrS2ffj7
        XNPaKCm6+1SyFypes6fNrofydeQlhvPqafiw9wU7hU4W3W7vXJ/a2HUrbtlDXgaY
        HWwBVGHRpz6djZkVe9nFtXK1lbXTULxCadv3vkc4CL6PmAEMnyMyY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E7612FF7F;
        Mon,  7 Aug 2023 12:14:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BC3C92FF7E;
        Mon,  7 Aug 2023 12:14:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brooke Kuhlmann <brooke@alchemists.io>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: Git Commit Notes (fetching/pushing)
References: <D01976C3-4B91-464B-ACF0-78DFFB066747@alchemists.io>
        <ZM/9+YyOAbWWXQtC@nand.local>
        <3A1AEE32-4A0C-445D-A1D8-146CDCA03563@alchemists.io>
        <xmqqwmy7irsd.fsf@gitster.g>
        <2301E39E-B70D-485B-AFA8-F8DA64B366A2@alchemists.io>
Date:   Mon, 07 Aug 2023 09:14:10 -0700
In-Reply-To: <2301E39E-B70D-485B-AFA8-F8DA64B366A2@alchemists.io> (Brooke
        Kuhlmann's message of "Mon, 7 Aug 2023 08:02:46 -0600")
Message-ID: <xmqq4jlaj0dp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 720E19F4-353D-11EE-81AB-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brooke Kuhlmann <brooke@alchemists.io> writes:

> I ended up using the following configuration in order to
> explicitly fetch/push branches, notes, and tags:
>
> [remote "origin"]
> 	url = https://github.com/bkuhlmann/test
> 	fetch = +refs/heads/*:refs/remotes/origin/*
> 	fetch = +refs/notes/*:refs/notes/*
> 	fetch = +refs/tags/*:refs/tags/*
> 	push = +refs/heads/*:refs/remotes/origin/*

This will push your local branches (e.g. refs/heads/xyzzy) to their
remote-tracking branches (e.g. refs/remotes/origin/xyzzy) of the
same name.  Is that what you meant?  It is unclear what kind of use
you have your remote repository for, and in some use cases, it is
perfectly valid if a push from here is used as a substitute for a
fetch from there to arrange the push from here like how you have
above, to push into refs/remotes/origin/* of a remote repository
with a working tree.

But often, a remote is used as a publishing point (i.e. everybody
pulls from and only you push into it) or as a central meeting place
(i.e. everybody pulls from and pushes into it), and in these cases,
a push refspec would look more like

	push = refs/heads/*:refs/heads/*

This is especially true when the remote is a bare repository, or
hosted at a hosting site you or nobody has access to its working
tree.

Note the lack of leading '+'; that is absolutely essential if you
are pushing into a central meeting place because you want to avoid
force pushing that will clobber others' work, and it is also a great
discipline even if you are pushing into your publishing point
because those in your downstream will be disrupted if you rewind
your history.


