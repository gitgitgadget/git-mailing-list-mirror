From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [BUG] git-svn dcommit fails (connection closed unexpectedly)
Date: Mon, 14 May 2007 20:13:26 +0200
Message-ID: <vpqtzuf46k9.fsf@bauges.imag.fr>
References: <vpq7irfengj.fsf@bauges.imag.fr>
	<8c5c35580705110427o4de686e8qdb37f6a2da0043e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 20:14:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnf3c-0006A5-6c
	for gcvg-git@gmane.org; Mon, 14 May 2007 20:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860AbXENSNi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 14:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756645AbXENSNi
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 14:13:38 -0400
Received: from imag.imag.fr ([129.88.30.1]:40996 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756860AbXENSNh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 14:13:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4EIDQxB004537
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 14 May 2007 20:13:26 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hnf30-0005cD-DP; Mon, 14 May 2007 20:13:26 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hnf30-0006u1-Au; Mon, 14 May 2007 20:13:26 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <8c5c35580705110427o4de686e8qdb37f6a2da0043e4@mail.gmail.com> (Lars Hjemli's message of "Fri\, 11 May 2007 13\:27\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 14 May 2007 20:13:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47281>

--=-=-=

"Lars Hjemli" <lh@elementstorage.no> writes:

> Is this happening if you dcommit a file in a new directory?

That's it indeed.

The attached script seems to reproducibly trigger the problem on my
box:

$ ../git-svn-test.sh
Checked out revision 0.
A         file
Adding         file
Transmitting file data .
Committed revision 1.
Initialized empty Git repository in .git/
moy@localhost's password: 
        A       file
r1 = 4357177f2d927931d31c8c49c0237561648001a7 (git-svn)

Checked out HEAD:
  svn+ssh://localhost//home/moy/tmp/test/test.26377/svnrepo r1
Created commit aa2db5a: newdir
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 newdir/newfile
moy@localhost's password: 
        A       newdir/newfile
Network connection closed unexpectedly: Connection closed unexpectedly at /home/moy/bin/local/verimag/git-svn line 405
$


--=-=-=
Content-Type: text/x-sh
Content-Disposition: attachment; filename=git-svn-test.sh

#! /bin/sh

mkdir test.$$
cd test.$$

svnadmin create svnrepo

svn co file://$PWD/svnrepo svnco

cd svnco
echo content > file
svn add file
svn commit -m "added file"
cd ../

# This triggers the bug.
git-svn clone svn+ssh://localhost/$PWD/svnrepo git-svn-co

# while this doesn't
# git-svn clone file://localhost/$PWD/svnrepo git-svn-co

cd git-svn-co

mkdir newdir
echo othercontent > newdir/newfile

git add newdir/newfile

git commit -m "newdir"

git-svn dcommit

--=-=-=



-- 
Matthieu

--=-=-=--
