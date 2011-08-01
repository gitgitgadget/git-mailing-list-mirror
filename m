From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH] describe: Refresh the index when run with --dirty
Date: Sun, 31 Jul 2011 21:52:41 -0400
Message-ID: <1312163561-77072-1-git-send-email-allan.caffee@gmail.com>
References: <20110731062055.GB14384@sigill.intra.peff.net>
Cc: Allan Caffee <allan.caffee@gmail.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 03:55:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnhj9-00057z-Ei
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 03:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab1HABxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 21:53:17 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37114 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab1HABxP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 21:53:15 -0400
Received: by qwk3 with SMTP id 3so2577786qwk.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 18:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :to;
        bh=38Y/Ap3xR+whDhCZmgU8RfSRCc+JsVbB73zD7q4uAE0=;
        b=ttc5nt4ad3wiAdNj9pXEUD0Tv7M/vYczIZnH4Hx58NHfNtiHdSxaLXcujTSXsKhxSC
         8z/pm6ChsBeiMgMLL0qBGxmF6XQS+FChDqAr3DOeiQw8t5LsDeC15nCFmlysyUOCyZcy
         pXK+Wpcnp/sYUpxR1zB0QgKuv8BA1pUx55DDU=
Received: by 10.229.251.138 with SMTP id ms10mr2868394qcb.71.1312163594670;
        Sun, 31 Jul 2011 18:53:14 -0700 (PDT)
Received: from localhost.localdomain (pool-108-16-32-99.phlapa.fios.verizon.net [108.16.32.99])
        by mx.google.com with ESMTPS id d12sm2834539qcd.2.2011.07.31.18.53.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 18:53:13 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <20110731062055.GB14384@sigill.intra.peff.net>
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178294>

When running git describe --dirty the index should be refreshed.  Previously
the cached index would cause describe to think that the index was dirty when,
in reality, it was just stale.

The issue was exposed by python setuptools which hardlinks files into another
directory when building a distribution.
---
 builtin/describe.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 66fc291..792af76 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -24,6 +24,7 @@ static int longformat;
 static int abbrev = -1; /* unspecified */
 static int max_candidates = 10;
 static struct hash_table names;
+static struct lock_file index_lock; /* real index */
 static int have_util;
 static const char *pattern;
 static int always;
@@ -399,6 +400,7 @@ static void describe(const char *arg, int last_one)
 int cmd_describe(int argc, const char **argv, const char *prefix)
 {
 	int contains = 0;
+	int fd;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "contains",   &contains, "find the tag that comes after the commit"),
 		OPT_BOOLEAN(0, "debug",      &debug, "debug search strategy on stderr"),
@@ -462,8 +464,16 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		die(_("No names found, cannot describe anything."));
 
 	if (argc == 0) {
-		if (dirty && !cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1, diff_index_args, prefix))
-			dirty = NULL;
+		if (dirty) {
+			read_cache();
+			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
+			fd = hold_locked_index(&index_lock, 0);
+			if (0 <= fd)
+				update_index_if_able(&the_index, &index_lock);
+
+			if (!cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1, diff_index_args, prefix))
+				dirty = NULL;
+		}
 		describe("HEAD", 1);
 	} else if (dirty) {
 		die(_("--dirty is incompatible with committishes"));
-- 
1.7.3.2
