From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 15/16] update-index.c: add a force-rewrite option
Date: Sun,  5 Aug 2012 23:49:12 +0200
Message-ID: <1344203353-2819-16-git-send-email-t.gummerer@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pcouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:51:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy8iw-0001x2-Ko
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 23:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251Ab2HEVuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 17:50:51 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48918 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab2HEVuO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 17:50:14 -0400
Received: by mail-ee0-f46.google.com with SMTP id l10so649089eei.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 14:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1imxI06QdDYpz29h0ddDW6LzpZOJmA3ljme5g8ibjd4=;
        b=a6pX7FLfCbh0EY+4KSa8vTP1/bLIWL3m8HBeJTvDYMK3vJUs+eryVAUUjro8kr/TG9
         LESPKnoqVhmnM901wJiOZF20HwH02hxJUovb0Wl44Yh6Tscl9qX/88SbckdN1pkSWsPT
         0qouyOalFz6pP3BZfqsfnRYalKlB/Si1tHj3vomTOO3jmmZY+VL7EZp2sz+5IcOF/rZR
         4SgPRLYPc1U0ILNWjlH+J4qUUWfRq1aPwj/EZrr0xBcfoSoKmO8gFnR6Q9P4zoAr7mF2
         eTqtL/4z9ma5YzyJ4XwZhPmQ5IKTCYIFz6Qjhsnzzlc1fB9TtnZSudEgY2dI4B9qfmbQ
         LM1Q==
Received: by 10.14.175.130 with SMTP id z2mr10501614eel.0.1344203413535;
        Sun, 05 Aug 2012 14:50:13 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id g42sm42242597eem.14.2012.08.05.14.50.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 14:50:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202925>

Add a force-rewrite option to update-index, which allows the user
to rewrite the index, even if there are no changes. This can be used
to do performance tests of both the reader and the writer.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/update-index.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 4ce341c..7fedc8f 100644
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
@@ -728,6 +729,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "unmerged", &refresh_args.flags,
 			"refresh even if index contains unmerged entries",
 			REFRESH_UNMERGED),
+		OPT_SET_INT(0, "force-rewrite", &force_rewrite,
+			"force a index rewrite even if there is no change", 1),
 		{OPTION_CALLBACK, 0, "refresh", &refresh_args, NULL,
 			"refresh stat information",
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
@@ -886,7 +889,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
-	if (active_cache_changed) {
+	if (active_cache_changed || force_rewrite) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-- 
1.7.10.GIT
