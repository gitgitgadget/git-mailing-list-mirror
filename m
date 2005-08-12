From: Pavel Roskin <proski@gnu.org>
Subject: Re: New script: cg-clean
Date: Thu, 11 Aug 2005 23:59:00 -0400
Message-ID: <1123819140.4248.55.camel@dv>
References: <1120862084.17812.6.camel@dv>
	 <20050710154618.GF24249@pasky.ji.cz>
	 <1123312443.17959.34.camel@dv.roinet.com>
	 <20050811232925.GK25280@pasky.ji.cz> <1123808053.4248.47.camel@dv>
	 <20050812010811.GM25280@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 05:59:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3Qhf-0001ND-AW
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 05:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVHLD7P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 23:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVHLD7P
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 23:59:15 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:56002 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750775AbVHLD7O
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 23:59:14 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E3Qez-00089H-NA
	for git@vger.kernel.org; Thu, 11 Aug 2005 23:56:45 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E3QhD-00048e-Oz; Thu, 11 Aug 2005 23:59:03 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j7C3x05r015909;
	Thu, 11 Aug 2005 23:59:00 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050812010811.GM25280@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-08-12 at 03:08 +0200, Petr Baudis wrote:
> Dear diary, on Fri, Aug 12, 2005 at 02:54:13AM CEST, I got a letter
> where Pavel Roskin <proski@gnu.org> told me that...
> > Hi, Petr!
> 
> Hi,
> 
> > Unfortunately, my latest revision of cg-clean has "committed suicide"
> > just when I was about to post it.  Anyway, I would prefer to wait until
> > you apply my patch to cg-status to ignore all ignores.  That would allow
> > me to reuse cg-status.
> 
> well, I did quite a while ago. Unless the kernel.org mirroring system
> broke, it should be already public.

Yes, it's there.  Thank you.

This is another attempt at cg-clean.  Verbose mode is now default (i.e.
everything that's removed is reported), "-q" makes the script quiet.
I've reinstated the "hard" option, it's now "-D".

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
#	Also clean directories and their contents.
#
# -D::
#	Same as -d but try harder (change permissions first).
#
# -q::
#	Quiet - don't report what's being cleaned.
#
# -x::
#	Also clean files ignored by cg-status, such as object files.

USAGE="cg-clean [-d] [-D] [-q] [-x]"

. ${COGITO_LIB}cg-Xlib || exit 1

noexclude=
cleandir=
cleandirhard=
quiet=
while optparse; do
	if optparse -d; then
		cleandir=1
	elif optparse -D; then
		cleandir=1
		cleandirhard=1
	elif optparse -q; then
		quiet=1
	elif optparse -x; then
		noexclude=1
	else
		optfail
	fi
done

[ "$ARGS" ] && usage

clean_dirs()
{
	dirlist=$(mktemp -t gitlsfiles.XXXXXX)
	git-ls-files --cached | sed -n 's|^'"$_git_relpath"'||p' |
	sed -n 's|/[^/]*$||p' | sort -u >"$dirlist"

	save_IFS="$IFS"
	IFS=$'\n'

	fpath=${_git_relpath-./}
	find "$fpath" -type d -print | \
	sed 's|^'"$fpath"'||;/^$/d;/^\.git$/d;/^\.git\//d' |
	cat - "$dirlist" | sort -u | diff - "$dirlist" |
	sed -n 's/< //p' |

	for file in $(cat); do
		path="${_git_relpath}$file"
		if [ -z "$cleandir" ]; then
			echo "Not removing $file/"
			continue
		fi
		if [ ! -d "$path" ]; then
			# Perhaps directory was removed with its parent
			continue
		fi
		[ "$quiet" ] || echo "Removing $file/"
		if [ "$cleandirhard" ]; then
			chmod -R 700 "$path"
		fi
		rm -rf "$path"
		if [ -e "$path" -o -L "$path" ]; then
			echo "Cannot remove $file/"
		fi
	done

	IFS="$save_IFS"
	rm -f "$dirlist"
}

clean_files()
{
	xopt=
	if [ "$noexclude" ]; then
		xopt="-x"
	fi

	save_IFS="$IFS"
	IFS=$'\n'

	cg-status "$xopt" -w | sed -n 's/^? //p' |
	for file in $(cat); do
		path="${_git_relpath}$file"
		if [ -d "$path" ]; then
			# Sanity check, shouldn't happen
			echo "FATAL: cg-status reports directories" >&2
			exit 1
		elif [ -e "$path" -o -L "$path" ]; then
			[ "$quiet" ] || echo "Removing $file"
			rm -f "$path"
			if [ -e "$path" -o -L "$path" ]; then
				echo "Cannot remove $file"
			fi
		else
			echo "File $file has disappeared!"
		fi
	done

	IFS="$save_IFS"
}

# Even if -d or -D is not specified, we want to tell user about
# directories that are not removed
if [ -z "$quiet" -o "$cleandir" ]; then
	clean_dirs
fi

clean_files



-- 
Regards,
Pavel Roskin
