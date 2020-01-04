Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05F6C32771
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 21:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6210124653
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 21:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgADVrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:47:12 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:51651 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgADVrM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 16:47:12 -0500
X-Originating-IP: 157.45.75.168
Received: from localhost (unknown [157.45.75.168])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 0410640005;
        Sat,  4 Jan 2020 21:47:07 +0000 (UTC)
Date:   Sun, 5 Jan 2020 03:17:03 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] worktree: delete branches auto-created by 'worktree
 add'
Message-ID: <20200104214703.5su6h4edzkwjv2kx@yadavpratyush.com>
References: <20191214161438.16157-1-me@yadavpratyush.com>
 <20191214161438.16157-2-me@yadavpratyush.com>
 <CAPig+cRL5w7azdALeBKKisTZwjgU6QhBqJRzQqDENjYiaTT0oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRL5w7azdALeBKKisTZwjgU6QhBqJRzQqDENjYiaTT0oA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Thanks for the review.

On 27/12/19 06:05AM, Eric Sunshine wrote:
> (Sorry for taking so long to review this patch; it ended up being a
> quite lengthy review.)

No problem :-). And sorry for being so late to reply.
 
> On Sat, Dec 14, 2019 at 11:16 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > When no branch name is supplied to 'worktree add', it creates a new
> > branch based on the name of the directory the new worktree is located
> > in. But when the worktree is later removed, that created branch is left
> > over.
> 
> This is describing the existing (intentional) behavior but doesn't
> explain why this might be annoying or problematic. To help sell the
> patch, it might make sense to say something about how the behavior can
> trip up newcomers to git-worktree, leaving them to wonder why they are
> accumulating so many branches that they weren't aware they created. A
> comment about why you think "git worktree add -d foo" is not a viable
> way to side-step the creation of unwanted branches might also be
> worthwhile. For instance, you might say something about how newcomers
> might not read the documentation thoroughly enough to know about
> --detach or to understand what it means; indeed, some newcomers to Git
> presumably have trouble with the concept of a detached HEAD and may
> find it scary.

Will do.
 
> > Remove that branch when removing the worktree. To make sure no commits
> > are lost, the branch won't be deleted if it has moved.
> 
> My knee-jerk reaction upon reading the first sentence of this
> paragraph was that this is a significant and undesirable behavior
> change, however, the second sentence helps to allay my fears about it.
> 
> It's possible, I suppose, that there is some existing tooling
> somewhere which relies upon the current behavior, but it's hard to
> imagine any good reason to do so. (That is, "git worktree add foo &&
> git worktree remove foo" is just a glorified and expensive way to say
> "git branch foo".) So, I don't look upon this change with disfavor; it
> could well be beneficial for newcomers, and perhaps a nice convenience
> in general.

It is possible that some script somewhere does 

  git worktree add foo
  do_something # doesn't move the branch
  git worktree remove foo
  git branch -d foo

Branch deletion would fail here, which might be considered as an error 
by the script. Not sure how common that would be though.
 
> However, there is a rather serious flaw in the implementation. My
> expectation is that it should only automatically delete a branch if
> the branch creation was inferred; it should never automatically delete
> a branch which was created explicitly. You kind of have this covered
> (and even have a test for it), but it doesn't work correctly when the
> user explicitly requests branch creation via -b/-B and the branch name
> matches the worktree name. For instance:
> 
>     git worktree add -b foo foo
>     git worktree remove foo
> 
> incorrectly automatically removes branch "foo" even though the user
> requested its creation explicitly.

Thanks for pointing it out. Will fix.
 
> Another big question: Should an automatically-created branch be
> deleted automatically when a worktree is pruned? That is, although
> this sequence will remove an automatically-created branch:
> 
>     git worktree add foo
>     git worktree remove foo
> 
> the current patch will not clean up the branch given this sequence:
> 
>     git worktree add foo
>     rm -rf foo
>     git worktree prune

I see no problem with doing the same thing in 'prune' too.
 
> Either way, it might be worthwhile to update the documentation to mention this.

I'll see if I can make 'prune' delete the branch too. Otherwise, I'll 
mention it in the documentation.
 
