From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] describe: do not use unannotated tag even if exact match
Date: Wed, 18 Nov 2009 14:32:26 +0100
Message-ID: <985ab43f219852a6d5dc302424fd1c012e19a09e.1258551042.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 14:33:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAkfC-0006gj-Uj
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 14:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756963AbZKRNd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 08:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbZKRNd1
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 08:33:27 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:35794 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753158AbZKRNd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 08:33:26 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 18 Nov
 2009 14:33:32 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 18 Nov
 2009 14:33:11 +0100
X-Mailer: git-send-email 1.6.5.3.381.gfeb7e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133173>

4d23660 (describe: when failing, tell the user about options that
work, 2009-10-28) forgot to update the shortcut path where the code
detected and used a possible exact match.  This means that an
unannotated tag on HEAD would be used by 'git describe'.

Guard this code path against the new circumstances, where unannotated
tags can be present in ->util even if we're not actually planning to
use them.

While there, also add some tests for --all.

Reported by 'yashi' on IRC.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin-describe.c  |    2 +-
 t/t6120-describe.sh |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index d4efb10..71be2a9 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -200,7 +200,7 @@ static void describe(const char *arg, int last_one)
 		die("%s is not a valid '%s' object", arg, commit_type);
 
 	n = cmit->util;
-	if (n) {
+	if (n && (tags || all || n->prio == 2)) {
 		/*
 		 * Exact match to an existing ref.
 		 */
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index c050f94..065dead 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -92,12 +92,18 @@ check_describe A-* HEAD^
 check_describe D-* HEAD^^
 check_describe A-* HEAD^^2
 check_describe B HEAD^^2^
+check_describe D-* HEAD^^^
 
 check_describe c-* --tags HEAD
 check_describe c-* --tags HEAD^
 check_describe e-* --tags HEAD^^
 check_describe c-* --tags HEAD^^2
 check_describe B --tags HEAD^^2^
+check_describe e --tags HEAD^^^
+
+check_describe heads/master --all HEAD
+check_describe tags/c-* --all HEAD^
+check_describe tags/e --all HEAD^^^
 
 check_describe B-0-* --long HEAD^^2^
 check_describe A-3-* --long HEAD^^2
-- 
1.6.5.3.381.gfeb7e
