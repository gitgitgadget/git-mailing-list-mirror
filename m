From: Phil Pennock <phil-gitml@phil.spodhuis.org>
Subject: .gitignore sub-dir exclusions not overriding '*'
Date: Wed, 19 Nov 2014 03:40:11 +0000
Message-ID: <20141119034010.GA18145@tower.spodhuis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 04:48:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqwGJ-0003IR-3V
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 04:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbaKSDsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 22:48:55 -0500
Received: from mx.spodhuis.org ([94.142.241.89]:39387 "EHLO mx.spodhuis.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754175AbaKSDsc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 22:48:32 -0500
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Nov 2014 22:48:31 EST
Received: from authenticated user by smtp.spodhuis.org with esmtpa 
	id 1Xqw7p-0004oA-6d; Wed, 19 Nov 2014 03:40:13 +0000
Content-Disposition: inline
OpenPGP: url=https://www.security.spodhuis.org/PGP/keys/0x4D1E900E14C1CC04.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The behaviour below is seen with both git 1.8.3.2 and git 2.1.3; I am
not subscribed to the vger list, please keep me in the CC list.

Use-case: git repo which only holds PGP-encrypted files with a .asc
extension, no matter which sub-directory they're in, or if in the top
directory.

Simple layout; for demo purposes names starting 'incl' should end up
included, those starting 'excl' should end up excluded, but not based on
those prefices: they're success result indicators; so:

    cd wherever
    git init
    mkdir foo
    touch incl.asc excl excl.txt foo/incl.asc foo/excl.txt foo/excl
    $EDITOR .gitignore

Expected to work as .gitignore in top-level of repo:

    *
    !**/*.asc
    !.gitignore

With that, `git status` ignores the contents of foo/ thusly:

    $ git check-ignore -v foo/incl.asc
    .gitignore:1:*	foo/incl.asc

Commenting out the '*' line and removing the '!' from the second, the
**/*.asc clearly matches.  The only way I can make this style work is to
set the first line to '**/*.*' which fails to exclude the plain 'excl'
files (no extension).

It seems that there's some magic around '*' as the entire final path
component of a pattern which causes it to match against the entire
directory, and excludes of the directory can not be overriden by matches
against '*.ext' within the directory, even when they come later in the
same config file at the same precedence.

This does not seem to my reading to match the behaviour described by
`git help gitignore` (checked in both versions of git) and so seems to
me to be a bug, but if it's a failure of my understanding, please help
me to understand where I messed up.

Thanks,
-Phil
