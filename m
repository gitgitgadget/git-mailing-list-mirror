From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 15/16] update-index.c: add a force-rewrite option
Date: Thu,  2 Aug 2012 13:02:05 +0200
Message-ID: <1343905326-23790-16-git-send-email-t.gummerer@gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 13:03:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwtBp-0005Lo-KE
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 13:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656Ab2HBLD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 07:03:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54882 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636Ab2HBLDT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 07:03:19 -0400
Received: by mail-ey0-f174.google.com with SMTP id c11so838702eaa.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 04:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ccMkcUR19TxjZJEr76CKyNWNZr66ve7fCjceTAPYyvw=;
        b=HcI3/Elwob4ND8lCK8M/B6IDUrMY/7/vZkc5J/giEaK/zqIwsip+L3xY3l+2Q/5nak
         0cDvWJ71jaU5XaQYBUldSNPKzfKXkh2DL6hkIYYfmMyu7mem4HWpHen54hvmp5D75aat
         k81t3Ito/Rvslw35FTl2FQQqSW+YsNBP6gCeaURqBk3fF4PjdAwboGT4Wl0wb/GXGeOQ
         em14NLY+8k20irrzp0LFVLQGXBpjOfiyVi4liHmAtQVb+U6fcvPWNk2LFNg1VZ6m+oyk
         Qr0xtmsJ7B1bbsq20DsjJsqpkdt/M5GSR44KSqUNBqx9ZtIY5x1J7h+LifRfwsitBEBc
         j5JA==
Received: by 10.14.204.72 with SMTP id g48mr19790134eeo.45.1343905399006;
        Thu, 02 Aug 2012 04:03:19 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id a41sm2340367eep.7.2012.08.02.04.03.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 04:03:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.886.gdf6792c.dirty
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202762>

Add a force-rewrite option to update-index, which allows the user
to rewrite the index, even if there are no changes. This can be used
to do performance tests of both the reader and the writer.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/update-index.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index e747def..063bf54 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -24,6 +24,7 @@ static int allow_remove;
 static int allow_replace;
 static int info_only;
 static int force_remove;
+static int force_rewrite;
 static int verbose;
 static int mark_valid_only;
 static int mark_skip_worktree_only;
@@ -734,6 +735,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "unmerged", &refresh_args.flags,
 			"refresh even if index contains unmerged entries",
 			REFRESH_UNMERGED),
+		OPT_SET_INT(0, "force-rewrite", &force_rewrite,
+			"force a index rewrite even if there is no change", 1),
 		{OPTION_CALLBACK, 0, "refresh", &refresh_args, NULL,
 			"refresh stat information",
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
@@ -892,7 +895,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
-	if (active_cache_changed) {
+	if (active_cache_changed || force_rewrite) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-- 
1.7.10.886.gdf6792c.dirty
