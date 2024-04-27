Received: from thechases.com (thechases.com [54.39.151.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A81428F4
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.151.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714249073; cv=none; b=LazHKhyHVZO/gsASuIU3KKK30X1YOeJlztNbq9pX2lAMp4akMZ5tbdlw5k6RCAX/NxzvvmilTx9IjCD6i+T/IrMHHhRiJElSdyXwQp3xp2cAtzDRxyV2w/hxydD8R8Z7iQFIQDPNqC22e9fRWmFn/jiB4EfvUvCp21ixtk5y7HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714249073; c=relaxed/simple;
	bh=b+dG414FT2nlWthlZ/7ZuJjCNB1FXTtvc3FdHMBLfBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az4ucrq20fTngBt22Sp5vDmeZAVB0WCGO8yvQQtzJX4D1ZwOx8WdF2JLKGbuL1PTjz9Mz0ix1Vqezrdc+JKFW8on1uCJNh41haOQioVrQrrquzxix7aje9fzfUGP91w25djyiVqsaIOnavkovkWsjj3FWA541fQwnJzH+0KDa3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tim.thechases.com; spf=pass smtp.mailfrom=tim.thechases.com; arc=none smtp.client-ip=54.39.151.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tim.thechases.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tim.thechases.com
Received: from localhost (thechases.com [local])
	by thechases.com (OpenSMTPD) with ESMTPA id 70625687;
	Sat, 27 Apr 2024 20:17:44 +0000 (UTC)
Date: Sat, 27 Apr 2024 15:17:44 -0500
From: Tim Chase <git@tim.thechases.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Stashing just index..working-copy rather than HEAD..working-copy?
Message-ID: <Zi1daCgMI3KkC9yA@thechases.com>
References: <ZikMqXeDnOqK_wlq@thechases.com>
 <CAPx1GvcxyDDQmCssMjEnt6JoV6qPc5ZUpgPLX3mpUC_4PNYA1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPx1GvcxyDDQmCssMjEnt6JoV6qPc5ZUpgPLX3mpUC_4PNYA1w@mail.gmail.com>

On 2024-04-24 15:17, Chris Torek wrote:
> Let's start with revisiting the subject line here:
> 
> > Stashing just index..working-copy rather than HEAD..working-copy?
> 
> This implies that you're thinking about Git as storing diffs.

Having looked at the `gitk --all` display (or similar git-log with
graph visualization) I can see the pair of stashed commits you
describe,

  $ git init dummy
  $ cd dummy
  $ seq 10 > a.txt
  $ git add a.txt
  $ ed a.txt
  5s/$/ production change/
  6s/$/ pending change/
  wq
  $ git add -p
  e
  (modify the diff so that only line #5 is modified and line 6 remains untouched)
  $ git stash -k

This feels like what I expect (the diff that my `git add -p` showed):

  $ git diff --cached
  diff --git a/a.txt b/a.txt
  index 0ff3bbb..94fa4fc 100644
  --- a/a.txt
  +++ b/a.txt
  @@ -2,7 +2,7 @@
   2
   3
   4
  -5
  +5 production change
   6
   7
   8
  
> Now, the way `git stash` works is that it saves not one but
> *two* snapshots, both as commits, but with neither one being
> "on" any *branch*.

Right.  So looking at my test repo

  $ git log --oneline --graph --all
  *   aad5479 (refs/stash) WIP on main: 7f38a19 Initial checkin
  |\  
  | * e8e0979 index on main: 7f38a19 Initial checkin
  |/  
  * 7f38a19 (HEAD -> main) Initial checkin

the stash looks right when I diff the two snapshots that the
logs produce

  $ git diff e8e0..aad5
  diff --git a/a.txt b/a.txt
  index 94fa4fc..c9203f6 100644
  --- a/a.txt
  +++ b/a.txt
  @@ -3,7 +3,7 @@
   3
   4
   5 production change
  -6
  +6 pending change
   7
   8
   9

AFAICT, that's diffing the I and W commits you detail.

> That's why `git stash --keep-index` lets you test what's in
> the index.  This is an obvious practical use for `git stash
> --keep-index`.

Right, so we're on the same page through here.

If I apply that diff against the current state of things (production
changes in the Index & WC but not committed officially yet), it
works without conflict.

> The problem with this comes in later: both `git stash apply` and
> `git stash pop` run into it.  They run into it whether you use
> `--index` or not.  **Here's the root of the problem: `git stash`
> made two commits, not one.**

Almost...as shown above, the diff of the "I" and "W" commits
*does* produce the correct diff that applies cleanly.  So the root
of the problem is diffing the "wrong" (for values of my expectations)
pair of commits to generate this diff to apply.

> How does `git apply` work?  Well, it takes, as its input, a
> diff.  We get a diff by comparing *two things*.  So `git stash
> apply` compares two things: the commit that you had as `HEAD`
> when you ran `git stash`, and the commit that `git stash` saved
> as "W".
> 
> `git stash apply` therefore runs:
> 
>     git diff [various options if needed] <W's HEAD-parent> <W>

And here's where it feels confusing/wrong to me -- it's choosing
to diff W^..W instead of I..W to obtain that diff-to-apply.

As noted in `git help stash` in the `pop` docs

  The working directory must match the index.

which it does.

  $ git diff # compare WC with index

returns no difference.  However the working directory doesn't match
W^1.  Choosing to apply W^..W is what introduces the conflicts.

Maybe those docs should read something like

  The working directory must match the HEAD at the time of stashing

or something like that?

> If your current working tree matches W's HEAD-parent, this
> application proceeds smoothly, and you're all set.  But what
> if, for whatever reason, your current working tree *doesn't*
> match W's HEAD-parent?  What if instead if matches W's I-parent,
> aka the "I" commit?  In that case, some lines try to apply
> twice and/or cause a conflict -- and that's exactly what you
> have been running into.

Exactly :-)

> If `git stash` had a way to do:
> 
>     git diff [options] <W's I-parent> <W>
> 
> and apply that, *that* would be what you would want here.  But
> alas, it lacks any such option.
> 
> What `git stash` *does* have is `git stash apply --index`.  This
> tells Git to run *two* `git diff`s:
> 
>     git diff [options] <original HEAD-parent> <I>
>     git diff [options] <I> <W>
> 
> Git then tries to apply the first diff to both the index and the
> working tree (a la `git apply --index`), and then apply the second
> diff to the working tree only (`git apply` without options).

If I understand you correctly, it sounds like `git stash {apply,pop}
--index` does a bit of a `reset` of the index & WC back to the
pre-stashed state, then *recreates* the index based on that first
diff, and recreates the WC based on both diffs.

> If your working tree matches the original `HEAD`, you get just
> what you want: the index is restored to the way it was when you
> ran `git stash --keep-index`, and then the working tree is also
> restored to the way it was at that time.

Right.

> **The biggest pitfall here is that you might forget `--index`.**

Fair (and worth my considering an alias or something)

> If you use `git stash pop`, this can be pretty terrible!

And what brought me to posting :-)

> Now, if you use the "DANGEROUS" recipe, suppose you run:
> 
>     git stash --keep-index
>     [test and find that it's all good]
>     git reset --hard
>     git stash pop       [OOPS FORGOT TO USE --index]

This takes no imagination on my part having done exactly that
omission of --index :-)

> `git stash` *already saves everything you want*.  It's actually
> the *application* step that goes awry here.

Right.

> With all that said, I'd like to make one last suggestion, which
> I think is a lot simpler: *stop using `git stash`*.  Just make
> a commit!

And given the limitations I'm seeing on how stash pop/apply behave,
I think that's the conclusion I'm coming to as well (and sorta what
/u/splettnet kinda suggested).

By doing an actual commit:

  $ git add -p # complex teasing out of the commit
  $ git commit -m "message if all tests succeed"
  $ git stash

I can test it, and if it works, the commit is already in the repo.
Then a

  $ git stash pop

does what I expect, and if the testing failed, I can

  $ git reset --mixed HEAD~

to get back to where I was.

That suffices for me.

Thanks for the detailed write-up!

-tkc





