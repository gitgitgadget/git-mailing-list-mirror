From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC variant 2 of 2] "needs update" considered harmful
Date: Sun, 20 Jul 2008 00:48:21 -0700
Message-ID: <7v7ibhdmii.fsf@gitster.siamese.dyndns.org>
References: <7vtzelf4mf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 09:49:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKTg2-0004q4-US
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 09:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbYGTHs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 03:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbYGTHs3
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 03:48:29 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbYGTHs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 03:48:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A887C33259;
	Sun, 20 Jul 2008 03:48:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BE0A233258; Sun, 20 Jul 2008 03:48:23 -0400 (EDT)
X-commit: 8b005661de21195feb86f4f90b691aad823ede29
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3D33BCF4-5630-11DD-A7C1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89171>

"git update-index --refresh", "git reset" and "git add --refresh" have
reported paths that have local modifications as "needs update" since the
beginning of git.

Although this is logically correct in that you need to update the index at
that path before you can commit that change, it is now becoming more and
more clear, especially with the continuous push for user friendliness
since 1.5.0 series, that the message is suboptimal.  After all, the change
may be something the user might want to get rid of, and "updating" would
be absolutely a wrong thing to do if that is the case.

I prepared two alternatives to solve this.  Both aim to reword the message
to more neutral "locally modified".

This patch is a more straightforward variant that changes the message not
only for Porcelain commands ("add" and "reset") but also changes the
output from the plumbing command "update-index".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c                           |    2 +-
 t/t2103-update-index-ignore-missing.sh |    2 +-
 t/t7102-reset.sh                       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f83de8c..d37aec0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1019,7 +1019,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			}
 			if (quiet)
 				continue;
-			printf("%s: needs update\n", ce->name);
+			printf("%s: locally modified\n", ce->name);
 			has_errors = 1;
 			continue;
 		}
diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
index 4fbf855..f775acb 100755
--- a/t/t2103-update-index-ignore-missing.sh
+++ b/t/t2103-update-index-ignore-missing.sh
@@ -62,7 +62,7 @@ test_expect_success '--unmerged --refresh' '
 	test_must_fail git update-index --refresh &&
 	git update-index --unmerged --refresh &&
 	echo 2 >two &&
-	echo "two: needs update" >expect &&
+	echo "two: locally modified" >expect &&
 	test_must_fail git update-index --unmerged --refresh >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 96d1508..da4b142 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -419,7 +419,7 @@ test_expect_success 'resetting an unmodified path is a no-op' '
 '
 
 cat > expect << EOF
-file2: needs update
+file2: locally modified
 EOF
 
 test_expect_success '--mixed refreshes the index' '
-- 
1.5.6.4.570.g052e6
