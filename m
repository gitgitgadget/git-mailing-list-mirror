From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH] i18n: unpack-trees: avoid substituting only a verb in sentences
Date: Thu, 12 May 2016 23:16:26 +0000
Message-ID: <1463094986-7344-1-git-send-email-vascomalmeida@sapo.pt>
References: <xmqqy47ec2n2.fsf@gitster.mtv.corp.google.com>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 01:17:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0zqu-0001rH-5U
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 01:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbcELXRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 19:17:03 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:47684 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751111AbcELXRC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 19:17:02 -0400
Received: (qmail 17054 invoked from network); 12 May 2016 23:16:59 -0000
Received: (qmail 4946 invoked from network); 12 May 2016 23:16:59 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 12 May 2016 23:16:58 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <xmqqy47ec2n2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294489>

Instead of reusing the same set of message templates for checkout
and other actions and substituting the verb with "%s", prepare
separate message templates for each known action. That would make
it easier for translation into languages where the same verb may
conjugate differently depending on the message we are giving.

See gettext documentation for details:
http://www.gnu.org/software/gettext/manual/html_node/Preparing-Strings.html

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---

I removed "Please," in favor of "Please" as Junio C Hamano sugested.

 unpack-trees.c | 60 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 630a8cf..6bc9512 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -58,27 +58,61 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	int i;
 	const char **msgs = opts->msgs;
 	const char *msg;
-	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";
 
-	if (advice_commit_before_merge)
-		msg = _("Your local changes to the following files would be overwritten by %s:\n%%s"
-			"Please, commit your changes or stash them before you can %s.");
+	if (!strcmp(cmd, "checkout"))
+		msg = advice_commit_before_merge
+		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
+			  "Please commit your changes or stash them before you can switch branches.")
+		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
+	else if (!strcmp(cmd, "merge"))
+		msg = advice_commit_before_merge
+		      ? _("Your local changes to the following files would be overwritten by merge:\n%%s"
+			  "Please commit your changes or stash them before you can merge.")
+		      : _("Your local changes to the following files would be overwritten by merge:\n%%s");
 	else
-		msg = _("Your local changes to the following files would be overwritten by %s:\n%%s");
+		msg = advice_commit_before_merge
+		      ? _("Your local changes to the following files would be overwritten by %s:\n%%s"
+			  "Please commit your changes or stash them before you can %s.")
+		      : _("Your local changes to the following files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
-		xstrfmt(msg, cmd, cmd2);
+		xstrfmt(msg, cmd, cmd);
 
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		_("Updating the following directories would lose untracked files in it:\n%s");
 
-	if (advice_commit_before_merge)
-		msg = _("The following untracked working tree files would be %s by %s:\n%%s"
-			"Please move or remove them before you can %s.");
+	if (!strcmp(cmd, "checkout"))
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be removed by checkout:\n%%s"
+			  "Please move or remove them before you can switch branches.")
+		      : _("The following untracked working tree files would be removed by checkout:\n%%s");
+	else if (!strcmp(cmd, "merge"))
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be removed by merge:\n%%s"
+			  "Please move or remove them before you can merge.")
+		      : _("The following untracked working tree files would be removed by merge:\n%%s");
 	else
-		msg = _("The following untracked working tree files would be %s by %s:\n%%s");
-
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = xstrfmt(msg, "removed", cmd, cmd2);
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = xstrfmt(msg, "overwritten", cmd, cmd2);
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be removed by %s:\n%%s"
+			  "Please move or remove them before you can %s.")
+		      : _("The following untracked working tree files would be removed by %s:\n%%s");
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = xstrfmt(msg, cmd, cmd);
+
+	if (!strcmp(cmd, "checkout"))
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be overwritten by checkout:\n%%s"
+			  "Please move or remove them before you can switch branches.")
+		      : _("The following untracked working tree files would be overwritten by checkout:\n%%s");
+	else if (!strcmp(cmd, "merge"))
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be overwritten by merge:\n%%s"
+			  "Please move or remove them before you can merge.")
+		      : _("The following untracked working tree files would be overwritten by merge:\n%%s");
+	else
+		msg = advice_commit_before_merge
+		      ? _("The following untracked working tree files would be overwritten by %s:\n%%s"
+			  "Please move or remove them before you can %s.")
+		      : _("The following untracked working tree files would be overwritten by %s:\n%%s");
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = xstrfmt(msg, cmd, cmd);
 
 	/*
 	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
-- 
2.7.3
