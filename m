From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 0/5] builtin-status submodule summary
Date: Fri, 14 Mar 2008 23:28:36 +0800
Message-ID: <1205508521-7407-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 14 16:29:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaBqa-0003VC-HP
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 16:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbYCNP2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 11:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753675AbYCNP2t
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 11:28:49 -0400
Received: from mail.qikoo.org ([60.28.205.235]:50529 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753154AbYCNP2q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 11:28:46 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id C47FD470AE; Fri, 14 Mar 2008 23:28:41 +0800 (CST)
X-Mailer: git-send-email 1.5.4.4.653.g7cf1e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77241>

IMO, git submodule summary is not so useful for me if it's not
integrated into git-status. In fact i never use "git submodule
summary" directly. git-status with submodule summary support is very
useful to help user figure out what is going on in a more global level
when cooking the commit message.

So i think this series should go along with the submodule summary series.

The v2 series has following commits adding a new commit for documentation

      git-submodule summary: --for-status option
      builtin-status: submodule summary support
      builtin-status: configurable submodule summary size
      buitin-status: Add tests for submodule summary
      git-status: Mention status.submodulesummary config in the documentation

and diff relative to v1 is (not containing the documetation patch)

diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index a4cd553..33882c9 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -187,9 +187,7 @@ test_expect_success "status submodule summary is disabled by default" '
 	git diff expect output
 '
 
-cd sm &&
-head=$(git rev-parse --verify HEAD | cut -c1-7) &&
-cd ..
+head=$(cd sm && git rev-parse --short=7 --verify HEAD)
 
 cat > expect <<EOF
 # On branch master
diff --git a/wt-status.c b/wt-status.c
index c7cb69c..7a32c51 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -223,7 +223,7 @@ static void wt_status_print_changed(struct wt_status *s)
 }
 static void wt_status_print_submodule_summary(struct wt_status *s)
 {
-	if (wt_status_submodule_summary == 0) return;
+	if (! wt_status_submodule_summary) return;
 	struct child_process sm_summary;
 	char summary_limit[64];
 	sprintf(summary_limit, "%d", wt_status_submodule_summary);
@@ -339,8 +339,6 @@ void wt_status_print(struct wt_status *s)
 	}
 
 	wt_status_print_changed(s);
-	// must flush s->fp since following call will write to s->fp in a child process
-	fflush(s->fp);
 	wt_status_print_submodule_summary(s);
 	wt_status_print_untracked(s);
 
