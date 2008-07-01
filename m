From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC/PATCH 2/4] Add git-sequencer prototype documentation
Date: Tue, 1 Jul 2008 18:03:22 +0200
Message-ID: <20080701160322.GC5301@leksak.fem-net>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <1214879914-17866-3-git-send-email-s-beyer@gmx.net> <m34p79hhy9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 18:04:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDiLD-0005iZ-Kg
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 18:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757246AbYGAQDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 12:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756952AbYGAQDc
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 12:03:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:36859 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755974AbYGAQDa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 12:03:30 -0400
Received: (qmail invoked by alias); 01 Jul 2008 16:03:28 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp034) with SMTP; 01 Jul 2008 18:03:28 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/prE1ybznpmM6y8N8jJmzX0fpkl2Fp7/K4n5z/ut
	2tX9+cc6go02ve
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KDiKA-0003lI-8E; Tue, 01 Jul 2008 18:03:22 +0200
Content-Disposition: inline
In-Reply-To: <m34p79hhy9.fsf@localhost.localdomain>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87045>

Hi,

On Tue, Jul 01, 2008 at 06:02:54AM -0700,
Jakub Narebski <jnareb@gmail.com> wrote:
> > +git-sequencer will usually be called by another git porcelain, like
> > +linkgit:git-am[1] or linkgit:git-rebase[1].
> 
> I hope that it could be also used by git-cherry-pick and git-revert,
> so it would be possible to pick more than one commit...

Right, you've already mentioned it several times. ;-)
But I haven't included it currently, because git-sequencer currently *uses*
cherry-pick/revert to pick/revert commits, and I think this can lead to
some confusion.
And, I think there also has to be some discussion, e.g.
if even the single cherry-pick/revert uses sequencer, then the behavior
changes for the user: currently you have to "git commit" after a
conflict on cherry-pick. When it uses sequencer, you have to
git-sequencer --continue (or --skip or --abort) ;)

So I'm only concentrating on rebase and am users until the builtin sequencer
is in good shape.

> > +After resolving the conflict manually and updating the index with the
> > +desired resolution, you can continue the sequencing process with
> > +
> > +    git sequencer --continue
> 
> Does it run pre-commit hooks, for example checking for merge markers
> (but also whitespace errors), and can those checks be disabled?

It only commits (git commit) staged changes (if the working tree is
clean) and the pre-commit hooks are bypassed (as in rebase-i).

> > +-B::
> > +--batch::
> > +	Run in batch mode. If unexpected user intervention is needed
> > +	(e.g. a conflict or the need to run an editor), git-sequencer fails.
> > ++
> > +Note that the sanity check fails, if you use this option
> > +and an instruction like `edit` or `pause`.
> 
> s/.$/ is in the TODO file./

Agreed.

diff --git a/Documentation/git-sequencer.txt b/Documentation/git-sequencer.txt
index e0c6410..1a9eda4 100644
--- a/Documentation/git-sequencer.txt
+++ b/Documentation/git-sequencer.txt
@@ -62,7 +62,7 @@ OPTIONS
 	(e.g. a conflict or the need to run an editor), git-sequencer fails.
 +
 Note that the sanity check fails, if you use this option
-and an instruction like `edit` or `pause`.
+and an instruction like `edit` or `pause` is in the TODO file.
 
 --onto=<base>::
 	Checkout given commit or branch before sequencing.
##

> > +--edit::
> > +	Invoke editor to edit the undone rest of the TODO file.
> 
> Does it mean that editor will be invoked with only _unprocessed_
> part of the TODO file?  It looks like it, but it might be not
> obvious to some.

Thanks, this sounds better.

@@ -83,7 +83,7 @@ and an instruction like `edit` or `pause`.
 	operations can be done to change that status.
 
 --edit::
-	Invoke editor to edit the undone rest of the TODO file.
+	Invoke editor to edit the unprocessed part of the TODO file.
 +
 The file is syntax- and sanity-checked afterwards, so that you can
 safely run `git sequencer --skip` or `--continue` after editing.
