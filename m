From: Jos van den Oever <jos@vandenoever.info>
Subject: git svn pushing to wrong branch
Date: Sat, 03 Oct 2015 12:58:58 +0200
Message-ID: <1678505.kvedRta3XZ@joga>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart36125116.8g1cQr7p54"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 03 13:08:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiKfm-00066I-HV
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 13:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbbJCLIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 07:08:09 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:46458 "EHLO
	mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbbJCLII (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 07:08:08 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Oct 2015 07:08:08 EDT
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
	by mailgw-02.dd24.net (Postfix) with ESMTP id C708A5FC44
	for <git@vger.kernel.org>; Sat,  3 Oct 2015 10:59:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
	mailpolicy-02.live.igb.homer.key-systems.net
Received: from mailgw-02.dd24.net ([192.168.1.36])
	by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
	with ESMTP id CYW8fsu6Xnoj for <git@vger.kernel.org>;
	Sat,  3 Oct 2015 10:58:59 +0000 (UTC)
Received: from localhost (ip913586c5.adsl-surfen.hetnet.nl [145.53.134.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mailgw-02.dd24.net (Postfix) with ESMTPSA
	for <git@vger.kernel.org>; Sat,  3 Oct 2015 10:58:58 +0000 (UTC)
User-Agent: KMail/4.14.3 (Linux/4.0.4; KDE/4.14.3; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278967>

This is a multi-part message in MIME format.

--nextPart36125116.8g1cQr7p54
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello dear gitters,

I've been trying to use git-svn to work with branches. When I merge branch A 
into branch B, and then do a dcommit, the change is not pushed to branch B. 
I've attached a bash script that demonstrates the issue. I've tested with svn 
1.9 and git 2.5.

The problem goes away when the merge is done with --no-ff.

Best regards,
Jos van den Oever
--nextPart36125116.8g1cQr7p54
Content-Disposition: attachment; filename="mergetest.sh"
Content-Transfer-Encoding: 7Bit
Content-Type: application/x-shellscript; name="mergetest.sh"

#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail


TESTDIR=/tmp/svntest
SVNREPODIR=$TESTDIR/svn
SVN_URI=file://$SVNREPODIR/test

cd $TESTDIR

rm -rf $SVNREPODIR test

svnadmin create $SVNREPODIR
svn mkdir --parents $SVN_URI/trunk $SVN_URI/branches $SVN_URI/tags -m 'Create branches.'

git svn clone -s $SVN_URI
cd test

# create and checkout a new branch v1.2
svn copy $SVN_URI/trunk $SVN_URI/branches/v1.2 -m 'Create branch v1.2.'
git svn fetch --all
git checkout origin/v1.2 -b v1.2

# add a new file to branch v1.2
echo -e 1\\n2\\n3 > test.txt
git add test.txt
git commit test.txt -m 'Add test.txt'
git svn dcommit --merge

# create and checkout a new branch v1.2_issue-1
svn copy $SVN_URI/branches/v1.2 $SVN_URI/branches/v1.2_issue-1 -m 'Create branch v1.2_issue-1'
git svn fetch --all
git checkout origin/v1.2_issue-1 -b v1.2_issue-1

# do work in branch v1.2_issue-1
echo -e 4\\n5 >> test.txt
git commit test.txt -m 'Extend test.txt'
git svn dcommit

# merge branch v1.2_issue-1 into v1.2
git checkout v1.2
git merge v1.2_issue-1

# error! the change is pushed to v1.2_issue-1 instead of v1.2
git svn dcommit
svn log $SVN_URI

--nextPart36125116.8g1cQr7p54--
