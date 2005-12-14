From: Junio C Hamano <junkio@cox.net>
Subject: Re: new file leaked onto release branch
Date: Wed, 14 Dec 2005 00:37:10 -0800
Message-ID: <7v3bkw2hxl.fsf@assigned-by-dhcp.cox.net>
References: <200512140257.03975.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 09:39:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmS8Y-0006Jd-E1
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 09:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVLNIhO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 03:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVLNIhO
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 03:37:14 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:21997 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932099AbVLNIhN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 03:37:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051214083631.LRTU15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Dec 2005 03:36:31 -0500
To: Len Brown <len.brown@intel.com>
In-Reply-To: <200512140257.03975.len.brown@intel.com> (Len Brown's message of
	"Wed, 14 Dec 2005 02:57:03 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13621>

Len Brown <len.brown@intel.com> writes:

> Somehow a new file leaked from my "acpica" branch onto my "release" branch
> without me pulling "acpica" into "release".

I'll take a look at your "broken" branch later today (but will
go to bed first ;-), so please leave it around.

> I package up a tar-file for the remote machines with
> git-tar-tree $BRANCH $REPO | gzip -1 > $TARFILE
> But I still need to generate a patch containing all the local
> changes that I haven't checked into git yet.

Let me understand what you have correctly:

    You have the latest commit, changes needed to be tested in
    working tree, and index is somewhere in-between, because of
    "git-update-index --add" you did for patch generation; but
    ideally you would want to keep HEAD and index in sync.

And you need a way to do the above tar-tree + patch equivanent
to move what you have in your working tree to other machines for
pre-commit testing.  Some random thoughts on ways to do it.

(1) NFS with "make O=dir/to/store/output/files/"?

(2) Do you have git on other build boxes?  Perhaps

    mainbox$ edit on "acpica" branch
    mainbox$ git checkout -b build-test ;# branch from it
    mainbox$ git add some files
    mainbox$ git commit -a -m "Build test $(date)" ;# take all

    mainbox$ ssh i386box
    i386box$ git pull mainbox:/home/lnx/.git build-test
    Fast forward.
    i386box$ make ;# happy

    mainbox$ git checkout acpica ; git pull . build-test ;# fast forward

(3) Tarball approach, but taking the local modifications along
    as well:

    mainbox$ git update-index all-changed-paths-not-just-add
    mainbox$ git-tar-tree $(git-write-tree) $REPO | gzip >$TARFILE
    mainbox$ git reset ;# unregisters all mods since HEAD from index
    mainbox$ scp $TARFILE i386box:/home/lnx/

I suspect the last one is the least disruptive to your existing
workflow.
