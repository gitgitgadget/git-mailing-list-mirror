Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C366CC00523
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 05:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9081A218AC
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 05:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgAEFdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 00:33:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53722 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAEFdM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 00:33:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so11810972wmc.3
        for <git@vger.kernel.org>; Sat, 04 Jan 2020 21:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/2lxZR8HIp8P743ICME6i1h0JnKq7u/eBkXlGx6/QY=;
        b=kAwBCmicHtN2Orzj7H4j9zPe9xozElVKW/1wgzgunH6XDFxkNNagcPUSSaiXj0ow/k
         bTx63AuxeUY/s52mKpMGqCQ3IZaEHL6gUvHGJPCuzhJBpQGqztUmsoV70IhQvnwwmvqF
         76uX2LW9klw9vzHpoekotIgMJ+6zeKhybtvyr5WuNEVju4eywsygspVkVBk6ruimYChH
         zx1bNxg5WHeHFWnpAFvC3wsW554vQCV2hTUT7ZhYJipJDvj15N58+m2oznL+ucnK6uQ8
         MeSXFgDPkTDverkRFhwiL+Q6tnqo2LzhMVAi4m+K0jNIS4hHcUY5M8MZJy5PmoAwp0i4
         04Yg==
X-Gm-Message-State: APjAAAULAHP0NlHhCxJMSB4owb/UbyrGYu9L1n1mG1gTe9wpDb6cyPzk
        wuRdL0NNrobq097ITIxE2Z54OyPkIHdr4kxom5yp0Pxk
X-Google-Smtp-Source: APXvYqzXIQbCAFXFRIctMMP2J1tz/a60f+wBYQFGzHIPqi2WpVzp1nm8PeIzG2vkdZflgliQfksApy8ReKRF/z2exbo=
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr26895836wma.84.1578202388952;
 Sat, 04 Jan 2020 21:33:08 -0800 (PST)
MIME-Version: 1.0
References: <20191214161438.16157-1-me@yadavpratyush.com> <20191214161438.16157-2-me@yadavpratyush.com>
 <CAPig+cRL5w7azdALeBKKisTZwjgU6QhBqJRzQqDENjYiaTT0oA@mail.gmail.com>
In-Reply-To: <CAPig+cRL5w7azdALeBKKisTZwjgU6QhBqJRzQqDENjYiaTT0oA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Jan 2020 00:32:57 -0500
Message-ID: <CAPig+cT9z5HQqbyFKpb0sQ7Hh=hbcu8TwNdN1smK74HtLzw1cg@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree: delete branches auto-created by 'worktree add'
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 4, 2020 at 4:47 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> On 27/12/19 06:05AM, Eric Sunshine wrote:
> > On Sat, Dec 14, 2019 at 11:16 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > > Remove that branch when removing the worktree. To make sure no commits
> > > are lost, the branch won't be deleted if it has moved.
> >
> > My knee-jerk reaction upon reading the first sentence of this
> > paragraph was that this is a significant and undesirable behavior
> > change, however, the second sentence helps to allay my fears about it.
> > It's possible, I suppose, that there is some existing tooling
> > somewhere which relies upon the current behavior, but it's hard to
> > imagine any good reason to do so.
>
> It is possible that some script somewhere does
>
>  git worktree add foo
>  do_something # doesn't move the branch
>  git worktree remove foo
>  git branch -d foo
>
> Branch deletion would fail here, which might be considered as an error
> by the script. Not sure how common that would be though.

Good point. That's a quite believable scenario for a scripting case.
Even if the script itself doesn't check for an error from git-branch,
people could get annoyed if their scripts suddenly start complaining
"error: branch 'foo' not found". So, that's a genuine concern.

> > However, there is a rather serious flaw in the implementation. My
> > expectation is that it should only automatically delete a branch if
> > the branch creation was inferred; it should never automatically delete
> > a branch which was created explicitly. You kind of have this covered
> > (and even have a test for it), but it doesn't work correctly when the
> > user explicitly requests branch creation via -b/-B and the branch name
> > matches the worktree name. For instance:
> >
> >   git worktree add -b foo foo
> >   git worktree remove foo
> >
> > incorrectly automatically removes branch "foo" even though the user
> > requested its creation explicitly.
>
> Thanks for pointing it out. Will fix.

Note that this almost certainly deserves an extra test in t2403 since
the tests added by v1 didn't catch this problem.

> > Subjectively, it seems more natural to fully discuss automatic branch
> > removal here rather than referring to the discussion of "worktree
> > add".
>
> I considered doing this but then left that part in 'add' because the
> conditions in which the branch is auto deleted are described pretty well
> in add's documentation. Will move it to 'remove'.

In retrospect, I don't feel strongly about it one way or the other. It
just surprised me to find it discussed under "add" on my first
read-through. And if you do patch "prune" to also auto-remove an
auto-created branch, then "add" might be the better place for the
discussion anyhow.

