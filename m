From: linux@horizon.com
Subject: Re: Digging through old vendor code
Date: 13 Jan 2008 11:28:06 -0500
Message-ID: <20080113162806.13991.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org, jonsmirl@gmail.com,
	torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Sun Jan 13 17:28:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE5hQ-0001OO-Ju
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 17:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbYAMQ2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 11:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbYAMQ2J
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 11:28:09 -0500
Received: from science.horizon.com ([192.35.100.1]:11404 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752226AbYAMQ2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 11:28:08 -0500
Received: (qmail 13993 invoked by uid 1000); 13 Jan 2008 11:28:06 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70396>

> Heh. Maybe you could just use the rename logic?
>
> [How-to snipped]

Clever idea, but I think the real problem was to figure out what VERSION
of the file was the base; i.e. to look through history.

Still, it should be possible to adapt the technique...

#!/bin/sh

# List of files we are looking to copy from
SRC="drivers/serial/"
# Temporary work directory
DST=/tmp/work
git-clone -l -n -s . $DST
{ cd $DST; git-symbolic-ref HEAD refs/heads/DELETEME; }
for i in `git-rev-list v2.6.20..v2.6.24-rc6 -- $SRC`; do
        j=`git-describe $i`
        git-archive --prefix="$j/" $i -- $SRC | tar xf - -C $DST
        # This is abusing the index, but it saves space...
        { cd $DST; git add $j; rm -rf $j; }
done

# And  now proceed as per Linus's idea...
# Except we have it all in the index; no need
# to actually make a commit...

cd $DST
cp $target_file $DST
{ cd $DST; git-diff-files -M...; }


Maybe a real git wizard will show me how to insert the index entries
directly without ever doing anything as pedestrian as extracting, hashing,
and then deleting the files, but it's still not that bad.

And it's kind of a neat example of using the index as a staging area
for a commit.

(Exercise for the reader: the above gets a complete copy of every file in
the directory for every commit in qhich ANY file in the directory changed.
Better would be to do the git-rev-list per-file, so you only add unique
file versions.  This requires an outer loop over file names and a more
careful pathname specification to git add in the inner loop.)
