From: Theodore Tso <tytso@mit.edu>
Subject: Re: Conflict editing
Date: Sun, 4 Mar 2007 13:10:44 -0500
Message-ID: <20070304181044.GC8560@thunk.org>
References: <Pine.LNX.4.63.0703041339350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 04 19:11:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNvAd-0006dl-MX
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 19:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbXCDSKx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 13:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbXCDSKx
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 13:10:53 -0500
Received: from THUNK.ORG ([69.25.196.29]:60784 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005AbXCDSKw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 13:10:52 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HNvG2-0003wJ-RI; Sun, 04 Mar 2007 13:16:31 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HNvAS-0006EQ-Mz; Sun, 04 Mar 2007 13:10:44 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703041339350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41363>

On Sun, Mar 04, 2007 at 01:43:59PM +0100, Johannes Schindelin wrote:
> I often end up with conflicts, and I just want to edit the conflicting 
> files, one after another. To make this easier, I wrote a script (yes, no 
> builtin) to start the editor with the files having conflicts.
> 
> Of course, this script is dumb and has no way to edit files whose names 
> contain spaces, it will choke on conflicting symlinks and it does not 
> update the index after editing the files (to avoid erroneous updating). As 
> usual, it did not really receive more testing than absolutely necessary.

As it turns out, I've been working on my own script, git-mergetool, to
deal with conflicts, and while it isn't quite ready for prime time yet
(no documentation, doesn't deal with filenames with spaces yet, etc.)
it does fire up the GUI merge tools and it does update the index
afterwards.  My intention is to polish this up and submit this into a
patch to git.  

The goal is to have similar functionality to what Bitkeeper and
Mercurial have as far as GUI merge tools are concerned.  Once I am
done polishing git-mergetool, I'll likely submit a patch to enable a
config option which will cause "git merge" to automatically fire up
"git mergetool" if there are any conflicts.

The patch doesn't current fall back to firing up an editor, but in
order to subsume Johannes' script's functionality, I will probably add
that functionality with code that looks for merge markers and which
only does the "git add" if the merge markers are completely gone.

It currently uses a hard-wired preference order for the GUI merge
tools, based on the current functionality of said merge tools, but the
plan is to add options parsing and a config option to allow a
user-specified override.

Any comments, suggestions?

						- Ted

#!/bin/sh
#
# This program resolves merge conflicts in git
#

KDIFF3="kdiff3"
TKDIFF="tkdiff"
MELD="meld"

type "$KDIFF3"    >/dev/null 2>&1 || KDIFF3=
type "$TKDIFF"    >/dev/null 2>&1 || TKDIFF=
type "$MELD"      >/dev/null 2>&1 || MELD=

if test -z "$KDIFF3" -a -z "$TKDIFF" -a -z "$MELD" ; then
	echo "No available GUI merge tools available."
	exit 1
fi

merge_file () {
	path="$1"

	if test ! -f "$path" ; then
		echo "$path: file not found"
		exit 1
	fi

	f=`git-ls-files -u "$path"`
	if test -z "$f" ; then
		echo "$path: file does not need merging"
		exit 1
	fi

	BACKUP="$path.BACKUP.$$"
	LOCAL="$path.LOCAL.$$"
	REMOTE="$path.REMOTE.$$"
	BASE="$path.BASE.$$"
	CHGTEST="$LOCAL.chg.$RAND"

	mv $path $BACKUP
	cp $BACKUP $path

	git show :1:$path > "$BASE"
	git show :2:$path > "$LOCAL"
	git show :3:$path > "$REMOTE"

	if test -n "$KDIFF3" ; then
		kdiff3 --auto "$BASE" "$LOCAL" "$REMOTE" -o "$path"
		status=$?
	elif test -n "$TKDIFF" ; then
		tkdiff "$LOCAL" "$REMOTE" -a "$BASE" -o "$path"
		status=$?
	elif test -n "$MELD" ; then
		meld "$LOCAL" "$path" "$REMOTE"
		if test "$path" -nt "$BACKUP" ; then 
			status=0;
		else
			while true; do
			        echo "$path seems unchanged."
			        echo -n "Was the merge successful? [y/n] "
			        read answer
			        case "$answer" in
			        	y*|Y*) status=0; break ;;
					n*|N*) status=1; break ;;
				esac
			done
		fi
	fi
	rm -f "$LOCAL" "$REMOTE" "$BASE"
	if test $status != 0 ; then
		echo "merge of $path failed" 1>&2
		mv "$BACKUP" $path
		exit 1
	fi
	git add $path
}

if test $# -eq 0 ; then
	files=`git ls-files -u --abbrev=8 | colrm 1 24 | sort -u`
	if test -z "$files" ; then
		echo "No files need merging"
		exit 0
	fi
	echo Merging the files: $files
	for i in `git ls-files -u --abbrev=8 | colrm 1 24 | sort -u`
	do
		merge_file "$i"
	done
else
	while test $# -gt 0; do
		merge_file "$1"
		shift
	done
fi
exit 0 
