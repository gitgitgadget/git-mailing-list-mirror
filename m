From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [SCRIPT] cg-rpush & locking
Date: Thu, 02 Jun 2005 21:15:21 +0200
Message-ID: <429F5AC9.5080107@gmail.com>
References: <20050531190005.GE18723@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070107020506060207080401"
Cc: Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Thu Jun 02 21:19:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdvCd-0007wN-QM
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 21:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVFBTUV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 15:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVFBTTn
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 15:19:43 -0400
Received: from main.gmane.org ([80.91.229.2]:36314 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261251AbVFBTSO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 15:18:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ddv8h-0007M8-2f
	for git@vger.kernel.org; Thu, 02 Jun 2005 21:13:59 +0200
Received: from h65n2fls35o265.telia.com ([217.211.115.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Jun 2005 21:13:59 +0200
Received: from holmsand by h65n2fls35o265.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Jun 2005 21:13:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h65n2fls35o265.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <20050531190005.GE18723@atomide.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------070107020506060207080401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tony Lindgren wrote:
> Anybody have any better ideas for locking that also works with
> rsync?

Since this seems to be Push Day on the git list, here's my feeble 
attempt at the same thing (attached cg-push script).

I do stuff in this order:

     1. read remote HEAD
     2. check that a merge from local HEAD to remote would be
        fast-forward, otherwise tell people to pull and merge.
     3. push objects using --ignore-existing (or equivalent)
     4. write lock file with --ignore-existing. The lock file
        contains, in particular, the HEAD to be written.
     5. read remote HEAD (again) and the lock file. Bail if HEAD
        changed since the first read, or if the lock file isn't
        the one we attempted to write.
     6. write remote HEAD and delete lock file in using rsync's
        --delete-after

This should always be safe, since rsync (as I understand the man page) 
always writes to temp files, and then renames into place. Checking for 
fast-forward-mergability assures that other peoples changes don't get lost.

cg-push determines uri and foreign branch name using the same rules as 
cg-pull, which is real nice as it allows you to do:

$ cg-clone me@myserver.example.com:git-repos/myrepo.git mystuff
$ cd mystuff
# write some stuff
$ cg-commit
$ cg-push

and later

$ cg-update
# write more stuff
$ cg-commit
$ cg-push

and even later

$ cg-branch-add pub me@myserver.example.com:public-repos/myrepo.git
$ cg-push pub

So, you can work pretty much exactly as you would do in CVS or svn, if 
you're so inclined, safely sharing a common repository among many users.

Which is kinda neat, if I may say so myself...

/dan

--------------070107020506060207080401
Content-Type: text/plain;
 name="cg-push"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cg-push"

#! /usr/bin/env bash
#
# Push changes to a remote git repository
#
# Copyright (c) Dan Holmsand, 2005.
#
# Based on cg-pull,
# Copyright (c) Petr Baudis, 2005.
#
# Takes the branch name as an argument, defaulting to "origin" (see
# `cg-branch-add` for some description of branch names).
#
# Takes one optional option: --force, that makes cg-push write objects
# regardless of lock-files and remote state. Use with care...
#
# cg-push supports two types of location specifiers:
#
# 1. local paths - simple directory names of git repositories
# 2. rsync - using the "[user@]machine:some/path" syntax
#
# Typical use would look something like this:
#
#	# clone a remote branch:
#	cg-clone me@myserver.example.com:repo.git myrepo
#	cd myrepo
#
#	# make some changes, and then do:
#	cg-commit
#	cg-push
#	
# cg-push is safe to use even if multiple users concurrently push
# to the same repository. Here's how this works:
#
# First, cg-push checks that the local repository is fully merged with
# the remote one (this will always be the case if there is only one
# user). Otherwise, you need to cg-update from the remote repository
# before you can cg-push to it.
#
# Then, cg-push writes all the object files that are missing in the
# remote repository.
#
# To finish, cg-push writes a lock file to the remote site (ignoring
# any preexisting lock file), checks that our lock file actually got 
# written, checks that the remote head is still the same (i.e. that 
# the remote site hasn't been updated while we were copying objects), 
# writes the new remote head and removes the lock.
#
# The head of the local repository is also updated in the process (as if
# the remote branch had been cg-pull'ed).
#
# cg-push requires that there already is a repository in place at the
# remote location, but it actually only checks that it has a 
# "refs/heads" subdirectory. So, creating a remote repo ready for
# cg-pushing is as easy "mkdir -p repo.git/heads/refs" at the remote
# location.

# TODO: Write tags as well.

. ${COGITO_LIB}cg-Xlib

force=
if [ "$1" = --force ]; then
	force=1; shift
fi

name=$1
[ "$name" ] || { [ -s $_git/refs/heads/origin ] && name=origin; }
[ "$name" ] || die "what to push to?"
uri=$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch: $name"

rembranch=master
if echo "$uri" | grep -q '#'; then
	rembranch=$(echo $uri | cut -d '#' -f 2)
	uri=$(echo $uri | cut -d '#' -f 1)
fi

case $uri in
	*:*)
	readhead=rsync_readhead
	writeobjects=rsync_writeobjects
	writehead=rsync_writehead
	lock=rsync_lock
	;;
	*)
	if [ -d "$uri" ]; then
		[ -d "$uri/.git" ] && uri=$uri/.git
		readhead=local_readhead
		writeobjects=local_writeobjects
		writehead=local_writehead
		lock=local_lock
	else
		die "Don't know how to push to $uri"
	fi
	;;
esac

tmpd=$(mktemp -d -t cgpush.XXXXXX) || exit 1
trap "rm -rf $tmpd" SIGTERM EXIT

cid=$(commit-id) || exit 1
lock_msg="locked by $USER@$HOSTNAME on $(date) for writing $cid"
unset locked remhead

rsync_readhead() {
	rm -f "$tmpd/*" || return 1
	rsync $RSYNC_FLAGS --include="$rembranch" --include="$rembranch.lock" \
		--exclude='*' -r "$uri/refs/heads/" "$tmpd/" >&2 || 
		die "Fetching heads from $uri failed. Aborting."
	if [ "$locked" ]; then
		[ -s "$tmpd/$rembranch.lock" ] ||
		die "Couldn't acquire lock. Aborting."

		local rem_lock_msg=$(cat "$tmpd/$rembranch.lock")
		[ "$lock_msg" = "$rem_lock_msg" ] ||
		die "Remote is locked ($rem_lock_msg)."
	fi
	[ ! -e "$tmpd/$rembranch" ] || cat "$tmpd/$rembranch"
}

rsync_writeobjects() {
	[ -d "$_git/objects/" ] || die "no objects to copy"
	rsync $RSYNC_FLAGS -vr --ignore-existing --whole-file \
		"$_git/objects/" "$uri/objects/" 
}

rsync_lock() {
	echo "$lock_msg" > $tmpd/new_head_lock_file || return 1
	rsync $RSYNC_FLAGS --ignore-existing --whole-file \
		$tmpd/new_head_lock_file "$uri/refs/heads/$rembranch.lock"
}

rsync_writehead() {
	local heads=$tmpd/newhead
	mkdir $heads && echo "$1" > "$heads/$rembranch" || return 1
	rsync $RSYNC_FLAGS --include="$rembranch" --include="$rembranch.lock" \
		--exclude='*' --delete-after -r $heads/ "$uri/refs/heads/" 
}

local_readhead() {
	local lheads=$uri/refs/heads
	[ -d "$lheads" ] || die "no remote heads found at $uri"
	[ ! -e "$lheads/$rembranch" ] || cat "$lheads/$rembranch" 
}

local_writeobjects() {
	[ -d "$_git/objects/" ] || die "no objects to copy"
	[ -d "$uri/objects" ] || 
		GIT_DIR=$uri GIT_OBJECT_DIRECTORY=$uri/objects git-init-db ||
		die "git-init-db failed"
        # Note: We could use git-local-pull here, but this is safer
	# (git-*-pull don't react well to failures or kills), and
	# has the same semantics as rsync pushing.
	local dest=$(cd "$uri/objects" && pwd) || exit 1
	( cd "$_git/objects" && find -type f | while read f; do
		[ -f "$dest/$f" ] && continue
		ln "$f" "$dest/$f" 2>/dev/null || 
		cp "$f" "$dest/$f" || exit 1
	done ) 
}

local_lock() {
	([ "$force" ] || set -C 
	echo "$lockmsg" > "$uri/refs/heads/$rembranch.lock") 2>/dev/null
}

local_writehead() {
	local head=$uri/refs/heads/$rembranch
	echo "$1" > "$head.new" && mv "$head.new" "$head" &&
	rm "$head.lock"
}

echo "Checking remote repository"
remhead=$($readhead) || exit 1
[ "$remhead" ] || echo "Creating new branch"

if [ "$remhead" -a -z "$force" ]; then
	if [ "$remhead" = "$cid" ]; then
		echo "Remote branch \`$name' is already pushed" 
		exit 0
	fi
	git-cat-file commit "$remhead" &> /dev/null ||
	die "You need to pull from $name first. Aborting."

	base=$(git-merge-base "$remhead" "$cid") && [ "$base" ] ||
	die "You need to merge $name. Aborting."

	if [ "$base" = "$cid" ]; then
		echo "No changes to push"; exit 0
	fi

	[ "$base" = "$remhead" ] || 
	die "You need to merge $name first. Aborting." 
fi

echo "Writing objects"
$writeobjects || die "Failed to write objects. Aborting."

echo
echo "Writing new head"
$lock || die "Couldn't acquire lock on remote. Aborting."

if [ ! "$force" ]; then
	locked=1
	remhead2=$($readhead) || die "Aborting."
	[ "$remhead" = "$remhead2" ] || 
		die "Remote head changed during copy. Aborting."
fi

$writehead "$cid" || die "WARNING: Error writing remote head. Aborting."
echo "Push to $name succeeded"

echo "$cid" > "$_git/refs/heads/$name"
echo "Updated local head for $name to $cid"


--------------070107020506060207080401--

