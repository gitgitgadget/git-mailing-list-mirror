From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: A script to show diff in new window while
 editing commit message.
Date: Wed, 21 Jan 2009 23:49:02 -0800
Message-ID: <7vk58naihd.fsf@gitster.siamese.dyndns.org>
References: <7vy6x4b48e.fsf@gitster.siamese.dyndns.org>
 <1232596208-7384-1-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 08:50:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPuKj-0002e6-EP
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 08:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbZAVHtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 02:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbZAVHtM
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 02:49:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45125 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbZAVHtM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 02:49:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F6861D003;
	Thu, 22 Jan 2009 02:49:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8DA0C1D002; Thu,
 22 Jan 2009 02:49:04 -0500 (EST)
In-Reply-To: <1232596208-7384-1-git-send-email-ted@tedpavlic.com> (Ted
 Pavlic's message of "Wed, 21 Jan 2009 22:50:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26227A80-E859-11DD-A68D-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106733>

Ted Pavlic <ted@tedpavlic.com> writes:

> This new script (contrib/giteditor/giteditor) is an example GIT_EDITOR
> that causes the editor to open the commit message as well as a "git diff
> --cached" in a separate window. This behavior differs from "git commit
> -v" in that the diff can be browsed independently of the commit message
> without having to invoke a split window view in an editor.
>
> This script also detects when "stg edit" is being called and uses "stg
> show" instead. Hence, it implements a kind of "stg edit -v".
>
> This script is highly influenced by the "hgeditor" script distributed
> with the Mercurial SCM.
>
> Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
> ---
>
> This new commit responds to some of the issues brought up by Junio C
> Hemano (and Johannes Schindelin). In particular, it removes the
> paragraph from the commit message discussing how it could be "improved." 
>
> Also, this new version uses a "DIFFPIPE" to strip the old commit message
> from the top of the "stg show" output so that the "stg edit" behavior
> matches the "git commit" behavior. 
>
> Finally, this version adds a comment giving an idea for personalizing by
> adding the temporary directory creation back in (as a way to prevent
> editor backup files from piling up inside .git).
>
>  contrib/giteditor/giteditor |   86 +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 86 insertions(+), 0 deletions(-)
>  create mode 100755 contrib/giteditor/giteditor
>
> diff --git a/contrib/giteditor/giteditor b/contrib/giteditor/giteditor
> new file mode 100755
> index 0000000..5369732
> --- /dev/null
> +++ b/contrib/giteditor/giteditor
> @@ -0,0 +1,86 @@
> +#!/bin/sh
> +#
> +# Set GIT_EDITOR (or core.editor) to this script to see a diff alongside
> +# commit message. This script differs from "git commit -v" in that the
> +# diff shows up in a separate buffer. Additionally, this script works
> +# with "stg edit" as well.
> +#
> +# Copyright (c) 2009 by Theodore P. Pavlic <ted@tedpavlic.com>
> +# Highly influenced by hgeditor script distributed with Mercurial SCM.
> +# Distributed under the GNU General Public License, version 2.0.
> +#
> +# Possible personalizations:
> +#
> +# * If your GIT_DIR gets polluted with backup files created by your
> +#   editor when COMMIT_EDITMSG is saved, then have this script copy
> +#   COMMIT_EDITMSG (i.e., $1) to a temporary directory and then back to
> +#   COMMIT_EDITMSG when done. When the script cleans up after itself, it
> +#   can delete the temporary directory and any leftover backup files.
> +#   Note that the vim setting 'nobackup' disables saving backup files,
> +#   and this setting can be set automatically on gitcommit-type files
> +#   and files matching .stgit-*.txt with an appropriate ftdetect entry.

I am not sure what problem you are trying to offer a solution here.  Are
you suggesting a trick to avoid .git/COMMIT_EDITMSG~ left behind by Emacs?

> +# Find git
> +test -z "${GIT}" && GIT="git"

Why?

> +# Find stg
> +test -z "${STG}" && STG="stg"

Why?

> +# Find the nearest git-dir
> +GITDIR=$(git rev-parse --git-dir) || exit
> +
> +# Use an editor. To prevent loops, avoid GIT_EDITOR and core.editor.
> +EDITOR="${GIT_EDITOR_EDITOR-${VISUAL-${EDITOR-vi}}}"

At the beginning of this file, you have a nice insn to set GIT_EDITOR, but
this GIT_EDITOR_EDITOR to customize what underlying editor you end up
launching should also be documented in the same place.

I do not think you need the dq pair around the right hand side.

> +# If we recognize a popular editor, add necessary flags (e.g., to
> +# prevent forking)
> +case "${EDITOR}" in
> +    emacs)
> +        EDITOR="${EDITOR} -nw"
> +        ;;
> +    mvim|gvim|vim|vi)
> +        EDITOR="${EDITOR} -f -o"
> +        ;;
> +esac

 - Please align case arm labels with case and esac, like this (I do not
   mind 4-space indentation if that is what you are used to):

	case "$foo" in
        bar)
        	... do bar things ...
                ;;
	...
	esac

 - Braces around variables are noisy and distracting;

 - Why force emacs users to -nw?  If _you_ personally like -nw, shouldn't
   you be able to simply do:

	GIT_EDITOR_EDITOR="emacs -nw"

   in your environment?  After all, when you use $EDITOR later, you do not
   quote it and let $IFS separate the flags the variable may have in
   addition to the name of (or path to) the executable.

