Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE74C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 20:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E906138B
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 20:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhJTUeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 16:34:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54759 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJTUeH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 16:34:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CF3B15A0E2;
        Wed, 20 Oct 2021 16:31:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xxpDQgGRBHiRdJd+y4IFyQVMlRpST/8JF6dfBS
        5UUAI=; b=jw0J/30398/SV8obMX+tK6WFbf+z/6i6ktjYQ2WO03RxX2TLyh+Ids
        TOaNDZhKNMPUjmfEC9GjBCMxZA+JBT3ELu+htUz9hFRTZZLePuvQM5SleCBO7IB9
        9jPWAqJkb3nREqomZcLUT4z6GrRND7C6LBDQZq/vYc9ZlXV0bd7D0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0625915A0E0;
        Wed, 20 Oct 2021 16:31:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4CD3115A0DF;
        Wed, 20 Oct 2021 16:31:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/4] remote: use remote_state parameter internally
References: <20211013193127.76537-1-chooglen@google.com>
        <20211019224339.61881-1-chooglen@google.com>
        <20211019224339.61881-3-chooglen@google.com>
        <xmqqzgr3o4yw.fsf@gitster.g>
Date:   Wed, 20 Oct 2021 13:31:48 -0700
In-Reply-To: <xmqqzgr3o4yw.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        20 Oct 2021 12:45:27 -0700")
Message-ID: <xmqqtuhbo2tn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1149176-31E4-11EC-876A-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This made my "git push" to k.org and other places over ssh segfault
> when their tip and what I am attempting to push are identical.  I
> haven't spent more time than just to bisect the history down to
> identify this commit as the possible culprit.

(gdb) bt
#0  0x000055555579a785 in pushremote_for_branch (branch=0x0, explicit=0x7fffffffcf84)
    at remote.c:564
#1  0x000055555579a5c2 in remotes_remote_get_1 (remote_state=0x5555559782a0, name=0x0,
    get_default=0x55555579a742 <pushremote_for_branch>) at remote.c:518
#2  0x000055555579a6d0 in remotes_pushremote_get (remote_state=0x5555559782a0, name=0x0)
    at remote.c:542
#3  0x000055555579a740 in repo_pushremote_get (repo=0x555555974b80 <the_repo>, name=0x0)
    at remote.c:554
#4  0x000055555560aa9d in pushremote_get (name=0x0) at ./remote.h:135
#5  0x000055555560c5ce in cmd_push (argc=0, argv=0x7fffffffdc70, prefix=0x0)
    at builtin/push.c:611
#6  0x000055555557396a in run_builtin (p=0x555555941f78 <commands+2136>, argc=3,
    argv=0x7fffffffdc70) at git.c:461
#7  0x0000555555573d79 in handle_builtin (argc=3, argv=0x7fffffffdc70) at git.c:713
#8  0x0000555555573fe6 in run_argv (argcp=0x7fffffffdafc, argv=0x7fffffffdaf0) at git.c:780
#9  0x000055555557448f in cmd_main (argc=3, argv=0x7fffffffdc70) at git.c:911
#10 0x000055555565b2ae in main (argc=6, argv=0x7fffffffdc58) at common-main.c:52

The direct culprit is this part:

    const char *pushremote_for_branch(struct branch *branch, int *explicit)
    {
            if (branch && branch->pushremote_name) {
                    if (explicit)
                            *explicit = 1;
                    return branch->pushremote_name;
            }
            if (branch->remote_state->pushremote_name) {

where the second if() statement used to check "pushremote_name", but
now unconditionally dereferences "branch".

The caller is remote_get_1(); this funciton was called with
"current_branch", which can be NULL until you have a repository and
you've called read_config(), but otherwise shouldn't be.

I think somebody is not setting up the remote_state correctly?  When
the user wants to just use the repository-wide pushremote, not
having the current_branch would not matter, but if the pushremote
for the current branch is different from the repository-wide one,
the code would silently push to a wrong remote.

In any case, any public facing entry point, like pushremote_get()
that is directly called from cmd_push() with just a name, should
auto vivify an instance of struct remote_state and populate its
members as needed, I think, and in this particular case, I suspect
that it forgets to initialize the current_branch and other members
by calling read_config(), just like other entry points like
repo_remote_get() do.


