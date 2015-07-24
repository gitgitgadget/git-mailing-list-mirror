From: David Turner <dturner@twopensource.com>
Subject: [PATCH 3/9] bisect: do not use update-ref for BISECT_HEAD
Date: Fri, 24 Jul 2015 00:45:23 -0400
Message-ID: <1437713129-19373-4-git-send-email-dturner@twopensource.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jul 24 06:46:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUrw-0003mj-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbbGXEp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:45:56 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32987 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbbGXEpw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:45:52 -0400
Received: by qkdl129 with SMTP id l129so8260805qkd.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7qAAVfNJQDbARADXF+eJv2f1icemMewJxVizWTf4cc4=;
        b=fl/p/kMw2Y6lowyqPo63wldtal9uQFbCXI1uxzaqeGcCVUDSwjoEWr+btIXvz0Knqu
         hPUXeCavObd7vejjN3LID/wNln4JvKTTaGs1HPSoxpAwyZciN0JevNjkWdgl/1LzBYN6
         hUDuVR5mZ6zUJTV0tB4IJu6mGSJff98WoVb0n10GPgSR98yfXVgUcgrOQwOVMigALvhz
         shSW69f5PSAWmq88oavu25GDAZ241HyzsLqETUzS0alcmrqXKQiDFTcLYZD9Bcd7+Zn/
         433o/KF8Zpt7pp5JLf5pyRmaQlV8PMm7D/pDwVxEVJBWGpkb/S5/jqO9EnqBBVPtFuv8
         gFrA==
X-Gm-Message-State: ALoCoQlXicBgNXNRQuPx4objRXXDgBRofzpO38JJik3IRXoIXjN/9J5S+vsbxfZwZS8kjG1sw1uK
X-Received: by 10.140.133.135 with SMTP id 129mr18023346qhf.54.1437713151638;
        Thu, 23 Jul 2015 21:45:51 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p74sm3541579qkp.11.2015.07.23.21.45.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:45:51 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274546>

Because BISECT_HEAD is a pseudoref, we shouldn't use update-ref to
update it.  Instead, we simply write to and delete the file.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 git-bisect.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index ea63223..8263555 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -181,7 +181,7 @@ bisect_start() {
 	#
 	echo "$start_head" >"$GIT_DIR/BISECT_START" && {
 		test "z$mode" != "z--no-checkout" ||
-		git update-ref --no-deref BISECT_HEAD "$start_head"
+		git rev-parse "$start_head" > "$GIT_DIR/BISECT_HEAD"
 	} &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval true" &&
@@ -425,7 +425,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_TERMS" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
-	git update-ref -d --no-deref BISECT_HEAD &&
+	rm -f "$GIT_DIR/BISECT_HEAD" &&
 	# clean up BISECT_START last
 	rm -f "$GIT_DIR/BISECT_START"
 }
-- 
2.0.4.315.gad8727a-twtrsrc
