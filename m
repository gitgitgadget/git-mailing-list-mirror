From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] Bisect: fix calculation of the number of suspicious
	revisions
Date: Wed, 21 Mar 2007 22:04:54 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070321210454.GA2844@lala>
References: <20070317141209.GA7838@cepheus> <Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070317195840.GA20735@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 22:05:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU7zT-0007hN-4t
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 22:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbXCUVE7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 21 Mar 2007 17:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbXCUVE7
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 17:04:59 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:43925 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965026AbXCUVE6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2007 17:04:58 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HU7zN-00021b-Ap
	for git@vger.kernel.org; Wed, 21 Mar 2007 22:04:57 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2LL4s0e017801
	for <git@vger.kernel.org>; Wed, 21 Mar 2007 22:04:54 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2LL4s3c017800
	for git@vger.kernel.org; Wed, 21 Mar 2007 22:04:54 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070317195840.GA20735@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.14+cvs20070315 (2007-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42816>

Up to now the number printed was calculated assuming that the current r=
evision
to test is bad.  Given that it's not possible that this always matches =
the
number of suspicious revs if the current one is good, the maximum of bo=
th is
taken now.

Moreover I think the number printed was always one to high, this is fix=
ed, too.

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---
In the mail before I wrote that the former version of this patch was no=
t
complete.  This turned out to be a thinko.  So now I only used a better
Subject, a more verbose log and a hopefully more clear output.

 git-bisect.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index b1c3a6b..aeff732 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -150,8 +150,14 @@ bisect_next() {
 	    git-diff-tree --pretty $rev
 	    exit 0
 	fi
-	nr=3D$(eval "git-rev-list $rev $good -- $(cat $GIT_DIR/BISECT_NAMES)"=
 | wc -l) || exit
-	echo "Bisecting: $nr revisions left to test after this"
+	nr_bad=3D$(eval "git-rev-list $rev^ $good -- $(cat $GIT_DIR/BISECT_NA=
MES)" | wc -l) || exit
+	nr_good=3D$(eval "git-rev-list $bad^ ^$rev $good -- $(cat $GIT_DIR/BI=
SECT_NAMES)" | wc -l) || exit
+	if test "$nr_bad" -ge "$nr_good"; then
+		nr=3D"$nr_bad";
+	else
+		nr=3D"$nr_good";
+	fi;
+	echo "Bisecting: up to $nr suspicious revisions left after this test"
 	echo "$rev" > "$GIT_DIR/refs/heads/new-bisect"
 	git checkout -q new-bisect || exit
 	mv "$GIT_DIR/refs/heads/new-bisect" "$GIT_DIR/refs/heads/bisect" &&
--=20
1.5.0.3

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+hertz+in+sec**-1
