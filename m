From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Fix bad usage of mkpath in builtin-branch.sh
Date: Tue, 24 Oct 2006 03:59:36 +0200
Message-ID: <1161655176461-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 04:05:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcBa1-0000Xq-Bd
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 03:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWJXB7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 21:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWJXB7n
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 21:59:43 -0400
Received: from mail46.e.nsc.no ([193.213.115.46]:40363 "EHLO mail46.e.nsc.no")
	by vger.kernel.org with ESMTP id S1030183AbWJXB7m (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 21:59:42 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no [80.213.28.208])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id k9O1xb27007152;
	Tue, 24 Oct 2006 03:59:37 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.3.1.ga4cc-dirty
Date: Tue, 24 Oct 2006 03:55:02 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29913>

When checking if a branch start point referred to a commit-object,
the result of mkpath() was used as argument to get_sha1(), which
didn't work out as planned.

Now it's xstrdup'd first.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 builtin-branch.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index ffc2db0..f86bf68 100755
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -125,6 +125,7 @@ static void create_branch(const char *na
 	struct ref_lock *lock;
 	unsigned char sha1[20];
 	char ref[PATH_MAX], msg[PATH_MAX + 20];
+	const char *commitref;
 
 	snprintf(ref, sizeof ref, "refs/heads/%s", name);
 	if (check_ref_format(ref))
@@ -137,8 +138,10 @@ static void create_branch(const char *na
 			die("Cannot force update the current branch.");
 	}
 
-	if (get_sha1(mkpath("%s^0", start), sha1))
+	commitref = xstrdup(mkpath("%s^0", start));
+	if (get_sha1(commitref, sha1))
 		die("Not a valid branch point: '%s'.", start);
+	free(commitref);
 
 	lock = lock_any_ref_for_update(ref, NULL);
 	if (!lock)
-- 
1.4.3.1.ga4cc-dirty
