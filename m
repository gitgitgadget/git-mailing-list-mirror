From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH] Bisect: add special treatment for bangs passed to
 "bisect run".
Date: Tue, 1 May 2007 14:17:25 +0200
Message-ID: <20070501141725.8ed0f26a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 14:09:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HirAn-0001k1-7f
	for gcvg-git@gmane.org; Tue, 01 May 2007 14:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031687AbXEAMJb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 1 May 2007 08:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031686AbXEAMJa
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 08:09:30 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:57079 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031687AbXEAMJ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2007 08:09:29 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 8E266B94F3;
	Tue,  1 May 2007 14:09:27 +0200 (CEST)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45943>

Something like:

 $ git bisect run ! grep string my_file

does not work right now probably because '!' is a shell keyword.

(This simple script shows the problem:

 $ echo "#"\!"/bin/sh" > ./simple_test.sh
 $ echo "echo \"running:\" \"\$@\"" >> ./simple_test.sh
 $ echo "\"\$@\"" >> ./simple_test.sh
 $ chmod +x ./simple_test.sh
 $ ./simple_test.sh ! grep foo bar.txt
 running: ! grep foo bar.txt
 ./simple_test.sh: line 3: !: command not found
)

This patch tries to work around this problem by counting how
many bangs are passed at the beginning of the "bisect run"
argument list and changing the exit code accordingly.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

Hallo Uwe,

Le mardi 1 mai 2007 11:44, Uwe Kleine-K=F6nig a =E9crit :
> Hallo Christian,
>
> I didn't check you patch in deep, but you should consider that the
> special meaning of "!" isn't implemented in the original Bourne
> Shell[1].

You are right.

> IIRC this or something similar was brought up some time ago and the
> result was, that your script has to do the negation if needed.

You mean something like this ?

Thanks,
Christian.

 git-bisect.sh               |   19 +++++++++++++++++++
 t/t6030-bisect-porcelain.sh |    9 +++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 1cd4561..0c40fc9 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -307,12 +307,31 @@ bisect_replay () {
 bisect_run () {
     bisect_next_check fail
=20
+    # Count '!' because they need special code.
+    bang_count=3D0
+    while [ "$1" =3D=3D '!' ]
+    do
+      bang_count=3D$(expr $bang_count + 1)
+      shift
+    done
+    test $bang_count -gt 0 && bang_modulo=3D$(expr $bang_count % 2)
+
+    # Bisect loop.
     while true
     do
       echo "running $@"
       "$@"
       res=3D$?
=20
+      # Change res depending on bang count.
+      if [ $bang_count -gt 0 ]; then
+	  if [ $bang_modulo -eq 0 ]; then
+	      test $res -gt 0 && res=3D1
+	  else
+	      test $res -eq 0 && res=3D1 || res=3D0
+	  fi
+      fi
+
       # Check for really bad run error.
       if [ $res -lt 0 -o $res -ge 128 ]; then
 	  echo >&2 "bisect run failed:"
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 30f6ade..56fd645 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -99,6 +99,15 @@ test_expect_success \
      grep "$HASH4 is first bad commit" my_bisect_log.txt &&
      git bisect reset'
=20
+# We again want to automatically find the commit that
+# introduced "Ciao" into hello.
+test_expect_success \
+    '"git bisect run" with bang in argument' \
+    'git bisect start $HASH4 $HASH1 &&
+     git bisect run ! grep Ciao hello > my_bisect_log.txt &&
+     grep "$HASH4 is first bad commit" my_bisect_log.txt &&
+     git bisect reset'
+
 #
 #
 test_done
--=20
1.5.2.rc0.71.g4342-dirty