##

> > +merge [options] <commit-ish1> <commit-ish2> ... <commit-ishN>::
> > +	Merge commits into HEAD.
> 
> Nice.
> 
> "HEAD" mean last picked up / created commit, isn't it?

Right. This is used throughout the document...
I thought it is clear and better to use than always describing around it
by "last created commit".
But currently I'm unsure about it :)

> > ++
> > +A commit can also be given by a mark, if prefixed with a colon.
> 
> "You can refer to commit by mark", perhaps?

Hm, is "by" the right preposition?

@@ -150,7 +150,7 @@ The set marks are removed after the sequencer has completed.
 merge [options] <commit-ish1> <commit-ish2> ... <commit-ishN>::
 	Merge commits into HEAD.
 +
-A commit can also be given by a mark, if prefixed with a colon.
+You can refer to a commit by a mark.
 +
 If you do not provide a commit message (using `-F`, `-m`, `-C`, `-M`,
 or `--standard`), an editor will be invoked.
##

> > +	--standard;;
> > +		Generates a commit message like 'Merge ... into HEAD'.
> > +		See also linkgit:git-fmt-merge-msg[1].
> 
> Is it short for `--standard-message`?

Do you think it should?
Semantically it is less ambiguous, right, but
as there is not short option, I think we should not make
the long options too long...

Perhaps --std-msg?

> > +pick [options] <commit>::
> > +	Pick (see linkgit:git-cherry-pick[1]) a commit.
> > +	Sequencer will pause on conflicts.
> > ++
> > +See the following list and 'GENERAL OPTIONS' for values of `options`:
> > +
> > +	-R;;
> > +	--reverse;;
> > +		Revert the changes introduced by pick <commit>.
> > +
> > +	--mainline=<n>;;
> > +		Allows you to pick merge commits by specifying the
> > +		parent number (beginning from 1) to let sequencer
> > +		replay the changes relative to the specified parent.
> > +		+
> > +This option does not work together with `-R`.
> 
> Why?  I would have thought that it would work...

git-revert has no --mainline option.
When sequencer won't use cherry-pick/revert anymore, we can add that.

> > +patch [options] <file>::
> [...]
> > +	-*;;
> > +		Any other dash-prefixed option is passed to
> > +		linkgit:git-apply[1].
> > +		This is especially useful for flags like
> > +		`--reverse`, `-C<n>`, `-p<n>` or `--whitespace=<action>`.
> 
> Do all options make sense?  What about `--index' and `--cached',
> or about different no-apply options?

No, not all make sense and in fact the "any other dash-prefixed option"
was true some weeks ago, but now it's a lie. Now it is just a definite
subset and -C was renamed to --context due a conflict with the general
option -C.

This is better:    (Lot of text copy&pasted from git-apply.txt)

@@ -208,11 +208,50 @@ See the following list and 'GENERAL OPTIONS' for values of `options`:
 	-n;;
 		Pass `-n` flag to `git-mailinfo` (see linkgit:git-mailinfo[1]).
 
