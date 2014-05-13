From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 26/29] "guilt pop" now fails when there are no more patches to pop.
Date: Tue, 13 May 2014 22:31:02 +0200
Message-ID: <1400013065-27919-27-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:37:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJSY-0008Ka-4b
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbaEMUh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:37:56 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:50242 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192AbaEMUhx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:37:53 -0400
Received: by mail-la0-f43.google.com with SMTP id mc6so715122lab.2
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HjvETy64XR3HAO2pCCWpSmD+sWMZig/e+52QzD933Qs=;
        b=RWiRgJBzinUXnQRq05LLzi/B6g61+6uMOzThwQ0+ykeajLXa+11DZglanyPp8bacFG
         yAJnAK19zoMM5x5FQCH73ez1wn3mQzi3Kkogl5SmTxXuAtl8hjeSHL/kZOSgQYIvDY7k
         kirmah53vBMVTrygH+1X/UpV0jZjD4V9QMiRSHp1ke8PZvs7OkbJrbzmDAwWgYTlQnNs
         mJ2Xq7ovjYAs9j8oGyt9LFeW0XW+SchZZR0oP+jZjxkp/q5v3WWtkL+fH+a2OpVREBbd
         bDOFCLO0/6thqKEXHF9goNrhCudATB4KiTxXgAAYuUTf3BgmakyQHor/qS01savtm0E2
         egHw==
X-Gm-Message-State: ALoCoQm2WiO4K7o7y67o7xF1hQ+Ohjqsa20ivMMVyemE0/seUkS5D8cR9Zvu9R6Y7qnBu/8nJyEd
X-Received: by 10.112.13.137 with SMTP id h9mr2523516lbc.33.1400013472086;
        Tue, 13 May 2014 13:37:52 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.37.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:37:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248841>

This is analogous to how "guilt push" now fails when there are no more
patches to push.  Like push, the "--all" argument still succeeds even
if there was no need to pop anything.

Updated the test suite.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt-pop            | 17 +++++++++++------
 regression/t-021.out |  2 ++
 regression/t-021.sh  |  6 ++++++
 regression/t-061.sh  |  6 +++++-
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/guilt-pop b/guilt-pop
index f0e647f..191313e 100755
--- a/guilt-pop
+++ b/guilt-pop
@@ -49,9 +49,19 @@ fi
 patch="$1"
 [ ! -z "$all" ] && patch="-a"
 
+# Treat "guilt pop" as "guilt pop -n 1".
+if [ -z "$patch" ]; then
+	patch=1
+	num=t
+fi
+
 if [ ! -s "$applied" ]; then
 	disp "No patches applied."
-	exit 0
+	if [ "$patch" = "-a" ]; then
+		exit 0
+	else
+		exit 1
+	fi
 elif [ "$patch" = "-a" ]; then
 	# we are supposed to pop all patches
 
@@ -68,11 +78,6 @@ elif [ ! -z "$num" ]; then
 	# catch underflow
 	[ $eidx -lt 0 ] && eidx=0
 	[ $eidx -eq $sidx ] && die "No patches requested to be removed."
-elif [ -z "$patch" ]; then
-	# we are supposed to pop only the current patch on the stack
-
-	sidx=`wc -l < "$applied"`
-	eidx=`expr $sidx - 1`
 else
 	# we're supposed to pop only up to a patch, make sure the patch is
 	# in the series
diff --git a/regression/t-021.out b/regression/t-021.out
index 9b42d9c..58be12f 100644
--- a/regression/t-021.out
+++ b/regression/t-021.out
@@ -287,6 +287,8 @@ index 0000000..8baef1b
 +++ b/def
 @@ -0,0 +1 @@
 +abc
+% guilt pop
+No patches applied.
 % guilt push --all
 Applying patch..modify
 Patch applied.
diff --git a/regression/t-021.sh b/regression/t-021.sh
index 614e870..e0d2dc1 100755
--- a/regression/t-021.sh
+++ b/regression/t-021.sh
@@ -23,6 +23,12 @@ guilt series | _tac | while read n ; do
 done
 
 #
+# pop when there is nothing to pop
+#
+
+shouldfail guilt pop
+
+#
 # push all
 #
 cmd guilt push --all
diff --git a/regression/t-061.sh b/regression/t-061.sh
index 1411baa..6192f1b 100755
--- a/regression/t-061.sh
+++ b/regression/t-061.sh
@@ -48,7 +48,11 @@ cmd list_files
 
 for i in `seq 5`
 do
-	cmd guilt pop
+	if [ $i -ge 5 ]; then
+		shouldfail guilt pop
+	else
+		cmd guilt pop
+	fi
 	cmd git for-each-ref
 	cmd guilt push
 	cmd git for-each-ref
-- 
1.8.3.1
