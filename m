Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A64DC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 18:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E73B214D8
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 18:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KCnAu9qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733254AbgFSSD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:03:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62617 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgFSSD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 14:03:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 811DD615D9;
        Fri, 19 Jun 2020 14:03:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=1
        WMEFEpcou5PWr72ojh3JECHDQ4=; b=KCnAu9qk1EOEf6gRwr4vhDwU5aWoIzN31
        IN2qtcUoJ2zq5Dt/pPca/fFSpwJWf+izozdnwCxjxRhVOKkB+KgeSVgcz+4CdX2R
        5TS/Ukfd+3l3E/EYI7krxxMKl7F/gZ/FGqR8pPF0JZNwUC9vd1cFrl/Zh29W9jcy
        uxHCaNYPn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=did
        OkXOsbUnwBaXrV+/dbVP/hz8RBE0m4WjFuh+n8CFgc23yF/Mdg75BOTCaNnrdaGg
        IZqL1b6ng833jlpgRdc5oDUtCMAb08s+fK+8PTurqxL0FbkkifBaYocnMuPhoJNq
        lllAyIiwqD5V/o8dnb9t+W/2zFw05jA6+VM85oec=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79BA8615D8;
        Fri, 19 Jun 2020 14:03:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E64BF615D7;
        Fri, 19 Jun 2020 14:03:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Annoyance wrt ref@{1} and reflog expiry
Date:   Fri, 19 Jun 2020 11:03:54 -0700
Message-ID: <xmqqzh8zgcfp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D5CC7F8-B257-11EA-8D8A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have been disturbed by this for a long time, but not strongly
enough to do anything to it.

This sequence works

    $ git checkout -b newbranch
    $ git commit --allow-empty -m one
    $ git show -s newbranch@{1}

and shows the state that was immediately after the newbranch was
created.

But then if you do

    $ git reflog expire --expire=now refs/heads/newbranch
    $ git commit --allow=empty -m two
    $ git show -s newbranch@{1}

you'd be scolded with

    fatal: log for 'newbranch' only has 1 entries

While it is true that it has only 1 entry, we have enough
information in that single entry that records the transition between
the state in which the tip of the branch was pointing at commit
'one' to the new commit 'two' built on it, so we should be able to
answer "what object newbranch was pointing at?".  But we refuse to
do so.  

And it is unintuitive.  It is understandable to the users that all
the ref history before "reflog expire" is lost---it was what the end
user asked Git to do.  But after creating one commit on the state
(or do anything else that moves the ref) and finding it regrettable,
"git reset --hard @{1}" should be a viable way to recover from the
mistake made _after_ the reflog entries were expired.

Opinions?

