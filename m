From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 2/4] contrib/diffall: teach diffall to create tmp dirs without using mktemp
Date: Tue, 13 Mar 2012 13:45:31 -0400
Message-ID: <1331660734-10538-2-git-send-email-tim.henigan@gmail.com>
References: <1331660734-10538-1-git-send-email-tim.henigan@gmail.com>
Cc: tim.henigan@gmail.com
To: git@vger.kernel.org, gitster@poxbox.com
X-From: git-owner@vger.kernel.org Tue Mar 13 18:46:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7VnY-00089g-SY
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 18:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758935Ab2CMRqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 13:46:07 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58593 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759096Ab2CMRqG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 13:46:06 -0400
Received: by eaaq12 with SMTP id q12so460115eaa.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7IvbEzmz9g541bOfG9CZlvv8sx0Y6nf4Am0+YByAarU=;
        b=dF7URHsS29O7paQtcepXGSa7K/rtjls3V7mc46lSYW9SQOFk1KnHp88YCEV51XCsQG
         nfB+dMY4OK224YrD+Ko07xRT+lMk0oPoR/m5WuOUZliGbsIr8HJMvHnUDmjseJRMTmjN
         /UUZAZ48iwc9h8ogkwBiRoIF5JJN1doX3u4V37e95ZkbfYOEpQTYFh2uDgFUc7IvLnxv
         m2vKiIGCQ0lmbR2aAIN6aDTRcBnVDD3xCbqF6RrCd+Je+GcWDzRyc2MedRs+yLHw3tkg
         hPyyeL+LFNkSO5kLFJ35WAqp9K3tHKlOGIT3qE230QWh7MR1wkeHt7pEjkfaVuTlbVgr
         aYeg==
Received: by 10.224.222.141 with SMTP id ig13mr13571068qab.63.1331660764837;
        Tue, 13 Mar 2012 10:46:04 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id dw1sm4413939qab.4.2012.03.13.10.46.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 10:46:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0
In-Reply-To: <1331660734-10538-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193042>

mktemp is not available on all platforms.  Instead of littering the code
with a work-around, this commit replaces mktemp with a one-line Perl
script.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 contrib/diffall/git-diffall |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/contrib/diffall/git-diffall b/contrib/diffall/git-diffall
index d706a6d..443f646 100755
--- a/contrib/diffall/git-diffall
+++ b/contrib/diffall/git-diffall
@@ -45,13 +45,10 @@ cd "$cdup" || {
 	exit 1
 }
 
-# mktemp is not available on all platforms (missing from msysgit)
-# Use a hard-coded tmp dir if it is not available
-tmp="$(mktemp -d -t tmp.XXXXXX 2>/dev/null)" || {
-	tmp=/tmp/git-diffall-tmp.$$
-	mkdir "$tmp" || exit 1
-}
-
+# set up temp dir
+tmp=$(perl -e 'use File::Temp qw(tempdir);
+	$t=tempdir("/tmp/git-diffall.XXXXX") or exit(1);
+	print $t') || exit 1
 trap 'rm -rf "$tmp" 2>/dev/null' EXIT
 
 left=
-- 
1.7.10.rc0
