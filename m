From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 25/29] "guilt push" now fails when there are no more patches to push.
Date: Tue, 13 May 2014 22:31:01 +0200
Message-ID: <1400013065-27919-26-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=latin-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:37:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJSX-0008Ka-JW
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbaEMUhv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 16:37:51 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:51781 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189AbaEMUhr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:37:47 -0400
Received: by mail-la0-f52.google.com with SMTP id gl10so705091lab.25
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=dG/S5TfIMQjqFpgneduKObHKQvT3OoNGgxWF+y672bA=;
        b=VcNrKbGFCJa3CrkZNMU8gIR0hv7PqcMGA23c7puSCK4vgR3urXP8x4Zzk3ARooli95
         vdqOigVSzYTcXaPq7qCsXKEDcUbhtHakUZNcmWGs1GEsfkEvRhWa0awf/QTJ84Oefp/t
         S99NjmmFLDY+KeipAaKla2ou1VKJTOHnE5Nd4Hcy/Rvh7uac5bNjHy2BBaKWMXQiHudx
         H6g5oYSnEheBtSUI63HEvmUmuymL7vpeK3flT46yf1ivZ+B3gsQwfbhvLCh0PCYKyQoR
         PA3p6hztozxKcsh0Aw6HjESSt7gpNkJvHzIPNY2UFt2U4yB+vejWqd+JFerwpzKC+IIv
         WIHQ==
X-Gm-Message-State: ALoCoQkrUAdp32VnMOaoBBijTa1TEuym2uIteEDXIv+150uaDDJd7AMsRIKntBml6lw580urgbQ7
X-Received: by 10.112.17.102 with SMTP id n6mr7910014lbd.39.1400013466647;
        Tue, 13 May 2014 13:37:46 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.37.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:37:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248843>

This makes it easier to script operations on the entire queue, for
example run the test suite on each patch in the queue:

    guilt pop -a;while guilt push; do make test||break; done

This brings "guilt push" in line with the push operation in Mercurial
Queues (hg qpush), which fails when there are no patches to apply.

Updated the test suite.

"guilt push -a" still does not fail.  (It successfully manages to
ensure that all patches are pushed, even if it did not have to do
anything to make it so.)

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt-push           | 19 ++++++-----
 regression/t-020.out | 89 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 regression/t-020.sh  | 13 +++++++-
 3 files changed, 113 insertions(+), 8 deletions(-)

diff --git a/guilt-push b/guilt-push
index 67687e7..39c125e 100755
--- a/guilt-push
+++ b/guilt-push
@@ -56,6 +56,12 @@ fi
 patch=3D"$1"
 [ ! -z "$all" ] && patch=3D"-a"
=20
+# Treat "guilt push" as "guilt push -n 1".
+if [ -z "$patch" ]; then
+	patch=3D1
+	num=3Dt
+fi
+
 if [ "$patch" =3D "-a" ]; then
 	# we are supposed to push all patches, get the last one out of
 	# series
@@ -65,7 +71,7 @@ if [ "$patch" =3D "-a" ]; then
 		die "There are no patches to push."
 	fi
 elif [ ! -z "$num" ]; then
-	# we are supposed to pop a set number of patches
+	# we are supposed to push a set number of patches
=20
 	[ "$patch" -lt 0 ] && die "Invalid number of patches to push."
=20
@@ -78,11 +84,6 @@ elif [ ! -z "$num" ]; then
 	# clamp to minimum
 	[ $tidx -lt $eidx ] && eidx=3D$tidx
=20
-elif [ -z "$patch" ]; then
-	# we are supposed to push only the next patch onto the stack
-
-	eidx=3D`wc -l < "$applied"`
-	eidx=3D`expr $eidx + 1`
 else
 	# we're supposed to push only up to a patch, make sure the patch is
 	# in the series
