Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E6BC433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 02:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiDPCH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiDPCGM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:12 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0778D5717D
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 18:56:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0CBA6197578;
        Fri, 15 Apr 2022 21:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5izevqCynXKxF73dX5+vScx7TGU4L2TfJJNAcF
        q8rcc=; b=kXKc58sJP5yzRErUPQcztxXM/isW2F0SXygFm34KQO2fJEhhrdKOIU
        qyjEwwII6uXZpejEpzSTfL5O0PAlu4NhIFMVB75yvsUtvkTR13nS0/16Ly55jLs9
        qAAPrLJeYIvJMwCaYveuJmBapmB881OGMwoQcNBstJ8+UdHRkUMZs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0506C197577;
        Fri, 15 Apr 2022 21:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 85FAB197575;
        Fri, 15 Apr 2022 21:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, martinvonz@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Bare repositories in the working tree are a security risk
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqwnfs4kud.fsf@gitster.g>
        <kl6lh76v8vnj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqh76ucdg6.fsf@gitster.g>
        <kl6l5yn99ahv.fsf@chooglen-macbookpro.roam.corp.google.com>
        <YloVFn0SC/SF33b3@nand.local>
Date:   Fri, 15 Apr 2022 18:18:14 -0700
In-Reply-To: <YloVFn0SC/SF33b3@nand.local> (Taylor Blau's message of "Fri, 15
        Apr 2022 21:00:06 -0400")
Message-ID: <xmqqy2057rmx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17656AB8-BD23-11EC-8F24-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Is the proposal to only detect bare repositories that are called `.git`?
> I think that's what you're suggesting, though can't we just as easily
> embed a bare repository named ".git" in a clone as long as its not in
> the root directory?

I do not think "you can use your bare repository as before ONLY if
the directory is named .git; otherwise you must use GIT_DIR to point
at it" would fly; the Glen's exception may help many uses of ".git
subdirectory of a non-bare repository as if it were a bare" you can
find in tests, but does not help real-world use cases where there
may be bunch of bare repositories named "$project.git" at all.

But I have to point out that your attack above would not work, as we
do not allow ".git" directory in the index to begin with.  IOW, you
as an attacker may be able to prepare such a tree with nonstandard
tools, but the victim won't be able to check it out (and
fsck-during-transfer would probably block the cloning).
