Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2427C20281
	for <e@80x24.org>; Sun, 24 Sep 2017 00:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbdIXAMa (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 20:12:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59277 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751408AbdIXAMN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 20:12:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7468DB1BA8;
        Sat, 23 Sep 2017 20:12:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7+9qPczLMLoo2tbpRmcMlctVqW8=; b=Z5In4C
        jAwNpUBIyzeZ94cLGug580qEuy/j8blstAvrSEYafDMfN2WqYCK3xDBwFyawmT6P
        LN864HgZ7ElRnu1Eudj3AlKERDVv0FdKCD65jW6ChedWlYNcPDvy8GfI6n/eLo60
        sthRkGWiexXT7j7Z2HfgjO1z6F7M41gjAb9vQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z5xmoD5GFamAvKLlAzTZPJDmkAfinfh8
        J9anwXyZOr+2UFl2QoiXKkv0sv8rnOG9tFLCUByaviPOUlO93Yl9DBGrvQ5L/xp0
        7dKYtm12Es53J1edL0q7cc+WYz6oywreOHEgXTWD660H8I9xn9pFdAeRGscjiThv
        YhoAXUhbhMU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C4CBB1BA7;
        Sat, 23 Sep 2017 20:12:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7C4DB1BA6;
        Sat, 23 Sep 2017 20:12:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: is there a "symlink" option for cloning a repo in a separate filesystem?
References: <alpine.LFD.2.21.1709230418340.22644@localhost.localdomain>
Date:   Sun, 24 Sep 2017 09:12:11 +0900
In-Reply-To: <alpine.LFD.2.21.1709230418340.22644@localhost.localdomain>
        (Robert P. J. Day's message of "Sat, 23 Sep 2017 04:22:32 -0400
        (EDT)")
Message-ID: <xmqqtvzths4k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03A264EA-A0BD-11E7-B934-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   reading "man git-clone", and i understand the mechanics of the local
> protocol, so that if i run:
>
>   $ git clone /path/to/repo
>
> then "files under .git/objects/ directory are hardlinked to save space
> when possible."
>
>   but if the repo is in a separate filesystem, or on an NFS mount,
> hardlinks clearly won't work, so what happens then? does it default
> all the way back to regular copies? is there no intermediate symlink
> feature that would still work? (i suspect i am far from the first
> person to wonder this.)

After a normal "clone", you want the new repository as independently
usable even after the original repacks, rewinds some of its
branches, or even goes away completely.  

Imagine that we used symbolic links to point at loose object files
in the original and then the original repacked all of them into a
new packfile.  The symbolic links in the new repository will keep
pointing at their now-missing counterparts, and your new repository
is corrupt, because it does not know about the new packfile that is
meant to replace them in the original repository.

The sensible choices available to us are only the two: hardlink or
copy.  Using symbolic links does not make any sense in the context
of "clone".  Hardlinks make sense only because object files are only
created or removed but never modified in-place, and removal in the
original repository does not affect the "copy" you have in the new
repository.

As others mentioned, use "--reference", perhaps like

	git clone --reference /path/to/repo --no-local /path/to/repo

is one way to avoid having to make copies.  It first declares that
your new repository will keep depending on the project it borrowed
from forever with "--reference"; with that declaration, your new
repository does not have to store copies of objects that the
repository pointed at with --reference has, so the clone operation
itself, which wants to copy the objects in the source repository,
does not have to copy any.
