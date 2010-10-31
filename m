From: Pete Wyckoff <pw@padd.com>
Subject: index rebuild for cloned repo
Date: Sun, 31 Oct 2010 13:44:30 -0400
Message-ID: <20101031174430.GA30236@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 31 18:50:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCc3H-0002wV-I4
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 18:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756462Ab0JaRui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 13:50:38 -0400
Received: from honk.padd.com ([74.3.171.149]:35192 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756283Ab0JaRuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 13:50:37 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Oct 2010 13:50:37 EDT
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 013B7276;
	Sun, 31 Oct 2010 10:44:32 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 11F78319E9; Sun, 31 Oct 2010 13:44:30 -0400 (EDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160444>

I'm trying to share pre-built working trees using NFS-server-side
volume cloning (not "git clone").  This makes a new volume that
shares all the data with the source volume, including build
products that would otherwise take hours to regenerate.  While
the data is identical, much of the inode information changes:
uid, gid, ino, dev, mtime, ctime.

What is the best way to rewrite .git/index in the clone?  Options
that work but are slow:

    git reset --hard HEAD
	write all files, breaking data sharing, 2 min 45 sec

    git update-index --refresh
	stat and read all files, 5 min 55 sec

I hacked out the file data comparison in ce_modified_check_fs()
to measure:

    HACKED git update-index --refresh
	Just the stat, 13 sec

The lstat() is required to look up the new inode number.

The rest of the clone operation takes around 3 min, so
I'd like to avoid this additional 5+ min of read()s if
possible.  Is there a way to do so using existing commands?
Should I add a new option to update-index, or maybe write
a stand-alone tool to manipulate the index file directly?

Thanks,

		-- Pete


P.S.  The user-observable problem that occurs if I do not
rebuild the index is, e.g.:

    $ git cherry-pick build/top
    error: Your local changes to 'file.h' would be overwritten by merge.  Aborting.
    Please, commit your changes or stash them before you can merge.
