From: Jeff King <peff@peff.net>
Subject: [PATCH 04/68] fsck: don't fsck alternates for connectivity-only check
Date: Thu, 24 Sep 2015 17:05:30 -0400
Message-ID: <20150924210530.GA30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:05:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDhx-000067-V4
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbbIXVFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:05:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:35902 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753197AbbIXVFd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:05:33 -0400
Received: (qmail 11796 invoked by uid 102); 24 Sep 2015 21:05:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:05:32 -0500
Received: (qmail 28868 invoked by uid 107); 24 Sep 2015 21:05:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:05:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:05:30 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278563>

Commit 02976bf (fsck: introduce `git fsck --connectivity-only`,
2015-06-22) recently gave fsck an option to perform only a
subset of the checks, by skipping the fsck_object_dir()
call. However, it does so only for the local object
directory, and we still do expensive checks on any alternate
repos. We should skip them in this case, too.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0794703..46c7235 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -678,16 +678,17 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	git_config(fsck_config, NULL);
 
 	fsck_head_link();
-	if (!connectivity_only)
+	if (!connectivity_only) {
 		fsck_object_dir(get_object_directory());
 
-	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next) {
-		char namebuf[PATH_MAX];
-		int namelen = alt->name - alt->base;
-		memcpy(namebuf, alt->base, namelen);
-		namebuf[namelen - 1] = 0;
-		fsck_object_dir(namebuf);
+		prepare_alt_odb();
+		for (alt = alt_odb_list; alt; alt = alt->next) {
+			char namebuf[PATH_MAX];
+			int namelen = alt->name - alt->base;
+			memcpy(namebuf, alt->base, namelen);
+			namebuf[namelen - 1] = 0;
+			fsck_object_dir(namebuf);
+		}
 	}
 
 	if (check_full) {
-- 
2.6.0.rc3.454.g204ad51
