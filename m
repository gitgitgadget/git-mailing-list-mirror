Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD221F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 02:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfJHCpQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 22:45:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60656 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfJHCpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 22:45:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85DE12C8DA;
        Mon,  7 Oct 2019 22:45:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=A4imgGAgASGk
        1tK8Ulkc0oHJy+0=; b=hoz6CMU1RjpyAG/We+E/Ygq+FqGnKREVIAI4eq9voPf4
        +R4wJngH3DifQHiX3jmoZkBmGGeDsUaADTzQ+KsKmI1JJufn7mCFq2cit9qNuUT4
        teK05Yuo8Kq2yvXR3r0M/al6r11IL2iH4EYzZ2syAt61L1U2C10YITRMar2s8Cw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QnzN89
        LOr1ZpD4QeydKIB31mHD1rU7ue9FefgPJUXB8ZQjKXxpILwu61ZEsgyB/F0Pegls
        CqiPKYV3hIeHK+m3WEVqGlD3S6izEG0X/hwdyiiqXZVLj4Sr45y2cmkOHzU1DY5T
        7EsaA56rU7T5a1uqPPZDT3f9kzP2JYL10qnOs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D0422C8D9;
        Mon,  7 Oct 2019 22:45:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D918D2C8D8;
        Mon,  7 Oct 2019 22:45:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/5] Use complete_action's todo list to do the rebase
References: <20190925201315.19722-1-alban.gruin@gmail.com>
        <20191007092641.12661-1-alban.gruin@gmail.com>
Date:   Tue, 08 Oct 2019 11:45:09 +0900
In-Reply-To: <20191007092641.12661-1-alban.gruin@gmail.com> (Alban Gruin's
        message of "Mon, 7 Oct 2019 11:26:36 +0200")
Message-ID: <xmqqmuecnefe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A5874B38-E975-11E9-981E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This can be seen as a continuation of ag/reduce-rewriting-todo.
>
> Currently, complete_action() releases its todo list before calling
> sequencer_continue(), which reloads the todo list from the disk.  This
> series removes this useless round trip.
>
> Patches 1, 2, and 3 originally come from a series meaning to improve
> rebase.missingCommitsCheck[0].  In the original series, I wanted to
> check for missing commits in read_populate_todo(), so a warning could b=
e
> issued after a `rebase --continue' or an `exec' commands.  But, in the
> case of the initial edit, it is already checked in complete_action(),
> and would be checked a second time in sequencer_continue() (a caller of
> read_populate_todo()).  So I hacked up sequencer_continue() to accept a
> pointer to a todo list, and if not null, would skip the call to
> read_populate_todo().  (This was really ugly, to be honest.)  Some
> issues arose with git-prompt.sh[1], hence 1, 2 and 3.
>
> Patch 5 is a new approach to what I did first.  Instead of bolting a ne=
w
> parameter to sequencer_continue(), this makes complete_action() calling
> directly pick_commits().
>
> This is based on 4c86140027 ("Third batch").
>
> Changes since v1:
>
>  - Rewording of patches 1, 2, 4 and 5 according to comments made by
>    Phillip Wood, Junio C Hamano and Johannes Schindelin.
>
> The tip of this series is tagged as "reduce-todo-list-cont-v2" at
> https://github.com/agrn/git.
>
> [0] http://public-inbox.org/git/20190717143918.7406-1-alban.gruin@gmail=
.com/
> [1] http://public-inbox.org/git/1732521.CJWHkCQAay@andromeda/
>
> Alban Gruin (5):
>   sequencer: update `total_nr' when adding an item to a todo list
>   sequencer: update `done_nr' when skipping commands in a todo list
>   sequencer: move the code writing total_nr on the disk to a new
>     function
>   rebase: fill `squash_onto' in get_replay_opts()
>   sequencer: directly call pick_commits() from complete_action()
>
>  builtin/rebase.c |  5 +++++
>  sequencer.c      | 26 ++++++++++++++++++--------
>  2 files changed, 23 insertions(+), 8 deletions(-)
>
> Diff-intervalle contre v1=C2=A0:
> 1:  d177b0de1a ! 1:  9215b191c7 sequencer: update `total_nr' when addin=
g an item to a todo list
>     @@ Metadata
>       ## Commit message ##
>          sequencer: update `total_nr' when adding an item to a todo lis=
t
>     =20
>     -    `total_nr' is the total amount of items, done and toto, that a=
re in a
>     -    todo list.  But unlike `nr', it was not updated when an item w=
as
>     -    appended to the list.
>     +    `total_nr' is the total number of items, counting both done an=
d todo,

The same s/amount/number/ needs to be done to the log message of
patches 2/5 and 3/5.  Other than that, updated log messages looked
much more understandable.  Thanks.
