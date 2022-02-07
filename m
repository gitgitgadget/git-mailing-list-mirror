Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD6EC433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 22:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244044AbiBGWtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 17:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiBGWtW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 17:49:22 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBC5C061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 14:49:21 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E419916206B;
        Mon,  7 Feb 2022 17:49:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dTPc8c+2pfLNMxg9kOfIJ17oR+S0UjKY9uKDx3
        6ws+E=; b=Va4GmnoHRYA1zdKN4s4AZYP2wkMZO0aDKCuEZrkiO7B3j8qPWqGel7
        y+bllIRdhV4JgDWAyk3Z7sLhRuRRVy0z4pS3OnIOIU0aLdxswTylXmT/IzBeTGOY
        ino9yoyoQqPA+E7Da4rNB/P2IhORDTIzdIgwQIx13UsnInoXrJC6s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DCA7F162069;
        Mon,  7 Feb 2022 17:49:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 22578162067;
        Mon,  7 Feb 2022 17:49:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "Gamblin, Todd" <gamblin2@llnl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Commit SHA1 == SHA1 checksum?
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
        <121ce485-bea8-3168-aa35-d11eb13022da@iee.email>
        <xmqq1r0gjo6h.fsf@gitster.g>
        <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email>
        <xmqqee4fix0l.fsf@gitster.g>
        <20220207133244.kpyczjsxriepjtdt@meerkat.local>
        <xmqqczjyiecs.fsf@gitster.g>
        <20220207213449.ljqjhdx4f45a3lx5@meerkat.local>
Date:   Mon, 07 Feb 2022 14:49:16 -0800
In-Reply-To: <20220207213449.ljqjhdx4f45a3lx5@meerkat.local> (Konstantin
        Ryabitsev's message of "Mon, 7 Feb 2022 16:34:49 -0500")
Message-ID: <xmqqzgn2gumr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E9C39D6-8868-11EC-AA2A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Mon, Feb 07, 2022 at 12:57:55PM -0800, Junio C Hamano wrote:
>> You are solving a different problem: "I have this tar archive; what
>> git tree object would I get if I extract this archive to an empty
>> directory and said 'git add . && git write-tree'?".
>> 
>> I agree that one is computable.
>
> So, I was brainstorming about this today, and I'm curious if you think this
> would be a useful feature to have, maybe even natively?
>
> E.g. here's a scenario:
>
> "git archive -S <signed-object>" creates an additional file that is added to
> the generated tar/zip archive -- for example, a ${prefix}.GIT_ARCHIVE_SIG. That
> file contains the raw contents of the signed tag and/or the signed commit.
>
> "git verify-archive" would look for a toplevel .GIT_ARCHIVE_SIG file. If it's
> present, it would verify the signature on these "detached" signed objects to
> get a trusted tree hash. Then it would compute the tree hash of the tar
> archive (minus the .GIT_ARCHIVE_SIG file) to see if it matches.
>
> In my mind, that would provide the following benefits over the current
> practice of detached .sig files:
>
> 1. environments like github/git.kernel.org would be able to create verifiable
>    snapshot archives using an existing set of signed objects
> 2. packagers would be able to perform cryptographic verification without
>    needing to track any extra sources like corresponding .sig files; they
>    would just need to add a build-time dependency on git (plus whatever it
>    calls for cryptographic verification, such as gnupg or openssh)
> 3. this would automatically support all git-native signature mechanisms like
>    openssh and whatever else gets added in the future
>
> Does this idea have any merit, or is it too fragile/crazy to bother?

I may choose details differently at implementation level (instead of
an extra file, I'd see if we can add it as pax_extended_header, for
example), but I think that is workable and might be even useful,
provided if I am not misunderstanding your idea, so let me try
rephrasing to see how it would work.

Given a signed commit or a signed tag that points at a commit, your
enhanced "git archive" would create a .tar file with the contents of
the tree object, and adds copies signed objects that tells what tree
object the archive ought to have.  E.g. if you start from a signed
tag, "git cat-file tag $tag" output would allow you to learn the
object name of the tagged object, and to verify the PGP signature
embedded in the tag, but it is likely that the tagged object is a
commit, not a tree, so you'd also need to include "git cat-file
commit $tag^{commit}".  So you'd store the raw contents of the tag
(so that we have a hash-protected record of commit object name), and
the commit (so that we have a hash-protected record of tree object
name).

You as the recipient will find these in the tarball:

 - the files that are supposed to be the contents of tree X.

 - the raw contents of the commit C that is supposed to record the
   tree X.

 - the raw contents of the tag T that is supposed to point at the
   commit C.

Starting from the contents of tag T, which is PGP signed, you know
that the signer wanted to call commit C with the name of the tag T.
Then the raw contents that alledgedly are from commit C, you can
"git hash-object -t commit" it to verify that it indeed hashes down
to C (hence, it what the signer wanted to give you), and find the
name of the tree object X the commit records.  And when you added
all the blobs contained in the tarball (and nothing else) to the
index and ran write-tree on the resulting index, you would know what
tree object the tarball contained, and if it hashes down to X, you
know that the cryptographic hash chain starting from PGP signature
on T attests that that tarball matches what the signer wanted you
to have.
