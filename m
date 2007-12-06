From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [RFC] Mirroring svn
Date: Wed, 05 Dec 2007 22:22:33 -0800
Message-ID: <1196922153.10408.101.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 07:23:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0A8r-00063H-SH
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 07:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683AbXLFGW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 01:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbXLFGW2
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 01:22:28 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:55240 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732AbXLFGW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 01:22:27 -0500
Received: by rv-out-0910.google.com with SMTP id k20so128804rvb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 22:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=xq8MAj+EGPeC78EX5q48rX/kkf0/gpSPi5Fw3UpgGhk=;
        b=SMF1R/PD/+qss9XAkaGW182OAYwfAeIg7scWTBw1mBaWBA2gtrExANfBUbImFPySHxzP/IVZtumZXJ3AixHiQ7qaUKR22xjB9AD6LLBhgqL477WCqzyowGd0tosOrAxGAaTzQMzIBg23UvAVkQhI2rfRZSpHK/1Gt2abfWmrMNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=nwMHytCyqaPU07CHswDEASMq/r5hinADIKy5W/X+nuhvC/J7X7xG5xiPAbkBsNB26Ek3UQv6bIUyJFvdmMaad4gXHI5rycm8Rh7dFr2vbpXJR3K07+QXX+XIs4xk1cMRf0qoEsL0un6ykikKpGRH9NUi9kJvfKPfqw/5SNart14=
Received: by 10.140.172.6 with SMTP id u6mr1745162rve.1196922145966;
        Wed, 05 Dec 2007 22:22:25 -0800 (PST)
Received: from ?192.168.1.101? ( [216.19.190.48])
        by mx.google.com with ESMTPS id k2sm729452rvb.2007.12.05.22.22.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Dec 2007 22:22:25 -0800 (PST)
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67253>

After the discussions lately regarding the gcc svn mirror.  I'm coming
up with a recipe to set up your own git-svn mirror.  Suggestions on the
following.

// Create directory and initialize git
mkdir gcc
cd gcc
git init
// add the remote site that currently mirrors gcc
// I have chosen the name gcc.gnu.org *1* as my local name to refer to
// this choose something else if you like
git remote add gcc.gnu.org git://git.infradead.org/gcc.git
// fetching someone else's remote branches is not a standard thing to do
// so we'll need to edit our .git/config file
// you should have a section that looks like:
[remote "gcc.gnu.org"]
	url = git://git.infradead.org/gcc.git
	fetch = +refs/heads/*:refs/remotes/gcc.gnu.org/*
// infradead's mirror puts the gcc svn branches in its own namespace
// refs/remotes/gcc.gnu.org/*
// change our fetch line accordingly
[remote "gcc.gnu.org"]
	url = git://git.infradead.org/gcc.git
	fetch = +refs/remotes/gcc.gnu.org/*:refs/remotes/gcc.gnu.org/*
// fetch the remote data from the mirror site
git remote update
// set up git-svn
// gcc has the standard trunk/branches/tags naming so use -s
// add a prefix so git-svn uses the metadata we just got from the
// mirror so we don't have to get everything from the svn server
// the --prefix must match whatever you chose in *1*, the trailing
// slash is important.
git svn init -s --prefix=gcc.gnu.org/ svn://gcc.gnu.org/svn/gcc
// your config should look like this now:
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[remote "gccmirror"]
	url = git://git.infradead.org/gcc.git
	fetch = +refs/heads/*:refs/remotes/gccmirror/*
[svn-remote "svn"]
	url = svn://gcc.gnu.org/svn/gcc
	fetch = trunk:refs/remotes/gcc.gnu.org/trunk
	branches = branches/*:refs/remotes/gcc.gnu.org/*
	tags = tags/*:refs/remotes/gcc.gnu.org/tags/*
// Try and get more revisions from the svn server
// this may take a little while the first time as git-svn builds
// metadata to allow bi-directional operation
git svn fetch


Happy Hacking

Harvey Harrison
