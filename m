Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5C5C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbiHBPXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHBPXP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:23:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5378413DF0
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:23:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86931142098;
        Tue,  2 Aug 2022 11:23:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=JQcrUubAlS+w20lES+nBGbxJk
        E5W3o/pWb7bkL8jw3Y=; b=gLZjmbtTkgvxtlnNfpKEVPWQrqAWsuAzo1zJcwQMC
        lPPhSGEUa5scn5olyI1i+Bu07I+nM/bSwyw8+U1oBwXfE9fI02kn7dX0dOkbZgxO
        B3rYAza3VMWlvBFk+LNUlSWXnByWfFCawnWHJU01YhNifp1KLPLvdYH/+g6Ijip+
        hA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F7EA142097;
        Tue,  2 Aug 2022 11:23:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E67E2142093;
        Tue,  2 Aug 2022 11:23:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Th=C3=A9o_MAILLART_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Th=C3=A9o?= MAILLART <tmaillart@gmail.com>
Subject: Re: [PATCH] rebase: introduce allow-inline-reword option
References: <pull.1228.git.git.1659422389830.gitgitgadget@gmail.com>
Date:   Tue, 02 Aug 2022 08:23:11 -0700
Message-ID: <xmqqles6is9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 060294A4-1277-11ED-B75C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Th=C3=A9o MAILLART via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> This new option (false by default) for interactive rebase allows users
> to modify the subject of a commit directly in the todo list, when they
> select the "reword" action.
> If the option is enabled, "reword" is selected and the subject has not
> changed, then the default behaviour is used.
> It also introduces a test for this specific option, and a related
> function (set_inline_reword_editor) in the lib-rebase.sh to use a
> simpler custom fake editor to be able to modify the message part of the
> lines in a todo list (in the most simple cases).
>
> Signed-off-by: Th=C3=A9o Maillart <tmaillart@gmail.com>
> ---
>     [RFC] rebase: reword: new feature change the subject in the todo li=
st

It is not clear if you meant this as a final submission or an RFC
but I'll take it as an RFC for now.

A handful of things come to my mind.

 * Would this want to be a new variant of "reword" that you would
   write into the todo list file, instead of a command line option
   that says "every 'reword' I write in the todo list file means
   something different now"?

 * Is there a plausible UI that allows inline editing of a commit
   log message that is more than one line long?  Should there be?

 * Under "inline" mode, when a "reword" is requested for a commit
   that has more than one line of log message, what should happen?
   Should the updated title become the ONLY content of the log of
   the updated commit?  Should it be an error, because it is clearly
   an information-losing operation?  Would it make sense to turn the
   "inline" reword into normal reword automatically for a commit
   with more than one line of log message?

 * If we choose to special case a commit with more than one line of
   message in order to prevent the 'inline' mode from losing
   valuable information in the original commits, what role should
   trailer lines play when we decide if a commit has only one line
   of message?  For example, if a lazy "title only" commit has no
   body message but a sign-off and other trailers like helped-by,
   would it make sense to keep the trailers intact and only replace
   the title, still in inline mode?

Here is an alternative design that may be conceptually cleaner.

 * We do not introduce a new option at all.  "reword" means "open
   the editor and you can edit the whole thing" as always.

 * We introduce "retitle" that can be used instead of "reword".

   The line for a commit originally shows "pick" followed by an
   abbreviated commit object name followed by its title, and the
   body of the message and the trailer is hidden.  If you change
   "pick" to "retitle" and edit the shown title, then the original
   log message from the commit is read as a whole, its title line is
   replaced with what "retitle" line has, and the result is used as
   the updated log message.

That way, those who write more than one line of commit log message
can still use the feature without having to worry about losing
information when the only thing they want to fix is a typo in the
title, and those who write only one line of commit log message do
not have to pass the new "--inline" option at all.  They can use
'retitle' instead of 'reword'.

Hmm?
