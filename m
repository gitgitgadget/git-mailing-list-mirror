Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C28C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 17:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382064AbhLCRcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 12:32:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52980 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358912AbhLCRcw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 12:32:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B87DE9415;
        Fri,  3 Dec 2021 12:29:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WVRPHfFW7yKjhYNnfIofgKlIeZmZztBpk8W/4j
        1o4xM=; b=EpY/2Qi9+hfZMJJJ31VVGScHo/JnbHBYuHOaQ1nRIUlZwIavf4QSk2
        GlzwtFRhZCcAYQ4jYcuUmH08Asvf8wCdA4JGnjUrk6vox2qCuGACGNKUO5IWpiPR
        abvP0OXJ2SRzuytAuJEuMfuIoEFCqCYRT75pplbCL3jX0AeWwOTpc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42A28E9413;
        Fri,  3 Dec 2021 12:29:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4A72E9412;
        Fri,  3 Dec 2021 12:29:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] push: make '-u' have default arguments
References: <xmqqbl1yvpa0.fsf@gitster.g>
        <20211203081446.17596-1-chakrabortyabhradeep79@gmail.com>
Date:   Fri, 03 Dec 2021 09:29:26 -0800
In-Reply-To: <20211203081446.17596-1-chakrabortyabhradeep79@gmail.com>
        (Abhradeep Chakraborty's message of "Fri, 3 Dec 2021 13:44:46 +0530")
Message-ID: <xmqqtufpsikp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90EF6268-545E-11EC-883C-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

>> One thing that bothers me is that unlike your assumption, not
>> everybody uses push.default set to simple or upstream.  I am not
>> convinced that the "git push -u" that defaults to do the 'current'
>> push with TRANSPORT_PUSH_SET_UPSTREAM for them is an improvement
>> for them.
>
> May be you're right. It may not be an improvement for all. But I
> think they also would be happy seeing this 'default' case of 
> 'set-upstream'.

Not at all.  

The argument for the "good" case is for "simple" or "current" users,
they want their "git push" without repo and branch arguments to
push their current branch to the branch with the same name at the
default remote repository, and if we arrange "git push -u" to do the
sameand set up "branch.$current.merge", they will find it convenient.

The same reasoning applies for other users who do *not* want their
"git push" without repo and branch arguments to push as if they are
doing the push.default=current push.  If we make "git push -u" push
the current (and only the current) branch to the branch of the same
name at the default remote repository by overwriting argv[] like the
patch under discussion does, we would be giving these users a
convenient way to do what they do not want to do.  Besides, I think
with the current code

    $ git -c push.default=matching push -u

already does the right thing by pushing the matching branches and
sets up upstream for the branches that get pushed without the patch
in question.  With the patch, because it blindly mucks with argv[]
to force pushing only the current branch to the default remote, the
established expectation by existing users is broken.

That of course is not an improvement but actively hurts them.  We
shouldn't be making it easier for our users to hurt themselves.

So, no.  The patch in its current form is totally unacceptable.

Shouldn't the rule be something like "if 'git push $args' (where
$args may be nothing, or any options other than '-u') pushes a
branch (or a set of branches) to a repository, 'git push -u $args'
(with the same $args) should set the branch.*.{remote,merge} for the
branch(es) to the same repository" for the introduction of default
to be truly an improvement?  Or is it too strict and makes the rule
not to trigger even for the intended audience?
