From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-mailsplit: with maildirs try to process new/ if cur/ is empty
Date: Fri, 26 Oct 2007 14:15:39 +0000
Message-ID: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 16:15:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlPyH-0003Zv-Lf
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 16:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbXJZOPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 10:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbXJZOPU
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 10:15:20 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:33366 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751361AbXJZOPT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 10:15:19 -0400
Received: (qmail 29929 invoked by uid 1000); 26 Oct 2007 14:15:39 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62411>

When saving patches to a maildir with e.g. mutt, the files are put into
the new/ subdirectory of the maildir, not cur/.  This makes git-am state
"Nothing to do.".  This patch lets git-mailsplit fallback to new/ if the
cur/ subdirectory is empty.

This was reported by Joey Hess through
 http://bugs.debian.org/447396

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/git-am.txt |    3 ++-
 builtin-mailsplit.c      |    5 +++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index e4a6b3a..49f79f6 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -26,7 +26,8 @@ OPTIONS
 <mbox>|<Maildir>...::
 	The list of mailbox files to read patches from. If you do not
 	supply this argument, reads from the standard input. If you supply
-	directories, they'll be treated as Maildirs.
+	directories, they'll be treated as Maildirs, which should contain
+	the patches either in the cur/ subdirectory, or in new/.
 
 -s, --signoff::
 	Add `Signed-off-by:` line to the commit message, using
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 43fc373..eaf3cbe 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -131,6 +131,11 @@ static int split_maildir(const char *maildir, const char *dir,
 	snprintf(curdir, sizeof(curdir), "%s/cur", maildir);
 	if (populate_maildir_list(&list, curdir) < 0)
 		goto out;
+	if (list.nr == 0) {
+		snprintf(curdir, sizeof(curdir), "%s/new", maildir);
+		if (populate_maildir_list(&list, curdir) < 0)
+			goto out;
+	}
 
 	for (i = 0; i < list.nr; i++) {
 		FILE *f;
-- 
1.5.3.4
