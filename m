From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-clean command
Date: Mon, 03 Apr 2006 17:06:36 -0700
Message-ID: <7vzmj2b3w3.fsf@assigned-by-dhcp.cox.net>
References: <20060403221841.25097.18242.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 02:06:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQZ4E-0005PR-Un
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 02:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWDDAGj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 20:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWDDAGj
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 20:06:39 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:45479 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751092AbWDDAGi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 20:06:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060404000637.XPLA17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Apr 2006 20:06:37 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <20060403221841.25097.18242.stgit@dv.roinet.com> (Pavel Roskin's
	message of "Mon, 03 Apr 2006 18:18:41 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18363>

Pavel Roskin <proski@gnu.org> writes:

> This command removes untracked files from the working tree.  This
> implementation is based on cg-clean with some simplifications.  The
> documentation is included.

I am not opposed to the command in the sense that I do not want
to forbid people from doing what they want to do, but on the
other hand I do not see why people (apparently many people) want
to have something like this.  Are their "make clean" broken?

Having said that, just some nitpicks.

> diff --git a/.gitignore b/.gitignore
>...
> +git-clean

I appreciate the attention to the detail; very nice to have
a .gitignore entry along with addition of a command.

> diff --git a/git-clean.sh b/git-clean.sh
>...
> +for arg in "$@"; do

	for arg
        do
        	...

> +	if [ "$arg" = "-d" ]; then

	case "$arg" in -d)...

> +excl1=
> +excl2=
> +if [ -z "$noexclude" ]; then
> +	excl1="--exclude-per-directory=.gitignore"
> +	if [ -f "$GIT_DIR/info/exclude" ]; then
> +		excl2="--exclude-from=$GIT_DIR/info/exclude"
> +	fi
> +fi
> +
> +git-ls-files --others --directory "$excl1" "$excl2" |
> +while read -r file; do
> ...

The $noexclude case passes two empty strings to git-ls-files,
which may happen to be harmless with the current implementation,
but does not feel quite right.

Maybe better to read ls-files -z to be really pathname safe, I
dunno.

> +		$echo1 "Removing $file"
> +		[ "$cleandirhard" ] && chmod -R 700 "$file"

I am not quite sure this chmod -R is a good idea.  If we are
trying really hard would we need to also make sure we can rmdir
the "$file" by chmod'ing its parent directory?  But once we
start doing that where would we stop?
