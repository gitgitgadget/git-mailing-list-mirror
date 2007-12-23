From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] builtin-commit: fix amending of the initial commit
Date: Sat, 22 Dec 2007 19:55:34 -0800
Message-ID: <1198382136-15724-2-git-send-email-gitster@pobox.com>
References: <1198382136-15724-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 23 04:56:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6Hwy-0008FK-56
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 04:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbXLWDzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 22:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbXLWDzw
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 22:55:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbXLWDzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 22:55:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 55A7E258F;
	Sat, 22 Dec 2007 22:55:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DEAA2258E;
	Sat, 22 Dec 2007 22:55:47 -0500 (EST)
X-Mailer: git-send-email 1.5.4.rc1.19.g9151fa
In-Reply-To: <1198382136-15724-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69166>

When amending initial commit without editor, the command
incorrectly barfed because the check to see if there is anything
to commit referenced the non-existent HEAD^1.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 96410de..d8f0dfd 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -374,7 +374,7 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 
 	if (no_edit) {
 		struct rev_info rev;
-		unsigned char sha1[40];
+		unsigned char sha1[20];
 		const char *parent = "HEAD";
 
 		fclose(fp);
@@ -382,12 +382,12 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 		if (!active_nr && read_cache() < 0)
 			die("Cannot read index");
 
-		if (get_sha1("HEAD", sha1) != 0)
-			return !!active_nr;
-
 		if (amend)
 			parent = "HEAD^1";
 
+		if (get_sha1(parent, sha1))
+			return !!active_nr;
+
 		init_revisions(&rev, "");
 		rev.abbrev = 0;
 		setup_revisions(0, NULL, &rev, parent);
-- 
1.5.4.rc1.19.g9151fa
