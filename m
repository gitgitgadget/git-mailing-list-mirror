From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] [WIP] git on MacOSX and files with decomposed utf-8 file names
Date: Fri,  8 Feb 2008 08:09:36 +0100
Message-ID: <12024545841553-git-send-email-prohaska@zib.de>
References: <12024545763364-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mitch Tishmack <mitcht.git@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 11:02:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNQ4E-0004C9-PZ
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 11:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbYBHKCO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2008 05:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbYBHKCO
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 05:02:14 -0500
Received: from mailer.zib.de ([130.73.108.11]:35891 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932416AbYBHKCM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 05:02:12 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m1879iPs016369;
	Fri, 8 Feb 2008 08:09:44 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m1879aYY024894;
	Fri, 8 Feb 2008 08:09:44 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <12024545763364-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73063>

=46rom: Mitch Tishmack <mitcht.git@gmail.com>

[ spr: This patch contains Mitch's work with his original email
       as the commit message. ]

Apologies Steffen, I grabbed your CamelCase test and did a search/repla=
ce,
wasn't sure what to call it though... But I am on lunch and wanted to b=
e
useful. Rip it apart all you want.

=46ails on hfs* on OSX, works on ufs. I will bother with zfs when it ca=
n be used
again.

On UFS:
$ /bin/sh ./t0060-normalization.sh
*   ok 1: setup
*   ok 2: rename (silent normalization)
*   ok 3: merge (silent normalization)
* passed all 3 test(s)

On HFS:
$ /bin/sh t0060-normalization.sh
*   ok 1: setup
* FAIL 2: rename (silent normalization)

     git mv =C3=A4 =C3=A4 &&
     git commit -m "rename"

* FAIL 3: merge (silent normalization)

     git reset --hard initial &&
     git merge topic

* failed 2 among 3 test(s)

The test case, it uses perl, assuming only 5.6.1+ will work with this:

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t0060-normalization.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100755 t/t0060-normalization.sh

diff --git a/t/t0060-normalization.sh b/t/t0060-normalization.sh
new file mode 100755
index 0000000..f754fe4
--- /dev/null
+++ b/t/t0060-normalization.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description=3D'Test for silent normalization issues'
+
+. ./test-lib.sh
+
+auml=3D`perl -CO -e 'print pack("U",0x00E4)'`
+aumlcdiar=3D`perl -CO -e 'print pack("U",0x0061).pack("U",0x0308)'`
+test_expect_success setup "
+  touch $aumlcdiar &&
+  git add $aumlcdiar &&
+  git commit -m \"initial\"
+  git tag initial &&
+  git checkout -b topic &&
+  git mv $aumlcdiar tmp &&
+  git mv tmp $auml &&
+  git commit -m \"rename\" &&
+  git checkout -f master
+
+"
+
+test_expect_success 'rename (silent normalization)' "
+
+ git mv $aumlcdiar $auml &&
+ git commit -m \"rename\"
+
+"
+
+test_expect_success 'merge (silent normalization)' '
+
+ git reset --hard initial &&
+ git merge topic
+
+'
+
+test_done
--=20
1.5.4.40.g4a680
