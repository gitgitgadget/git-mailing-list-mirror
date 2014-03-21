From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 26/28] "guilt pop" now fails when there are no more patches to pop.
Date: Fri, 21 Mar 2014 08:32:04 +0100
Message-ID: <1395387126-13681-27-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:33:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtxd-0002XC-JP
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbaCUHdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:45 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58524 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759932AbaCUHdk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:40 -0400
Received: by mail-lb0-f174.google.com with SMTP id u14so1374674lbd.19
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZPtgDsvhqqIcxeT/8lGXLQo5Yy8X7q7JKAyyeYtfh7U=;
        b=EHV1CunnsWWmILSQMfrlvP5yp6y2bygNhwFDtDBykwybIiedSePqFtM20VCP29O3Q5
         Dm4sr7102xd3+WMswLVunJQv80ozjm1gQ+K1vDkOB0B4gJ61vp7NVkqmWCgKIFejUUte
         QctWL4KLeuLIeEdQ6LHxAjubmbh/yf6jpLnQFYrfx6hkBfb7SBdjVBeX6Iee9BDEd4fL
         eG2BiHKHYKdz22PGxEop2iyXYsYaT4e0zK5wnWv6DiJ+7ikIgDOUYLTM6HCRw4pvqIvp
         aZ+LJvECpKrUeQjt11IMQ8Pec3CpOMp1a3n6Ogwx4s8rZjcZbnUaeWi35yXerIRJ4mQs
         ntVA==
X-Gm-Message-State: ALoCoQnm3HbD+N0Zp59M8N0at27j8Gy+Gl13AyU1ELOFc5Emo8v/fla4Youe9wT/2r2GYIV+JAoz
X-Received: by 10.152.190.135 with SMTP id gq7mr32811651lac.28.1395387219262;
        Fri, 21 Mar 2014 00:33:39 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244651>

This is analogous to how "guilt push" now fails when there are no more
patches to push.  Like push, the "--all" argument still succeeds even
if there was no need to pop anything.

Updated the test suite.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt-pop            | 13 +++++++------
 regression/t-021.out |  2 ++
 regression/t-021.sh  |  6 ++++++
 regression/t-061.sh  |  7 ++++++-
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/guilt-pop b/guilt-pop
index f0e647f..208f868 100755
--- a/guilt-pop
+++ b/guilt-pop
@@ -48,10 +48,16 @@ fi
 
 patch="$1"
 [ ! -z "$all" ] && patch="-a"
+[ -z "$patch" ] && { patch=1; num=t; }
 
 if [ ! -s "$applied" ]; then
 	disp "No patches applied."
-	exit 0
+	if [ "$patch" = "-a" ]
+	then
+		exit 0
+	else
+		exit 1
+	fi
 elif [ "$patch" = "-a" ]; then
 	# we are supposed to pop all patches
 
@@ -68,11 +74,6 @@ elif [ ! -z "$num" ]; then
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
index 1411baa..a9a4fea 100755
--- a/regression/t-061.sh
+++ b/regression/t-061.sh
@@ -48,7 +48,12 @@ cmd list_files
 
 for i in `seq 5`
 do
-	cmd guilt pop
+	if [ $i -ge 5 ]
+	then
+		shouldfail guilt pop
+	else
+		cmd guilt pop
+	fi
 	cmd git for-each-ref
 	cmd guilt push
 	cmd git for-each-ref
-- 
1.8.3.1
