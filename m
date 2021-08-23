Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CC5C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 09:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1E061002
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 09:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhHWJWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 05:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbhHWJWq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 05:22:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C41C061760
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=+oU5PY/1Bee7sE121Enwy2pq1/PraATYw95C7qam3EY=;
        t=1629710524; x=1630920124; b=lz9NU/A+jkIDMs9ctCH3wMG+k22TbBRunklojDrOpVfyN3q
        it6+26lfzGakmT4VTYOedamC8tXKe7kTqz/HsFBzEC4zy9TGOjqCqutlpfxwm5E4MENqqPQtivk2I
        Gpr/O+vv20T+zKxeIRrqzlt7HEDebA5Jk8cFR7K1Pe+9m/JtJXtPYDkYIlEKXxO3GY7Tzmygbnb1u
        Y6hfeTO2z5Z2bnKzHw4emDF3An+7xsiCw7+hb3/ipIuVHFE+nDQYn8M1yJ+C74ae0G6EkQrxqtbRg
        WRacn5u+mLpcCitiNkbqQtdBFoBlfmRC9Z6qvGfcKOXadDaNHFP7ZI4w6UkftFNQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mI69a-00EmgG-7N; Mon, 23 Aug 2021 11:22:02 +0200
Message-ID: <dbb24573efc3dd945acd8acdfd9fe627ad7cbcd2.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] multi-pack-index: allow operating without pack files
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Cc:     bup-list@googlegroups.com
Date:   Mon, 23 Aug 2021 11:22:01 +0200
In-Reply-To: <edb9c412-70c8-4fc6-04ab-417eca05ee15@gmail.com>
References: <20210820195558.44275-1-johannes@sipsolutions.net>
         <edb9c412-70c8-4fc6-04ab-417eca05ee15@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2021-08-22 at 20:34 -0400, Derrick Stolee wrote:
> On 8/20/2021 3:55 PM, Johannes Berg wrote:
> > Technically, multi-pack-index doesn't need pack files to exist,
> > but add_packed_git() today checks whether it exists or not.
> 
> Having a multi-pack-index is supposed to indicate that we have
> these objects in the objects/pack directory within the specified
> pack-files.

Yeah, so, like I tried to explain in the patch email, this is
(partially) for a non-git use case.

The way you could think of it is that I'm trying to make a local index
cache, so we know locally which objects we have, but the actual packs
and their contents are stored in some slow/expensive (remote) storage
system.

With the local cache, I'd like to understand whether or not I have a
given object (in particular to avoid storing it again if I see it), and
also I'd like to know _where_ it is (which pack and where in the pack)
so that I can access only parts, instead of downloading everything.

The server isn't necessarily able to run something 'smart', it might
just be S3 blob storage, but storing pack files, not individual objects.

> I understand your goal to relax a condition of the multi-pack-index
> file, but it's triggered by a flag during write and that choice
> isn't persisted into the file. There is no way for a later Git
> process to understand that the multi-pack-index doesn't actually
> guarantee object existence.

It does, since the pack files are recorded. I've tested this briefly,
and it doesn't really seem to have any problems with it.

While I understand the concern, I'd also envision that this tool
command-line option is never set when this is used on normal git
repositories, only when used in this special use case I tried explaining
above.

> And in a completely other side: one would think that including
> a pack-file in the multi-pack-index would allow deleting the .idx
> file, but there are a few reasons why we do not (including
> interactions with third-party tools).

Well, arguably you can always restore it from the pack file, so you can
always delete it ;) Not sure git is set up for that though. Also, even
old versions of git would probably choke since they don't read the
multi-pack-index.

> So, I'm not necessarily on board with this change unless
> something is added to the multi-pack-index file (such as a new
> version 2 and an optional chunk understood by that version) that
> tells future Git processes that the .pack files might not exist.
> I'm still not sure what Git should do about that other than stop
> reading the multi-pack-index and ignore its contents.

It seems to do that today, or at least try to find in the idx if it goes
looking for an object and the multi-pack-index references a pack file
that doesn't exist - and as Martin also pointed out, that really is
necessary for this to work with older versions of git.

> [snip comments on the code]

Fair enough. I think we need to figure out the conceptual question
though - whether or not this is something that's acceptable in git in
the first place.

Like I said, the intent isn't to break git repositories or to even use
this on a git repository that's also normally being read by git (even
though I don't see any problems with that, but my testing wasn't very
deep). The intent (and the reason for this being [RFC]) is to see if git
upstream would be amenable to such a change that lets other tools use
git's index - especially multi-pack-index - machinery to operate on such
a thing as the "index cache" I described above.

In particular, in bup's [1] use case, we currently support our own
"midx" format which is similar to multi-pack-index, but only contains
*object existence*, not *object location*. Thus, there are two problems:

   1. In a normal bup/git repository, when bup is used to write objects
      (it only ever writes packs), then the midx is also updated to
      allow bup itself to check for object existence without opening all
      the *.idx files, allowing it to deduplicate objects efficiently.
      In this case, bup always uses git to retrieve objects pack, and
      this leads to inefficiencies: git will not be able to use the midx
      files (and they don't contain object location anyway), but git
      will open all the *.idx files. If we ask it, it might maintain its
      own multi-pack-index.
      
      Obviously, in this mode, there's no reason to have this patch - we
      can just ask git to create the multi-pack-index and add code to
      bup to understand how to read it in order to check for object
      existence (for deduplication).
      
   2. However, I'm working on adding encrypted repositories to bup, and
      there the objects are stored differently - still in something like
      a pack file, but it's encrypted, in a way that's done at the
      object level.
      
      In this mode, bup maintains an object index in a clear-text cache,
      i.e. all the *.idx files, and currently adds its own midx to be
      able to efficiently check for object existence.
      
      However, in this case, bup cannot use git to access objects, since
      there's no real git directory, only a folder containing the *.idx
      files, the data is "elsewhere".
      
      Since the *.idx file format is still the same (no reason to change
      it), with this patch we can use git to efficiently (in both
      developer time, I don't need to rewrite it, and runtime, since
      it's in C not python) ask git to write the multi-pack-index that
      then bup can use to do both: a) check for object existence during
      further backups while adding new objects, and b) look for object
      location while accessing the repository for reading.

I completely understand that this is a non-git use case, and I'm
entirely happy for you to tell me to get lost, but I figured it was such
a small change I had to try, rather than rewriting the entire multi-
pack-index maintenance code for bup (or importing git's there).

Really for (2) I don't even care about using git's multi-pack-index,
since git never uses it, but I wanted to have the same between (1) and
(2), and if we want git - called on a bup/git repo - to have a multi-
pack-index, then we need git's format, of course.

The other hack I considered was to just create empty *.pack files for
each *.idx file in the index cache because then git is (currently) happy
to accept this, so it never really validates anything there even when
the pack files "exist", but that felt even worse and like something git
might break with just a little more validity checking.


So basically I had choices between:
   A. implement multi-pack-index in bup, to cover both (1) and (2)
   B. implement a new midx format in bup, to cover just (2)
   C. call unmodified git in bup, to cover just (1)
   D. this patch to cover both (1) and (2)
   E. create dummy *.pack files for the *.idx files in the cache, so
      that git will accept it.

Obviously, I can also do any combination of these, e.g. B & C, but this
was the least amount of work ;)


But really, it's up to you, I'm just asking. If you feel this doesn't
fit into git's machinery (despite being so simple), I'll just do
"something else", not sure which one I might do. Quite possibly A., if
only because then I can write tests with "git multi-index-pack verify"
:-)

johannes

[1] https://bup.github.io/, not to be confused with bupstash.io

