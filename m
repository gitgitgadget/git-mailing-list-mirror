From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 09/28] Test suite: properly check the exit status of commands.
Date: Fri, 21 Mar 2014 08:31:47 +0100
Message-ID: <1395387126-13681-10-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQty9-0003NI-Qh
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759749AbaCUHd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:29 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:60382 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343AbaCUHdN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:13 -0400
Received: by mail-la0-f48.google.com with SMTP id gf5so1372630lab.21
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rse31GUYW5KlSBNCwOdBSFBL46i+fSe2V0GFqRYG9tQ=;
        b=lCsRlPzHsnnycS6MFKn/Tqz+0iEhD2iwUWqkc6KrYrSt0TAprCnEOtrCNT2FfuKONV
         RRxLVK0FewAFqf1ocasRHLKwupwpl15GrQ9up4cgKHa3l04EnUi5N6v2L/SrwGszf5bt
         phWo3CGk4yMm5irHrXIQ8hgXiYmZ2uwSCTmT9vo/xOENLHQuuL0uA1uZLLEOZv/Zz1/+
         o2xCUr99p/CRseY+70Wl6nXaZkEgqFMBr7RWphThwx8ccAAJxKrgVqI6LD9Ku5IAJE8c
         eS3zYTpGWGAwAIPgdCPS0plV/s9paPnOiriNBZGUNkcYkD1fLWGYYudWUr5hDl3k5Rc7
         lRQA==
X-Gm-Message-State: ALoCoQk3nXr7ccozZgcKLJmvHJ4nzwlek2cbwZIbggIlRFns4RoJxjRMBfWbu5SpL2jpEklmSt5p
X-Received: by 10.112.46.225 with SMTP id y1mr31075043lbm.12.1395387192676;
        Fri, 21 Mar 2014 00:33:12 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244663>

The "cmd" and "shouldfail" functions checked the exit status of the
replace_path function instead of the actual command that was running.
(The $? construct checks the exit status of the last command in a
pipeline, not the first command.)

Updated t-032.sh, which used "shouldfail" instead of "cmd" in one
place.  (The comment in the script makes it clear that the command is
expected to succeed.)

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 regression/scaffold | 17 +++++++++++------
 regression/t-032.sh |  2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/regression/scaffold b/regression/scaffold
index 5c8b73e..e4d7487 100644
--- a/regression/scaffold
+++ b/regression/scaffold
@@ -51,18 +51,23 @@ function filter_dd
 function cmd
 {
 	echo "% $@"
-	"$@" 2>&1 | replace_path && return 0
-	return 1
+	(
+		exec 3>&1
+		rv=`(("$@" 2>&1; echo $? >&4) | replace_path >&3 ) 4>&1`
+		exit $rv
+	)
+	return $?
 }
 
 # usage: shouldfail <cmd>..
 function shouldfail
 {
 	echo "% $@"
-	(
-		"$@" 2>&1 || return 0
-		return 1
-	) | replace_path
+	! (
+		exec 3>&1
+		rv=`(("$@" 2>&1; echo $? >&4) | replace_path >&3 ) 4>&1`
+		exit $rv
+	)
 	return $?
 }
 
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
