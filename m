From: worley@alum.mit.edu (Dale R. Worley)
Subject: Bug in "git log --graph -p -m" (version 1.7.7.6)
Date: Tue, 5 Feb 2013 12:00:16 -0500
Message-ID: <201302051700.r15H0GXx031004@freeze.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 18:07:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2lzo-0005z5-Sy
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 18:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733Ab3BERHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 12:07:25 -0500
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:57331
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754949Ab3BERHY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 12:07:24 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Feb 2013 12:07:24 EST
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id wfyS1k00E0EZKEL53h0JiY; Tue, 05 Feb 2013 17:00:18 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id wh0H1k00z1KKtkw3Mh0J6c; Tue, 05 Feb 2013 17:00:18 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r15H0Hj4031005
	for <git@vger.kernel.org>; Tue, 5 Feb 2013 12:00:17 -0500
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r15H0GXx031004;
	Tue, 5 Feb 2013 12:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1360083618;
	bh=yGDnzwX72NDPbtbHP00c/ISMXinNejs9y45ump9R/tE=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=HR6VlXP6FGO8c3/J1GUxshAoOfVGAX9C0VypcZPGNqXl9nF01aKi2ufyQZKYwZk/N
	 KZ6ye1PSKKX8kq2EaSoxnLptBukb/iHNSnverpDHyBbI42oV5H/oHFApbzyNwa5wMU
	 b2FRfduYOzaki+VZviOupPpDBleS6BDPzK5dzw6+TxB0VW7PScDagmH8fsAuDOEFxB
	 58a9as9/+rr6lSalL2QH04+9vnBL6+QMydd7SqmtTtQr4yN+DSA8O7+A9hapb2/gbB
	 VG4+gWTqzXtvvxpotJ+Xm6FSPmMNe5HyIUjC5crxHpb4NDXAwdzEbOi7nqd8/y8DlG
	 FSD6WysaDN2ow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215520>

I have found a situation where "git log" produces (apparently)
endless output.  Presumably this is a bug.  Following is a (Linux)
script that reliably reproduces the error for me (on Fedora 16):

----------
set -ve

# Print the git version.
git --version

# Create respository.
rm -rf .git
git init

# Initial commit.
( echo 1 ; echo 2 ; echo 3 ) >file
git add file
git commit -m 'Commit P'
git branch B HEAD

# Next commit on master adds line "1a".
( echo 1 ; echo 1a ; echo 2 ; echo 3 ) >file
git add file
git commit -m 'Commit Q'

git checkout B

# Next commit on B adds line "2a".
( echo 1 ; echo 2 ; echo 2a ; echo 3 ) >file
git add file
git commit -m 'Commit R'

# Merge the two commits, but add line "3a" to the commit as well.
git checkout master
git merge --no-commit B
# Show what the merge produces.
cat file
# Add line "3a".
( echo 1 ; echo 1a ; echo 2 ; echo 2a ; echo 3 ; echo 3a ) >file
git commit -m 'Commit S'

# These log commands work.
git log
git log --graph
git log --graph -p

# This log command produces infinite output.
git log --graph -p -m
----------

Dale
