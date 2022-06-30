Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1C4C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 00:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiF3AFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 20:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiF3AFh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 20:05:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CD4248EF
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 17:05:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id mf9so35804655ejb.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 17:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZjYFUli0XMKEpWikpHTELTHjrh+6z8838wpbeoNhzI=;
        b=mwSOIs2rnkQRPT0po2dX6IiZU3zrvZ+CA3LUjNUyWDfIYUJ0H3r1KMRYqUAudTQvjX
         XKgv4e4PtDJOPlphgS2QXAr5kIVywXWI3V0ycLgoJEyMWdiCk9YbDYQ07f+5a+tl5owX
         KHkmYtp5gRhiBLstgLwooYMqHbSSRnagxGyjGmV+Ccdg079gbMWuOAWJ2YztCciJXMsx
         gZ/mgP/eVuLO2LyQlvRVoqhHgA1HFSeaM5i53mCvaa9nUdMIfy70ALLyX6cK8VrEkG3n
         C2EKiqHPwlZN6Hel7gpQuLsMlzgLCJXmRpNYPHuQAfcSuDnAsGj8zXVshMdkCEo9f0Aa
         BwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZjYFUli0XMKEpWikpHTELTHjrh+6z8838wpbeoNhzI=;
        b=YENOK8tIjzJUdrHk14SDmgf6tmLY2bkpYztUSoWVdQGMrGNA8wxJY+aVb2hNIO+Nrr
         RBErynpYl1bbp+gNAzg9TAXHaJ1hGAtfuSCzdRTMjgBw1JNGYYFh5Y69dfuQ9tEuTp1/
         j5eKnvqi7vHO+QJzMSWqLqvnrzRwlZBtq/eZ6hxFZi2fvJEbl2stG/hT0VWBTsg36rs5
         vj2wIfoDh8G3wnRnq7hew1lHycgILLF+qMTc2DuiFeRYbccyVXN6wyuAYZBawIUV42Yz
         LgL4vXuE2b+PkOFZ03+G/4UaZ+jmeqdWBG3Av6Vcz+9suLJPjapIfNOMFWdZvSsRGi91
         WgNw==
X-Gm-Message-State: AJIora9OlTrPFjj4bEqvi/pvhoFY7dmIy3k3J+X1qiV6i4ag5BKEpjeP
        sTlOJ8SNuyZPXzWG9Xvgz50qOB4bQ+3e+0svChE=
X-Google-Smtp-Source: AGRyM1vG5gyAJRhaC9CBBgufqizEcRtI9b233YMKoo9m1yUU+pJ3rpsR9bBHnP0KvYR1JnP8oh6s44FNiHoLKeJq/Gc=
X-Received: by 2002:a17:907:2ccb:b0:72a:430d:17a9 with SMTP id
 hg11-20020a1709072ccb00b0072a430d17a9mr3549721ejc.613.1656547534475; Wed, 29
 Jun 2022 17:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <bb2badccb71d76efe0e47431246376b1e7016b05.1655871652.git.gitgitgadget@gmail.com>
 <20220627184744.1361309-1-jonathantanmy@google.com>
In-Reply-To: <20220627184744.1361309-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Jun 2022 17:05:22 -0700
Message-ID: <CABPp-BG8r4zUOKZ+DzZOdsEwr+580cK=SvZ4n_euPOV1Nocu+A@mail.gmail.com>
Subject: Re: [PATCH 3/3] merge-ort: fix issue with dual rename and add/add conflict
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 27, 2022 at 11:47 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > The testcases added in t6423 a couple commits ago are slightly different
> > but similar in principle.  They involve a similar case of paired
> > renaming but instead of A/ -> B/ and B/ -> C/, the second side renames
> > a leading directory of B/ to C/.
>
> Hmm...one side moved sub1 -> sub3 and the other moved sub2 from the root
> to under sub1, right? So it's more like A/ -> B/ and C/ -> A/C/.

Hmm, maybe I should have been more explicit in my mapping:
   A = sub2
   B = sub1/sub2
   leading directory of B = sub1
   C = sub3

> > And both sides add a new file
> > somewhere under the directory that the other side will rename.
>
> Rename or move, I think.

I'm confused; I don't understand what this comment means.  Renames
tend to be created using "git mv", before or after making content
changes, so to me a file being renamed or a file being moved to a
different location are synonymous.  What distinction are you making
between renames and moves?

