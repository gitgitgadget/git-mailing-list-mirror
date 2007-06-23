From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add git-save script
Date: Sat, 23 Jun 2007 13:15:28 -0700
Message-ID: <7vmyyq2zrz.fsf@assigned-by-dhcp.pobox.com>
References: <20070623220215.6117@nanako3.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 22:15:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2C1A-0000WN-PY
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 22:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXFWUPa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 16:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbXFWUPa
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 16:15:30 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42242 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbXFWUP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 16:15:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070623201528.DTDT17635.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 23 Jun 2007 16:15:28 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id F8FU1X0081kojtg0000000; Sat, 23 Jun 2007 16:15:29 -0400
In-Reply-To: <20070623220215.6117@nanako3.bluebottle.com> (Nanako Shiraishi's
	message of "Sat, 23 Jun 2007 22:02:15 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50749>

Nanako Shiraishi <nanako3@bluebottle.com> writes:

> I wrote this little script to save the changes I made, perform the update,
> and then come back to where I was, but on top of the updated commit.
>
> Here is how to use my script:
>
>     $ git save
>     $ git pull
>     $ git save restore

Heh, I earlier said that I'd start looking at the "stash", but
haven't done anything about it so far (I was busy with the day
job).  More honestly, I was being lazy, and sometimes lazy are
rewarded, with a contribution from a new git hacker.

I think this is more or less in the direction I was planning to
head to; thanks for the patch.

Having said that, I have a few comments.  Style, robustness,
and portability.

> diff --git a/git-save.sh b/git-save.sh
> new file mode 100755
> index 0000000..b45652e
> --- /dev/null
> +++ b/git-save.sh
> @@ -0,0 +1,74 @@
> +#! /bin/sh

Style.  "#!/bin/sh" (no space after she-bang).

