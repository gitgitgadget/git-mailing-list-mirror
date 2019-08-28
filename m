Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B6E71F461
	for <e@80x24.org>; Wed, 28 Aug 2019 15:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfH1PeJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 11:34:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63196 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfH1PeI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 11:34:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB00D8137F;
        Wed, 28 Aug 2019 11:34:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PIZ9MvBp7zWsPesOb/KfZ4eqypE=; b=cn+pU9
        ur83lb8V4KvsR3xWBISh3C/AU9LHsIrh43FZarfwUubMnowbP61DTy5/ubo1Esj+
        XjEZWdxChYOCEant++xty+AQfigWLR9gkH/4GrBUpu6khSxBIZGGow/VcI6sTRZE
        4zmx2I47i0leBYpdNvEaQF3Wxzn1yLkCkfE+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tl/5tcJ13CwyvSUYmC9MbqsKAMSq1hF6
        jGr9jS2xLkBQ4xMP2A9dVZvhjfwqIJta2b1gYy4ce7MjiK80pcp2j653vcSaXfIg
        HnxdLAUW0nhz6PCgjlwRwqITqCjzGcRNyLfMUtJRKvNegKFolMkYjEjZbCa5qdSD
        swcRbwwdDRs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D38628137E;
        Wed, 28 Aug 2019 11:34:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 07A4F8137B;
        Wed, 28 Aug 2019 11:34:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ben Wijen <ben@wijen.net>, git@vger.kernel.org,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/1] rebase.c: make sure the active branch isn't moved when autostashing
References: <20190821182941.12674-1-ben@wijen.net>
        <20190826164513.9102-1-ben@wijen.net>
        <nycvar.QRO.7.76.6.1908281454070.46@tvgsbejvaqbjf.bet>
Date:   Wed, 28 Aug 2019 08:34:01 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1908281454070.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 28 Aug 2019 14:56:03 +0200 (CEST)")
Message-ID: <xmqqh8611eza.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44165434-C9A9-11E9-AD56-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> FWIW I disagree with the decision to mingle a bug fix with a change of
> behavior. Resetting to the correct OID is of course the bug fix.
> Dropping the message is a change of behavior.

In general I strongly advocate that a patch should fix one thing and
one thing well without breaking other things, so we are on the same
page.

As I said in <xmqqftltqjy1.fsf@gitster-ct.c.googlers.com>, I think
the message that is leaked from "reset --hard" was reporting an
incorrect thing, iow, showing the message itself is another bug.

IIUC, the bug is twofold:

 - When --autostash creats a stash entry, the command attempts to
   reset the working tree and the tip of the current branch to where
   it should be (i.e. HEAD).  As we know, this attempt is faulty and
   resets to a wrong commit, not to HEAD.  This is the primary bug
   the patch under discussion fixes.

 - A message is given only when the above happens.  When rebasing
   from a clean working tree, we do not report "HEAD is now at..."
   at all.  And when autostash happens, the message is still not
   correct even after fixing to which commit we reset to.  "HEAD is
   now at ..." is misleading in that it implies that we changed to
   something else, but in reality, we have been on the same commit
   all the time since the command started, created a stash and wiped
   the working tree clean after doing so, when the message is given.
   That "reset --hard" is done only to clean the index and the
   working tree and talking about "HEAD is now..." is a bug in its
   context.

So, from the purist point of view, I see it may make sense to update
this patch to add logic to give a pointless and misleading "HEAD is
now at..." message so that we will report the location of HEAD where
the "rebase --autostash" command started at, to fix only the first
bug.  We still need a follow up patch that removes the message to
fix the other bug, perhaps with a follow-up to update the "first
rewinding..."  message, which is shown whether autostash kicks in or
not, so that it reports which commit we are rebuilding the history.

Thans.
