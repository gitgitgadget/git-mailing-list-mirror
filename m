From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Add git-notes
Date: Sun, 15 Jul 2007 22:11:28 -0700
Message-ID: <7v8x9h6igv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
	<Pine.LNX.4.64.0707160023360.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 07:11:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAIrs-0007bL-Uv
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 07:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbXGPFLc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 01:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbXGPFLb
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 01:11:31 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:50463 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbXGPFLa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 01:11:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716051131.VNNI1358.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 16 Jul 2007 01:11:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q5BU1X00F1kojtg0000000; Mon, 16 Jul 2007 01:11:30 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52636>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This script allows you to edit and show commit notes easily.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .gitignore   |    1 +
>  Makefile     |    2 +-
>  git-notes.sh |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+), 1 deletions(-)
>  create mode 100755 git-notes.sh
>
> diff --git a/git-notes.sh b/git-notes.sh
> new file mode 100755
> index 0000000..e0ad0b9
> --- /dev/null
> +++ b/git-notes.sh
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +
> +USAGE="(edit | show) [commit]"
> +. git-sh-setup
> +
> +test -n "$3" && usage
> +
> +test -z "$GIT_NOTES_REF" && GIT_NOTES_REF="$(git config core.notesref)"
> +test -z "$GIT_NOTES_REF" &&
> +	die "No notes ref set."

	test -n "${GIT_NOTES_REF=$(git config core.notesref)}" || die

> +COMMIT=$(git rev-parse --verify --default HEAD "$2")

This silently annotates the HEAD commit if $2 is misspelled, I
suspect.  Also if HEAD does not exist, COMMIT will be empty and
this whole command will exit with non-zero status, which you
would want to catch here...

> +NAME=$(echo $COMMIT | sed "s/^../&\//")

... or here.

> +case "$1" in
> +edit)
> +	MESSAGE="$GIT_DIR"/new-notes
> +	GIT_NOTES_REF= git log -1 $COMMIT | sed "s/^/#/" > "$MESSAGE"

$MESSAGE and its associated temporary file needs to be cleaned
up upon command exit; perhaps a trap is in order.

> +	GIT_INDEX_FILE="$MESSAGE".idx
> +	export GIT_INDEX_FILE
> +
> +	CURRENT_HEAD=$(git show-ref $GIT_NOTES_REF | cut -f 1 -d ' ')
> +	if [ -z "$CURRENT_HEAD" ]; then
> +		PARENT=
> +	else
> +		PARENT="-p $OLDTIP"
> +		git read-tree $GIT_NOTES_REF || die "Could not read index"
> +		git cat-file blob :$NAME >> "$MESSAGE" 2> /dev/null
> +	fi

I take that OLDTIP is a typo.

	if CURRENT_HEAD=$(git show-ref -s "$GIT_NOTES_REF")
        then
		PARENT="-p $CURRENT_HEAD"
                ...
	else
        	PARENT=
	fi

> +
> +	${VISUAL:-${EDITOR:-vi}} "$MESSAGE"
> +
> +	grep -v ^# < "$MESSAGE" | git stripspace > "$MESSAGE".processed

Makes us wonder if we would want to teach hash-stripping to
git-stripspace, doesn't it?

> +	mv "$MESSAGE".processed "$MESSAGE"
> +	if [ -z "$(cat "$MESSAGE")" ]; then

Make this 'if test -s "$MESSAGE"' and swap then/else clause
around; no reason to slurp the value into your shell.

> +		test -z "$CURRENT_HEAD" &&
> +			die "Will not initialise with empty tree"
> +		git update-index --force-remove $NAME ||
> +			die "Could not update index"
> +	else
> +		BLOB=$(git hash-object -w "$MESSAGE") ||
> +			die "Could not write into object database"
> +		git update-index --add --cacheinfo 0644 $BLOB $NAME ||
> +			die "Could not write index"
> +	fi
> +
> +	TREE=$(git write-tree) || die "Could not write tree"
> +	NEW_HEAD=$(: | git commit-tree $TREE $PARENT) ||
> +		die "Could not annotate"

Hmph.  How about "echo Annotate $COMMIT | git commit-tree..."?

> +	case "$CURRENT_HEAD" in
> +	'') git update-ref $GIT_NOTES_REF $NEW_HEAD ;;
> +	*) git update-ref $GIT_NOTES_REF $NEW_HEAD $CURRENT_HEAD;;
> +	esac
> +;;

There are some places that have "$GIT_NOTES_REF" in dq and some
places you don't.  I think GIT_NOTES_REF begins with refs/ and
consists only of valid refname characters, so unless the user
wants to shoot himself in the foot it should be Ok, but we
probably would want to quote it.

Also, as unquoted $CURRENT_HEAD will not even count as a
parameter to update-ref, you do not have to do that case/esac,
but simply do:

	git update-ref "$GIT_NOTES_REF" $NEW_HEAD $CURRENT_HEAD

Would we have reflog for this ref?  What would we want to see as
the message if we do?
