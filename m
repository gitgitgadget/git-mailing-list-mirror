Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F58C43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 17:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiGFRZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 13:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiGFRZP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 13:25:15 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C255CDF
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 10:25:13 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o8-20020a17090ab88800b001ef81869167so6487278pjr.2
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 10:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=aS+wvFSxkuW2bXTLduqqo5jXZC+7scOjoWkpzXks+VE=;
        b=Gdl8MsCvPncaN98Qd/LrFgNl3piaqjhPv7r1W4/MGr2A8Ntn+rHGt2o6GI29iOc5KP
         GvYBCofKwh0Gd/ICOd5MmbsYxz5bOxvcIpV5Yf8ZCfJTMck25Sfm0MoiRSF0vfSGePLx
         HjLzU4agRbGat/rBJMhiSAglZ01FSje7+lw+p38F+B46NtlCaQE4v8bCeYQCfQEodlDe
         annNwre8UufLtzexOr1GPPiIjDuCQ2QbhrIrGUxwyga9nMMB4/0jSA/B3Dh+jwVFhIEl
         4J0KaAzUNFk7aOeckvAaikqLjObo+6e3FDX4jd/AbTo8RPdJjPmLZKJklgT1FSZ3XCdD
         M4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=aS+wvFSxkuW2bXTLduqqo5jXZC+7scOjoWkpzXks+VE=;
        b=AwdAxYSX4Bl+MhcCQUgTZX7XIfyQiIdyO8Kyp896mSZg1TszuX6NvnC2AeDMHjSfUu
         DRECOKxhzZn9jqvn4TEnvI+OoF91BZNt+WW3bVrJz/INmKggGIs5OXgiYivp4wzF1+aX
         zpiq8gSBWVZWevisABOG+n9yaK0G2TyaEBNSYf8jF4H7faU0Ehf9ce7v29M2taXzbKGr
         GBuYkDE4/NJsCdWAO1Cq05dqcStkDFS1RUeIPqytGwEbAy38YefN5bSbmaExVsKB3p0U
         mghHGErMnf4UigydT/v8R1aKdFu8/qh0qinSjUztqN2iPizm/wUOtUTzj81cLBkWV8w0
         CTHA==
X-Gm-Message-State: AJIora96psRlLWjWAYieBSfA/nnxEAOA41KvXS3rycbCcHKQDHZi5ayP
        Flq7TvbGyP0fQbg+ETbrmMP3ah7OjtoFK9JxEDoH
X-Google-Smtp-Source: AGRyM1ssOcIXZfCJtXOG41zpI7O23737J3Ms4Lc4LbZf/u+osWmAhS7ElvM/4tcsb3lv4mFCsu4oULwU4/wH9Nb9Slpy
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:f688:b0:16a:81d4:17e0 with
 SMTP id l8-20020a170902f68800b0016a81d417e0mr49240934plg.174.1657128312573;
 Wed, 06 Jul 2022 10:25:12 -0700 (PDT)
Date:   Wed,  6 Jul 2022 10:25:05 -0700
In-Reply-To: <CABPp-BG8r4zUOKZ+DzZOdsEwr+580cK=SvZ4n_euPOV1Nocu+A@mail.gmail.com>
Message-Id: <20220706172505.270363-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: Re: [PATCH 3/3] merge-ort: fix issue with dual rename and add/add conflict
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for getting back to this so late. I don't have any issues with the
patches, but just to close the loop:

Elijah Newren <newren@gmail.com> writes:
> On Mon, Jun 27, 2022 at 11:47 AM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > > The testcases added in t6423 a couple commits ago are slightly different
> > > but similar in principle.  They involve a similar case of paired
> > > renaming but instead of A/ -> B/ and B/ -> C/, the second side renames
> > > a leading directory of B/ to C/.
> >
> > Hmm...one side moved sub1 -> sub3 and the other moved sub2 from the root
> > to under sub1, right? So it's more like A/ -> B/ and C/ -> A/C/.
> 
> Hmm, maybe I should have been more explicit in my mapping:
>    A = sub2
>    B = sub1/sub2
>    leading directory of B = sub1
>    C = sub3

Substituting into A/ -> B/ and "a leading directory of B/ to C/", we
get:

  sub2 -> sub1/sub2 and sub1 -> sub3

which is indeed what is happening. I see, thanks.

> > > And both sides add a new file
> > > somewhere under the directory that the other side will rename.
> >
> > Rename or move, I think.
> 
> I'm confused; I don't understand what this comment means.  Renames
> tend to be created using "git mv", before or after making content
> changes, so to me a file being renamed or a file being moved to a
> different location are synonymous.  What distinction are you making
> between renames and moves?

