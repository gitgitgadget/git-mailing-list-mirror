From: Pavel Roskin <proski@gnu.org>
Subject: New script: cg-clean
Date: Fri, 08 Jul 2005 18:34:44 -0400
Message-ID: <1120862084.17812.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 09 00:42:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr1Y2-0001NT-OK
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 00:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbVGHWia (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 18:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbVGHWfW
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 18:35:22 -0400
Received: from h-64-105-159-118.noclli.covad.net ([64.105.159.118]:59031 "HELO
	roinet.com") by vger.kernel.org with SMTP id S262941AbVGHWep (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 18:34:45 -0400
Received: (qmail 3335 invoked from network); 8 Jul 2005 22:34:44 -0000
Received: from mtproxy.roinet.com (HELO dv) (192.168.1.1)
  by roinet.com with SMTP; 8 Jul 2005 22:34:44 -0000
To: git <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.3 (2.2.3-8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello, Petr!

Please consider this script for Cogito.

Signed-off-by: Pavel Roskin <proski@gnu.org>

#!/usr/bin/env bash
#
# Clean unknown files from the working tree.
# Copyright (c) Pavel Roskin, 2005
#
# Cleans file and directories that are not under version control.
# Only regular files that are not ignored by cg-status are cleaned
# by default.
#
# OPTIONS
# -------
# -i::
#	Clean files ignored by cg-status, such as object files.
#
# -s::
#	Clean symlinks, fifos, sockets and other special files.
#
# -r::
#	Clean directories.
#
# -R::
#	Clean directories, try harder.  Make directories writeable
#	recursively before removing.
#
# -a::
#	Clean all the above.
#
# If any other arguments are specified, they will be the only files
# considered for removal.  It will also imply the `-a' option.

USAGE="cg-clean [-i] [-s] [-r] [-R] [-a] [FILE]..."

. ${COGITO_LIB}cg-Xlib

cleanexclude=
cleanspecial=
cleandir=
cleandirhard=
while optparse; do
	if optparse -i; then
		cleanexclude=1
	elif optparse -s; then
		cleanspecial=1
	elif optparse -r; then
		cleandir=1
	elif optparse -R; then
		cleandirhard=1
	elif optparse -a; then
		cleanexclude=1
		cleandirhard=1
	else
		optfail
	fi
done

if [ "$ARGS" ]; then
	cleanexclude=1
	cleandirhard=1
fi

# Good candidate for cg-Xlib
# Put exclude options for git-ls-files to EXCLUDE
set_exclude() {
	stdignores=('*.[ao]' '.*' tags '*~' '#*' ',,merge*')
	for ign in "${stdignores[@]}"; do
		EXCLUDE="$EXCLUDE --exclude=$ign"
	done

	EXCLUDEFILE=$_git/exclude
	if [ -f "$EXCLUDEFILE" ]; then
		EXCLUDE="$EXCLUDE --exclude-from=$EXCLUDEFILE"
	fi
}

EXCLUDE=
if [ -z "$cleanexclude" ]; then
	set_exclude
fi	

git-update-cache --refresh > /dev/null

do_clean() {
	# FIXME - very suboptimal
	if [ "$ARGS" ]; then
		local found=
		for arg in "${ARGS[@]}"; do
			if [ "$arg" = "$file" ]; then
				found=1
				break
			fi
		done
		[ "$found" ] || return
	fi

	if [ "$cleandirhard" ]; then
		chmod -R 700 "$file"
		rm -rf "$file"
		return
	fi

	if [ "$cleandir" ]; then
		rm -rf "$file"
		return
	fi

	if [ "$cleanspecial" ]; then
		[ -d "$file" ] && return
		rm -f "$file"
		return
	fi

	[ -f "$file" ] && rm -f "$file"
}

# Need to use temporary file so that changing IFS doesn't affect $EXCLUDE
# expansion.
filelist=$(mktemp -t gitlsfiles.XXXXXX)
git-ls-files --others $EXCLUDE >"$filelist"
IFS=$'\n'
for file in $(cat "$filelist"); do
	do_clean "$file"
done

rm -f "$filelist"


-- 
Regards,
Pavel Roskin
