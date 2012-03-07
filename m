From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Bug in svn-fe: copying the root directory acts as if it's an empty
 directory
Date: Wed, 07 Mar 2012 23:13:06 +0000
Message-ID: <4F57EB82.4000309@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:13:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Q3G-0004E3-Uk
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 00:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632Ab2CGXNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 18:13:21 -0500
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:54462 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030527Ab2CGXNK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 18:13:10 -0500
X-Greylist: delayed 3985 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Mar 2012 18:13:09 EST
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120307231308.RRII14668.mtaout03-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Wed, 7 Mar 2012 23:13:08 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120307231308.TNSZ23925.aamtaout04-winn.ispmail.ntl.com@[192.168.0.2]>
          for <git@vger.kernel.org>; Wed, 7 Mar 2012 23:13:08 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=AxQYzBtj680A:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=-pYScUsbJR6y9qxaXrQA:9 a=1tFEhsJyL0cJARBrrfQA:7 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192500>

Here's a bug with svn-fe that I stumbled over while snorkelling through
repo madness.  I've tested it with the version of svn-fe in git.git's
master branch.

Copying the root directory to a sub-directory (e.g. doing `svn cp .
trunk` to standardise your layout) doesn't correctly initialise the new
directory.  To replicate the issue, run the following script from an
empty directory (update GIT_DIR to point to your git.git repository):

GIT_DIR="/home/andrew/git/git"
ROOT_DIR="$(pwd)"

svnadmin create repo
svn checkout "file://$ROOT_DIR/repo" checkout
cd checkout
echo text > README.txt
svn add README.txt
svn ci -m "Created README.txt"
svn cp "file://$ROOT_DIR/repo" "file://$ROOT_DIR/repo/trunk" \
    -m "Created trunk"
cd ..
mkfifo backchannel
mkdir git-repo
cd git-repo/
git init
svnadmin dump --deltas "$ROOT_DIR/repo" \
    | "$GIT_DIR/contrib/svn-fe/svn-fe" 3<../backchannel \
    | "$GIT_DIR/git-fast-import" --cat-blob-fd=3 3>../backchannel

Expected: the git repo contains "README.txt" and "trunk/README.txt"
Observed: "README.txt" exists but "trunk/README.txt" doesn't

	- Andrew
