From: Pavel Roskin <proski@gnu.org>
Subject: Re: New script: cg-clean
Date: Sat, 06 Aug 2005 03:14:03 -0400
Message-ID: <1123312443.17959.34.camel@dv.roinet.com>
References: <1120862084.17812.6.camel@dv>
	 <20050710154618.GF24249@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 06 09:31:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1J8e-0006YN-07
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 09:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVHFH3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 03:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVHFH1u
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 03:27:50 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:59622
	"EHLO dv.roinet.com") by vger.kernel.org with ESMTP id S262088AbVHFHZ6
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 6 Aug 2005 03:25:58 -0400
Received: from dv.roinet.com (dv.roinet.com [127.0.0.1])
	by dv.roinet.com (8.13.4/8.13.4) with ESMTP id j767PrPc019633;
	Sat, 6 Aug 2005 03:25:53 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j767PpKs019629;
	Sat, 6 Aug 2005 03:25:51 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050710154618.GF24249@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello, Petr!

Sorry for delay.

On Sun, 2005-07-10 at 17:46 +0200, Petr Baudis wrote:
> Dear diary, on Sat, Jul 09, 2005 at 12:34:44AM CEST, I got a letter
> where Pavel Roskin <proski@gnu.org> told me that...
> > Hello, Petr!
> 
> Hello,
> 
> > Please consider this script for Cogito.
> > 
> > Signed-off-by: Pavel Roskin <proski@gnu.org>
> 
> the script is definitively interesting, but I have couple of notes
> about it first:
> 
> (i) -i sounds wrong for anything but being interactive here ;-) What
> about -A?

I agree that -i could be confusing, but -A would seem to imply "All", so
let it be -x from "exclude".

> (ii) I'm confused - if -a is all of the above, how do I clean _only_
> regular files, and only those not ignored by cg-status?

cg-clean without options.  I'm changing the description to avoid
confusion.

> (iii) Makes it any sense to remove only special files?

I thought it would make sense to have an option to remove them in
addition to regular files, but now I think it's not worth the trouble to
distinguish between them.

> (iv) -r implies being recursive, but it has nothing to do with that
> here.

Renamed to -d.  Other confusing options have been removed.  "-a" is
retired because it's not hard to type "-dx".  Explicit arguments are not
accepted - one can easily use "rm" instead.  That should make cg-clean
much simpler.

> (v) Semantically, I think it's quite close to cg-reset. What about
> making it part of cg-reset instead of a separate command? I tend to be
> careful about command inflation. (That's part of being careful about the
> usability in general.) That's just an idea and possibly a bad one, what
> do you think?

I understand your concern, but cg-reset does other things.  cg-reset
changes the branch.  cg-clean allows to start the build from scratch
without changing the branch.

It's not uncommon for me to revert patches one-by-one looking for the
patch that breaks something.  I could make minor changes e.g for
debugging or to fix breakage in certain revisions.  I would revert such
by cg-clean before going to another revision.  cg-reset would be an
overkill - it would move me to the latest release.

I can imagine that cg-reset would call cg-clean (optionally) to allow
fresh start on the main branch.  The opposite would be wrong.

Here's the simplified cg-clean script.  Note that the "-d" option is not
working with the current version of git of a bug in git-ls-files.  I can
work it around by scanning all directories in bash, but I think it's
easier to fix git (remove "continue" before DT_REG in ls-files.c).

Processing of .gitignore was taken from cg-status, and I don't really
understand it.  But I think it's important to keep that code in sync.
It could later go to cg-Xlib.

Signed-off-by: Pavel Roskin <proski@gnu.org>

#!/usr/bin/env bash
#
# Clean unknown files from the working tree.
# Copyright (c) Pavel Roskin, 2005
#
# Cleans file and directories that are not under version control.
# When run without arguments, files ignored by cg-status and directories
# are not removed.
#
# OPTIONS
# -------
# -d::
#	Also clean directories.
#
# -x::
#	Also clean files ignored by cg-status, such as object files.

USAGE="cg-clean [-d] [-x]"

. ${COGITO_LIB}cg-Xlib

cleanexclude=
cleandir=
while optparse; do
	if optparse -d; then
		cleandir=1
	elif optparse -x; then
		cleanexclude=1
	else
		optfail
	fi
done

# Good candidate for cg-Xlib
# Put exclude options for git-ls-files to EXCLUDE
set_exclude() {
	EXCLUDE=

	stdignores=('*.[ao]' '.*' tags '*~' '#*' ',,merge*')
	for ign in "${stdignores[@]}"; do
		EXCLUDE="$EXCLUDE --exclude=$ign"
	done

	EXCLUDEFILE=$_git/exclude
	if [ -f "$EXCLUDEFILE" ]; then
		EXCLUDE="$EXCLUDE --exclude-from=$EXCLUDEFILE"
	fi

	{
		path="$_git_relpath"
		dir=
		[ -r .gitignore ] && EXCLUDE="$EXCLUDE --exclude-from=.gitignore"
		while [[ "$path" == */* ]]; do
			dir="${dir:-.}/${path%%/*}"
			path="${path#*/}"
			[ -r $dir/.gitignore ] && EXCLUDE="$EXCLUDE --exclude-from=$dir/.gitignore"
		done
	}
}

if [ -z "$cleanexclude" ]; then
	set_exclude
else
	EXCLUDE=
fi	

git-update-cache --refresh > /dev/null

# Need to use temporary file so that changing IFS doesn't affect $EXCLUDE
# expansion.
filelist=$(mktemp -t gitlsfiles.XXXXXX)
git-ls-files --others $EXCLUDE >"$filelist"
save_IFS="$IFS"
IFS=$'\n'
for file in $(cat "$filelist"); do
	IFS="$save_IFS"
	if [ -d "$file" ]; then
		if [ "$cleandir" ]; then
			# Try really hard by changing permissions
			chmod -R 700 "$file"
			rm -rf "$file"
		fi
		return
	fi
	rm -f "$file"
done

rm -f "$filelist"


-- 
Regards,
Pavel Roskin
