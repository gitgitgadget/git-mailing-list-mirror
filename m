From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] receive-pack: reject invalid refnames
Date: Wed,  2 Jan 2008 22:52:06 +0100
Message-ID: <1199310726946-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 22:53:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JABWE-000755-Ok
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 22:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbYABVwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 16:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753631AbYABVwK
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 16:52:10 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40872 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370AbYABVwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 16:52:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 2DC6D68009A7;
	Wed,  2 Jan 2008 22:52:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1-wruZdEzP45; Wed,  2 Jan 2008 22:52:07 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 07921680067B; Wed,  2 Jan 2008 22:52:06 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69494>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 receive-pack.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index d0a563d..a038a40 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -165,7 +165,9 @@ static const char *update(struct command *cmd)
 	unsigned char *new_sha1 = cmd->new_sha1;
 	struct ref_lock *lock;
 
-	if (!prefixcmp(name, "refs/") && check_ref_format(name + 5)) {
+	/* only HEAD and refs/... are allowed */
+	if (strcmp(name, "HEAD") && 
+	    (prefixcmp(name, "refs/") || check_ref_format(name + 5))) {
 		error("refusing to create funny ref '%s' remotely", name);
 		return "funny refname";
 	}
@@ -177,7 +179,8 @@ static const char *update(struct command *cmd)
 	}
 	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
 	    !is_null_sha1(old_sha1) &&
-	    !prefixcmp(name, "refs/heads/")) {
+	    (!prefixcmp(name, "refs/heads/") ||
+	     !strcmp(name, "HEAD"))) {
 		struct object *old_object, *new_object;
 		struct commit *old_commit, *new_commit;
 		struct commit_list *bases, *ent;
-- 
1.4.4.4
