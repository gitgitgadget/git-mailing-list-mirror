Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C75715EAA
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.inka.de (mail.inka.de [IPv6:2a04:c9c7:0:1073:217:a4ff:fe3b:e77c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E002193
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 03:38:17 -0800 (PST)
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1r0gsy-0024iB-CI; Wed, 08 Nov 2023 12:38:16 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id B6DD3600B8; Wed,  8 Nov 2023 12:36:36 +0100 (CET)
Date: Wed, 8 Nov 2023 12:36:36 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: Error when "git mv" file in a sparsed checkout
Message-ID: <20231108113636.GT7041@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20231107130303.GS7041@raven.inka.de>
 <CABPp-BEAU8rPeNHphut0ZxcLdH0pzjh+Z_CF+rg2uhvVZoZfxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEAU8rPeNHphut0ZxcLdH0pzjh+Z_CF+rg2uhvVZoZfxg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Thanks for the reply, Elijah!

On Tue, Nov 07, 2023 at 06:21:00PM -0800, Elijah Newren wrote:
> On Tue, Nov 7, 2023 at 5:32 AM Josef Wolf <jw@raven.inka.de> wrote:
> > I have used the procedure described below for many years. In fact,
> > this procedure is part of a script which I am using for about 10 years.
> > This procedure was definitely working with git-2-25-1 and git-2.26.2.
> >
> > Now, with git-2.34.1 (on a freshly installed ubuntu-22.04), this
> > procedure fails.
> >
> > Here is what I do:
> >
> > I want to rename a file on a branch which is not currently checked out
> > without messing/touching my current working directory.
> >
> > For this, I first create a clone of the repo with shared git-directory:
> >
> >   $ SANDBOX=/var/tmp/manage-scans-X1pKZQiey
> >   $ WT=$SANDBOX/wt
> >   $ GIT=$SANDBOX/git
> >
> >   $ mkdir -p $SANDBOX
> >   $ git --work-tree $WT --git-dir $GIT clone -qns -n ~/upstream-repo $GIT
> >
> > Then, I do a sparse checkout in this clone, containing only the file
> > that is to be renamed:
> >
> >   $ cd $WT
> >   $ echo 'path/to/old-filename' >>$GIT/info/sparse-checkout
> >   $ git --work-tree $WT --git-dir $GIT config core.sparsecheckout true
> >   $ git --work-tree $WT --git-dir $GIT checkout -b the-branch remotes/origin/the-branch
> >   Switched to a new branch 'the-branch'
> >
> > Next step would be to "git mv" the file:
> >
> >   $ mkdir -p /path/to  # already exists, but should do no harm
> >   $ git --work-tree $WT --git-dir $GIT mv path/to/old-filename path/to/new-filename
> 
> sparse checkouts are designed such that only files matching the
> patterns in the sparse-checkout file should be present in the working
> tree, so renaming to a path that should not be present is problematic.
> We could possibly have "git-mv" immediately remove the path from the
> working tree (while leaving the new pathname in the index), but that's
> problematic in that users often overlook the index and only look at
> the working tree and might think the file was deleted instead of
> renamed.  Not immediately removing it is potentially even worse,
> because any subsequent operation (particularly ones like checkout,
> reset, merge, rebase, etc.) are likely to nuke the file from the
> working tree and the fact that the removal is delayed makes it much
> harder for users to understand and diagnose.
> 
> So, Stolee fixed this to make it throw an error; see
> https://lore.kernel.org/git/pull.1018.v4.git.1632497954.gitgitgadget@gmail.com/
> for details.  His description did focus on cone mode, but you'll note
> that none of my explanation here did.  The logic for making this an
> error fully applies to non-cone mode for all the same reasons.
> 
> If you want to interact with `path/to/new-filename` as a path within
> your sparse checkout (as suggested by your git-mv command), then that
> path should actually be part of your sparse checkout.  In other words,
> you should add `path/to/new-filename` to $GIT/info/sparse-checkout and
> do so _before_ attempting your `git mv` command.  If you don't like
> that for some reason, you are allowed to instead ignore the
> problematic consequences of renaming outside the sparse-checkout by
> providing the `--sparse` flag.  Both of these possibilities are
> documented in the hints provided along with the error message you
> showed below:
> 
> >   The following paths and/or pathspecs matched paths that exist
> >   outside of your sparse-checkout definition, so will not be
> >   updated in the index:
> >   path/to/new-filename
> >   hint: If you intend to update such entries, try one of the following:
> >   hint: * Use the --sparse option.
> >   hint: * Disable or modify the sparsity rules.
> >   hint: Disable this message with "git config advice.updateSparsePath false"
> >
> > This error is something I have not expected.
> >
> > Error message suggests, there already exists a file named "new-filename". This
> > is not true at all. There is no file named "new-filename" in the entire
> > repository. Not in any directory of any branch.
> 
> You are correct; the wording of the error message here is suboptimal
> and seems to have been focused more on the git-add case (the error
> message is shared by git-add, git-mv, and git-rm).  Thanks for
> pointing it out!  We could improve that wording, perhaps with
> something like:
> 
>     The following paths and/or pathspecs match paths that are
>     outside of your sparse-checkout definition, so will not be
>     updated:
> 
> Which is still slightly slanted towards git-add and git-rm cases, but
> I hope it works better than the current message.  Thoughts?

Yes, the wording was pretty much confusing me, since i could not find a file
named "new-file" anywhere in the repo.


There are more things confusing concerning sparse mode:

- It is not clear from git-sparse-checkout(1) when changes to
  $GIT_DIR/info/sparse-checkout are catched up. In my case: would it be enough
  to add the new pathname just before git-mv or would a fresh git-checkout be
  needed after modifying $GIT_DIR/info/sparse-checkout? You have clarified
  this in your response, but shouldn't this be clear from the manpage?

- git-sparse-checkout(1) refers to "skip-worktree bit". This concept is
  potentially not very familiar to the average git user which uses mostly
  porcelain. Thus, edge cases remain to be unclear.

- The pathspecs refers to .gitignore (which by itself is not very clear). But
  there are differences:
  1. giignore is relative to containing directoy, which don't seem to make
     much sense for sparse mode
  2. sparse specs are the opposite of gitignore, which seems to have different
     meaning in some edge-cases.

- For cone, it is not clear how the two "accepted patterns" look like what the
  semantics are. I understand that specifying a directory adds siblings
  recursively. But what does the "Parent" mode mean exactly and when/how is
  this recognized? I guess, this is just a mis-namer? IMHO, parent of /a/b/c would
  be /a/b and not /a/b/c/* (as git-sparse-chekout(1) suggests).

I guess all this is very clear to the core-developers. But for the occasional
user like myself, all this is pretty much confusing.


-- 
Josef Wolf
jw@raven.inka.de
