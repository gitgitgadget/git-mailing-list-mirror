From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 09/29] Test suite: properly check the exit status of commands.
Date: Tue, 13 May 2014 22:30:45 +0200
Message-ID: <1400013065-27919-10-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:34:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJPH-0002qB-OP
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140AbaEMUec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:34:32 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:41639 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137AbaEMUeb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:34:31 -0400
Received: by mail-la0-f47.google.com with SMTP id pn19so708759lab.6
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rse31GUYW5KlSBNCwOdBSFBL46i+fSe2V0GFqRYG9tQ=;
        b=VrYVzHWXmYyG//eU4/jqQkB0Cj+FOoPWJT5mwJVXGHj/l63T/jghIsS6EPY208okZb
         mWfjbqripzli+XY/uKrvxP+FUUTqWH5QuTDvolRQb4c1cSVxKkMFpBLKsL41iGS0Zx23
         H/jwX9pwp6/N3Y9sgx9IEaCYsr5s72KtweeK3boG0EK4lRKmhEjFfCxwX7L7uK6VoMCD
         eDIKzNqyHVenURap0FpYQylx5MMaOT3ZWTQpES/GYoiLWWwQ1W46kwaOxalbM0CqFGEr
         bdJoBrQCseBcbZzYK3ilyLdBXn9pAdgidBtMPYC5s7kSyEiiv9r3LI6E1ucuPr8q6mpr
         TWkg==
X-Gm-Message-State: ALoCoQlLjc+wH+En9orCpRoFopefRnAx6B1SdaF2IG+NJ1N+DlwfyvOEmjQ/Zx7PeNeRFQx623ma
X-Received: by 10.152.197.69 with SMTP id is5mr14241457lac.10.1400013269913;
        Tue, 13 May 2014 13:34:29 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.34.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:34:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248825>

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
