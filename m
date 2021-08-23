Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47009C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 07:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C64A6121E
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 07:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhHWHdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 03:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbhHWHdB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 03:33:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB38C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=K3iu1MmlRPokJbg2bfL92QpdGSJK7wuSv1tpf2D86G8=;
        t=1629703939; x=1630913539; b=jVyAmyBiDrs96AmdL7geGVB1iIFSFvpZryAHU0ro508cxuB
        TT6X4Y42H8D3u5yz5GSnVhDatnlV8Fpfq83Y6Mz0wseMi0QjY8oV74I8EgYYk6jJlc96fPF04XaLU
        QhsQ7m+a5J8Q0xa7mkv/4RFimnUj/5K17CFaDh2A1C01MrD3Vf8LsqOaiP0x2dtd2jqI1iUeYOxNP
        KWiZzym2mGCczddPCq7311o4EvuaS38WBXoap9siFk9c/0tqNJL/yGroSo+AyzQz+mrLxhTr3mb84
        vkbN6NNm8MXpw9y4BYdx8u6tBgjuee886l/bTOdToug8hjhYvXgg8IeshUKFsAAw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mI4RN-00EkgU-4Q; Mon, 23 Aug 2021 09:32:17 +0200
Message-ID: <c74ff2a21c09a9ac69b73c53deb3bb4f0159775b.camel@sipsolutions.net>
Subject: Re: [PATCH] multi-pack-index: fix --object-dir from outside repo
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Date:   Mon, 23 Aug 2021 09:32:15 +0200
In-Reply-To: <YSLxqnxlyEUQ+ljJ@nand.local>
References: <20210820193504.37044-1-johannes@sipsolutions.net>
         <YSLxqnxlyEUQ+ljJ@nand.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

> Thanks for CC'ing me; I have definitely been wondering about the
> intended behavior of `--object-dir` on the list recently [1].

Oh, hah. Not really being a contributor I'm not following the list,
thanks for the pointer.

> I think your patch message could use some clarifying, though.  Invoking
> 
>     cd $REPO/..
>     git multi-pack-index write --object-dir=$REPO/.git/objects
> 
> has... different behavior depending on which side of the "write"
> argument you put `--object-dir".

Wait what?! To be honest, I didn't expect it to even be valid on the
right-hand side of "write".

>  On the left-hand side (i.e.,
> "--object-dir=... write", you get something like:
> 
>     cd $REPO/..
>     git multi-pack-index --object-dir=$REPO/.git/objects write
> 
>     zsh: segmentation fault  git.compile multi-pack-index ...
> 
> because the_repository->objects->odb isn't initialized (so reading
> `path` in `clear_midx_files_ext` crashes).

Right, this is what I was doing.

>  But in the opposite order
> (i.e., "write --object-dir=...") you get:
> 
>     BUG: environment.c:280: git environment hasn't been setup
>     zsh: abort      git.compile multi-pack-index write
> 
> because we catch that case much earlier in get_object_directory(). Why?
> Because cmd_multi_pack_index() fills in the value of object_dir with
> get_object_directory() if it isn't filled in already, but seeing "write"
> causes us to stop parsing and dispatch to the sub-command
> cmd_multi_pack_index_write().

Great ...

But why do we even support both? What would the semantic difference be?

I'd be happy with either one of them working I guess :)

> I discussed this a little in [1] also (see the part about using
> RUN_SETUP instead). There are definitely different ways to handle that;
> you could equally imagine only dying if we were both outside of a Git
> repository and didn't point at one via `--object-dir`.
> 
> But that's separate from another issue which is fixed by your patch
> which is that we don't respect the value of `--object-dir` when cleaning
> up MIDX .rev files via clear_midx_files_ext().

Well, I _mostly_ meant to fix the crash, but yes, this is really the
underlying issue, and indeed we should clean up the .rev files in this
case as well.

> Your fix there (to use the path of an object_dir instead of a repository
> struct) makes sense (since we don't ever fill in a repository struct
> corresponding to the `--object-dir` parameter from the MIDX code).
> 
> But I think that's a separate issue than the RUN_SETUP thing I mentioned
> earlier, so I would probably consider breaking this into two patches,
> the first which addresses the RUN_SETUP thing, and the second which is
> this fix.

I never wanted to fix the other issue though ;-)

And honestly, I think I don't understand the discussion at [1] well
enough to really submit a patch for it.

> > +test_expect_success 'multi-pack-index with --object-dir need not be in repo' '
> > +	p="$(pwd)" &&
> > +	rm -f $objdir/multi-pack-index &&
> > +	cd / &&
> > +	git multi-pack-index --object-dir="$p/$objdir" write &&
> > +	cd "$p"
> > +'
> > +
> 
> I agree with Stolee that there should be a new repo created within the
> current working directory, that way you can "cd .." and be both outside
> of the repo you just created, but not outside of the test environment.

OK, fair enough, I'll resubmit.

> But let's make sure that we're not deleting any files that we should be
> leaving alone. So it might be good to do something like:
> 
>     git init repo &&
>     test_when_finished "rm -fr repo" &&
>     (
>       cd repo &&
> 
>       test_commit base &&
>       git repack -d &&
>     ) &&
> 
>     rev="$objdir/pack/multi-pack-index-$(midx_checksum $objdir).rev" &&
>     touch $rev &&

Hah, so you just manually pretend it was there - and meanwhile I was
looking for a way to get git to generate one :)

> 
>     git multi-pack-index write --object-dir=repo/.git/objects &&

Now this has the order of arguments the other way around, why?

>     test_path_is_file repo/.git/objects/pack/multi-pack-index &&
>     test_path_is_file repo/.git/objects/multi-pack-index &&
>     test_path_is_file $objdir/pack/multi-pack-index &&
>     test_path_is_file $rev

Why would test_path_is_file? Seems like it should be !test_path_is_file?

> 
> That isn't testing the "invoked from a non-repo, but --object-dir" is
> given case, but I think that's fine since they really are separate
> things.

But that's the one thing I really want to work :)

> Note also that midx_checksum doesn't exist, but it is merely a wrapper
> over a test-tool that prints out (for a multi_pack_index "m") `m->data +
> m->data_len - the_hash_algo->rawsz`.
> 
> So between splitting the patch, clarifying the patch message, and
> implementing support for this new test helper, this may be more of a
> project than you were bargaining for ;).
> 

Sounds like ;)
But actually we don't really care about the midx_checksum here, afaict?
MIDX_WRITE_REV_INDEX isn't ever set, so the rev files are not created
today?

> Let me know if you want any
> help. I also don't mind taking care of it myself, since I promised in
> [1] that I'd fix this issue anyway.

Thanks :)
How about I resubmit this patch with some of the edits, especially with
test for the case I care about (--object-dir used from a non-git place
to point elsewhere) and then you can build on top of that?

Thanks,
johannes

> [1]: https://lore.kernel.org/git/YQMFIljXl7sAAA%2FL@nand.local/
> 

