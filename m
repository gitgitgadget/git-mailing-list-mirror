From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 09/33] Test suite: properly check the exit status of commands.
Date: Sun, 18 May 2014 23:59:45 +0200
Message-ID: <1400450409-30998-10-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:05:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9DG-0002Gx-Sh
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbaERWFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:05:43 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:44459 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbaERWFn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:05:43 -0400
Received: by mail-la0-f51.google.com with SMTP id gf5so3449152lab.38
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HSsAEfnCejCK7E/0QoStgm8nEMtgNFcqNQy2PFjP8Wo=;
        b=DImdUGJHTOMMpFQXjSav/PogMdz3x7tawcwPLRAPUE2GpWTlAgqFcSv5wGLYevn88g
         hC78qDkg+nZlvbVWUG3NxFnly1HDxcVoLqzwYt2SU6mCUMMoMEfvlq3yJgakkvr/RoTu
         NK30Yu3esIieD7/RSYHRKtaeOiB/WQH9W4pZ0naagJeOEEy6ALEAB4bTzOJ9IVetJCfm
         XBIpDrpF6KmThYPgN5w1tJyJhWitTb3egA175JicUgxHxyYcdHIfpn2v2OA7Em+5x0FI
         4mpTbvlkuLkbgNmv4zwCTZqvSA+Rep4ePJVRDcN5n2ryjLdAZgDem5pCpoEKSaqlExsS
         KDgA==
X-Gm-Message-State: ALoCoQkkfEZLJkODQXHJvognj8skf6OnyH4Z+TH5LUI+zvAWkPw/fHe4qNzGsRjnrnogw61leCr2
X-Received: by 10.112.154.74 with SMTP id vm10mr12691615lbb.47.1400450741650;
        Sun, 18 May 2014 15:05:41 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.05.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:05:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249524>

The "cmd" and "shouldfail" functions checked the exit status of the
replace_path function instead of the actual command that was running.
(The $? construct checks the exit status of the last command in a
pipeline, not the first command.)

Print an explicit error message if a command that should fail actually
succeeds.

Updated t-032.sh, which used "shouldfail" instead of "cmd" in one
place.  (The comment in the script makes it clear that the command is
expected to succeed.)

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 regression/scaffold | 23 ++++++++++++++++-------
 regression/t-032.sh |  2 +-
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/regression/scaffold b/regression/scaffold
index 5c8b73e..2e04c83 100644
--- a/regression/scaffold
+++ b/regression/scaffold
@@ -51,19 +51,28 @@ function filter_dd
 function cmd
 {
 	echo "% $@"
-	"$@" 2>&1 | replace_path && return 0
-	return 1
+	if ! (
+		exec 3>&1
+		rv=`(("$@" 2>&1; echo $? >&4) | replace_path >&3 ) 4>&1`
+		exit $rv
+	) ; then
+		echo "% FAIL: The above command should succeed but failed."
+		exit 1
+	fi
 }
 
 # usage: shouldfail <cmd>..
 function shouldfail
 {
 	echo "% $@"
-	(
-		"$@" 2>&1 || return 0
-		return 1
-	) | replace_path
-	return $?
+	if (
+		exec 3>&1
+		rv=`(("$@" 2>&1; echo $? >&4) | replace_path >&3 ) 4>&1`
+		exit $rv
+	) ; then
+		echo "% FAIL: The above command should fail but succeeded."
+		exit 1
+	fi
 }
 
 # usage: list_files
diff --git a/regression/t-032.sh b/regression/t-032.sh
index b1d5f19..bba401e 100755
--- a/regression/t-032.sh
+++ b/regression/t-032.sh
@@ -28,7 +28,7 @@ shouldfail guilt import -P foo3 foo
 cmd guilt import -P foo2 foo
 
 # ok
-shouldfail guilt import foo
+cmd guilt import foo
 
 # duplicate patch name (implicit)
 shouldfail guilt import foo
-- 
1.8.3.1
