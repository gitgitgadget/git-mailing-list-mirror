Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D017C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0785860295
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhHDAia (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 20:38:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57616 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhHDAi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 20:38:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CED24129B49;
        Tue,  3 Aug 2021 20:38:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HMz/FQAmU+UxNcJyxb4KVjXPPE6KsDXQKP0XHd
        OOkgg=; b=FuiaQRFjo3WrcgnqgJx7tWJSaugMdPMYzZQQvf2vHnwOFlyViwTe5y
        xlLYtDW2L9zKZHDERtklgqV1u0Q+XREXbO+oFQoGRYefwbctXpK2F0X2fN3yBCkP
        GRuCO/f51d/xKIGlCHOOWbMQv2JXKWCgdPGVNicuxT7cJcdk5p7YM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C77ED129B46;
        Tue,  3 Aug 2021 20:38:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1DA94129B44;
        Tue,  3 Aug 2021 20:38:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Cameron Steffen <cam.steffen94@gmail.com>, git@vger.kernel.org
Subject: Re: git revert --continue --no-verify
References: <CAAVFnNkW6Bc4bBDeea2v-VFydvEC0dBw+QXVA0-6OnmF8km3ZA@mail.gmail.com>
        <YQmsJUe6hAMy/QGA@nand.local>
        <CAAVFnN=W27rdE1EH-joscyJEooAsDrdtPropVVaBYwhte=cPJA@mail.gmail.com>
        <YQmuT2ZYe1mzHBjI@nand.local>
        <CAAVFnNmitHeimogaGUUwWGWhve+wbF6CXcSNUonGCWAgOSKzjA@mail.gmail.com>
        <YQm+PWAtc3rixqsw@nand.local>
Date:   Tue, 03 Aug 2021 17:38:13 -0700
In-Reply-To: <YQm+PWAtc3rixqsw@nand.local> (Taylor Blau's message of "Tue, 3
        Aug 2021 18:07:57 -0400")
Message-ID: <xmqq4kc6rqmi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 414AA832-F4BC-11EB-8075-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Aug 03, 2021 at 04:33:09PM -0500, Cameron Steffen wrote:
>> Perhaps the issue then is that the pre-commit hook should not run for
>> `git revert --continue`? It does not run for `git revert`.
>
> This does look like an oversight to me, but you'll have to bear with me
> since I am relatively unfamiliar with the sequencer code.
>
> Ultimately `git revert` calls do_pick_commit() which either calls
> do_commit() or run_git_commit(). A couple of curiosities there:
>
>   - do_commit() does fall back to run_git_commit() if it has the
>     VERIFY_MSG bit set in `flags`.
>   - run_git_commit() passes `-n` only when VERIFY_MSG *isn't* set, so
>     the VERIFY_MSG bit does imply that the pre-commit hook would be run
>     there.
>   - when do_pick_commit() does have to fall back to run_git_commit(), it
>     sets the VERIFY_MSG bit in flags.
>
> But we never end up calling run_git_commit() (except in the case of
> errors) because do_pick_commit() special-cases `command == TODO_REVERT`
> (which is the case for `git revert`) and calls `do_commit()`.
>
> But it gets weirder: do_commit() calls run_git_commit() itself, but
> before the caller in do_pick_commit() has had a chance to add VERIFY_MSG
> to the flags.
>
> So I suspect that this is an oversight, but perhaps somebody more
> familiar with this code could confirm my thinking.

IIRC, the "--continue" option that creates a commit came much later
for lazy folks; the norm was to conclude your conflict resolution
with "git commit" so that the HEAD and the index and the working
tree matches before running "--continue".  Wouldn't that work in
this case?  That is

    $ git <some sequencing command> A..B
    ...
    ... stops with conflict
    $ edit
    $ git add ...
    $ git commit --no-verify
    $ git <that sequencing command> --continue


    
