From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH v2] t7501-commit.sh: explicitly check that -F prevents invoking the editor
Date: Fri,  9 Jan 2009 18:30:05 +0100
Message-ID: <1231522205-10510-1-git-send-email-dato@net.com.org.es>
References: <alpine.DEB.1.00.0812301250210.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 09 18:31:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLLCo-0006Ew-Ns
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 18:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbZAIRaK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jan 2009 12:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbZAIRaJ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 12:30:09 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:2438
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZAIRaI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 12:30:08 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 8ED7D801BF68;
	Fri,  9 Jan 2009 18:30:06 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LLLBN-0002l0-RQ; Fri, 09 Jan 2009 18:30:05 +0100
X-Mailer: git-send-email 1.6.1.134.g55c35
In-Reply-To: <alpine.DEB.1.00.0812301250210.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105020>

The "--signoff" test case in t7500-commit.sh was setting VISUAL while
using -F -, which indeed tested that the editor is not spawned with -F.
However, having it there was confusing, since there was no obvious reas=
on
to the casual reader for it to be there.

This commits removes the setting of VISUAL from the --signoff test, and
adds in t7501-commit.sh a dedicated test case, where the rest of tests =
for
-F are.

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---
* Johannes Schindelin [Tue, 30 Dec 2008 13:04:46 +0100]:

> Hmm.  Obviously, I failed to document properly why I tested the edito=
r,=20
> but I think it makes sense to assume that -F still triggered an=20
> interactive editor at some stage in the development of builtin commit=
=2E

> I do not have anything against separating that issue into another tes=
t=20
> case, but I am strongly opposed to simply removing it.

Ok, I've moved it to a separate test case, please review to see if you
approve of it.

Thanks,

 t/t7500-commit.sh |    5 +----
 t/t7501-commit.sh |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 6e18a96..5998baf 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -149,10 +149,7 @@ EOF
=20
 test_expect_success '--signoff' '
 	echo "yet another content *narf*" >> foo &&
-	echo "zort" | (
-		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
-		git commit -s -F - foo
-	) &&
+	echo "zort" | git commit -s -F - foo &&
 	git cat-file commit HEAD | sed "1,/^$/d" > output &&
 	test_cmp expect output
 '
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 63bfc6d..b4e2b4d 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -127,6 +127,26 @@ test_expect_success \
 	"showing committed revisions" \
 	"git rev-list HEAD >current"
=20
+cat >editor <<\EOF
+#!/bin/sh
+sed -e "s/good/bad/g" < "$1" > "$1-"
+mv "$1-" "$1"
+EOF
+chmod 755 editor
+
+cat >msg <<EOF
+A good commit message.
+EOF
+
+test_expect_success \
+	'editor not invoked if -F is given' '
+	 echo "moo" >file &&
+	 VISUAL=3D./editor git commit -a -F msg &&
+	 git show -s --pretty=3Dformat:"%s" | grep -q good &&
+	 echo "quack" >file &&
+	 echo "Another good message." | VISUAL=3D./editor git commit -a -F - =
&&
+	 git show -s --pretty=3Dformat:"%s" | grep -q good
+	 '
 # We could just check the head sha1, but checking each commit makes it
 # easier to isolate bugs.
=20
--=20
1.6.1.134.g55c35
