From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] detect dup failure
Date: Wed, 27 Jun 2007 13:59:47 +0200
Message-ID: <87wsxpobf0.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 13:59:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3WBd-0003Nd-B5
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 13:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbXF0L7u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 07:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbXF0L7u
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 07:59:50 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:44696 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbXF0L7t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 07:59:49 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id DD1CC5A398
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 13:59:48 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id D68E42BDA2; Wed, 27 Jun 2007 13:59:47 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51032>

Without this, if you ever run out of file descriptors, dup will
fail (silently), fdopen will return NULL, and fprintf will
try to dereference NULL (i.e., usually segfault).

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 builtin-log.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 073a2a1..ca54387 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -588,8 +588,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (ignore_if_in_upstream)
 		get_patch_ids(&rev, &ids, prefix);

-	if (!use_stdout)
-		realstdout = fdopen(dup(1), "w");
+	if (!use_stdout) {
+		int fd = dup(1);
+		if (fd < 0)
+			die("failed to duplicate standard output");
+		realstdout = fdopen(fd, "w");
+	}

 	prepare_revision_walk(&rev);
 	while ((commit = get_revision(&rev)) != NULL) {
