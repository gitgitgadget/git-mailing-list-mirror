Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83698C433EF
	for <git@archiver.kernel.org>; Sat,  2 Jul 2022 19:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiGBTE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jul 2022 15:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiGBTEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jul 2022 15:04:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3327CBC0D
        for <git@vger.kernel.org>; Sat,  2 Jul 2022 12:04:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A02A1B1000;
        Sat,  2 Jul 2022 15:04:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OIIhveBJNqgo5CwxrUBs2WHfd9NQnsN6Jtpw/v
        7lXqI=; b=P910KhbsTdd+qLnp9MpOz+jf5N1PntOW1lhYRKoqd4Om4HDo8iGOnJ
        qO4QXNn0wquhnittG8GaqBb75eOBkfa6+AyRyTWLDjw/WYYldDQK4IAgwvaJhkgP
        BdtbviF+bAfYCf0OfltksS+EAwiRGyWQgJ7MM96R5tDOeqTZJkKfc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 936A71B0FFF;
        Sat,  2 Jul 2022 15:04:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2BAC51B0FFE;
        Sat,  2 Jul 2022 15:04:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias Beyer <mail@beyermatthias.de>
Cc:     git@vger.kernel.org
Subject: Re: cherry-pick with --no-rerere-autoupdate does still rerere?
References: <1656746869.11nc2qu6dn.astroid@takeshi.none>
Date:   Sat, 02 Jul 2022 12:04:17 -0700
In-Reply-To: <1656746869.11nc2qu6dn.astroid@takeshi.none> (Matthias Beyer's
        message of "Sat, 02 Jul 2022 09:30:18 +0200")
Message-ID: <xmqqwncv49qm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C67ED086-FA39-11EC-A6DC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Beyer <mail@beyermatthias.de> writes:

> I just experienced a `git cherry-pick <commit> --no-rerere-autoupdate` where the
> conflict still got automatically resolved from rerere.

If I am not mistaken, this is totally expected.  You told the
command "use rerere but do not blindly accept the replayed
resolution into the index".

When you run "cherry-pick" there are three possible outcomes:

 * The change <commit> wanted to make cleanly replays on top of
   HEAD.  Unless --no-commit is given, we update the index and the
   working tree, make a commit, and advance HEAD to point at the new
   commit.

 * The change does not cleanly replay, and you either do not have an
   earlier resolution recorded in the rerere database, or you tell
   rerere not to kick in by setting the rerere.enabled configuration
   variable to 'false'.  In this case, the working tree files would
   have conflict markers in them and the index would have higher
   stages for these conflicted paths to record the original, our,
   and their versions.

 * The change does not cleanly replay, but your rerere database
   knows a resolution you accepted already that applies cleanly, and
   you allow rerere to kick in by the rerere.enabled configuration
   variable.  This will update the working tree files by replaying
   the recorded resolution, but leaves the index conflicted, so that
   you can inspect the auto-resolution with "git diff --cc".

   If rerere is allowed to update the index with the result of its
   operation (either by the rerere.autoupdate configuration or the
   --rerere-autoupdate command line option), it also adds the result
   to the index ("git diff --cc" would no longer work as a way to
   view how the conflict was resolved).

I think the default these days is to allow rerere to replay the
resolution to the working tree files, but not allow the index to be
auto-updated.  This allows people to be lazy but still be careful
before (re)committing to accept the previous resolution to the
index.

The above is not limited to "git cherry-pick", but applies also to
any mergy operation like "git merge", "git revert", and "git am -3".

A bonus protip.  Always write dashed options to a subcommand (like
"cherry-pick") before non-option argument, i.e.

	git cherry-pick --[no-]rerere-autoupdate <commit>

Some subcommands may be lenient and take arguments given in a wrong
order when they are not ambiguous, but it is a good discipline to
follow.
