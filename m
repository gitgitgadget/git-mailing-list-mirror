Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDA6C0015E
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 18:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbjHOSEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 14:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbjHOSD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 14:03:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4851C198B
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 11:03:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD72B2512A;
        Tue, 15 Aug 2023 14:03:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+kG2WcFS7A3OhOCgywFaVlQ1esldiu4KVMksQu
        LUfVA=; b=aVWOjakLiJIstixfpnMOHHzta224c6zKFYsn+Y3b64YI77UVnjcnJO
        e8akTTrmUvPD/Lka64c7AK7vM/jVTbqRZCgRdOgZ5Yy5ufB4clTyKFlJpl3d37hB
        /jkiC59g0ZRXBfwIdT4HC4p2XqLkcD4FMnk4liexf32Ejz1xjg5bg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5ACD25129;
        Tue, 15 Aug 2023 14:03:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 25BC025128;
        Tue, 15 Aug 2023 14:03:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        friebetill@gmail.com, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 1/1] git stash needing mkdir deletes untracked file
References: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
        <20230808172624.14205-1-tboegi@web.de>
        <6e40eb0b-2331-1e39-bee0-c9720c24d1c8@gmail.com>
        <20230809184751.ffwolkvjwoptnmen@tb-raspi4>
        <9f76de24-d337-ed41-fb81-888dba0b1656@gmail.com>
Date:   Tue, 15 Aug 2023 11:03:49 -0700
In-Reply-To: <9f76de24-d337-ed41-fb81-888dba0b1656@gmail.com> (Phillip Wood's
        message of "Tue, 15 Aug 2023 10:15:37 +0100")
Message-ID: <xmqqcyzoji7u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16FA3F66-3B96-11EE-9BC1-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I don't think we should be treating "git stash" as a special case here
> - commands like "git checkout" should not be removing untracked files
> unprompted either.

Yeah, I tend to agree.  "git checkout branch path" should overwrite
a leftover "path" in the working tree in response to such an
explicit request, and that should equally apply for a request with
pathspec e.g. "git checkout branch .", as the latter is also an
explicit "please check out all paths out of the tree-ish of the
branch".

But "git checkout branch" in a working tree with untracked "path"
should not lose it if "branch" has it as a tracked file.

> I think stopping and telling the user that the file would be
> overwritten as we do in other cases would be better.

Yup, that is what we have done and probably one of the design
choices that made us successful.

>> Reading the different reports and including own experience,
>> I still think that a directory called ".deleted-by-user"
>> or ".wastebin" or something in that style is a good idea.
>
> I can see an argument for being able to opt-in to that for "git
> restore" and "git reset --hard" but that is a different problem to the
> one here.

Yeah, I tend to agree.  If anything, such a trash directory should
be kept out-of-line, not inside the working tree.  Perhaps in $HOME
or somewhere, and not necessarily tied to the use of Git, as the way
a file gets "deleted by user" is not necessarily limited to the use
of Git.

