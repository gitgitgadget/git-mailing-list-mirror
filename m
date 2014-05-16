From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 09/31] Test suite: properly check the exit status of commands.
Date: Fri, 16 May 2014 16:45:56 +0200
Message-ID: <1400251578-17221-10-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:50:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJSS-0003HN-Te
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbaEPOt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:49:56 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:52182 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932363AbaEPOtw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:49:52 -0400
Received: by mail-la0-f42.google.com with SMTP id el20so2051421lab.29
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rse31GUYW5KlSBNCwOdBSFBL46i+fSe2V0GFqRYG9tQ=;
        b=Vo3iwN3uAKCgEMLeQYGNbSIuVLr3XisVmRVaWjRTlqKjcVJLliu+LzdT3d4HGneWCB
         dI89xR6xur5lwyIPshZyLhkATsv/0zwJBqJytB6wOpkCsUHo/RUEtApED+TNsxtkMigl
         ebiEbYZ9009Bum1pnMo8xg6kxaShJDit0lJNb/RyKaLRKkdUIQd5DfTjTNhFrz5GUlId
         UP3rGsjfIiLaXbYI+5jMOBd2zafTQ1Kr2rWOIg7zdH7wM9XTJMMxhin03XPjZPoKRkQc
         giT6NVS23CdlJanmTE+wGnPV1IHU6wrbUnvmRj8D2EJS06uGwHDZURRtWAYBBFVzgXqz
         bpIQ==
X-Gm-Message-State: ALoCoQmQx9qo1YO8y9pKteuuoaYUpnorXVyIwn/FM8FgLSofo2xWdK7ga3tZupFDQ6uvxqKQ2AWu
X-Received: by 10.112.120.207 with SMTP id le15mr6708316lbb.45.1400251791269;
        Fri, 16 May 2014 07:49:51 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.49.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:49:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249317>

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
