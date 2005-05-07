From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Kernel nightly snapshots..
Date: Sat, 07 May 2005 13:39:28 +0100
Message-ID: <1115469570.29495.81.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0505041639130.2328@ppc970.osdl.org>
	 <42797F9F.9030002@zytor.com>
	 <1115303933.16187.135.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0505050742180.2328@ppc970.osdl.org>
	 <1115305813.16187.143.camel@hades.cambridge.redhat.com>
	 <1115307033.16187.146.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0505050846530.2328@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-+IFPTjOYi2m5Z1ha7V/V"
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 07 14:36:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUOXX-0008V7-Sj
	for gcvg-git@gmane.org; Sat, 07 May 2005 14:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbVEGMm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 08:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbVEGMlN
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 08:41:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18854 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263085AbVEGMkT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 08:40:19 -0400
Received: from shinybook.infradead.org ([81.187.226.99])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DUObI-0005ne-90; Sat, 07 May 2005 13:40:09 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505050846530.2328@ppc970.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-+IFPTjOYi2m5Z1ha7V/V
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-05-05 at 09:40 -0700, Linus Torvalds wrote:
> Btw, if you want to, you could simplify and optimize things heavily by 
> doign some very specific git internal mucking around, and using the new 
> "-m" flag I added to "git-diff-cache".

OK, this is in place now. I also made sure it was going to treat a real
'2.6.12' release as newer than '2.6.12-rcX'. The selection of the tags
and the output of the log are still chronological, which is of course
wrong -- but it'll do for now.

As an added bonus I've also fixed the script to refrain from creating a
-git1 snapshot even when there have been no commits since the last
release. And deleted 2.6.12-rc4-git1.

-- 
dwmw2

--=-+IFPTjOYi2m5Z1ha7V/V
Content-Disposition: inline; filename=git-snapshot.sh
Content-Type: application/x-shellscript; name=git-snapshot.sh
Content-Transfer-Encoding: 7bit

#!/bin/sh

set -x 

case `hostname` in
    hera.kernel.org)
	export PATH=/home/dwmw2/cogito:$PATH
	export BASE_DIRECTORY=/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
	STAGINGLOCK=/staging/upload.lock
	FINAL=/pub/linux/kernel/v2.6/snapshots
	;;
    shinybook.infradead.org)
	export PATH=/shiny/git/git-pasky-base:$PATH
	export BASE_DIRECTORY=/shiny/git/linux-2.6/.git
	unset FINAL
	unset STAGINGLOCK
	;;
    *)
	echo "Unknown host"
	exit 1;
esac

if [ ! -d $BASE_DIRECTORY ]; then
    echo BASE_DIRECTORY $BASE_DIRECTORY not present
    exit 1
fi

export WORK_DIRECTORY=$HOME/snapshots/2.6
export SNAP_TAG_DIRECTORY=$WORK_DIRECTORY/tags
export STAGE=$WORK_DIRECTORY/stage
export SHA1_FILE_DIRECTORY=$BASE_DIRECTORY/objects

# Find 'latest' tag in Linus' tree
# Chronological order is wrong but it'll do for now
RELNAME=`ls -rt $BASE_DIRECTORY/refs/tags/v2.* | tail -n1 | sed "s:$BASE_DIRECTORY/refs/tags/v::" `
RELOBJ=`cat $BASE_DIRECTORY/refs/tags/v$RELNAME`


# Find latest snapshot against that release, if there is one.
SNAPNAME=`ls -rt $SNAP_TAG_DIRECTORY/v$RELNAME-git* | tail -n1 | sed "s:$SNAP_TAG_DIRECTORY/v::" `

if [ "$SNAPNAME" == "" ]; then
	LASTOBJ=$RELOBJ
	CURNAME="$RELNAME-git1"
else
	LASTOBJ=`cat $SNAP_TAG_DIRECTORY/v$SNAPNAME`
	OLDGITNUM=`echo $SNAPNAME | sed s/^.*-git//`
	NEWGITNUM=`expr $OLDGITNUM + 1`
	CURNAME="$RELNAME-git$NEWGITNUM"
fi

LASTTREE=`tree-id $LASTOBJ`

CURCOMM=`cat $BASE_DIRECTORY/HEAD`
CURTREE=`tree-id $CURCOMM`
RELTREE=`tree-id $RELOBJ`

echo release $RELNAME commit $RELCOMM tree $RELTREE
echo last `git-cat-file -t $LASTOBJ` $LASTOBJ tree $LASTTREE
echo head $CURCOMM tree $CURTREE

[ "$LASTTREE" == "$CURTREE" ] && exit 0

#echo newsnap  $CURNAME $CURCOMM

EXTRAVERSION=-`echo $CURNAME | cut -f2- -d-`

cd $STAGE || exit 0

rm -rf tmp-empty-tree
mkdir -p tmp-empty-tree/.git
cd tmp-empty-tree

git-read-tree $CURCOMM
git-checkout-cache Makefile
perl -pi -e "s/EXTRAVERSION =.*/EXTRAVERSION = $EXTRAVERSION/" Makefile
git-diff-cache -m -p $RELTREE | gzip -9 > $STAGE/patch-$CURNAME.gz

# This is, unfortunately, in chronological order. Walking the tree would
# be better but we need a heuristic to tell 'local' vs 'remote' branches
echo $CURCOMM > $STAGE/patch-$CURNAME.id
cg-log $RELOBJ:$CURCOMM > $STAGE/patch-$CURNAME.log

echo $CURCOMM > $SNAP_TAG_DIRECTORY/v$CURNAME

echo New Snapshot $CURNAME

[ -z "$FINAL" ] && exit 0

if [ -r $STAGINGLOCK ]; then
    exec 200< /staging/upload.lock
    flock -s 200
fi

mv -v $STAGE/patch-$CURNAME* $FINAL

--=-+IFPTjOYi2m5Z1ha7V/V--

