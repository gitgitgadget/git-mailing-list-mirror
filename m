From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/6] reset: trivial refactoring
Date: Fri, 30 Aug 2013 16:56:45 -0500
Message-ID: <1377899810-1818-2-git-send-email-felipe.contreras@gmail.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 00:01:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFWlE-0006zB-Ki
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 00:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746Ab3H3WBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 18:01:33 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:54669 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582Ab3H3WBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 18:01:31 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so2961796oah.6
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1hGmMq48a7Vg6UJrnlCFzOE0oeJkfifjACDjYp5+/I8=;
        b=ga6/ZC0Mp34QAbPft8Pw/Vp9UMzkznxe3ONuv6eM8hh0uScdAh+2JzPMmeIFrVskkl
         AhXopCdjKRegDws+qUioA1+18J7y3gAb1AL0rTb/0slxsndQ7z+r9siRGJk+BCfpvST8
         hzuTidmz9ozKskO1jf9YvFE5eusUVU4eGQhStwE1MT/W8qiaAn2K/LOzBS6yJJF0GQPQ
         9OI33A095jOirCg6CXB4FnhQAFk/u97ynmDxNRfLp5WKunnC9ezl4B+Bfngs1NUauJOu
         VnfK4WTbCHhg+xhw1hR2KtgIDqMclcBoquiPfyb/oBqRs+J+t87n9+/0ceCDXBYmFTm4
         DfqA==
X-Received: by 10.182.18.102 with SMTP id v6mr8516382obd.71.1377900091087;
        Fri, 30 Aug 2013 15:01:31 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm141313oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 15:01:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233477>

After commit 3fde386 (reset [--mixed]: use diff-based reset whether or
not pathspec was given), some code can be moved to the 'reset_type ==
MIXED' check.

Let's move the code that is specific to MIXED.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/reset.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index afa6e02..225e3f1 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -326,8 +326,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 		int newfd = hold_locked_index(lock, 1);
 		if (reset_type == MIXED) {
+			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(pathspec, sha1))
 				return 1;
+			refresh_index(&the_index, flags, NULL, NULL,
+				      _("Unstaged changes after reset:"));
 		} else {
 			int err = reset_index(sha1, reset_type, quiet);
 			if (reset_type == KEEP && !err)
@@ -336,12 +339,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				die(_("Could not reset index file to revision '%s'."), rev);
 		}
 
-		if (reset_type == MIXED) { /* Report what has not been updated. */
-			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
-			refresh_index(&the_index, flags, NULL, NULL,
-				      _("Unstaged changes after reset:"));
-		}
-
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(lock))
 			die(_("Could not write new index file."));
-- 
1.8.4-fc
