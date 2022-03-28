Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BDEC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 20:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbiC1U5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiC1U52 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 16:57:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7356674EF
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 13:55:47 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 39F1A18C042;
        Mon, 28 Mar 2022 16:55:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vb+a9q5Ff85AC/shcEi1OI3d4Sz7bjh3NoOKDr
        8Psd0=; b=P0Vl5W43V/f0pfN6S8VfL8O7nLu8VfXr86lOVXVjWz2pHQxvs9+eqs
        2Hyi48bs7cSDfPxG5kcoQfe0KGn3mn9epa8CKNyhkEyGjVCAtaCYlMu2s4arVY+Z
        VJgo/F6X5Aa5+NxTBwABLIdRcANTDJCd+zPBZMJz3MiPhBMqqfmR4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3207318C041;
        Mon, 28 Mar 2022 16:55:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 984BD18C040;
        Mon, 28 Mar 2022 16:55:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        tytso@mit.edu, derrickstolee@github.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 01/17] Documentation/technical: add cruft-packs.txt
References: <cover.1638224692.git.me@ttaylorr.com>
        <cover.1646266835.git.me@ttaylorr.com>
        <784ee7e0eec9ba520ebaaa27de2de810e2f6798a.1646266835.git.me@ttaylorr.com>
        <YiZI99yeijQe5Jaq@google.com> <YjkjaH61dMLHXr0d@nand.local>
        <YjpDbHmKY9XA2p0K@google.com> <YjpHbaBspUasDdEy@nand.local>
        <YjpWFZ95OL7joFa4@google.com> <Yjpxd8qhwnAIJJma@nand.local>
        <YkICkpttOujOKeT3@nand.local>
Date:   Mon, 28 Mar 2022 13:55:43 -0700
In-Reply-To: <YkICkpttOujOKeT3@nand.local> (Taylor Blau's message of "Mon, 28
        Mar 2022 14:46:42 -0400")
Message-ID: <xmqq8rst23w0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FAD37F8-AED9-11EC-9E19-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> To summarize Jonathan's point (as I think I severely misunderstood it
> before), if two writers are repacking a repository with unreachable
> objects. The following can happen:
>
>   - $NEWGIT packs the repository and writes a cruft pack and .mtimes
>     file.
>
>   - $OLDGIT packs the repository, exploding unreachable objects from the
>     cruft pack as loose, setting their mtimes to "now".

And if these repeat, alternating new and old versions of Git, we
will keep refreshing the unreachable objects' mtimes forever.

But once you stop using old versions of Git, perhaps in 3 release
cycles or so, we'll eventually be able to purge them, right?

> One approach (that Jonathan suggested) is to prevent the above situation
> by introducing a format extension, so $OLDGIT could not touch the
> repository. But this comes at a (in my view, significant) cost which is
> that $OLDGIT can't touch the repository _at all_. An extension would be
> desirable if cross-version interaction resulted in repository
> corruption, but this scenario does not lead to corruption at all.

A repository may not be in a healthy state, when tons of unreachable
objects stay around forever, but it probably is a bit too harsh to
call it "corrupt".

> Another approach (courtesy Stolee, in an off-list discussion) is that we
> could introduce an optional extension available as an opt-in to prevent
> older versions of Git from interacting in a repository that contains
> cruft packs, but is not required to write them.

That smells too magic; let's not go there.

> A third approach (and probably my preferred direction) is to indicate
> clearly via a combination of updates to Documentation/cruft-packs.txt
> and the release notes that say something along the lines of:
>
>     If you use are repacking a repository using both a pre- and
>     post-cruft packs version of Git, please be aware that you will lose
>     information about the mtimes of unreachable objects.

I do not quite see how it helps.  After hearing "... will lose
information about the mtimes ...", what concrete action can a user
take?  Or a sys-admin?

It's not like use of cruft-pack is mandatory when you upgrade the
new version of Git, right?  Perhaps use of cruft-pack should be
guarded behind a configuration variable so that users who might want
to use mixed versions of Git will be protected against accidental
use of new version of Git that introduces the forever-renewing
untracked objects problem?  

Perhaps a configuration variable, repack.cruftPackEnabled, that is
by default disabled, can be used to protect people who do not want
to get into the "keep refreshing mtime" loop from using the cruft
packs by mistake?  repack.cruftPackEnabled can probably be part of
the "experimental" feature set, if we think it is the direction in
the future.




