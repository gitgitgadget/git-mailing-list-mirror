Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CA9EEAA78
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 21:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjINVxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINVxt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 17:53:49 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F72E1BFA
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 14:53:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5DADD25757;
        Thu, 14 Sep 2023 17:53:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=eIDlhaB/xoPZ74LQhCROHI+HBSBNengjLqPPAx
        rINfY=; b=GDEwlTDHzv3L1TSvpaBiRvIbA2mU9/qJCkGz2QXx+w2HcWEc5hwDOW
        3KR9h8hzdb/ZvVcmBhwhSCC6rj79vm7j1OlhNxkbHp0yfps+Qj+0XtXb0bn6ymMZ
        A6uABVzBi5co2cNnDEgHp0R1IAjuvsX1DDWKylFbjdARI4baNCFqw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5581D25755;
        Thu, 14 Sep 2023 17:53:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E9F2A25754;
        Thu, 14 Sep 2023 17:53:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Blake Campbell <bc@mpbell.io>, git@vger.kernel.org
Subject: Re: skip-worktree autostash on pull
In-Reply-To: <ZQN9Azt/K28WLfqH@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 14 Sep 2023 21:37:07 +0000")
References: <AB6A85F5-3E76-4462-931E-AD76E0066C37@mpbell.io>
        <ZQN9Azt/K28WLfqH@tapette.crustytoothpaste.net>
Date:   Thu, 14 Sep 2023 14:53:40 -0700
Message-ID: <xmqq7cosifq3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B546354-5349-11EE-9743-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Your particular case is one of many reasons we suggest this approach.
> There is in fact an --autostash argument in git pull, as well as git
> rebase, both of which work as you might expect, but in general they
> still won't work properly with --skip-worktree and given the FAQ entry
> above, we wouldn't add support for that in the option.

As you mentioned, "--autostash" will move away the local change
while your otherwise clean working tree needs to be updated from the
upstream via "git pull" (or "git pull --rebase").  So the only thing
the user may want to be careful would be "git commit -a" (and "git
add -u"), I would think.  A pre-commit hook should be able to stop
you from committing with local changes to these selected paths you
want to keep following the upstream _with_ local changes (i.e. run
"diff --cached --name-only HEAD" and exit with non-zero when one of
these paths appear in its output).  Upon seeing such a failure, you
can "git stash" the changes, then "git commit" again.  And you do
not need to abuse assume-unchanged or skip-worktree for doing that.



