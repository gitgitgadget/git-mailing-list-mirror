From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool: use more conservative temporary filenames
Date: Wed,  8 Oct 2014 01:56:02 -0700
Message-ID: <1412758562-25402-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Sergio Ferrero <sferrero@ensoftcorp.com>,
	Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 11:03:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbn9v-0006uu-6N
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 11:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587AbaJHJDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 05:03:21 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:51433 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307AbaJHIzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 04:55:23 -0400
Received: by mail-pa0-f41.google.com with SMTP id eu11so8830963pac.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2014 01:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QRKP4/nY2AyCE8r4pv/oU+CHPLBTrlwOosNkiLQ9ra0=;
        b=Z0DrqoIfvjiAssrJYfmUpIGJ8ixbSvDdpsibtnwvLpwLMUlxcccia+EurdCVHX7yzc
         1jKp6r6yrG3cQD0hRKzrDvqHxUzqu9+P7id4McVKX72KgEOs3qbpopyFd1rYtXxqPypb
         iyWGSyk1rIhhyk7pModv0qyHpOiiVmPBrJAsNA5sT/u2DbFHFG5rPxsrfOjZEcqYrnHs
         5vWeP+J6uo7+EjE5bb8FQ/bEMvECNcDVusKfJ0lITbWn7AOjUnD2HK5Mn5pnEkTBRMan
         /xYB9Sh1/sq4m06LAqfz8mFg7yOPAaxdX3+lSXVWOaqe6DR5kM+sfheVBmO9NmEoQOpL
         RPDw==
X-Received: by 10.68.233.68 with SMTP id tu4mr8906690pbc.65.1412758522869;
        Wed, 08 Oct 2014 01:55:22 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id fr7sm15826523pdb.79.2014.10.08.01.55.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 Oct 2014 01:55:22 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.337.gd0cf3c1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid filenames with multiple dots so that overly-picky tools do
not misinterpret their extension.

Previously, foo/bar.ext in the worktree would result in e.g.

	foo/bar.ext.BASE.1234.ext

This can be improved by having only a single .ext and using
underscore instead of dot so that the extension cannot be
misinterpreted.  The resulting path becomes:

	foo/bar_BASE_1234.ext

Suggested-by: Sergio Ferrero <sferrero@ensoftcorp.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 9a046b7..1f33051 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -228,11 +228,15 @@ merge_file () {
 		return 1
 	fi
 
-	ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
-	BACKUP="./$MERGED.BACKUP.$ext"
-	LOCAL="./$MERGED.LOCAL.$ext"
-	REMOTE="./$MERGED.REMOTE.$ext"
-	BASE="./$MERGED.BASE.$ext"
+	ext=$(expr "$MERGED" : '.*\(\.[^/]*\)$')
+	base=$(basename "$MERGED" "$ext")
+	dir=$(dirname "$MERGED")
+	suffix="$$""$ext"
+
+	BACKUP="$dir/$base"_BACKUP_"$suffix"
+	BASE="$dir/$base"_BASE_"$suffix"
+	LOCAL="$dir/$base"_LOCAL_"$suffix"
+	REMOTE="$dir/$base"_REMOTE_"$suffix"
 
 	base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
 	local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
-- 
2.1.2.337.gd0cf3c1
