From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/2] Fix interactive rebase when the editor saves with
 CR/LF
Date: Sun, 25 Oct 2015 15:10:11 +0100 (CET)
Message-ID: <cover.1445782122.git.johannes.schindelin@gmx.de>
References: <cover.1445777347.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 15:10:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqM0K-0004iX-Qi
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 15:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbbJYOKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 10:10:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:65460 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509AbbJYOKX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 10:10:23 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0M3ARX-1agfhb2IVD-00szbJ;
 Sun, 25 Oct 2015 15:10:12 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445777347.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:B8h3//aa4gVvgSvF3iqQd7kgtlWHRxJ84hO/On/hsGZnXSO8NZb
 vlH4lXBJfNueWNN9/tJUJg2+IU8d+ZOGBTJTDa+TDNRbY49agunq8irJ+ozu8qf6/02wqJr
 3+0iCDnUJBtBwP00cH4GTSMp79oga+xq86g0A3rZWOfQ7315o3VBL10W3SzgUofedXzAa3+
 SaSd5Eyq7hh81gOTJWsmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YOoBObGb2xw=:KMHXq4RRNCfsFhtshBZAuI
 HS64+OPt7bzKeReptUgAVK76zU6wNTIfiPIXVips0iHTK9vhD51QqLoCRYptfzWfqCwCy6xZp
 p+ATrArbofSftttSAy5mMS28vsY05r03qO/0K3dPl0Hs5mYdNfbHk2qUOaSuai9AtDenjoH6f
 mMureDmQ+G4wbjwcoD8U9wLHEypg4CD1s8B5qhQJGB1J9IjV/mQlVVaHqCVF7NoKpBtvUI7Bg
 4PbfXgkgFRzfcC7CxkGeNGFlKhkxLxs/24iZ/VHAxgR6WAfz19SZ+mxk7KwrkrDMxgzGLfS4A
 HdO/3ZuPm1GlrLZJjRNX3iiyqG4M35hUIaG3Fq8TE03caKX0D7WbhHP1oOGAf/xuZRDLftnF9
 QY9bzWJpIWPmW0BtZTR2x7EVZFNQ7vlI+Rt/CLBVG6KkVH+QvOxMsBL+736NBnCshZzr/yjJa
 PXV5JB17MUaN6CXiXZVJGdcJFnZCa89HdR9QFDaICC1s8UrFUOu26w4CRfevB74x6D0hAeUyO
 BUCXZ1BMy8JIiFTZ+UKn0Ew5QCQiTm9q2CiEiodFoEWDCIz1a7Y+LKwz3r5fy81hH6eU8cNpY
 0ePbR3q0BgNDT5Yb+lHmFcUoBNpYPDFevTgGjq62enmsMgKuFv2II606ly+5Vqs076RXPRoFC
 U2RdRPewSVLKzkoOcWAdhEc0oCsiQVxk7rnPjkQkwxJWJjHNeeChtuvp1bq81sIlLDTmbhu++
 64X+2aEtTLcCLbUT3NbqcGpD9Y+0ZGuBRbITtquqxp+GqfMGSKCNnti5LTDjeexoB7IK/V3d 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280151>

Chad Boles reported that `git rebase -i` recently started producing
errors when the editor saves files with DOS line endings. The symptom
is:

	Warning: the command isn't recognized in the following line:
	 -

	You can fix this with 'git rebase --edit-todo'.
	Or you can abort the rebase with 'git rebase --abort'.

The real bummer is that simply calling `git rebase --continue` "fixes"
it.

Turns out that we now check whether a single Carriage Return is a valid
command. This new check was introduced recently (1db168ee9, ironically
named "rebase-i: loosen over-eager check_bad_cmd check").

The proposed fix is to teach *all* shell scripts in Git to accept CR as
a field separator. Since LF is already specified as such, it should be
an uncontentious change.


Johannes Schindelin (2):
  Demonstrate rebase fails when the editor saves with CR/LF
  sh-setup: explicitly mark CR as a field separator

 git-sh-setup.sh               |  4 ++--
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

Interdiff vs v1:

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 94dfe04..e34673d 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -11,7 +11,7 @@ unset CDPATH
 
 # Similarly for IFS, but some shells (e.g. FreeBSD 7.2) are buggy and
 # do not equate an unset IFS with IFS with the default, so here is
-# an explicit SP HT LF.
+# an explicit SP HT LF CR.
 IFS=' 	
-'"$(printf '
')"
+'"$(printf '\r')"
 

-- 
2.1.4
