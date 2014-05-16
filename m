From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 26/31] "guilt pop" now fails when there are no more patches to pop.
Date: Fri, 16 May 2014 16:46:13 +0200
Message-ID: <1400251578-17221-27-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:56:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJYd-0002hX-Gu
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbaEPO4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:56:14 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:64632 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932506AbaEPO4M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:56:12 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so2058502lab.17
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gUdEyRQJ8ZVQZnZaHlU5kTVtpwAgfPqsGDF/c5uyOpw=;
        b=N02r8VAMrT48SGgVm2HJDAPRdVVBDYCFONGnRk05gEBg3jyZyYKyGzRm8CF3ZEjKPv
         q0vve+gJ3gMrs+v9qb3ab6tLnZAPEaykETy2HLXbK1W+8OVf+/IHrqp5MplVJl+JXbP+
         CbWsqQB52SpjIdK7WvaX+K6RBI0YSF+Gdoj1Uz4ZJo35Cao7LcoiSLs98LKW+8RuiX+y
         swqbUKMIT1K3jLwSL06avEcxH8E6JOSCdjtNBOXiM00mtVhDA7ASjRdIKSWF21BA5ZDZ
         4Ez3jCe2bbv3PKOLnkx+NQcGVfEiOEE8oK61qp5RvaIt9/JLnSKpx8tP/oQiZ3UQejCK
         1Hqw==
X-Gm-Message-State: ALoCoQnhV7/Bzixytvoo/zWsL5bnjN9m/lTyv4jLs6MU3tswuZjLmiz5Ca9/8bjI3T8JwKthcgQ1
X-Received: by 10.152.121.39 with SMTP id lh7mr12178610lab.7.1400252171026;
        Fri, 16 May 2014 07:56:11 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.56.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:56:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249335>

This is analogous to how "guilt push" now fails when there are no more
patches to push.  Like push, the "--all" argument still succeeds even
if there was no need to pop anything.

Updated the test suite.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
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
