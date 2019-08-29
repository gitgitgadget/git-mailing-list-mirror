Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CAE01F461
	for <e@80x24.org>; Thu, 29 Aug 2019 03:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfH2Dyt (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 23:54:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63972 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfH2Dyt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 23:54:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F390316882C;
        Wed, 28 Aug 2019 23:54:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FAgG12wPSrQ6Va5Ez64+bm94f8I=; b=iUMwL/
        g2gcV3hDF9ACBmYDizkd2DBdwSqdQVdkEP2J/yDMn3LXb9aOpWZYSaJJXDx4eU90
        nyTOIyDJDTbo1MN+uDuseM/W7Yi1HdTfRGZwDh2ddYx+WmhfGhHY1IdJzKF9M4CC
        C5UeXbG2nyRlQn69Kn/wi8sdzG+zKIAwjyDYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L+VmY5+x0UtsXSwvX/MsxPoJRWa0LXV0
        y1U70yDlOiwFs492txeflIP7GcD0f+8gowAD/GnLzNweF3OZXI5soSIJ4jD5bDsr
        hR9UHJZJBUnVjQ4OCFgzV8Dm1WMXBqAy6FTcDlbkYrbjnNVj02SAhzRY5hOpdxFg
        Y1a6Nq9UBVU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBC0F16882B;
        Wed, 28 Aug 2019 23:54:46 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59D5616882A;
        Wed, 28 Aug 2019 23:54:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dmitry Nikulin <pastafariant@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-diff passes <rev>:<path> args to GIT_EXTERNAL_DIFF incorrectly?
References: <CAH53SykX12SN83=gey8KS_x3cGkXH758sfEieskXnnvos8DMcA@mail.gmail.com>
Date:   Wed, 28 Aug 2019 20:54:45 -0700
In-Reply-To: <CAH53SykX12SN83=gey8KS_x3cGkXH758sfEieskXnnvos8DMcA@mail.gmail.com>
        (Dmitry Nikulin's message of "Tue, 27 Aug 2019 21:24:02 +0300")
Message-ID: <xmqqtva0zkvu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDC8644A-CA10-11E9-8A59-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dmitry Nikulin <pastafariant@gmail.com> writes:

> $ env GIT_EXTERNAL_DIFF=./print_argv.py git diff
> origin/branch1:file1.txt origin/branch2:file2.txt

I didn't even know external-diff driver is called (and does not even segfaut)
in the "compare two blobs" hack codepath.

The syntax <tree-ish>:<path-in-the-tree> you have on the command
line resolves to a blob object name.  There is no leading directory
name, there is no permission bits or executable bit, there is no
filename, when "diff" is told to compare two blob objects this way.
THe "diff" machinery that drives the external (or internal for that
matter) diff will only get two 40-hex blob object names and nothing
else.  The only pieces of information you can trust among those the
external program may receive are the blob object name(s) and the
contents stored in the temporary files given to it.  The location of
these temporary files or their mode bits have no relation to the
"files" in some tree in the original repository, as that information
is long lost when you write <tree-ish>:<path-in-the-tree> to tell
Git to use that as a blob object name.

    $ git diff -M branch1 branch2 -- file1 file2

if file1 and file2 have similar-enough contents, may have a better
chance of what you wanted to ask Git (if I am guessing what it is,
that is).






