Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F88C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 22:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiDOWUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 18:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiDOWUe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 18:20:34 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E6857158
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 15:18:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C01991965C8;
        Fri, 15 Apr 2022 18:18:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dwN+AJAO85rwReA+3hnd8JBOoYXh4TmY3odMoN
        sV3CY=; b=DTc5N6aZMCgY/gmJ3SGSu2tMhdYEk7/zP+L6+3FfCRc0R2F+uhdIcd
        2ElQSbDiOSnFUSIBf/oAAdauqYCK/ufW7IO1/V9o4AEWHVek8vPwrDuuGQ8T7apb
        xs9mDkt9UIPaa8A5IHhRWMyG3VnGuZrCCchuzO9b4a+Vof9aC5UY0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B891E1965C6;
        Fri, 15 Apr 2022 18:18:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 28E231965C5;
        Fri, 15 Apr 2022 18:17:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, Taylor Blau <me@ttaylorr.com>,
        martinvonz@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Bare repositories in the working tree are a security risk
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqwnfs4kud.fsf@gitster.g>
        <kl6lh76v8vnj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqbkx31sc0.fsf@gitster.g>
        <kl6lbkx2821q.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 15 Apr 2022 15:17:54 -0700
In-Reply-To: <kl6lbkx2821q.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 15 Apr 2022 14:33:21 -0700")
Message-ID: <xmqqk0bqat4d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7235FE0-BD09-11EC-8AB1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> FWIW I experimented with turning off bare repo recognition altogether
> and seeing what breaks.

I guess our mails crossed ;-)  I've done a similar one locally and
sent a report out earlier, and I think the part of the function in
question that we disabled is identical.

>     ++ git clone http://127.0.0.1:5550/dumb/repo.git clone-tmpl
>     Cloning into 'clone-tmpl'...
>     fatal: repository 'http://127.0.0.1:5550/dumb/repo.git/' not found
>
> This sounds to me like Git isn't recognizing the static http files as a
> remote Git repo, and if so, --git-dir doesn't sound like it'll save us.

If the http server side we ship _depends_ on the fact that we
historically consider that it is enough to chdir into a directory to
use that directory as a bare repository, it is not all that
surprising that the server side infrastructure needs to do an
equivalent of "export GIT_DIR=." in addition to chdir it already
does into the directory.  There may be other things that the http
responder in the affected test needs to do before it can recognize
that the dumb/repo.git URL refers to a valid bare repository, and
until that happens, the above experiment may not start working.

I am not worried about that kind for breakage all that much, because
it is entirely under _our_ control how an HTTP request received
results in a "git" invocation, how "git clone/fetch ssh://" invokes
the process that runs "git upload-pack" on the other side in the
directory requested, etc.

What worries me more is the effect on _other_ people's server
implementations ("server", because that is one major class of use
case of bare repositories).  Essentially they need to identify the
places where they depend on the current behaviour (i.e. going to the
bare repository is enough to use it) and export GIT_DIR=. when they
invoke "git" there.  The actual change that is necessary might be
small, but identifying the places that need such changes may be
added burden to them.

Thanks.
