Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F4AC433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 21:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241135AbiCRV0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 17:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbiCRV0x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 17:26:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9292467F2
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 14:25:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 698E11075CF;
        Fri, 18 Mar 2022 17:25:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N8ptOCxHC9jn4f8p1W1q1vchU/lXJkWDUB9UIe
        JqeAs=; b=Y7K+Mmd/Z69YSTvCHgOoe+KLOtXS8i0omrTQ8nDjlu7lDD3DcqmQ6/
        rOOkupKfMPJpU9mgcOAsRF8KW9+OQO63CqOAGaI7HILN9P1Wm2+jPhZjG2wjN7Ak
        ZugWgJ/7DrDx+fanQT8dre7WI46ZCOpZO8nb3EOpPyQ2pJ2Z9CIKM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60E391075CE;
        Fri, 18 Mar 2022 17:25:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF33B1075CC;
        Fri, 18 Mar 2022 17:25:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org
Subject: Re: how to automatically open conflicted files when "git rebase"
 encounter conflict
References: <bc7b04de-17be-df86-1c93-792903eeec9b@mails.ucas.ac.cn>
        <YjToDb9Mz9Q9z4Bq@camp.crustytoothpaste.net>
Date:   Fri, 18 Mar 2022 14:25:31 -0700
In-Reply-To: <YjToDb9Mz9Q9z4Bq@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Fri, 18 Mar 2022 20:14:05 +0000")
Message-ID: <xmqqv8wb6jhw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F155A20C-A701-11EC-923D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Fortunately, there are lots of ways to do this.  The way I happen to do
> it is with an alias:
>
>   [alias]
>     conflicted = "!f() { git status -s | grep -E '^(DD|AA|.U|U.)' | cut -b4-; };f"
>
> and then I run this:
>
>   git conflicted | xargs nvim-gtk
>
> To preempt someone pointing this out, you would want to use "git status
> --porcelain" for scripting instead of "git status -s", but I happen to
> know what I'm doing in this particular case (and have reasons for it)
> and can fix things if it breaks.  You should probably use --porcelain.

I wonder if adding "--name-only" support to "ls-files" helps here.
It would make the above

    git ls-files [-z] --name-only -u | xargs [-0] editor

As your "grep -E" pattern indicates, "status" makes another
comparison with HEAD that we do not even use, when we only need to
list the unmerged paths in the index.

There is no "--[no-]name-only", and "-s" (for obvious reasons) asks
to show the mode, stage, and the object name information.  When we
added "-u", we said "if you are asking for conflicted paths, you of
course want to know the stage information" without questioning the
wisdom of that decision, especially as Linus and I were both in the
mindset to produce a small building-block to be used in a script
back then, and for a tool that deals with an unmerged index, having
the path alone is not all that useful.

But with time, we learn more needs out of our existing tools.

