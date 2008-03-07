From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] Revert part of 744dacd (builtin-mv: minimum fix to avoid
 losing files)
Date: Fri,  7 Mar 2008 02:54:44 -0800
Message-ID: <1204887286-32574-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 11:55:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXaEk-0004Fx-T4
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 11:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757079AbYCGKzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 05:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756845AbYCGKzA
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 05:55:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44584 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756354AbYCGKy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 05:54:59 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3D5E0225B
	for <git@vger.kernel.org>; Fri,  7 Mar 2008 05:54:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9028D225A for <git@vger.kernel.org>; Fri,  7 Mar 2008 05:54:54 -0500
 (EST)
X-Mailer: git-send-email 1.5.4.3.587.g0bdd73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76472>

When get_pathspec() was originally made absolute-path capable,
we botched the interface to it, without dying inside the function
when given a path that is outside the work tree, and made it the
responsibility of callers to check the condition in a roundabout
way.  This is made unnecessary with the previous patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-mv.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 68aa2a6..94f6dd2 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -19,7 +19,6 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
 				  int count, int base_name)
 {
 	int i;
-	int len = prefix ? strlen(prefix) : 0;
 	const char **result = xmalloc((count + 1) * sizeof(const char *));
 	memcpy(result, pathspec, count * sizeof(const char *));
 	result[count] = NULL;
@@ -33,11 +32,8 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
 			if (last_slash)
 				result[i] = last_slash + 1;
 		}
-		result[i] = prefix_path(prefix, len, result[i]);
-		if (!result[i])
-			exit(1); /* error already given */
 	}
-	return result;
+	return get_pathspec(prefix, result);
 }
 
 static void show_list(const char *label, struct path_list *list)
-- 
1.5.4.3.587.g0bdd73