-	-*;;
-		Any other dash-prefixed option is passed to
-		linkgit:git-apply[1].
-		This is especially useful for flags like
-		`--reverse`, `-C<n>`, `-p<n>` or `--whitespace=<action>`.
+	--exclude=<path-pattern>;;
+		Do not apply changes to files matching the given path pattern.
+		This can be useful when importing patchsets, where you want to
+		exclude certain files or directories.
+
+	-R;;
+	--reverse;;
+		Apply the patch in reverse.
+
+	--no-add;;
+		When applying a patch, ignore additions made by the
+		patch.  This can be used to extract the common part between
+		two files by first running `diff` on them and applying
+		the result with this option, which would apply the
+		deletion part but not addition part.
+
+	--whitespace=<action>;;
+		Specify behavior on whitespace errors.
+		See linkgit:git-apply[1] for a detailed description.
+
+	--context=<n>;;
+		Ensure at least <n> lines of surrounding context match before
+		and after each change.  When fewer lines of surrounding
+		context exist they all must match.  By default no context is
+		ever ignored.
+
+	--inaccurate-eof;;
+		Under certain circumstances, some versions of diff do not
+		correctly detect a missing new-line at the end of the file.
+		As a result, patches created by such diff programs do not
+		record incomplete lines correctly.
+		This option adds support for applying such patches by
+		working around this bug.
+
+	-p<n>;;
+		Remove <n> leading slashes from traditional diff paths.
+		The default is 1.
+
+	--unidiff-zero;;
+		By default, linkgit:git-apply[1] expects that the patch being
+		applied is a unified diff with at least one line of context.
+		This provides good safety measures, but breaks down when
+		applying a diff generated with --unified=0. To bypass these
+		checks use '--unidiff-zero'.
 
 
 pause::
##

> > +ref <ref>::
> > +	Set ref `<ref>` to the current HEAD, see also
> > +	linkgit:git-update-ref[1].
> 
> So this functions like "git reset --soft <ref>", isn't it?

No. Why do you think that? `ref` is set, and not HEAD.
I think the description makes that clear.

> > +squash [options] --from <mark>::
> > +	Squash all commits from the given mark into one commit.
> > +	There must not be any `merge` instructions between the
> > +	`mark` instruction and this `squash --from` instruction.
> 
> Can you use <commit> instead of <mark> here?

I wanted to make it clear that you can only specify a mark:
a commit that has been somehow used in this sequencer session.

Or have you meant that you think it is a bad restriction to only
allow marks and no commits?
I think this is a useful thing, because it's user-safe and I
cannot imagine a case where you want to give a sha1 or a
tag or branch or something.

Here an example why it is useful for user-editing:

(on commit f00babe)
	mark :1
	pick badcebab
	patch foo
	pick dadadada
	squash -m "Foo the cebab" --signoff --from :1

This squashes all between the mark and the squash into one commit,
on top of f00babe.

If we allow commits, the user could think that

	pick badcebab
	patch foo
	pick dadadada
	squash -m "Foo the cebab" --signoff --from badcebab

does the same, but this leads to:
 f00babe, picked-badcebab, squash-of-foo-and-dadadada

So
	squash -m "Foo the cebab" --signoff --from f00babe
would be correct.  But this is unintuitive.
So it's safer if we restrict this to marks.

> > +	--include-merges;;
> > +		Sanity check does not fail if you have merges
> > +		between HEAD and <mark>.
> 
> How do you squash merges?  Creating merge with an union of parents,
> excluding commits which got squashed?

My squashes are realized using git reset --soft ... and then commit.
I think this makes only sense when there are no merges in between,
so I added the check, but if someone wants to squash merges, he should
be able to do it.
To somehow answer your question: I do not care what the result is,
because I do not know what the result "should be".
IIRC the "other" parents of the merge commit are not kept, so it seems
that you have a commit that contains the changes after the merge, but
not the meta information like the right parents.

> It means
> 
>   ...a---b---c---d         ...[abcd]
>             /        ==>        /
>       ...x-/               ..x-/
> 
> but
> 
>   ...a---b---c---d          ...[abcd]
>       \     /        ==>
>        \-x-/ 
> 

I think it will be ...[abcdx].

But as I said, "I don't care". And the help description shows that.

> > +RETURN VALUES
> > +-------------
> > +* any other value on error, e.g.
> > +  running git-sequencer on a bare repository.
> 
> Don't you enumerate those return values?

In one of the very first spec versions, it was value 1, but:

	$ grep -A 3 ^die git-sh-setup
	die() {
		echo >&2 "$@"
		exit 1
	}

	$ grep -m 1 -A 4 die_builtin usage.c
	static NORETURN void die_builtin(const char *err, va_list params)
	{
		report("fatal: ", err, params);
		exit(128);
	}


Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
