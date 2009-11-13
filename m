From: Jeff Epler <jepler@unpythonic.net>
Subject: cherry-pick vs submodule, conflicts
Date: Fri, 13 Nov 2009 12:05:12 -0600
Message-ID: <20091113180512.GA29783@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 19:05:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N90Wb-0005c4-1R
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 19:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756624AbZKMSFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 13:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755541AbZKMSFV
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 13:05:21 -0500
Received: from dsl.unpythonic.net ([206.222.212.217]:43643 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751917AbZKMSFU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 13:05:20 -0500
Received: by unpythonic.net (Postfix, from userid 1000)
	id 09D971148EA; Fri, 13 Nov 2009 12:05:12 -0600 (CST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132839>

A fellow git user of mine encountered an unexpected problem cherry-
picking from one branch to another.  The conflict was 'added by us: sub'
and I created a small program that leads to the same message.

#!/bin/bash
# This script demonstrates that it doesn't work to cherry-pick when some (not
# even touched) path is a submodule in HEAD but a regular subdirectory in the
# branch being picked from.
#
# Furthermore, when using 'git mergetool', the (desired?) action 'c'
# gives the error "fatal: unable to stat 'sub': No such file or directory".
#
# The behavior is essentially the same on
# git version 1.6.3.3
# git version 1.6.5.rc1.49.ge970
#
# maybe this is related to
# http://kerneltrap.org/mailarchive/git/2007/7/7/250935
# but the case must be extended to cover submodules?

set -e
BASEDIR=$(pwd)
rm -rf main sub &&
mkdir sub main &&
(cd sub && git init && touch y && git add y && git commit -my) &&
                                        # make a submodule
cd ../main &&
git init &&
touch x; git add x &&
git commit -mx &&                       # initial commit
git branch b &&
mkdir sub &&                            # on master, make sub a subdir
touch sub/y; git add sub/y &&
git commit -my &&
echo 1 > x &&
git commit -mx1 -a &&                   # and create a second commit
CHERRY=$(git rev-parse HEAD) &&         # which is a tasty cherry
git checkout b &&
git submodule add file://$BASEDIR/sub sub &&
git submodule update &&
git commit -my &&                       # on brach, make sub a submodule
! git cherry-pick $CHERRY &&            # pull second commit from master
git status                              # what happened?
