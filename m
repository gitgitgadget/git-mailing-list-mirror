From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Added giteditor script to show diff while editing commit
 message.
Date: Wed, 21 Jan 2009 22:46:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901212216310.3586@pacific.mpi-cbg.de>
References: <1232570841-25641-1-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:47:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPkvQ-0002VL-10
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 22:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbZAUVq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 16:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbZAUVq0
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 16:46:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:47133 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752077AbZAUVqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 16:46:25 -0500
Received: (qmail invoked by alias); 21 Jan 2009 21:46:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 21 Jan 2009 22:46:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pmNcHmupp/FxKivjDNmmYP/Sl5RVT8G/WNiuZt2
	2n5+EFr7ZwHVxf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232570841-25641-1-git-send-email-ted@tedpavlic.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106683>

Hi,

the subject could use some work.  For example, I would prefix it with 
"contrib:", and -- imitating other commit messages -- use the imperative 
form "Add" instead of the frowned-upon past tense.

On Wed, 21 Jan 2009, ted@tedpavlic.com wrote:

> From: Ted Pavlic <ted@tedpavlic.com>

As this is exactly what your email said in its header, it is redundant 
information.  Worse, it is information that made me look back to know why 
it needs to be there.  Distracting.

> diff --git a/contrib/giteditor/README b/contrib/giteditor/README
> new file mode 100644
> index 0000000..b769c3e
> --- /dev/null
> +++ b/contrib/giteditor/README
> @@ -0,0 +1,9 @@
> +A GIT_EDITOR to show diff alongside commit message. User can review diff
> +within commit edit window. Works with StGit ("stg edit") as well.
> +
> +To use this script, set it as the value of GIT_EDITOR (or core.editor).
> +
> +
> +Copyright (c) 2009 by Theodore P. Pavlic <ted@tedpavlic.com>
> +Highly influenced by hgeditor script distributed with Mercurial SCM.
> +Distributed under the GNU General Public License, version 2.0.

What information does the README add that is not in the script itself?

If there is none, please refrain from adding the README to begin with.

> diff --git a/contrib/giteditor/giteditor b/contrib/giteditor/giteditor
> new file mode 100755
> index 0000000..13ca5f6
> --- /dev/null
> +++ b/contrib/giteditor/giteditor
> @@ -0,0 +1,111 @@
> +#!/bin/sh
> +#
> +# A GIT_EDITOR to show diff alongside commit message.

Maybe "Set GIT_EDITOR to giteditor if you want to see a diff of what will 
be committed in the editor"?

> +# Find git
> +[ -z "${GIT}" ] && GIT="git"

Yes, I know it is contrib/, but you may want to adopt Git's coding style 
early.

Besides, I find it funny that you want to override git with $GIT.

> +# Use an editor. To prevent loops, avoid GIT_EDITOR and core.editor.
> +EDITOR=${GIT_EDITOR_EDITOR} || \
> +    EDITOR=${VISUAL} || \
> +    EDITOR=${EDITOR} || \
> +    EDITOR="vi";
> +
> +# If we recognize a popular editor, add necessary flags
> +case "${EDITOR}" in
> +    emacs)
> +        EDITOR="${EDITOR} -nw"

Mhm.  Should this not be the user's choice?  Some like emacs to start up 
in a window.

> +# Remove temporary files even if we get interrupted
> +GITTMP=""

GITTMP= would be completely sufficient.  Not to mention the consistency 
with Git's shell code.

> +# End GITTMP in ".git" so that "*.git/" syntax highlighting recognition
> +# doesn't break
> +GITTMP="${TMPDIR-/tmp}/giteditor.$RANDOM.$RANDOM.$RANDOM.$$.git"
> +(umask 077 && mkdir "${GITTMP}") || {
> +    echo "Could not create temporary directory! Exiting." 1>&2
> +    exit 1
> +}

Umm.  Why?  Why do you need a temporary .git directory?

> +if [ -f "$1" ]; then
> +    # We were passed an existing commit message
> +
> +    "${DIFFCMD}" ${DIFFARGS} >> "${GITTMP}/diff"
> +## Uncomment if you only want to see diff of what changed
> +## (note that it only works if DIFFCMD is git)
> +#    (
> +#        grep '^#.*modified:' "$1" | cut -b 15- | while read changed; do
> +#            "${DIFFCMD}" ${DIFFARGS} "${changed}" >> "${GITTMP}/diff"
> +#        done
> +#    )

--diff-filter=M

> +
> +     cat "$1" > "${GITTMP}/${COMMITMSG}"
> +
> +else
> +
> +    # Give us a blank COMMITMSG to edit
> +    touch "${GITTMP}/${COMMITMSG}"

Why not just touch it, instead of testing if the file exists first?

> +
> +    # Generate the diff
> +    "${DIFFCMD}" ${DIFFARGS} >> "${GITTMP}/diff"
> +    #touch "${GITTMP}/diff"

Commented out code in a submitted patch?

> +
> +fi
> +
> +# Use MD5 to see if commit message changed (necessary?)
> +MD5=$(which md5sum 2>/dev/null) || \
> +    MD5=$(which md5 2>/dev/null)
> +
> +[ -x "${MD5}" ] && CHECKSUM=$( ${MD5} "${GITTMP}/${COMMITMSG}" )
> +if [ -s "${GITTMP}/diff" ]; then
> +    # Diff is non-empty, so edit msg and diff
> +    ${EDITOR} "${GITTMP}/${COMMITMSG}" "${GITTMP}/diff" || exit $?

vi users will hate you, as you do not give them a chance to edit the 
message after having seen the diff.

> +else
> +    # Empty diff. Only edit msg
> +    ${EDITOR} "${GITTMP}/${COMMITMSG}" || exit $?
> +fi
> +[ -x "${MD5}" ] && (echo "${CHECKSUM}" | ${MD5} -c >/dev/null 2>&1 && exit 13)

git commit will abort anyway if the commit message has not changed.  Plus, 
it does a better job, as it checks only the non-commented-out text.

BTW why on earth do you put every single variable name in curly brackets?

> +
> +# Commit message changed, so dump it on original message from Git
> +mv "${GITTMP}/${COMMITMSG}" "$1"

And why did you not use "$1" all the time?

> +
> +# (recall that GITTMP directory gets cleaned up by trap above)
> +exit $?

Just writing "exit" is the same in effect, but preferred in Git shell 
coding.

Besides all that criticism, there is also a fundamental issue.  The diff 
is in a separate file.

Instead, I suggest having something like this:

-- snip --
#!/bin/sh

# set GIT_EDITOR or core.editor to this script if you want to see a diff
# instead of the output of "git status".

# filter out the "git status" output (keeping the "On branch" line)
mv "$1" "$1".tmp
grep -v "^# [^O]" < "$1".tmp > "$1"
rm "$1".tmp

# append the diff
case "$1" in
*.stgit-edit.txt)
	stg show
;;
*)
	git diff --cached
;;
esac | sed -e 's/^/# /' >> "$1"

exec ${VISUAL:-${EDITOR:-vi}} "$1"
-- snap --

Hth,
Dscho
