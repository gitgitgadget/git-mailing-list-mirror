From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 23/25] reset: the command takes committish
Date: Tue,  3 Jul 2012 14:37:13 -0700
Message-ID: <1341351435-31011-24-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:39:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAp6-0007vc-55
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933024Ab2GCVjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:39:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35303 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755150Ab2GCViC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:38:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66FE186A2
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:38:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uNNN
	CJSK5HLpX/ECwI6CnIri83Q=; b=QO2+S8FAON8Gc+bfXl9xAJeluR5IdzwZEfh/
	4DwZB9WoMRFWlYibLIXs7+bIoMoa/UDy2otfiYWXJD37txCqiwyjidkCYZeAMWJF
	vJcjRCa2W9FI2/T3kIRRSv/A2hWDQy5wsICRqSiCK+ZLEULjVxkMiq5clMooQ2Db
	1u1PCSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=JW0I4A
	n2VIVrKBzIS2W4M1GqyOkYamuHpQKNk+4xidWCyniELAcvwntHwYN67G10Oa3dfx
	5MNsjmwFnSg69iR1kGCgzPvqJxyDtFYijYI9G5qrgxjHPfNWu3lXTHxQIDxM0JJj
	BP1iwEret+vHo1tFp+4nEms2uEFhM4rujidZs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E8C486A1
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:38:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB7C286A0 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:38:01 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5D7C585A-C557-11E1-BB47-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200971>

This is not strictly correct, in that resetting selected index
entries from corresponding paths out of a given tree without moving
HEAD is a valid operation, and in such case a tree-ish would suffice.

But the existing code already requires a committish in the codepath,
so let's be consistent with it for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/reset.c                     | 10 ++++++++--
 t/t1512-rev-parse-disambiguation.sh |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 8c2c1d5..392fb63 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -276,7 +276,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		 * Otherwise, argv[i] could be either <rev> or <paths> and
 		 * has to be unambiguous.
 		 */
-		else if (!get_sha1(argv[i], sha1)) {
+		else if (!get_sha1_committish(argv[i], sha1)) {
 			/*
 			 * Ok, argv[i] looks like a rev; it should not
 			 * be a filename.
@@ -289,9 +289,15 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (get_sha1(rev, sha1))
+	if (get_sha1_committish(rev, sha1))
 		die(_("Failed to resolve '%s' as a valid ref."), rev);
 
+	/*
+	 * NOTE: As "git reset $treeish -- $path" should be usable on
+	 * any tree-ish, this is not strictly correct. We are not
+	 * moving the HEAD to any commit; we are merely resetting the
+	 * entries in the index to that of a treeish.
+	 */
 	commit = lookup_commit_reference(sha1);
 	if (!commit)
 		die(_("Could not parse object '%s'."), rev);
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index dd42729..c3b78b9 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -121,7 +121,7 @@ test_expect_success 'git log takes only commit-ish' '
 	git log 11021982
 '
 
-test_expect_failure 'git reset takes only commit-ish' '
+test_expect_success 'git reset takes only commit-ish' '
 	git reset 11021982
 '
 
-- 
1.7.11.1.229.g706c98f