> +
> +. git-sh-setup
> +require_work_tree
> +
> +function save_work () {

No noiseword "function" for portability.

When you say "#!/bin/sh", you are writing for the family of
generic Bourne shells, not specifically for korn nor bash.  For
example, dash is a fine POSIX shell, but does not grok function
noiseword.  When in doubt, please stay away from things not in
POSIX (e.g. function, [[, ]], ${parameter//pattern/string/}).

> +	save=$( (
> +		i_tree=$(git-write-tree)
> +
> +		TMP=$GIT_DIR/.git-save-tmp
> +		GIT_INDEX_FILE=$TMP
> +		export GIT_INDEX_FILE
> +
> +		git-read-tree $i_tree
> +		git-add -u
> +		w_tree=$(git-write-tree)
> +		rm $TMP
> +		git-read-tree --prefix=base/ HEAD^{tree}
> +		git-read-tree --prefix=indx/ $i_tree
> +		git-read-tree --prefix=work/ $w_tree
> +		git-write-tree
> +		rm $TMP
> +	) )

Hmph.

I see many problems here, although the basic idea is sound and
"interesting".  I especially like the use of three trees in a
single commit, without any parenthood.

 - $GIT_DIR could contain shell metachararcters / whitespace, so
   could $TMP as well.  Always quote such variables, or you risk
   a surprise from "rm".

 - You probably would not want to create a new "save" if your
   working tree and the index are clean.  To test for the
   condition, you can do something like:

	git-diff --quiet --cached && git-diff --quiet

 - I generally prefer cleaning temporary files with "rm -f", and
   also set a trap upon exit, like this:

	# near the beginning of the script
	TMP="$GIT_DIR/.git-save-tmp-$$"
	trap 'rm -f "$TMP"' 0 
	... and then much later ...

	save=$( (
		GIT_INDEX_FILE=$TMP
		export GIT_INDEX_FILE
                ...
	) )

 - I wonder what happens if any of the commands in the above
   sequence errors out.  For example, I think you will get a
   failure from the first git-write-tree if you are in the
   middle of a merge.  You would want to error out as soon as
   you see a problem.

 - Although you keep a separate tree for the index (before the
   "git add -u" to grab the working tree changes) in the saved
   data, it does not seem to be used.  It _might_ make sense to
   replace "git add -u" with "git add ." so that work/ tree
   contains even untracked (but not ignored) files, and on the
   restore side unstage the paths that appear in work/ but not
   in indx/.  I dunno.

> +
> +	head=$(git-log --abbrev-commit --pretty=oneline -n 1 HEAD)
> +	if branch=$(git symbolic-ref -q HEAD); then
> +		branch=${branch#refs/heads/}
> +	else
> +		branch='(no branch)'
> +	fi &&

Minor style.  Please don't write "; then\n".  Line-up "then",
"elif", "else", and "fi"; it is much easier to read that way.

> +	msg=$(printf 'WIP on %s "%s"' "$branch" "$head")
> +
> +	saved=$(printf '%s' "$msg" | git-commit-tree "$save")
> +	git update-ref -m "$msg" refs/heads/saved $saved
> +	printf 'Saved %s\n' "$msg" >&2
> +}
> +
> +function list_save () {
> +	git-log --abbrev-commit --pretty=oneline -g "$@" saved
> +}

I really like the way reflog is used for this.  Your saves do
not necessarily tied to a single branch (so there are no
parent-child relation between each save entry), but you can
still identify what each of the save is about because your log
message has branch name in it.

The sha1 at the beginning of oneline output, although they are
abbreviated, seem not very useful in this context, by the way.
I presume your intended use case is to view "git save list"
output, and say "git save restore saved@{2}" to apply the one
third from the top.  For that use, the commit object name is
irrelevant.  Maybe sed it out like this to make it even
prettier?

	git-log --pretty=oneline -g "$@" saved
        sed -e 's/^[0-9a-f]* //'

> +function show_save () {
> +	save=$(git rev-parse --verify --default saved "$1")
> +	git diff-tree --stat $save:base $save:work
> +}

Nice, but after trying this myself a bit, I seriously wished for
"git save show -p", so I did it myself, like this:

	show_save () {
		flags=$(git rev-parse --no-revs --flags "$@")
		if test -z "$flags"
		then
			flags=--stat
		fi
		save=$(git rev-parse --revs-only --no-flags --default saved "$@")
		git diff-tree $flags $save:base $save:work
	}

It's a dense (and ancient style) plumbing code so needs a bit of
explanation:

 - The first git-rev-parse looks at "$@", discards everything
   that are not options and discards object names.  So 'git save
   show -p some' will give you "-p" in flags.

 - The second one discards flags, and grabs 'some' out of '-p
   some', or defaults to "saved".

> +function restore_save () {
> +	save=$(git rev-parse --verify --default saved "$1")
> +	h_tree=$(git rev-parse --verify $save:base)
> +	i_tree=$(git rev-parse --verify $save:indx)
> +	w_tree=$(git rev-parse --verify $save:work)
> +
> +	git-merge-recursive $h_tree -- HEAD^{tree} $w_tree
> +}

The same "robustness" comments for the save_work function apply
here.  You probably do not want to restore on a dirty tree; the
intended use case is "stash away, pull, then restore", so I
think it is Ok to assume that you will only be restoring on a
clean state (and it would make the implementation simpler).

The three-way merge is done correctly here, and I would imagine
the users would feel the UI quite natural _if_ this merge
conflicts.  "git diff" would show only the conflicted paths
(because the updates coming from the old working tree is placed
in the index for cleanly merged paths), editing a conflicted
file and "git add $that_path" would resolve.  That's exactly the
same workflow for a conflicted merge.

However, I think it is a bit counterintuitive to update the
working tree change to the index if the merge did not conflict.
It might be better to run an equivalent of "git reset", so that
after "git save restore", the user can say "git diff" (not "git
diff HEAD") to view the local changes.  Perhaps...

	if git-merge-recursive ...
	then
        	# Cleanly merged..
		added="$TMP" &&
                git-diff --cached --name-only --diff-filter=A >"$added" &&
		git-read-tree HEAD &&
                git-update-index --add --stdin <"$added" ||
			die "Cannot unstage local modification"
		git-update-index --refresh
	fi

The --diff-filter dance is so that we do not "forget" newly
added files when we do "read-tree HEAD".

> +
> +if [ "$1" = list ]; then
> +	shift
> +	if [ "$#" = 0 ]; then
> +		set x -n 10
> +		shift
> +	fi
> +	list_save "$@"
> +elif [ "$1" = show ]; then
> +	shift
> +	show_save "$@"
> +elif [ "$1" = restore ]; then
> +	shift
> +	restore_save "$@"
> +else
> +	save_work
> +	git reset --hard

I am not absolutely sure if "git reset --hard" belongs here.
You can certainly type one less command in your example sequence
("stash; pull; restore").  But I suspect there may be a case
that would be more useful if "git save" did not do the reset
itself.  I dunno....

> +fi
> +
> +

Style.  This is a perfect place to use "case/esac".

	case "$1" in
	list)
        	do this thing
                ;;
	...
	*)
        	do default thing
                ;;
        esac

Much easier to read, isn't it?
