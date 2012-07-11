From: marcnarc@xiplink.com
Subject: [PATCH 1/6] Rename remote.c's default_remote_name static variables.
Date: Wed, 11 Jul 2012 11:33:56 -0400
Message-ID: <1342020841-24368-2-git-send-email-marcnarc@xiplink.com>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com, Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 17:35:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Soywi-00074K-0E
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 17:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758154Ab2GKPfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 11:35:12 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:39212 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758101Ab2GKPfK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jul 2012 11:35:10 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q6BFY4Ua029776;
	Wed, 11 Jul 2012 11:34:06 -0400
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201310>

From: Marc Branchaud <marcnarc@xiplink.com>

This prepares the code to handle a true remote.default configuration value.

Rename two variables:
  default_remote_name          --> effective_remote_name
  explicit_default_remote_name --> explicit_effective_remote_name

effective_remote_name is the remote name that is currently "in effect".
This is the currently checked-out branch's remote (in which case
explicit_effective_remote_name=1), or "origin" if the branch has no remote
(or the working tree is a detached HEAD).

The next commit re-introduces default_remote_name with its new semantics.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 remote.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/remote.c b/remote.c
index 6833538..6f371e0 100644
--- a/remote.c
+++ b/remote.c
@@ -47,8 +47,8 @@ static int branches_alloc;
 static int branches_nr;
 
 static struct branch *current_branch;
-static const char *default_remote_name;
-static int explicit_default_remote_name;
+static const char *effective_remote_name;
+static int explicit_effective_remote_name;
 
 static struct rewrites rewrites;
 static struct rewrites rewrites_push;
@@ -360,8 +360,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 				return config_error_nonbool(key);
 			branch->remote_name = xstrdup(value);
 			if (branch == current_branch) {
-				default_remote_name = branch->remote_name;
-				explicit_default_remote_name = 1;
+				effective_remote_name = branch->remote_name;
+				explicit_effective_remote_name = 1;
 			}
 		} else if (!strcmp(subkey, ".merge")) {
 			if (!value)
@@ -481,9 +481,9 @@ static void read_config(void)
 	unsigned char sha1[20];
 	const char *head_ref;
 	int flag;
-	if (default_remote_name) /* did this already */
+	if (effective_remote_name) /* did this already */
 		return;
-	default_remote_name = xstrdup("origin");
+	effective_remote_name = xstrdup("origin");
 	current_branch = NULL;
 	head_ref = resolve_ref_unsafe("HEAD", sha1, 0, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
@@ -680,8 +680,8 @@ struct remote *remote_get(const char *name)
 	if (name)
 		name_given = 1;
 	else {
-		name = default_remote_name;
-		name_given = explicit_default_remote_name;
+		name = effective_remote_name;
+		name_given = explicit_effective_remote_name;
 	}
 
 	ret = make_remote(name, 0);
-- 
1.7.11.1
