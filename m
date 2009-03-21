From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/7] Fix "branch -m @{-1} newname"
Date: Sat, 21 Mar 2009 15:13:37 -0700
Message-ID: <1237673619-12608-6-git-send-email-gitster@pobox.com>
References: <1237673619-12608-1-git-send-email-gitster@pobox.com>
 <1237673619-12608-2-git-send-email-gitster@pobox.com>
 <1237673619-12608-3-git-send-email-gitster@pobox.com>
 <1237673619-12608-4-git-send-email-gitster@pobox.com>
 <1237673619-12608-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 23:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll9U6-0007f9-UU
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 23:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371AbZCUWN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 18:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268AbZCUWN4
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 18:13:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431AbZCUWNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 18:13:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B2E58399
	for <git@vger.kernel.org>; Sat, 21 Mar 2009 18:13:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DF8778398 for
 <git@vger.kernel.org>; Sat, 21 Mar 2009 18:13:51 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.299.gda643a
In-Reply-To: <1237673619-12608-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8F83ED8A-1665-11DE-A5CA-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114082>

The command is supposed to rename the branch we were on before switched
from to a new name, but the codepath involved in it was not aware of the
short-hand notation we added recently.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-branch.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 7452db1..e15440f 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -468,18 +468,18 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	if (!oldname)
 		die("cannot rename the current branch while not on any.");
 
-	strbuf_addf(&oldref, "refs/heads/%s", oldname);
-
+	strbuf_branchname(&oldref, oldname);
+	strbuf_splice(&oldref, 0, 0, "refs/heads/", 11);
 	if (check_ref_format(oldref.buf))
-		die("Invalid branch name: %s", oldref.buf);
-
-	strbuf_addf(&newref, "refs/heads/%s", newname);
+		die("Invalid branch name: '%s'", oldname);
 
+	strbuf_branchname(&newref, newname);
+	strbuf_splice(&newref, 0, 0, "refs/heads/", 11);
 	if (check_ref_format(newref.buf))
-		die("Invalid branch name: %s", newref.buf);
+		die("Invalid branch name: '%s'", newname);
 
 	if (resolve_ref(newref.buf, sha1, 1, NULL) && !force)
-		die("A branch named '%s' already exists.", newname);
+		die("A branch named '%s' already exists.", newref.buf+11);
 
 	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 		 oldref.buf, newref.buf);
-- 
1.6.2.1.299.gda643a