> > A bit of bikeshedding regarding the filename: "auto_created" is rather
> > unusual. Most names in the .git hierarchy are short and sweet. Also,
> > with the exception of ORIG_HEAD and FETCH_HEAD, all other multi-word
> > filenames seem to use hyphen rather than underscore, which suggests
> > "auto-created" would be a better choice. However, I'd probably drop
> > the hyphen altogether. Finally, "auto_created", alone, does not
> > necessarily convey that the branch was auto-created; someone could
> > misinterpret it as meaning the worktree itself was auto-created, so I
> > wonder if a better name can be found.
>
> Any suggestions? Does "implicitbranch"/"implicit-branch" sound any
> better? How about "branch-auto-created-at"? It is very clear but is a
> mouthful.

Taking into account the suggestion from my review that you likely also
will need to store in this file the name of the auto-created branch
(not just the original OID of that branch), then the nature of this
file changes a bit, which might help suggest a better name.
"implicitbranch" and "implicit-branch" are not bad, though a bit of a
mouthful. What about "autobranch"?

> > A bigger question, though, is whether we really want to see new files
> > like this springing up in the .git/worktrees/<id>/ directory for each
> > new piece of metadata which belongs to a worktree. I ask because this
> > isn't the first such case in which some additional worktree-specific
> > metadata was proposed (see, for instance, [1]). So, I'm wondering if
> > we should have a more generalized solution, such as introducing a new
> > file which can hold any sort of metadata which comes along in the
> > future. In particular, I'm thinking about a file containing an
> > extensible set of "key: value" tuples, in which case the "auto
> > created" metadata would be just one of possibly many keys.
>
> Do you worry that the number of metadata files might grow to be too
> large? I can't say how worktrees will grow in the future, but right now
> there are 4 metadata files ('commondir', 'gitdir', 'HEAD', 'ORIG_HEAD').
> So, not a lot.

I'm not particularly worried about the number of files. A couple
thoughts I had in mind are: (1) other tools or non-canonical Git
implementations (jgit, libgit, etc.) may be poking around inside the
.git/worktrees/<id>/ directory, and (2) the information represented by
this new file may deserve inclusion in the output of "git worktree
list --porcelain".

It was #1, in particular, I think, which got me thinking of having a
standardized format (i.e. extensible "key: value" list) for worktree
metainfo added in the future. It would require a one-time cost for
each tool/library to implement, and would then effectively be free as
more metainfo is added to the worktree. Compare that with having to
write a reader/parser for each new metainfo file added (not that these
files are terribly difficult to parse).

Similarly, a standardized format simplifies #2, extending "git
worktree list --porcelain" to output additional metainfo.

By the way, I wouldn't mind seeing "git worktree list --porcelain"
extended to output this new information, but I don't insist upon it as
a requirement of this patch; it can easily be done later if the need
arises. (In fact, the --porcelain documentation is so woefully lacking
and under-specified that it needs an overhaul, which I think deserves
a patch series of its own, thus is another reason I don't really
expect/want to see that change made by this patch.)

> I chose to add a new file because from what I have noticed, Git keeps a
> lot of metadata in files like this (HEAD, refs, etc). Do other
> subsystems use a key-value store? What problems did they face?
>
> I'd prefer to not take on this feature (since I expect it to be a lot of
> work), but if there are strong opinions on using a key-value store then
> I guess I'll bite the bullet.

I brought up the idea of a standardized extensible "key: value" store
because, having that older email thread in mind, it was the first
thought which popped into my mind when I saw this patch introducing a
new file in .git/worktrees/<id>/. However, one can make a good
argument that Git already has such a standard, and that that standard
is simply using individual files like "HEAD", "gitdir", "commondir",
etc. So, I think I'm pretty comfortable with the idea of storing this
information in a new file as this patch does. After all, there's
plenty of precedent in Git for doing it that way.

> > > +    if (auto_create) {
> > > +        fd = xopen(sb.buf, O_WRONLY | O_CREAT | O_TRUNC, 0666);
> > > +        get_oid("HEAD", &oid);
> >
> > Unless I'm mistaken, this is just wrong. You're grabbing the OID of
> > HEAD from the worktree in which "worktree add" is being invoked,
> > however, if the new branch name is DWIM'd from an existing
> > tracking-branch, then the OID should be that of the tracking-branch,
> > not HEAD of the current worktree. So, you should be using the OID
> > already looked up earlier in the function, 'commit->object.oid', which
> > should be correct for either case.
>
> Oops! Thanks for pointing it out. Will fix.

This deserves a new test in t2403, as well (or perhaps two new tests
since there are a couple different ways the starting OID can be
DWIM'd, if I'm reading the code correctly).

> > By the way, this suffers from the problem that if "git worktree add
> > foo" fails for some reason, such as because path "foo" already exists,
> > then the new branch will _not_ be cleaned up automatically since that
> > failure will happen before "auto_created" is ever created (among other
> > reasons). But that's not a new issue; it's an existing flaw of
> > "worktree add" not cleaning up a branch it created before it discovers
> > that it can't actually create the target directory for some reason, so
> > I wouldn't expect you to fix that problem with this submission. (I'm
> > just mentioning it for completeness.)
>
> I'll see if I can come up with a fix for this as a follow-up patch.

