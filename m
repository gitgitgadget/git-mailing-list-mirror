Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7FEC433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 15:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381943AbiEMPXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 11:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381938AbiEMPXB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 11:23:01 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472C36540F
        for <git@vger.kernel.org>; Fri, 13 May 2022 08:22:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22DCF122D41;
        Fri, 13 May 2022 11:22:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rjwqO/w96FrM1ZIaQ1YrwAyRb3K41O+3bPKCsU
        6Hqr0=; b=Ljo/gzqE1OYVkTPJBjFJLmhxtClRYhMf+7zjXlNCigV5JJI374GK+D
        QzMDfM1j+JWaM0kzoLubr3zjSeEMuAF1N7GsRtGCXMqyorlOFmDH7M6PBOLEKxBj
        oGSDhSuBLdcVfLZuTlxvGRAG2W88C1VuuLGFdug0jWu4o6RjzeyGc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B11C122D3F;
        Fri, 13 May 2022 11:22:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7FCEA122D3D;
        Fri, 13 May 2022 11:22:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     =?utf-8?B?0JLQsNC00LjQvCDQptCy0LXRgtC60L7Qsg==?= 
        <vadim.tsvetkov80@gmail.com>, git@vger.kernel.org,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: Git Submodules ref setting
References: <F20FCD5B-7788-4D4C-8402-2C4CF447B2F5@gmail.com>
        <88fa7138-cb3f-ab88-525c-198396b0a262@gmail.com>
Date:   Fri, 13 May 2022 08:22:56 -0700
In-Reply-To: <88fa7138-cb3f-ab88-525c-198396b0a262@gmail.com> (Philippe
        Blain's message of "Thu, 12 May 2022 18:42:09 -0400")
Message-ID: <xmqqwnepbgof.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 915BC386-D2D0-11EC-A2F1-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Yes, it was a deliberate design choice to have a deterministic state
> of a repository using submodules upon 'git clone'. Recording a submodule
> at a specific branch instead of at a specific commit would make this design
> choice impossible to achieve.

The above sentences are all correct, but it answers a slightly
different question, I think.

I suspect that Vadim wanted to see if it is desirable to point at a
non-branch ref with "submodule.<name>.branch" entry (or invent a new
"submodule.<name>.ref" entry) in the ".gitmodules" file.

While the answer to that question is "probably not", to understand
why, your answer helps ;-).

The "submodule.<name>.branch" entry hints the name of the branch to
be used in the named submodule while working on submodule changes
meant to go with the change that will be made to the superproject.

It is expected that the workflow goes like this:

 * A contributor checks out branch X of the superproject, which
   binds another project whose name is N as its submodule at path P.
   In the tree of the commit at the tip of branch X in the
   superproject, a concrete commit C in the submodule is recorded
   at that path.

 * The .gitmodules file found in that superproject checkout may
   record submodule.N.branch with value Y.  The commit C should be
   checked out in the submodule.

 * The contributor works on something that involves both the
   superproject and the submodule.  Perhaps the new feature in the
   superproject requires an enhanced version of the submodule, so
   there is an dependency.  New commits are added on top of C in the
   submodule, and branch Y is advanced.  The commit at the tip of
   that branch is recorded in the superproject's tree, and together
   with the changes in the superproject that use the modified
   submodule advance the branch X of the superproject.

 * The contributor shares the work with other participants by
   pushing branch X of the superproject and branch Y of the
   submodule.  There may be other branches that may be pushed out
   "while at it", but at least these two need to be pushed out.

For this workflow to work, it is necessary, as you said, that an
exact commit is recorded in the tree of the superproject.  We can
guarantee a correct build of the superproject at commit at the
updated tip of branch X, because we know which submodule commit
needs to go with it.

But it is not sufficient.  The history in the submodule needs to be
manageable---the contributors who cloned the superproject and the
submodule need to check out a commit to work on and extend their
histories, and while it is possible to work always on detached HEAD,
at the place where contributors meet with their work, i.e. the
repository their changes were pushed in the last step in the above
sequence, there needs _some_ ref.  It is possible to use a
non-branch ref for that, but because the contributors have to check
that ref out after cloning and fetching the submodule, it makes
little sense not to require that ref to be a proper branch that can
be checked out (instead of merely giving a starting point of an
unnamed branch, aka detached HEAD).

And that is why "remote.<name>.branch" is there and it is not
"remote.<name>.ref".






