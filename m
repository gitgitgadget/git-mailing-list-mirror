From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/7] Fix branch -m @{-1} newname
Date: Mon, 23 Mar 2009 00:58:37 -0700
Message-ID: <03d3aada5a2a68a7acdb6286fd72155f01626e41.1237791716.git.gitster@pobox.com>
References: <cover.1237791716.git.gitster@pobox.com>
 <431b1969fcde69959a23355fba6894fb69c8fa0c.1237791716.git.gitster@pobox.com>
 <a552de75eb01f78046feaf7dc88e5e4833624ad5.1237791716.git.gitster@pobox.com>
 <a31dca0393fefae894b7a155ae24000107bcc383.1237791716.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 09:01:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llf5u-0003W2-4E
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 09:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856AbZCWH7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 03:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756795AbZCWH7A
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 03:59:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47555 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756801AbZCWH66 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 03:58:58 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 231808693
	for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:58:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AA75A868A for
 <git@vger.kernel.org>; Mon, 23 Mar 2009 03:58:55 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.349.ga64c
In-Reply-To: <a31dca0393fefae894b7a155ae24000107bcc383.1237791716.git.gitster@pobox.com>
In-Reply-To: <cover.1237791716.git.gitster@pobox.com>
References: <cover.1237791716.git.gitster@pobox.com>
X-Pobox-Relay-ID: 760A83CA-1780-11DE-89E2-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114258>

The command is supposed to rename the branch we were on before switched
from to a new name, but was not aware of the short-hand notation we added
recently.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-branch.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 7452db1..0df82bf 100644
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
+		die("A branch named '%s' already exists.", newref.buf + 11);
 
 	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 		 oldref.buf, newref.buf);
-- 
1.6.2.1.349.ga64c