> > An example use case of when something like this is useful is when the
> > user wants to check out a separate worktree to run and test on an older
> > version, but don't want to touch the current worktree. So, they create a
> > worktree, run some tests, and then remove it. But this leaves behind a
> > branch the user never created in the first place.
> 
> The last sentence isn't exactly accurate. The user _did_ create the
> branch. It would be more accurate to say "...the user did not
> necessarily _intentionally_ create..." or something like that.

Yes, that was the intention of the sentence. Will fix.
 
> > So, remove the branch if nothing was done on it.
> 
> By the way, the ordering of the commit message paragraphs is a bit
> off; it somewhat tries to justifies the change before explaining what
> the problem is. I'd suggest this order:
> 
>     - describe current behavior
>     - explain why current behavior can be undesirable in some circumstances;
>       cite your example use-case here, perhaps
>     - describe how this patch improves the situation
> 
> The two paragraphs which talk about "remove the branch" are just
> repeating one another. I would drop one of them and keep the other as
> the final bullet point of the suggested commit message order.

Will fix.
 
> > Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> > ---
> > diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> > @@ -73,8 +73,9 @@ If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
> >  doesn't exist, a new branch based on HEAD is automatically created as
> > -if `-b <branch>` was given.  If `<branch>` does exist, it will be
> > -checked out in the new worktree, if it's not checked out anywhere
> > +if `-b <branch>` was given.  In this case, if `<branch>` is not moved, it is
> > +automatically deleted when the worktree is removed.  If `<branch>` does exist,
> > +it will be checked out in the new worktree, if it's not checked out anywhere
> 
> I found it confusing to find automatic branch deletion described here
> under the "worktree add" command...
> 
> > @@ -108,6 +109,10 @@ Remove a working tree. Only clean working trees (no untracked files
> > +Removing a working tree might lead to its associated branch being deleted if
> > +it was auto-created and has not moved since. See `add` for more information on
> > +when exactly this can happen.
> 
> Subjectively, it seems more natural to fully discuss automatic branch
> removal here rather than referring to the discussion of "worktree
> add".

I considered doing this but then left that part in 'add' because the 
conditions in which the branch is auto deleted are described pretty well 
in add's documentation. Will move it to 'remove'.
 
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > @@ -35,6 +35,7 @@ struct add_opts {
> > +static int auto_create;
> 
> I think this variable belongs in the 'add_opts' structure rather than
> being file-global.

Ok.
 
> > @@ -270,11 +271,13 @@ static int add_worktree(const char *path, const char *refname,
> > -       int len, ret;
> > +       int len, ret, fd;
> > +       struct object_id oid;
> > +       char *hex;
> 
> Rather than declaring 'fd', 'oid', and 'hex' here, how about declaring
> them in the scope of the "if (auto_create) {" conditional below, which
> is the only place they are used?

Will do. Some other projects I've contributed to in the past insist on 
declaring everything up-front, so I played it safe and put them here.
 
> > @@ -353,6 +356,18 @@ static int add_worktree(const char *path, const char *refname,
> > +       strbuf_reset(&sb);
> > +       strbuf_addf(&sb, "%s/auto_created", sb_repo.buf);
> 
> Why aren't these two lines inside the "if (auto_create) {" conditional
> below? They seem to be used only for that case.

Yes, they should be. Will fix.
 
> I think this new worktree metadata file warrants a documentation
> update. In particular, gitrepository-layout.txt talks about
> worktree-specific metadata files, and the "Details" section of
> git-worktree.txt may need an update.

Will fix.
 
> A bit of bikeshedding regarding the filename: "auto_created" is rather
> unusual. Most names in the .git hierarchy are short and sweet. Also,
> with the exception of ORIG_HEAD and FETCH_HEAD, all other multi-word
> filenames seem to use hyphen rather than underscore, which suggests
> "auto-created" would be a better choice. However, I'd probably drop
> the hyphen altogether. Finally, "auto_created", alone, does not
> necessarily convey that the branch was auto-created; someone could
> misinterpret it as meaning the worktree itself was auto-created, so I
> wonder if a better name can be found.

Any suggestions? Does "implicitbranch"/"implicit-branch" sound any 
better? How about "branch-auto-created-at"? It is very clear but is a 
mouthful.
 
> A bigger question, though, is whether we really want to see new files
> like this springing up in the .git/worktrees/<id>/ directory for each
> new piece of metadata which belongs to a worktree. I ask because this
> isn't the first such case in which some additional worktree-specific
> metadata was proposed (see, for instance, [1]). So, I'm wondering if
> we should have a more generalized solution, such as introducing a new
> file which can hold any sort of metadata which comes along in the
> future. In particular, I'm thinking about a file containing an
> extensible set of "key: value" tuples, in which case the "auto
> created" metadata would be just one of possibly many keys. For
> instance:

Do you worry that the number of metadata files might grow to be too 
large? I can't say how worktrees will grow in the future, but right now 
there are 4 metadata files ('commondir', 'gitdir', 'HEAD', 'ORIG_HEAD'). 
So, not a lot.

I chose to add a new file because from what I have noticed, Git keeps a 
lot of metadata in files like this (HEAD, refs, etc). Do other 
subsystems use a key-value store? What problems did they face?
 
>     branch-auto-created-at: deadbeef
> 
> The above is a genuine question. I'm not demanding that this patch
> implement it, but I think it deserves discussion and thought before
> making a decision.

I'd prefer to not take on this feature (since I expect it to be a lot of 
work), but if there are strong opinions on using a key-value store then 
I guess I'll bite the bullet.
 
> [1]: http://public-inbox.org/git/CAPig+cRGMEjVbJZKXOskN6=5zchisx7UuwW9ZKGwoq5GQZQ_rw@mail.gmail.com/
> 
> > +       /* Mark this branch as an "auto-created" one. */
> 
> This comment doesn't really say anything which the code itself isn't
> already saying (especially if you move the strbuf_addf() call inside
> the conditional), so the comment could be dropped.

Ok.
 
> > +       if (auto_create) {
> > +               fd = xopen(sb.buf, O_WRONLY | O_CREAT | O_TRUNC, 0666);
> > +               get_oid("HEAD", &oid);
> 
> Unless I'm mistaken, this is just wrong. You're grabbing the OID of
> HEAD from the worktree in which "worktree add" is being invoked,
> however, if the new branch name is DWIM'd from an existing
> tracking-branch, then the OID should be that of the tracking-branch,
> not HEAD of the current worktree. So, you should be using the OID
> already looked up earlier in the function, 'commit->object.oid', which
> should be correct for either case.

Oops! Thanks for pointing it out. Will fix.
 
> > +               hex = oid_to_hex(&oid);
> > +               write_file_buf(sb.buf, hex, strlen(hex));
> > +
> > +               if (close(fd))
> > +                       die(_("could not close '%s'"), sb.buf);
> > +       }
> 
> Is there a reason you're creating the file in this rather manual
> fashion rather than using write_file() as is already heavily used in
> this code for creating all the other files residing in
> .git/worktrees/<id>/?

No particular reason. I didn't look around enough to catch the pattern 
of using write_file() for this. Will fix.
 
> This code is correctly sandwiched within the "is_junk" scope, which
> means that "auto_created" will be cleaned up automatically, along with
> other .git/worktrees/<id>/ files, if "worktree add" fails for some
> reason. Good.
> 
> >         argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
> >         argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
> > @@ -576,6 +591,8 @@ static int add(int ac, const char **av, const char *prefix)
> >                 if (run_command(&cp))
> >                         return -1;
> >                 branch = new_branch;
> > +
> > +               auto_create = 1;
> 
> Drop the unnecessary blank line.
> 
> By the way, this suffers from the problem that if "git worktree add
> foo" fails for some reason, such as because path "foo" already exists,
> then the new branch will _not_ be cleaned up automatically since that
> failure will happen before "auto_created" is ever created (among other
> reasons). But that's not a new issue; it's an existing flaw of
> "worktree add" not cleaning up a branch it created before it discovers
> that it can't actually create the target directory for some reason, so
> I wouldn't expect you to fix that problem with this submission. (I'm
> just mentioning it for completeness.)

I'll see if I can come up with a fix for this as a follow-up patch.
 
> > @@ -912,9 +929,10 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
> >                 OPT_END()
> >         };
> > -       struct strbuf errmsg = STRBUF_INIT;
> > +       struct strbuf errmsg = STRBUF_INIT, sb = STRBUF_INIT, hex = STRBUF_INIT;
> > -       int ret = 0;
> > +       int ret = 0, delete_auto_created = 0;
> > +       struct object_id oid;
> 
> Perhaps move the declarations of 'hex' and 'oid' into the scope where
> they are used rather than making them global to the function.

Will do.
 
> > @@ -939,6 +957,23 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
> > +       /*
> > +        * Check if we auto-created a branch for this worktree and it hasn't
> > +        * moved since. Do it before the contents of the worktree get wiped.
> > +        * Delete the branch later because it is checked out right now.
> > +        */
> 
> Good useful comment.

Thanks.
 
> > +       git_path_buf(&sb, "worktrees/%s/auto_created", wt->id);
> > +       if (file_exists(sb.buf)) {
> > +               strbuf_read_file(&hex, sb.buf, 0);
> 
> You can avoid an unnecessary race condition here by dropping the
> file_exists() call altogether and just checking the return code of
> strbuf_read_file() -- which you should probably be doing anyhow. If
> strbuf_read_file() returns a non-negative value, then you know it
> exists, so file_exists() is redundant.

Will fix. Though I don't see how it would be a "race condition". Is 
file_exists() asynchronous in some way? Otherwise, how would a race 
happen and between what?
 
> > +               get_oid(wt->id, &oid);
> > +
> 
> Drop the unnecessary blank line.
> 
> > +               if (strcmp(hex.buf, oid_to_hex(&oid)) == 0)
> > +                       delete_auto_created = 1;
> 
> I was wondering if it would be more semantically correct to parse
> 'hex' into an 'oid' and compare them with oidcmp() rather than doing a
> string comparison of the hex values (though I'm not sure it will
> matter in practice).

Since I haven't spent too much time in the Git internals, the string 
representation feels more natural to me. And that's why I went this way 
subconsciously. While I don't mind either, I wonder if it would make a 
difference in practice. Anyway, if you have a preference for the other 
way round, I'll trust your gut feeling.
 
> > +       }
> > +
> > +       strbuf_release(&sb);
> > +       strbuf_release(&hex);
> 
> Drop the unnecessary blank line.
> 
> > @@ -952,6 +987,17 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
> > +       if (delete_auto_created) {
> > +               struct child_process cp = CHILD_PROCESS_INIT;
> > +               cp.git_cmd = 1;
> > +
> > +               argv_array_push(&cp.args, "branch");
> > +               argv_array_push(&cp.args, "-d");
> > +               argv_array_push(&cp.args, wt->id);
> > +
> > +               ret |= run_command(&cp);
> > +       }
> 
> Alternately:
> 
>     argv_array_pushl(&cp.args, "branch", "-d", wt->id, NULL);

Ok.
 
> However, I don't think it is correct to use 'wt->id' here as the
> branch name since there is no guarantee that the <id> in
> .git/worktrees/<id>/ matches the branch name with which the worktree
> was created. For instance:
> 
>     git worktree add foo/bar existing-branch
>     git worktree add baz/bar
> 
> will, due to name conflicts, create worktree metadata directories:
> 
>     .git/worktrees/bar
>     .git/worktrees/bar1
> 
> where the first is associated with branch "existing-branch", and the
> second is associated with new branch "bar". When you then invoke "git
> worktree remove baz/bar", it will try removing a branch named "bar1",
> not "bar" as intended. To fix this, I think you need to record the
> original auto-created branch name in the "auto_created" metadata file
> too, not just the OID.

Interesting! Didn't think of a situation like this. Thanks for pointing 
it out. Will fix.
 
> Finally, make this code consistent with other existing similar code in
> this file by dropping the unnecessary blank lines in this hunk.

The blank lines are a personal preference for me mostly. I am not a huge 
fan of seeing large chunks of code with do blank lines in between. IMO 
it hurts readability. But, I think staying consistent with the code that 
already exists is more important. Will remove all them.
 
> > diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
> > @@ -222,4 +222,49 @@ test_expect_success 'not remove a repo with initialized submodule' '
> > +test_expect_success 'remove auto-created branch' '
> > +       (
> > +               git worktree add to-remove &&
> > +               git worktree remove to-remove &&
> > +               git branch -l to-remove >branch_list &&
> > +               test_line_count = 0 branch_list
> > +       )
> > +'
> 
> I don't think there is any need for this test to be run in a subshell,
> so you can drop the enclosing '(' and ')'.

I was following the pattern in the two tests above. Will drop the 
parentheses.
 
> I worry about using porcelain git-branch to check whether the branch
> has actually been removed. Using git-rev-parse would likely be a more
> direct and safe way to test it. For instance:
> 
>     git worktree add to-remove &&
>     git worktree remove to-remove &&
>     test_must_fail git rev-parse --verify -q to-remove
> 
> should be sufficient, I think. And, to be really thorough, you might say:
> 
>     test_might_fail git branch -D to-remove &&
>     git worktree add to-remove &&
>     git rev-parse --verify -q to-remove &&
>     git worktree remove to-remove &&
>     test_must_fail git rev-parse --verify -q to-remove
> 
> The above comments apply to the other new tests added by this patch, as well.

Will fix.
 
> > +test_expect_success 'do not remove a branch that was not auto-created' '
> > +       (
> > +               git worktree add -b new_branch to-remove &&
> 
> Nit: The inconsistent mix of underscore and hyphen in names is odd.
> Perhaps settle on one or the other (with a slight preference toward
> hyphen).

I'll change 'new_branch' to 'new-branch'.
 
> > +               git worktree remove to-remove &&
> > +               git branch -l new_branch >branch_list &&
> > +               test_line_count = 1 branch_list &&
> 
> As noted earlier, although this particular case of a branch created
> explicitly with -b works as expected by not deleting the branch, the
> similar case:
> 
>     git worktree add -b to-remove to-remove &&
> 
> will incorrectly automatically delete the branch.
> 
> > +               git branch -d new_branch &&
> > +               git branch foo &&
> > +               git worktree add to-remove foo &&
> > +               git worktree remove to-remove &&
> > +               git branch -l foo >branch_list &&
> > +               test_line_count = 1 branch_list &&
> > +               git branch -d foo &&
> > +               git branch to-remove &&
> > +               git worktree add to-remove &&
> > +               git worktree remove to-remove &&
> > +               git branch -l to-remove >branch_list &&
> > +               test_line_count = 1 branch_list &&
> > +               git branch -d to-remove
> 
> If any code above this "git branch -d" fails, then it will never get
> this far, thus won't remove "to-remove". To perform cleanup whether
> the test succeeds or fails, you should use test_when_finished()
> _early_ in the test:
> 
>     test_when_finished "git branch -d to-remove || :" &&
> 
> However, if you restructure the tests as suggested above, then you
> might be able to get away without bothering with this cleanup.
> 
> > +       )
> > +'
> 
> This test is checking three distinct cases of explicitly-created
> branches. It would make it easier to debug a failing case if you split
> it up into three tests -- one for each case.

I considered doing it, but then I thought maybe I shouldn't add so many 
tests. And since there are only 3 rather independent cases, it would not 
be that difficult to figure out which one is the culprit. Will split 
them.
 
> > +test_expect_success 'do not remove auto-created branch that was moved' '
> > +       (
> > +               git worktree add to-remove &&
> > +               cd to-remove &&
> > +               test_commit foo &&
> > +               cd ../ &&
> 
> We normally avoid cd'ing around in tests like this because it can
> cause tests following this one to run in the wrong directory if
> something above the "cd ../" fails. In this particular case, it
> doesn't matter since the entire body of this test is within a
> subshell.
> 
> However, if you take advantage of test_commits()'s -C argument, then
> you can ditch the cd's and the subshell altogether:
> 
>     test_commit -C to-remove foo &&

Ok.
 
> > +               git worktree remove to-remove &&
> > +               git branch -l to-remove >branch_list &&
> > +               test_line_count = 1 branch_list &&
> > +               git branch -D to-remove
> > +       )
> > +'

I'll send out the v2 as soon as I can. Thanks.

-- 
Regards,
Pratyush Yadav
