From: Tony Lindgren <tony@atomide.com>
Subject: [SCRIPT] cg-rpush & locking
Date: Tue, 31 May 2005 12:00:05 -0700
Message-ID: <20050531190005.GE18723@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uQr8t48UFsdbeI+V"
Cc: Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Tue May 31 21:04:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdC0d-0003Ul-TP
	for gcvg-git@gmane.org; Tue, 31 May 2005 21:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVEaTEG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 15:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVEaTBZ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 15:01:25 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:51178 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261243AbVEaTAU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 15:00:20 -0400
Received: from pimout6-ext.prodigy.net (pimout6-int.prodigy.net [207.115.4.22])
	by ylpvm12.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j4VJ0D2A011391
	for <git@vger.kernel.org>; Tue, 31 May 2005 15:00:14 -0400
X-ORBL: [67.117.73.34]
Received: from torttu.muru.com (adsl-67-117-73-34.dsl.sntc01.pacbell.net [67.117.73.34])
	by pimout6-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j4VJ0Eug171610;
	Tue, 31 May 2005 15:00:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by torttu.muru.com (Postfix) with ESMTP id 499F0BF459;
	Tue, 31 May 2005 12:00:11 -0700 (PDT)
Received: from torttu.muru.com ([127.0.0.1])
	by localhost (torttu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24752-09; Tue, 31 May 2005 12:00:01 -0700 (PDT)
Received: from marenki.muru.com (unknown [192.168.100.15])
	by torttu.muru.com (Postfix) with ESMTP id 3D54ABF456;
	Tue, 31 May 2005 12:00:01 -0700 (PDT)
Received: by marenki.muru.com (Postfix, from userid 1000)
	id CAE0B31B51E; Tue, 31 May 2005 12:00:05 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: mutt-ng 1.5.9i (Linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at adsl-67-117-73-34.dsl.sntc01.pacbell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

Attached is a little script we're using for pushing changes to the
linux-omap tree. I modified it from an earlier script done by
Matthias Urlichs.

It uses rsync over ssh and should work with rsync write access too.

In order to remove lock files using rsync, I've added
a .git/locks subdirectory that contains the lock file.

The reason for this is that it allows replacing the lock directory
with an empty directory using rsync. This removes the lock file
after the remote update is done.

Currently the local lock has some issues with chained pushes...
If somebody is pushing from a remote repo to the local repo while
the local repo is being pushed to some other remote repo, the lock
may get removed.

Of course the lock does not protect from local changes either.

Anybody have any better ideas for locking that also works with
rsync?

Tony

--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=cg-rpush

#!/bin/sh
#
# Pushes changes from the local git repo to remote repo.
#
# Copyright (C) 2005 Tony Lindgren <tony@atomide.com>
#
# Some parts based on an earlier push script, 
# Copyright (C) 2005 Matthias Urlichs.
#
# Takes the remote repo's name or url as parameter.
#
# Most likely the remote repo is not rsync writable, but
# you can use rsync over ssh for the push.
#
# When using rsync over ssh, you must use the real repo
# path on the server and an ssh key to avoid typing in
# the password multiple times. For example:
#
# $ export RSYNC_FLAGS="-z --progress"
# $ export RSYNC_RSH="ssh -i /home/user/.ssh/my-git-key"
# $ cg-rpush some.machine:/home/git/repo
#

. ${COGITO_LIB}cg-Xlib

name=$1

BRANCHES=".git/branches"
HEADS=".git/refs/heads"
OBJECTS=".git/objects"
LOCKS=".git/locks"
REMOTE_LOCK="write_lock"
TMP="/tmp"

uri=""

function usage () {
	echo "Usage: [RSYNC_FLAGS=\"-e ssh\"] $0 some.machine:/home/git/repo"
	exit 1
}

function die () {
	if [ -f $LOCKS/$REMOTE_LOCK ]; then
		rm -f $LOCKS/$REMOTE_LOCK
	fi
	echo cg-rpush: $@ >&2
	exit 1
}

function clean_locks () {
	rm -f $LOCKS/$REMOTE_LOCK
	rsync $RSYNC_FLAGS -r --delete $LOCKS/ $uri/$LOCKS
}

function validate_input () {
	[ "$name" ] || usage
	if [ ! -d ".git" ]; then
		die "Could not find local .git directory"
	fi
	uri=$(cat $BRANCHES/$name 2>/dev/null)
	[ "$uri" ] || uri=$name
	echo $uri
}

#
# We must use a lock directory to allow removing the remote lock
# files with rsync by copying over it with an empty directory.
# Creating the remote lock file should be safe. However, please note
# that we must also be careful not to remove local .git/locks/write_lock
# in case somebody is pushing to our local repo from a remote machine.
# Currently the local lock file creation can conflict with a lock
# file creation from a remote machine to our local machine.
#
function lock_files () {
	echo "Attempting to to create a write lock on remote..."
	if [ ! -d $LOCKS ]; then
		mkdir $LOCKS;
	fi
	if [ -f $LOCKS/$REMOTE_LOCK ]; then
		echo "Local write_lock already exists: $LOCKS/$REMOTE_LOCK"
		exit 1
	fi
	lock_stamp="$USER@$HOSTNAME $(date)"
	echo $lock_stamp > $LOCKS/$REMOTE_LOCK
	rsync $RSYNC_FLAGS -r --ignore-existing $LOCKS/ $uri/$LOCKS

	# Check what the remote .git/locks/write_lock has
	tmpfile=$TMP/remote_lock_$RANDOM
	rsync $RSYNC_FLAGS "$uri/$LOCKS/$REMOTE_LOCK" $tmpfile
	remote_stamp=$(cat $tmpfile)
	rm -f $tmpfile
	if [ "$remote_stamp" != "$lock_stamp" ]; then
		die "Remote locked by $remote_stamp, please try again later"
	fi
}

function check_remote_version () {
	echo "Getting remote version..."
	tmpfile=$TMP/remote_head_$RANDOM
	rsync $RSYNC_FLAGS -Lr "$uri/$HEADS/master" $tmpfile
	remote_head=$(cat $tmpfile)
	rm -f $tmpfile
	if [ -z "$remote_head" ]; then
		clean_locks
		die "Remote repository does not have $uri/$HEADS/master"
	fi
	echo "Remote head is at: $remote_head"
	if [ "$(git-cat-file -t "$remote_head" 2>/dev/null)" != "commit" ]; then
		clean_locks
		die "Remote is ahead, please do a pull first"
	fi
}

function push_git_objects () {
	echo "Pushing .git/objects..."
	rsync $RSYNC_FLAGS --ignore-existing --whole-file -v -r \
		"$OBJECTS/" "$uri/$OBJECTS/"
}

function update_remote_head () {
	local_head=$(cat $HEADS/master)
	echo "Updating remote head to: $local_head"
	rsync $RSYNC_FLAGS -Lr $HEADS/master "$uri/$HEADS/master"
}

function print_note () {
	echo "Remote updated successfully"
	echo "NOTE: Not updating checked out remote files in case they"
	echo "have been edited locally on the remote machine."
	echo "To sync checked out files on remote, you can run cg-cancel"
	echo "on remote machine. You can check for uncommitted changes"
	echo "on remote with cg-diff first, which should only show"
	echo "changes done in this push."
}

#
# Main program
#
uri=$(validate_input)
lock_files
check_remote_version
push_git_objects
update_remote_head
clean_locks
print_note
exit

--uQr8t48UFsdbeI+V--
