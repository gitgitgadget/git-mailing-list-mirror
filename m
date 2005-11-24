From: Eric Wong <normalperson@yhbt.net>
Subject: simple git repository browser with vim
Date: Thu, 24 Nov 2005 01:33:22 -0800
Message-ID: <20051124093322.GA3899@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 24 10:35:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfDTr-0007OS-Q0
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 10:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbVKXJdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 04:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVKXJdY
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 04:33:24 -0500
Received: from hand.yhbt.net ([66.150.188.102]:30954 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1751327AbVKXJdX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 04:33:23 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id DA1EF2DC033; Thu, 24 Nov 2005 01:33:22 -0800 (PST)
To: git list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12700>

Here's a really quick and easy way to browse git repositories for vim
users.  Hopefully somebody else finds this useful, I know I do.

The idea is just to open a temporary file with git sha1sums (say git-log
output) in vim, move your cursor over any one of the object sha1sums,
and then hit ,G (or any shortcut of your choice) in normal mode to
show what one of those was.

It relies on a simple shell script I wrote called 'git-show' that picks
a reasonable way to display each of the blob, tree, or commit object
types.  I'm fairly sure somebody else has written something like
git-show before, I just couldn't find it.  I'd imagine it's pretty
useful standalone without vim, too.

If you :set foldmethod=marker in vim, you can pass the -f
flag to git-show and it'll enclose the output with the the default
vim fold markers: {{{  }}}

This is the line I've added to my .vimrc:

	map ,G yaw:.!git-show -f <c-r>" <CR>

And here is git-show in all it's glory:
---

#!/bin/sh

while : ; do
	case "$1" in
	-f|--fold-marker)
		fold_marker=1
		;;
	*)
		if [ -z "$sha1sum" ]; then
			sha1sum="$1"
		fi
		break
		;;
	esac
	shift
done

type=`git-cat-file -t $sha1sum`

if [ -n "$fold_marker" ]; then
	echo "$type($1) {{{"
fi

case "$type" in
	tree)
		git-ls-tree -r $1
		;;
	blob)
		git-cat-file blob $1
		;;
	commit)
		git-cat-file commit $1
		echo ''
		git-whatchanged --max-count=1 -C -p -r $1
		;;
esac

if [ -n "$fold_marker" ]; then
	echo '}}}'
fi

-- 
Eric Wong