@@ -109,7 +110,11 @@ if [ "$sidx" -gt "$eidx" ]; then
 	else
 		disp "File series fully applied, ends at patch `get_series | tail -n=
 1`"
 	fi
-	exit 0
+	if [ -n "$all" ]; then
+		exit 0
+	else
+		exit 1
+	fi
 fi
=20
 get_series | sed -n -e "${sidx},${eidx}p" | while read p
diff --git a/regression/t-020.out b/regression/t-020.out
index 7e07efa..23cb9db 100644
--- a/regression/t-020.out
+++ b/regression/t-020.out
@@ -270,6 +270,95 @@ index 0000000..8baef1b
 +++ b/def
 @@ -0,0 +1 @@
 +abc
+% guilt push
+File series fully applied, ends at patch mode
+% guilt push -a
+File series fully applied, ends at patch mode
+% list_files
+d .git/patches
+d .git/patches/master
+d .git/refs/patches
+d .git/refs/patches/master
+f 22930c6d1f1938f298a4fca51c57e4b47171db21  .git/patches/master/mode
+f 413390f3906f16f30b054a4fb86c1e014b964504  .git/patches/master/remove
+f 71596bf71b72c2717e1aee378aabefbfa19ab7c8  .git/patches/master/status
+f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
+f bacb4aad8a55fe4e7aa58a9ae169990bb764069f  .git/patches/master/series
+f bc9ab2e0f5db99d483961e956e814d963f0309f8  .git/patches/master/modify
+r 33633e7a1aa31972f125878baf7807be57b1672d  .git/refs/patches/master/m=
odify
+r 37d588cc39848368810e88332bd03b083f2ce3ac  .git/refs/patches/master/a=
dd
+r ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba  .git/refs/patches/master/m=
ode
+r ffb7faa126a6d91bcdd44a494f76b96dd860b8b9  .git/refs/patches/master/r=
emove
+% git log -p
+commit ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    patch mode
+
+diff --git a/def b/def
+old mode 100644
+new mode 100755
+
+commit ffb7faa126a6d91bcdd44a494f76b96dd860b8b9
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    patch remove
+
+diff --git a/abd b/abd
+deleted file mode 100644
+index fd3896d..0000000
+--- a/abd
++++ /dev/null
+@@ -1 +0,0 @@
+-=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
+\ No newline at end of file
+
+commit 37d588cc39848368810e88332bd03b083f2ce3ac
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    patch add
+
+diff --git a/abd b/abd
+new file mode 100644
+index 0000000..fd3896d
+--- /dev/null
++++ b/abd
+@@ -0,0 +1 @@
++=89=F6u=1B=D8=14=BD=04=E1=1A=7FZ=E2=F1e=CF=C8E=84=A3=06=1FW=C0V=BC/=9B=
=03U?=DA<|=13=12=A2@6=A48'H=B81G_=98=CD=A7*=B7=12=F0R=D2=99=A4
=7F=AA=C2~=B7
+\ No newline at end of file
+
+commit 33633e7a1aa31972f125878baf7807be57b1672d
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    patch modify
+
+diff --git a/def b/def
+index 8baef1b..7d69c2f 100644
+--- a/def
++++ b/def
+@@ -1 +1,2 @@
+ abc
++asjhfksad
+
+commit d4850419ccc1146c7169f500725ce504b9774ed0
+Author: Author Name <author@email>
+Date:   Mon Jan 1 00:00:00 2007 +0000
+
+    initial
+   =20
+    Signed-off-by: Commiter Name <commiter@email>
+
+diff --git a/def b/def
+new file mode 100644
+index 0000000..8baef1b
+--- /dev/null
++++ b/def
+@@ -0,0 +1 @@
++abc
 % guilt pop --all
 All patches popped.
 % guilt push
diff --git a/regression/t-020.sh b/regression/t-020.sh
index 906aec6..0f9f85d 100755
--- a/regression/t-020.sh
+++ b/regression/t-020.sh
@@ -26,6 +26,17 @@ guilt series | while read n ; do
 done
=20
 #
+# pushing when there is nothing to push
+#
+
+shouldfail guilt push
+cmd guilt push -a
+
+cmd list_files
+
+cmd git log -p
+
+#
 # pop all
 #
 cmd guilt pop --all
@@ -61,7 +72,7 @@ cmd guilt pop --all
=20
 npatches=3D`guilt series | wc -l`
 for n in `_seq -2 $npatches`; do
-	if [ $n -ge 0 ]; then
+	if [ $n -gt 0 ]; then
 		cmd guilt push -n $n
 	else
 		shouldfail guilt push -n $n
--=20
1.8.3.1
