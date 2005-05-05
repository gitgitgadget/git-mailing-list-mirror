From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Kernel nightly snapshots..
Date: Thu, 05 May 2005 16:10:11 +0100
Message-ID: <1115305813.16187.143.camel@hades.cambridge.redhat.com>
References: <Pine.LNX.4.58.0505041639130.2328@ppc970.osdl.org>
	 <42797F9F.9030002@zytor.com>
	 <1115303933.16187.135.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0505050742180.2328@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-pfElb6rshVZ77UmCuPvm"
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 17:05:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DThtS-00070g-PJ
	for gcvg-git@gmane.org; Thu, 05 May 2005 17:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVEEPKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 11:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVEEPKd
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 11:10:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62414 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262128AbVEEPKS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 11:10:18 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DThzS-0003Ou-1b; Thu, 05 May 2005 16:10:14 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505050742180.2328@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-pfElb6rshVZ77UmCuPvm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-05-05 at 07:44 -0700, Linus Torvalds wrote:
> If you fetch the _whole_ object database (with rsync), you should get 
> them.

OK, I've changed my 'origin' to an rsync URL referring to the same
place, to make sure I get tags correctly in future. 2.6.12-rc3-git1 is
in the process of being built; if the attached script works and
continues working when invoked from cron, we might even see nightly
snapshots again as requested...

-- 
dwmw2

--=-pfElb6rshVZ77UmCuPvm
Content-Disposition: inline; filename=git-snapshot.sh
Content-Type: application/x-shellscript; name=git-snapshot.sh
Content-Transfer-Encoding: 7bit

#!/bin/sh

export PATH=$PATH:/home/dwmw2/cogito

STAGINGLOCK=/staging/upload.lock
STAGE=/staging/dwmw2/snapshot-2.6
FINAL=/pub/linux/kernel/v2.6/snapshots

cd /home/dwmw2/git/snapshot-2.6

cg-update origin || exit 1

RELNAME=`cg-tag-ls | grep -v 'git' | tail -n1 | cut -f1 | sed s/^v//`
RELCOMM=`cg-tag-ls | grep -v 'git' | tail -n1 | cut -f2`
SNAPNAME=`cg-tag-ls | grep -- "$RELNAME-git" | tail -n1 | cut -f1 | sed s/^v//`
SNAPCOMM=`cg-tag-ls | grep -- "$RELNAME-git" | tail -n1 | cut -f2`
CURCOMM=`cat .git/HEAD`

echo release  $RELNAME $RELCOMM
echo lastsnap $SNAPNAME $SNAPCOMM 
echo head $CURCOMM

[ "$SNAPCOMM" == "$CURCOMM" ] && exit 0


if [ "$SNAPNAME" == "" ]; then
	CURNAME="$RELNAME-git1"
else
	OLDGITNUM=`echo $SNAPNAME | sed s/^.*-git//`
	NEWGITNUM=`expr $OLDGITNUM + 1`
	CURNAME="$RELNAME-git$NEWGITNUM"
fi


#echo newsnap  $CURNAME $CURCOMM

CURTREE=$CURCOMM
RELTREE=`git-cat-file tag $RELCOMM | head -n1 | cut -f2 -d' '`

EXTRAVERSION=-`echo $CURNAME | cut -f2- -d-`

perl -pi -e "s/EXTRAVERSION =.*/EXTRAVERSION = $EXTRAVERSION/" Makefile
cg-diff Makefile > $STAGE/tmppatch-extraver
checkout-cache -f Makefile

# echo $CURTREE:$RELTREE

# This is, unfortunately, in chronological order. Walking the tree would
# be better.
echo $CURCOMM > $STAGE/patch-$CURNAME.id
cg-log $RELTREE:$CURTREE > $STAGE/patch-$CURNAME.log
cg-diff -r $CURTREE:$RELTREE > $STAGE/tmppatch-$CURNAME-base
combinediff -p1 $STAGE/tmppatch-extraver $STAGE/tmppatch-$CURNAME-base | gzip -9 > $STAGE/patch-$CURNAME.gz
rm $STAGE/tmppatch-extraver $STAGE/tmppatch-$CURNAME-base
cg-tag v$CURNAME $CURCOMM

echo New Snapshot $CURNAME

if [ -r $STAGINGLOCK ]; then
    exec 200< /staging/upload.lock
    flock -s 200
fi

mv -v $STAGE/* $FINAL

--=-pfElb6rshVZ77UmCuPvm--

