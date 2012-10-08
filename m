From: Mark Hills <mark@pogo.org.uk>
Subject: sharedRepository derived from file permissions
Date: Mon, 8 Oct 2012 10:07:30 +0100 (BST)
Message-ID: <1210080955590.12283@wes.ijneb.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 08 11:43:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TL9s0-0007LV-76
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 11:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192Ab2JHJnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 05:43:19 -0400
Received: from mx.ij.cx ([212.13.201.15]:59860 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751001Ab2JHJnR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 05:43:17 -0400
X-Greylist: delayed 2146 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Oct 2012 05:43:17 EDT
Received: from mark (helo=localhost)
	by wes.ijneb.com with local-esmtp (Exim 4.77)
	(envelope-from <mark@pogo.org.uk>)
	id 1TL9JC-0000S5-Vn
	for git@vger.kernel.org; Mon, 08 Oct 2012 10:07:30 +0100
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207228>

We make extensive use of unix permissions and core.sharedRepository -- 
multiple developers push to the same repo.

I have often wondered why core.sharedRepository is needed at all as a 
separate configuration?

It looks like it might be easier (and less confusing to users) to derive 
this attribute from the top-level .git directory?

For many years in our organisation we have been using the scripts below to 
make it easier for users to configure a repository -- a one-time 
operation.

Is there a reason why Git doesn't just follow (and echo) the top-level 
permissions?

Many thanks

-- 
Mark


#!/bin/bash
#
# Propagate permissions of the top-level directory through a repository,
# and configure it for use.
#

if [ "$1" = "--help" ]; then
	echo "Usage: $0 <bare_git_repo>.git"
	echo "Fix permissions on a Git repository, based on the permissions"
	echo "at the top level directory."
	exit 0
fi

if [ -z "$1" ]; then
	echo "Repository argument is mandatory (see --help); aborting."
	exit 1
fi

REPO="$1"

if [ ! -d "$REPO/objects" -o ! -f "$REPO/config" -o ! -f "$REPO/HEAD" ]; then
	echo "$REPO does not look like a bare Git repository; aborting."
	exit 1
fi

# Fix ownership
chown -cR --reference="$REPO" "$REPO"/*

# Fix all the directory permissions after ownership (setting ownership
# removes setgid bit)
find "$REPO" -type d | xargs chmod -c --reference="$REPO"

# Fix files
find "$REPO" -type f | xargs chmod --reference="$REPO"
find "$REPO" -type f | xargs chmod a-sx

# Tidy up; permissions on object files are always 444
find "$REPO/objects" -type f | xargs chmod 0444

# Configure the repository to remove the need for further fixes
# by basing core.SharedRepository on the top level permissions
PERM=0`stat -c '%a' "$REPO"`
MODE=`printf %04o $(($PERM&0666))` # bash required
if [ "$MODE" = "0660" ]; then
	MODE=group
elif [ "$MODE" = "0666" ]; then
	MODE=all
fi
git --git-dir "$REPO" repo-config core.sharedRepository "$MODE"
chmod --reference="$REPO" "$REPO/config"
chmod a-sx "$REPO/config"
