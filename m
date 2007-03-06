From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-mergetool to run an appropriate merge conflict resolution program
Date: Mon, 05 Mar 2007 21:43:48 -0800
Message-ID: <7vr6s3sz8r.fsf@assigned-by-dhcp.cox.net>
References: <E1HORtY-0000zK-8B@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 06 06:44:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOST0-0004RV-Ok
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 06:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965786AbXCFFnv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 00:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965784AbXCFFnv
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 00:43:51 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43871 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965786AbXCFFnu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 00:43:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306054350.FXIP2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 6 Mar 2007 00:43:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XHjo1W00H1kojtg0000000; Tue, 06 Mar 2007 00:43:49 -0500
In-Reply-To: <E1HORtY-0000zK-8B@candygram.thunk.org> (Theodore Ts'o's message
	of "Tue, 06 Mar 2007 00:07:28 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41538>

"Theodore Ts'o" <tytso@mit.edu> writes:

> +git-mergetool(1)
> +================
> +
> +NAME
> +----
> +git-mergetool - Forward-port local commits to the updated upstream head
> +

Hmph.  We already have a tool to achieve such a goal, and that
is called git-rebase.  Why would we want your program? ;-)

> diff --git a/git-mergetool.sh b/git-mergetool.sh
> new file mode 100755
> index 0000000..b961719
> --- /dev/null
> +++ b/git-mergetool.sh
> @@ -0,0 +1,208 @@
> +#!/bin/sh
> +#
> +# This program resolves merge conflicts in git
> +#
> +# Copyright (c) 2006 Theodore Y. Ts'o
> +#
> +# This file is licensed under the GPL v2, or a later version
> +# at the discretion of Linus Torvalds.

Heh ;-).

> +#
> +
> +usage () {
> +    echo "Usage: git mergetool [--tool=tool] [file to merge] ..."
> +    exit 1
> +}

Do we want to do this by hand ourselves, or dot-source sh-setup
like others?  You would also get die() for free.

> +merge_file () {
> ...
> +
> +	if test ! -f "$path" ; then
> +		echo "$path: file not found"
> +		exit 1
> +	fi
> +
> +	f=`git-ls-files -u "$path"`
> +	if test -z "$f" ; then
> +		echo "$path: file does not need merging"
> +		exit 1
> +	fi

You should be able to set IFS to exclude SP and then you only
have to say you do not support LF and HT, both of which are much
less likely than SP to be in the pathname.

> +	mv "$path" "$BACKUP"
> +	cp "$BACKUP" "$path"

What if $path is a symlink blob?  ;-)

> +	git cat-file blob ":1:$path" > "$BASE"
> +	git cat-file blob ":2:$path" > "$LOCAL"
> +	git cat-file blob ":3:$path" > "$REMOTE"

> +	case "$merge_tool" in
> +	    kdiff3)
> ...
> +	    tkdiff)
> ...
> +	    meld)
> ...
> +	    xxdiff)
> ...

It is depressing to see that the differences between the command
lines of these have to be much larger than just the command name
and order of three (or four if we count the result) paths
parameters.  I was hoping that we could do something like:

	mergetool -t='newmerge $BASE $LOCAL $REMOTE'

> +		xxdiff -X --show-merged-pane \
> +		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
> +		    -R 'Accel.Search: "Ctrl+F"' \
> +		    -R 'Accel.SearchForward: "Ctrl-G"' \

Do these configuration belong to individual scripts like this?

> +if test -z "$merge_tool" ; then
> +    if type kdiff3 >/dev/null 2>&1 && test -n "$DISPLAY"; then
> +	merge_tool="kdiff3";
> +    elif type tkdiff >/dev/null 2>&1 && test -n "$DISPLAY"; then
> +    	merge_tool=tkdiff
> +    elif type xxdiff >/dev/null 2>&1 && test -n "$DISPLAY"; then
> +    	merge_tool=xxdiff
> +    elif type meld >/dev/null 2>&1 && test -n "$DISPLAY"; then
> +        merge_tool=meld
> +    elif type emacs >/dev/null 2>&1; then
> +        merge_tool=emerge
> +    else
> +	echo "No available merge tools available."

Curious choice of words...

> +if test $# -eq 0 ; then
> +	files=`git ls-files -u --abbrev=8 | colrm 1 24 | sort -u`

Careful.  I think --abbrev=8 just means use at least 8 but more
as needed to make them unique.  sed -e 's/^[^	]*	//'
(whitespace are HTs) would be safer and simpler, as you are not
dealing with a pathname that has LF in it anyway.