> +# Remove temporary files even if we get interrupted
> +DIFFOUTPUT="${GITDIR}/giteditor.${RANDOM}.${RANDOM}.${RANDOM}.$$.diff"

The script begins with #!/bin/sh but isn't ${RANDOM} a Bash-ism?  Either
you should begin it with #!/bin/bash, or avoid bash-ism, if you do not
want to alienate poeple whose /bin/sh is not bash.

> +cleanup_exit() { 
> +    rm -f "${DIFFOUTPUT}" 
> +}
> +trap "cleanup_exit" 0       # normal exit
> +trap "exit 255" 1 2 3 6 15  # HUP INT QUIT ABRT TERM

It may have been useful while debugging this script, but is the temporary
file that precious to it needs to be kept upon HUP and friends?

> +# For git, COMMITMSG=COMMIT_EDITMSG
> +# For stg, COMMITMSG=.stgit-edit.txt
> +# etc.
> +COMMITMSG=$(basename "$1")
> +DIFFPIPE="cat"
> +case "${COMMITMSG}" in
> +    .stgit-edit.txt)        # From "stg edit" 
> +        DIFFCMD="${STG}"
> +        DIFFARGS="show"
> +        DIFFPIPE="tail +$(wc -l "$1"|awk '{print $1+3}')"
> +        ;;
> +    *)                      # Fall through to "git commit" case
> +        DIFFCMD="${GIT}"
> +        DIFFARGS="diff --cached"
> +        # To focus on files that changed, use:
> +        #DIFFARGS="diff --cached --diff-filter=M"
> +        ;;
> +esac
> +

This '*' case is horribly wrong.

What happens if other parts of git (or third party tools around git) runs
core.editor for things other than the commit log messages (or anything you
do not know how to prepare a sensible diff to show)?  Shouldn't you act as
if you were not there at all to avoid surprising the end user with an
unexpected diff output?

For example, doesn't "git rebase -i" launch core.editor to let you edit
the pick/edit/squash insn sequence?  What diff are you showing in such a
case, and how would that help your users?

> +# Do the diff and save the result in DIFFOUTPUT
> +"${DIFFCMD}" ${DIFFARGS} | ${DIFFPIPE} > ${DIFFOUTPUT}

Because your "extra information in another file" processing depends
heavily on what the edited file is (you are already generating the diff
differently for "git commit" and "stg edit"), I think having this outside
the above case statement is a false factoring; it would be easier to read
and maintain if they are defined in each case arm.  I would probably write
this part like this:

	case "$COMMITMSG" in
        .stgit-edit.txt)
        	do whatever appropriate for "stg edit"  and emit to stdout
                ;;
	COMMIT_EDITMSG)
        	if git rev-parse -q --verify HEAD >/dev/null
                then
                	git diff --cached
		else
                        git diff --cached 4b825dc642cb6eb9a060e54bf8d69288fbee4904
                fi
                ;;
	*)
        	: we do not know how to handle this one
                ;;
	esac >"$DIFFOUTPUT"

You need to quote "$DIFFOUTPUT"; it is a path in $GIT_DIR which means it
can have $IFS character.

> +# If DIFFOUTPUT is nonempty, open it alongside commit message
> +if test -s "${DIFFOUTPUT}"; then
> +    # Diff is non-empty, so edit msg and diff
> +    ${EDITOR} "$1" "${DIFFOUTPUT}" || exit
> +else
> +    # Empty diff. Only edit msg
> +    ${EDITOR} "$1" || exit

In the latter case, it may be cleaner to:

	rm -f "$DIFFOUTPUT"
        exec ${EDITOR} "$1"

One more thing.  You may want to study how git_editor() in git-sh-setup
scriptlet solves the issue of (1) the path to the editor executable may
have $IFS character that the end user may want to quote, and (2) the end
user may want to include options to the editor in the varaible, by using
eval.

> +fi
> +
> +# (recall that DIFFOUTPUT file gets cleaned up by trap above)
> +exit