I was thinking that a rename means that the directory still has the same
parent directory, whereas a move means that the directory keeps its
basename but has a different parent directory. Maybe it's just the way I
think about things, but the important thing here is that a directory was
moved so that its parent directory is a directory that is different and
that already exists, and I think that this meaning is lost when we say
"rename". But it might just be me.

> Hmm, perhaps I should change this to:
> 
> /* Cases where we don't have or don't want a directory rename for this
> path, so we return NULL */
> 
> The purpose of this function is to check whether a given path would be
> modified by directory renaming to get a new path.  So, "no new path"
> means we don't have an applicable directory rename or don't want to
> use it.

I see - the new text makes sense.

> > >       if (strmap_empty(dir_renames))
> > >               return new_path;
> > > +     if (strmap_get(&collisions[other_side], path))
> > > +             return new_path;
> >
> > So as far as I understand, collisions here, for a given side, is a map.
> > The map's keys are all the filenames of added and renamed files (I'm
> > assuming that's what 'A' and 'R' are) from that side after any directory
> > moves on the other side are applied. So, for example, if we add "foo/a"
> > on side A and rename "foo/" to "bar/" on side B, then side A's collision
> > map would have a key "bar/a". So I'm not sure if "collision" is the
> > right name here, but the existing code already uses it so I'll leave it
> > be.
> 
> Let's take your example a bit further, to discuss the original kind of
> usecase that "collisions" was written for.  In addition to adding
> "foo/a" on side A, we also add "foo2/a" and "foo3/a".  And then in
> addition to renaming "foo/" to "bar/" on side B, we also rename
> "foo2/" to "bar/" and "foo3/" to "bar/", thus merging all of foo/,
> foo2/, and foo3/ into a single directory named bar/.  If the files in
> foo/, foo2/, and foo3/ on side B were all unique, you can see how
> there'd be no problem merging these directories together.  The problem
> only comes at merge time when you attempt to apply the directory
> renames from side B to the new files on side A.  That's when you get
> collisions, in this case three files that would be named bar/a.
> 
> Checking for such collisions was the purpose of the "collisions"
> metadata, so I think the name is fitting.  The only problem is that
> we're reusing that data now for a slightly different purpose, though I
> think it's still "collision-y".

That makes sense, thanks.

> > It makes sense that this situation (of side A having "bar/a" because
> > side B renamed "foo/" to "bar/", and at the same time, side B adds its
> > own "bar/a") is weird, as stated in the commit message, so I don't mind
> > disabling checking for directory rename in this case.  However, in
> > theory, I don't see how disabling this check would fix anything, since
> > the bug seems to be about two different files on different sides being
> > renamed to the same filename through some convoluted means. (Unless this
> > is the only convoluted means to do it, and disabling it means that the
> > bug wouldn't occur.)

[snip]

> Hmm...let me see if I can explain this a different way.
> 
> The short version of the issue here is that if a directory rename
> wants to rename NEWFILE -> ALTERNATE_NEWFILE, but there is another
> directory rename on the other side of history that wants to rename
> ANOTHER_FILE -> NEWFILE, then we run into problems and have to turn
> off the NEWFILE -> ALTERNATE_NEWFILE.  This check here is all about
> this case.
> 
> To see why this is the problematic setup...
> 
> Now a conflict_info
> stores information about the OIDs and modes for all three sides of the
> merge (i.e. both sides of the merge and the base).  Whenever a rename
> is processed, we have to update this map, because the rename makes the
> conflict_info now apply to a different path.  In the simple cases, the
> conflict_info from the source path needs to be merged with the
> conflict_info for the target path, and the source path's conflict_info
> needs to be marked as null (literally setting the .is_null field to
> 1).  rename/rename and such can make this a bit more complicated.

Ah, I think I was missing this part. The intention is that processing
one side in this way (and thus modifying its conflict_info) would not
affect the processing of any other sides, but there is a bug that makes
it not so. (And the intention is not, say, when processing all sides,
to write the output in a new data structure so that the result is the
same no matter the order.)

So I think the answer to my question is: no, we do not want to be able
to rename two different files on different sides to the same filename
through any convoluted means, and if that happens, it's a bug.

[snip illustration of what happens in either merge order]

> To avoid this order dependence, and the weird multiple-renaming of a
> single path, we just want to turn off directory renames when the
> source of a directory rename on one side is the target of a directory
> rename on the other.  That's what this patch does.
> 
> 
> Does that help?  Or did I make it more confusing?

I think that helped, thanks.
