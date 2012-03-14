From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 2/5 v2] contrib/diffall: create tmp dirs without mktemp
Date: Wed, 14 Mar 2012 12:38:03 -0400
Message-ID: <1331743086-32304-3-git-send-email-tim.henigan@gmail.com>
References: <1331743086-32304-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 14 17:40:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7rF5-0004j9-QY
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 17:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184Ab2CNQjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 12:39:42 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63245 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab2CNQjl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 12:39:41 -0400
Received: by ghrr11 with SMTP id r11so2003030ghr.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CxUUBnWiMRMo7vgU+lrPnA3064Qo5//pFrqI6albvcs=;
        b=TEkVu1zGeonp0tnS+SUDsb7yPNGEWKBwFbUhouwPaeNKZZTetetffblnQfyOicNuS3
         EH/iP2DsT9f3jYKXAD3KvqXyIwMaQUAfHrVUCijAWDEJNVaXNnrIGbuKcTbLsFSxb9+z
         D4g5QZ8mw0kOJmH22yvsFOSqxP7Dwf16DmJYfCiPx9rq6r6tHP6zQ0RbrAeEqjZYHkR+
         O5/cZJ/y+OwahFqW/iFQmlz54vfDN4DfoklgwSpjlNNCgbfCsR25E75eQqRM0xR8fnL0
         dGa4a7TWhFOXGu94mIfhFBZw7fUy0EPrDXLShZUYelx9QT4nZH7h8nUD2z8mHUCuXite
         T/wQ==
Received: by 10.224.174.200 with SMTP id u8mr3760103qaz.57.1331743181458;
        Wed, 14 Mar 2012 09:39:41 -0700 (PDT)
Received: from localhost ([99.38.69.118])
        by mx.google.com with ESMTPS id fq1sm9645867qab.10.2012.03.14.09.39.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 09:39:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0
In-Reply-To: <1331743086-32304-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193129>

mktemp is not available on all platforms.  Instead of littering the code
with a work-around, this commit replaces mktemp with a one-line Perl
script.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

v2 did not affect this patch.


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
