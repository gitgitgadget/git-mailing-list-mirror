Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56898C04A6A
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 16:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjHHQaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjHHQ24 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 12:28:56 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B8B11F7D
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 08:51:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C1D127B47;
        Tue,  8 Aug 2023 02:33:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=EvMBD/RLx4aP4SFCiXxN2QvxYUBGR1o6fpR7orZckh8=; b=tTCi
        jWiLqY6M67VTyj+Pgb0VRyi4A9OGtk2vDTlUsYjUvEyPnh9G9Q+CZtTp3xHPpJki
        AG64nfiX/n5tDrF9ELOVitrjh5MBRWbPAqKEueGYvMroyTH3/Cl2CNAPIN5zOH97
        c9j7X4hcloE4mM18Mkng4j2NGq72E+JyTJ1hWgc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54D9027B46;
        Tue,  8 Aug 2023 02:33:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6CDC327B45;
        Tue,  8 Aug 2023 02:33:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH RESEND] format-patch: add --description-file option
References: <20230807170936.2336760-1-oswald.buddenhagen@gmx.de>
Date:   Mon, 07 Aug 2023 23:33:49 -0700
Message-ID: <xmqqttta9h6a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89571AAC-35B5-11EE-95EA-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> When formatting patches from a detached HEAD, there is no branch
> description to derive the cover letter from. While with format-patch
> one could post-process the generated file (which would be ugly enough),
> scripting that with send-email would be *really* ugly. So add an option
> to feed a description directly.

I think it makes sense to give the same set of features to those who
run format-patch from a detached HEAD as to those who run it on a
branch.  But personally I am not interested in a new feature that
encourages use of send-email as a front-end to format-patch, which I
consider is a misfeature, to make it easier for a set of patches
without final proofreading to be sent out.

Having said that, with my maintainer hat on, if we were to add a new
feature to format-patch, it makes sense to allow it passed through
send-email as well, since the (mis)feature already exists.

Please elaborate a bit more on the use case, though.

 * "there is no branch description to derive from" makes a reader
   wonder what the workflow would become if you could do "git branch
   --add-description HEAD" to prepare a description, which would
   imply that what is more desirable might be a feature enhancement
   of the "branch" command, not "format-patch" or "send-email", to
   allow you to describe what you are doing on the HEAD.

 * Or does the end-user have a branch with description already
   prepared, but for some untold reason the tip of the branch is
   checked out on a detached HEAD?

   If so, an obviously better alternative design would be to add a
   feature that passes a branch name to format-patch and tell it to
   pretend that the user is working on the branch.  That way, not
   just "description", any feature that makes the command use "which
   branch are we on?" information to enhance its behaviour we have
   right now or we will add to the command will all benefit.  For
   example, builtin/log.c::cmd_format_match() uses branch_name only
   for calling read_branch_desc() via prepare_cover_text(), but it
   is perfectly reasonable for us to make the range-diff default
   derived based on the reflog of the "current branch" on, and
   "pretend we were on this branch" may help you in such a case.

In other words, if a particular solution proposed (or not proposed)
is sensible or not heavily depends on how the end-user ends up
running format-patch (and sending the output out) on a detached
HEAD, and where does the end-user want to take the description
information from. No, the answer to the latter is not "the file
specified with the --description-file option"; that is not a valid
answer.  The question is about how the contents of that file is
populated and maintained.

A feature to specify the template used when generating the cover
letter may also work well for such a use case.  Among placeholders
to specify where to place auto-generated things like:

 - shortlog information
 - other ways to list commits in the series (e.g. listing of commit
   titles from "git log --oneline -r" may be more appropriate and
   readable than "shortlog" output especially when the series was
   written by multiple authors),
 - diffstat

there would be a placeholder to stuff branch description output (for
the normal case), and in your detached HEAD use case, you'd prepare
such a template without using branch description placeholder, but
instead prepare the description in place in the template before
running format-patch.  Which might actually be a better alternative.

But all of that depends on what the expected use case to support is.

Thanks.
