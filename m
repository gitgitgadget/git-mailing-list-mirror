From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] mergetool: use more conservative temporary filenames
Date: Fri, 10 Oct 2014 01:19:47 -0700
Message-ID: <1412929187-57936-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Sergio Ferrero <sferrero@ensoftcorp.com>,
	Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 10:19:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcVQZ-0000vt-2N
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 10:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbaJJITu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 04:19:50 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59244 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbaJJITp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 04:19:45 -0400
Received: by mail-pa0-f51.google.com with SMTP id lj1so1312479pab.38
        for <git@vger.kernel.org>; Fri, 10 Oct 2014 01:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ioiSOLT34tIG0aDy8n8PJfdqKMVmszNyhgqtATYwZc4=;
        b=Ce62Y7ycw6E9e0Nlt8gUmKuAP9hYAXsiE9HwsgmHazHNyY3O3ppPfurdU/3OpMxi8d
         1fVGtuI2Mx2DZ8CvSH4CuFfuwi7dQXPePf4N4winTy9wMQ3zvN8EXvP2BMCLMiVWijLw
         E6iyXyqUIlErSMZqd7X/HomcdiOCXs1+UzK000eHN9O+JXP92tEmCmwDfDDZaItmm8au
         x5tH0Y4VF0rdHBZlNpK9vmdxrNPHLYCKG2o9EvLyBHGGEV2Xht/0vNiS+XuqZoC90awb
         b94GptEM4fNOVRVx+CSaS8viB0iFtY/OPnQe9qy6gC9/o1ksFYu2Jksc2ph7LMThGJk7
         O0Dw==
X-Received: by 10.66.228.166 with SMTP id sj6mr2828219pac.26.1412929184974;
        Fri, 10 Oct 2014 01:19:44 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id t9sm2671476pdo.37.2014.10.10.01.19.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 10 Oct 2014 01:19:44 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.375.gd89e6a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid filenames with multiple dots so that overly-picky tools do
not misinterpret their extension.

Previously, foo/bar.ext in the worktree would result in e.g.

	./foo/bar.ext.BASE.1234.ext

This can be improved by having only a single .ext and using
underscore instead of dot so that the extension cannot be
misinterpreted.  The resulting path becomes:

	./foo/bar_BASE_1234.ext

Suggested-by: Sergio Ferrero <sferrero@ensoftcorp.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since v1

The commit message changed to say "./foo" instead of "foo".

The patch now uses Junio's suggestion to minimize variables,
and preserves the original leading ./ just in case there are
tools that rely on having ./ in front of relative paths.

 git-mergetool.sh | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 9a046b7..96a61ba 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -228,11 +228,17 @@ merge_file () {
 		return 1
 	fi
 
-	ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
-	BACKUP="./$MERGED.BACKUP.$ext"
-	LOCAL="./$MERGED.LOCAL.$ext"
-	REMOTE="./$MERGED.REMOTE.$ext"
-	BASE="./$MERGED.BASE.$ext"
+	if BASE=$(expr "$MERGED" : '\(.*\)\.[^/]*$')
+	then
+		ext=$(expr "$MERGED" : '.*\(\.[^/]*\)$')
+	else
+		BASE=$MERGED
+		ext=
+	fi
+	BACKUP="./${BASE}_BACKUP_$$$ext"
+	LOCAL="./${BASE}_LOCAL_$$$ext"
+	REMOTE="./${BASE}_REMOTE_$$$ext"
+	BASE="./${BASE}_BASE_$$$ext"
 
 	base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
 	local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
-- 
2.1.2.375.gd89e6a9