If fixing this ends up being more involved than a relatively minor
change -- and I think it will be quite a bit more involved due to all
the die()ing going on inside add_worktree() -- then I could easily see
(and probably would prefer) it being a separate patch series (since
the changes made by the patch under discussion are already
sufficiently involved as to eat up a good deal of reviewer time).

> > > +    git_path_buf(&sb, "worktrees/%s/auto_created", wt->id);
> > > +    if (file_exists(sb.buf)) {
> > > +        strbuf_read_file(&hex, sb.buf, 0);
> >
> > You can avoid an unnecessary race condition here by dropping the
> > file_exists() call altogether and just checking the return code of
> > strbuf_read_file() -- which you should probably be doing anyhow. If
> > strbuf_read_file() returns a non-negative value, then you know it
> > exists, so file_exists() is redundant.
>
> Will fix. Though I don't see how it would be a "race condition". Is
> file_exists() asynchronous in some way? Otherwise, how would a race
> happen and between what?

I think I was remembering an earlier[1] issue with someone running a
bunch of git-worktree commands in parallel and encountering races, but
that shouldn't apply here. Still, the code will be cleaner by dropping
file_exists() altogether.

[1]: https://lore.kernel.org/git/cover.1550508544.git.msuchanek@suse.de/T/

> > > +        if (strcmp(hex.buf, oid_to_hex(&oid)) == 0)
> > > +            delete_auto_created = 1;
> >
> > I was wondering if it would be more semantically correct to parse
> > 'hex' into an 'oid' and compare them with oidcmp() rather than doing a
> > string comparison of the hex values (though I'm not sure it will
> > matter in practice).
>
> Since I haven't spent too much time in the Git internals, the string
> representation feels more natural to me. And that's why I went this way
> subconsciously. While I don't mind either, I wonder if it would make a
> difference in practice. Anyway, if you have a preference for the other
> way round, I'll trust your gut feeling.

It may not matter in practice, but having considered it further, I
really would prefer it to be semantically correct by comparing the
OIDs directly rather than the string representations. With the process
underway of updating Git to be able to work with multiple hash
functions (and moving away from SHA-1), making use of get_oid_hex()
and oideq() to perform this comparison may make the job of auditing
the code for multi-hash-function friendliness easier.

> > However, I don't think it is correct to use 'wt->id' here as the
> > branch name since there is no guarantee that the <id> in
> > .git/worktrees/<id>/ matches the branch name with which the worktree
> > was created. For instance:
> >
> >   git worktree add foo/bar existing-branch
> >   git worktree add baz/bar
> >
> > will, due to name conflicts, create worktree metadata directories:
> >
> >   .git/worktrees/bar
> >   .git/worktrees/bar1
> >
> > where the first is associated with branch "existing-branch", and the
> > second is associated with new branch "bar". When you then invoke "git
> > worktree remove baz/bar", it will try removing a branch named "bar1",
> > not "bar" as intended. To fix this, I think you need to record the
> > original auto-created branch name in the "auto_created" metadata file
> > too, not just the OID.
>
> Interesting! Didn't think of a situation like this. Thanks for pointing
> it out. Will fix.

Definitely deserves a test in t2403.

> > > +test_expect_success 'remove auto-created branch' '
> > > +    (
> > > +        git worktree add to-remove &&
> > > +        git worktree remove to-remove &&
> > > +        git branch -l to-remove >branch_list &&
> > > +        test_line_count = 0 branch_list
> > > +    )
> > > +'
> >
> > I don't think there is any need for this test to be run in a subshell,
> > so you can drop the enclosing '(' and ')'.
>
> I was following the pattern in the two tests above. Will drop the
> parentheses.

The existing tests use a subshell (the parentheses) because they 'cd'
around, and use of a subshell ensures that subsequent tests won't
adversely run in the wrong directory if the test fails for some reason
(since the affect of the 'cd' does not last beyond the end of the
subshell). As long as you're not cd'ing around (or doing a few other
questionable things), there's no need for the subshell.

> > > +test_expect_success 'do not remove a branch that was not auto-created' '
> > > +    (
> > > +        git worktree add -b new_branch to-remove &&
> >
> > Nit: The inconsistent mix of underscore and hyphen in names is odd.
> > Perhaps settle on one or the other (with a slight preference toward
> > hyphen).
>
> I'll change 'new_branch' to 'new-branch'.

As mentioned above, also add a test in which the explicitly-created
new branch has the same name as the worktree itself (since that case
was implemented wrong in v1 but the tests didn't catch the failure).

> I'll send out the v2 as soon as I can. Thanks.

There's no rush. Let's get the details and any lingering questions
worked out before subjecting reviewers to a new version (especially,
as my review time is somewhat limited these days).
