Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4C8C433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 21:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiGPVgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 17:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGPVgy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 17:36:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2CD186C6
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 14:36:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4AD2B1A7424;
        Sat, 16 Jul 2022 17:36:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d5/cn46V4rVV4KLvrBuGQe6LI/YyIitFNYTGQJ
        p7vX4=; b=mpbRJ05xXq8//sihiRaz0Wjw3fMhQQaxQ4sF/QXeeew6OeDg5Etboi
        WW4pFBv/IlgPfYh2eETRRIVwz7zL35MMTX1O/FeeS83UDLQrDWv4GxCxq+UU+E26
        jeg1PYLFSBxmtlWdiA/zsVAcxTvPHLl1EMn0v54o8zC38ixzW3md0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4379D1A7423;
        Sat, 16 Jul 2022 17:36:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E660C1A7422;
        Sat, 16 Jul 2022 17:36:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen Smith <ischis2@cox.net>
Cc:     git@vger.kernel.org
Subject: Re: Branch next doesn't look like it was pushed
References: <12032556.O9o76ZdvQC@thunderbird>
Date:   Sat, 16 Jul 2022 14:36:47 -0700
In-Reply-To: <12032556.O9o76ZdvQC@thunderbird> (Stephen Smith's message of
        "Sat, 16 Jul 2022 07:41:47 -0700")
Message-ID: <xmqqr12kwxhs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65F6B1D6-054F-11ED-9BD2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen Smith <ischis2@cox.net> writes:

> Is there a reason that with the latest commits to the repository that next is 
> no longer an ancestor of seen  and than main/master is no longer an ancestor 
> of next?

Let's get to the latter half of your question first.

Tips of various branches of Git project can be observed at
https://git.kernel.org/pub/scm/git/git.git/ and
https://github.com/git/git (among other mirrors) and they are at
these commits:

    maint         bbea4dcf42
    master        9dd64cb4d3
    next          4dd4a117ec
    seen          c82b393ce5

at the time of writing.  The 'next' branch is designed to be always
a descendant of 'master', unless I screw up, and I'd appreciate if
you let me know when it happens.  Right now, it is not the case,
though.

    $ git rev-list --count 4dd4a117ec..9dd64cb4d3
    0

Now, the 'seen' branch never was, and will never be, a descendant of
'next'.  It always is a decendant of 'master'.

Imagine how 'next' gets advanced.  It will never rewind during a
release cycle, so it starts at a feature release, and merges topics
and also merges 'master' back.  A topic might be merged once to
'next', then the topic may gain a commit or two to fix a bug in the
part of the topic that is already in 'next', and the updated topic
may be merged to 'next' again.  IOW, some topics may have merged to
'next' in multiple steps.  Topics cooking in 'next' may graduate by
getting merged to 'master', at which time, the draft release notes
is updated on the 'master' branch, and 'next' merges 'master' back.
This is to pick up the changes to the draft release notes.  In other
words, the history graph of 'next' will be a mess.

The 'seen' branch serves three purposes.

 * The first is to allow sanity checking the result of messy merges
   into 'next'.  For that, whenever 'master' advances, it is rebuilt
   from scratch from the tip of 'master' and merges each and every
   topic that are already in 'next' one by one, serially.  Even
   topics that were merged in multiple steps to 'next' may be merged
   in full with a single merge to 'seen'.  When all the topics in
   'next' (and nothing else) are merged, an empty single-parent
   commit with title '### match next' is added.  The idea is that
   the tree of this commit should exactly match the tree of 'next',
   or there may be some mismerges.  The 'next' branch, since it
   forked from the last release point, may have merged these topics
   in random order, in increments, and also merged back the changes
   made in 'master', but the end result should be the same as
   starting from the latest 'master' and merging the topics that are
   in 'next' but still not in 'master' one by one, each as a whole
   instead of doing so incrementally.

 * The second purpose of 'seen' is to gather other topics that I
   happened to have seen together into a single integration branch,
   so that

   (1) I can forewarn myself of possible conflicts and interactions
       among topics in flight, and

   (2) I can have a simple way to list all topics in flight.

   This is done by merging the other topic branches, on top of
   'seen^{/^### match next}' commit.  To list the topics that I am
   juggling "git log --oneline --first-parent master..seen" is an
   effective way.  For this to work, the rest of 'seen' cannot be
   built on top of 'next', whose history is allowed to be messy.
   This is why 'next' cannot be an ancestor of 'seen'.

 * The third purpose of 'seen' is to give me a version that I can be
   a guinea pig of.  I have a build of "git" that is cut from a
   point in 'seen' that is used in my daily use.

HTH.



