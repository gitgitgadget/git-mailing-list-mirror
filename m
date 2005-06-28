From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Subject: GIT-CVS sync script
Date: Tue, 28 Jun 2005 21:14:46 +0200
Message-ID: <20050628191445.GA27979@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Jun 28 21:12:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnLR6-0007q5-4K
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 21:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVF1TO6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 15:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVF1TO6
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 15:14:58 -0400
Received: from lumumba.uhasselt.be ([193.190.9.252]:28433 "EHLO
	lumumba.uhasselt.be") by vger.kernel.org with ESMTP id S261153AbVF1TOZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 15:14:25 -0400
Received: by lumumba.uhasselt.be (Postfix, from userid 1000)
	id B303DEDB20; Tue, 28 Jun 2005 21:14:46 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I find the included script useful to easily track a CVS repository in
GIT. You can both call it for the initial import and ofcourse for the
subsequent resynchronisation with the parent CVS repository (that's what
the script's about).

Would it be better to provide this as a patch against git-cvsimport-script?

It has been tested on the RTAI-Fusion repository.

With friendly regards,
Takis

Signed-off-by: Panagiotis Issaris <takis@gna.org>

#!/usr/bin/env bash
#
# Keep a GIT repository in sync with a CVS repository.
# 
# Copyright (c) Panagiotis Issaris, 2005.
#

CVS2GIT_PATCHSETNR=.cvs2git_patchsetnr
CVS2GIT_UPGRADESCRIPT=.cvs2git_updatescript
PROJECT_GITDIR=`pwd`
PROJECT_CVSDIR=$1
CVSPS_OPTIONS="--no-rlog"

usage () {
        echo -e "Usage: \n\t$0 /path/to/project/cvsdir"
        exit 1
}

if test $# -lt 1 ; then
usage
else
if test ! -d $PROJECT_CVSDIR; then
usage
fi
fi

cd $PROJECT_CVSDIR

if test ! -d $PROJECT_GITDIR/.git; then

TZ=UTC cvsps $CVSPS_OPTIONS -A > $PROJECT_GITDIR/.git-cvsps-result
git-cvs2git --cvsroot=`cat CVS/Root` --module=`cat CVS/Repository` < $PROJECT_GITDIR/.git-cvsps-result > $PROJECT_GITDIR/.cvs2git_updatescript

else

if test -f $PROJECT_GITDIR/.cvs2git_patchsetnr; then
PATCHSETNR=`cat $PROJECT_GITDIR/.cvs2git_patchsetnr`;
else
PATCHSETNR=`cvsps | grep "^PatchSet " | tail -n1 | cut -f2 -d' '`
fi
let PATCHSETNR=$PATCHSETNR+1

# Updating from patchset $PATCHSETNR...
TZ=UTC cvsps $CVSPS_OPTIONS -x -s $PATCHSETNR- -A > $PROJECT_GITDIR/.git-cvsps-result
if test ! -s $PROJECT_GITDIR/.git-cvsps-result; then
echo "No new patchsets available"
exit 2
fi
git-cvs2git -u --cvsroot=`cat CVS/Root` --module=`cat CVS/Repository` < $PROJECT_GITDIR/.git-cvsps-result > $PROJECT_GITDIR/.cvs2git_updatescript

fi

# Storing last patchset number $PATCHSETNR
PATCHSETNR=`grep "^PatchSet " $PROJECT_GITDIR/.git-cvsps-result | tail -n1 | cut -f2 -d' '`
echo $PATCHSETNR > $PROJECT_GITDIR/.cvs2git_patchsetnr

# And finally, execute the generated script
cd $PROJECT_GITDIR
sh .cvs2git_updatescript