> > While
> > the new files added start within different directories and thus could
> > logically end up within different directories, it is weird for a file
> > on one side to end up where the other one started and not move along
> > with it.  So, let's just turn off directory rename detection in this
> > case as well.
>
> Makes sense.
>
> > diff --git a/merge-ort.c b/merge-ort.c
> > index fa6667de18c..5bcb9a4980b 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -2292,9 +2292,13 @@ static char *check_for_directory_rename(struct merge_options *opt,
> >       struct strmap_entry *rename_info;
> >       struct strmap_entry *otherinfo = NULL;
> >       const char *new_dir;
> > +     int other_side = 3 - side_index;
> >
> > +     /* Cases where there is no new path, so we return NULL */
>
> What do you mean by "no new path"?

Hmm, perhaps I should change this to:

/* Cases where we don't have or don't want a directory rename for this
path, so we return NULL */

The purpose of this function is to check whether a given path would be
modified by directory renaming to get a new path.  So, "no new path"
means we don't have an applicable directory rename or don't want to
use it.

> >       if (strmap_empty(dir_renames))
> >               return new_path;
> > +     if (strmap_get(&collisions[other_side], path))
> > +             return new_path;
>
> So as far as I understand, collisions here, for a given side, is a map.
> The map's keys are all the filenames of added and renamed files (I'm
> assuming that's what 'A' and 'R' are) from that side after any directory
> moves on the other side are applied. So, for example, if we add "foo/a"
> on side A and rename "foo/" to "bar/" on side B, then side A's collision
> map would have a key "bar/a". So I'm not sure if "collision" is the
> right name here, but the existing code already uses it so I'll leave it
> be.

Let's take your example a bit further, to discuss the original kind of
usecase that "collisions" was written for.  In addition to adding
"foo/a" on side A, we also add "foo2/a" and "foo3/a".  And then in
addition to renaming "foo/" to "bar/" on side B, we also rename
"foo2/" to "bar/" and "foo3/" to "bar/", thus merging all of foo/,
foo2/, and foo3/ into a single directory named bar/.  If the files in
foo/, foo2/, and foo3/ on side B were all unique, you can see how
there'd be no problem merging these directories together.  The problem
only comes at merge time when you attempt to apply the directory
renames from side B to the new files on side A.  That's when you get
collisions, in this case three files that would be named bar/a.

Checking for such collisions was the purpose of the "collisions"
metadata, so I think the name is fitting.  The only problem is that
we're reusing that data now for a slightly different purpose, though I
think it's still "collision-y".

> It makes sense that this situation (of side A having "bar/a" because
> side B renamed "foo/" to "bar/", and at the same time, side B adds its
> own "bar/a") is weird, as stated in the commit message, so I don't mind
> disabling checking for directory rename in this case.  However, in
> theory, I don't see how disabling this check would fix anything, since
> the bug seems to be about two different files on different sides being
> renamed to the same filename through some convoluted means. (Unless this
> is the only convoluted means to do it, and disabling it means that the
> bug wouldn't occur.)

Hmm...let me see if I can explain this a different way.

The short version of the issue here is that if a directory rename
wants to rename NEWFILE -> ALTERNATE_NEWFILE, but there is another
directory rename on the other side of history that wants to rename
ANOTHER_FILE -> NEWFILE, then we run into problems and have to turn
off the NEWFILE -> ALTERNATE_NEWFILE.  This check here is all about
this case.

To see why this is the problematic setup...

The primary data structure in merge-ort is opt->priv->paths, a strmap
which maps: (path involved in the merge) -> (conflict_info).
(Technically, it could have a merged_info instead of a conflict_info
if the file was trivially resolvable early on but since merged_info is
the first entry in a conflict_info, logically it can still be thought
of as a conflict_info just with less data.).  Now a conflict_info
stores information about the OIDs and modes for all three sides of the
merge (i.e. both sides of the merge and the base).  Whenever a rename
is processed, we have to update this map, because the rename makes the
conflict_info now apply to a different path.  In the simple cases, the
conflict_info from the source path needs to be merged with the
conflict_info for the target path, and the source path's conflict_info
needs to be marked as null (literally setting the .is_null field to
1).  rename/rename and such can make this a bit more complicated.

Normally, directory renames would actually be a simpler case for this
merging of conflict_info structs rather than a more complicated case.
There cannot be a directory rename if the directory exists on both
sides, so we don't need to worry about there already being a file on
the other side whose conflict_info we need to merge with the source
conflict_info.  So, the code just added an assertion that there wasn't
one.  The problem is, that _another_ directory rename for the other
side of history can move a file into the way of where our directory
rename wants to operate on.  Let's jump into the example testcase I
added to make this more concrete:

   #   Commit O: sub1/file,                 sub2/other
   #   Commit A: sub3/file,                 sub2/{other, new_add_add_file_1}
   #   Commit B: sub1/{file, newfile}, sub1/sub2/{other, new_add_add_file_2}
   #
   #   In words:
   #     A: sub1/ -> sub3/, add sub2/new_add_add_file_1
   #     B: sub2/ -> sub1/sub2, add sub1/newfile, add
sub1/sub2/new_add_add_file_2

Here, the sub2/sub1/sub2/ rename on sideB will rename A's
sub2/new_add_add_file to sub1/sub2/new_add_add_file, which is at the
same location as B's sub1/sub2/new_add_add_file (and which A's sub1/
-> sub3/ directory rename would normally operate on).

Given our opt->priv->paths data structure, if we wanted to let both
directory renames take effect, then the order would matter:

* If the sub1/ -> sub3/ directory rename is applied first, then:
  * B's sub1/sub2/new_add_add_file gets renamed to sub3/sub2/new_add_add_file
  * sub1/sub2/new_add_add_file is marked as .is_null=1
  * A's sub2/new_add_add_file gets renamed to
sub1/sub2/new_add_add_file (which was already marked as null)

This set of steps seems to trigger the "error: cache entry has null
sha1" fatal error I mentioned earlier.  In contrast, if we take the
other order:

* If the sub2/ -> sub1/sub2/ rename is applied first, then:
  * A's sub2/new_add_add_file gets renamed to sub1/sub2/new_add_add_file
  * the conflict_info for the two sub1/sub2/new_add_add_file's are now merged
  * the sub1/ -> sub3/ directory rename is applied to move this file
to sub3/sub2/new_add_add_file

This second order may not sound so bad.  And, in fact, you can get
this behavior simply by relaxing (or commenting out) the assertion
Glen reported hitting.  However, that results in making the merge have
a fatal error when you reverse its direction (i.e. when swapping HEAD
and MERGE_HEAD), and seems somewhat confusing to me given that A's
sub2/new_add_add_file was renamed twice, going against the general
"avoid-mutiply-transitive-renames" rule employed elsewhere in
directory rename detection.

To avoid this order dependence, and the weird multiple-renaming of a
single path, we just want to turn off directory renames when the
source of a directory rename on one side is the target of a directory
rename on the other.  That's what this patch does.


Does that help?  Or did I make it more confusing?
