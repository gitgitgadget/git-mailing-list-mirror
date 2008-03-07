From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] Revert part of d089eba (setup: sanitize absolute and
 funny paths in get_pathspec())
Date: Fri,  7 Mar 2008 02:54:46 -0800
Message-ID: <1204887286-32574-3-git-send-email-gitster@pobox.com>
References: <1204887286-32574-1-git-send-email-gitster@pobox.com>
 <1204887286-32574-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 11:55:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXaF3-0004M2-Fd
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 11:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760283AbYCGKzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 05:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759293AbYCGKzQ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 05:55:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760119AbYCGKzP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 05:55:15 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 88B132274
	for <git@vger.kernel.org>; Fri,  7 Mar 2008 05:55:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EF53A2273 for <git@vger.kernel.org>; Fri,  7 Mar 2008 05:55:11 -0500
 (EST)
X-Mailer: git-send-email 1.5.4.3.587.g0bdd73
In-Reply-To: <1204887286-32574-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76474>

When get_pathspec() was originally made absolute-path capable,
we botched the interface to it, without dying inside the function
when given a path that is outside the work tree, and made it the
responsibility of callers to check the condition in a roundabout
way.  This is made unnecessary with the previous patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-ls-files.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 25dbfb4..dc7eab8 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -574,17 +574,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	pathspec = get_pathspec(prefix, argv + i);
 
 	/* Verify that the pathspec matches the prefix */
-	if (pathspec) {
-		if (argc != i) {
-			int cnt;
-			for (cnt = 0; pathspec[cnt]; cnt++)
-				;
-			if (cnt != (argc - i))
-				exit(1); /* error message already given */
-		}
+	if (pathspec)
 		prefix = verify_pathspec(prefix);
-	} else if (argc != i)
-		exit(1); /* error message already given */
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec && error_unmatch) {
-- 
1.5.4.3.587.g0bdd73

