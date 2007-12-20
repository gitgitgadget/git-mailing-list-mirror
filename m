From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fix git commit --amend -m "new message"
Date: Wed, 19 Dec 2007 19:23:03 -0800
Message-ID: <7v8x3qrqw8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 04:23:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5C0Y-0000M5-KG
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 04:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbXLTDXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 22:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753595AbXLTDXP
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 22:23:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbXLTDXO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 22:23:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6272A8E76;
	Wed, 19 Dec 2007 22:23:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C018A8E73;
	Wed, 19 Dec 2007 22:23:05 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68968>

The prepare_log_message() function serves two purposes:

 - Prepares the commit log message template, to be given to the end
   user;

 - Return true if there is something committable;

7168624c3530d8c7ee32f930f8fb2ba302b9801f (Do not generate full commit
log message if it is not going to be used) cheated to omit the former
when we know the log message template is not going to be used.  However,
its replacement logic to see if there is something committable was
botched.  When amending, it should compare the index with the parent of
the HEAD, not the current HEAD.  Otherwise you cannot run --amend to
fix only the message without changing the tree.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I think the other cheat to return !!active_nr is checking if it is
   the initial commit, and its test that appear in the context of this
   patch should be replaced with "if (initial_commit)", but I wanted to
   first fix the bug.

 builtin-commit.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 0a91013..96410de 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -375,6 +375,7 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 	if (no_edit) {
 		struct rev_info rev;
 		unsigned char sha1[40];
+		const char *parent = "HEAD";
 
 		fclose(fp);
 
@@ -384,9 +385,12 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 		if (get_sha1("HEAD", sha1) != 0)
 			return !!active_nr;
 
+		if (amend)
+			parent = "HEAD^1";
+
 		init_revisions(&rev, "");
 		rev.abbrev = 0;
-		setup_revisions(0, NULL, &rev, "HEAD");
+		setup_revisions(0, NULL, &rev, parent);
 		DIFF_OPT_SET(&rev.diffopt, QUIET);
 		DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
 		run_diff_index(&rev, 1 /* cached */);
