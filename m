From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH 2/2] Display warning for default git push with no push.default config
Date: Mon, 16 Mar 2009 16:42:52 +0100
Message-ID: <1237218172-16565-3-git-send-email-finnag@pvv.org>
References: <1237218172-16565-1-git-send-email-finnag@pvv.org>
Cc: gitster@pobox.com, Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 16:45:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjF0I-0001AL-K4
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 16:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbZCPPni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 11:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbZCPPng
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 11:43:36 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:53590 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbZCPPne (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 11:43:34 -0400
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1LjEyL-0004WS-U2; Mon, 16 Mar 2009 16:43:28 +0100
X-Mailer: git-send-email 1.6.2.99.g52e77
In-Reply-To: <1237218172-16565-1-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113338>

If a git push without any refspecs is attempted, display a warning.
The current default behavior is to push all matching refspecs, which
may come as a surprise to new users, so the warning shows how
push.default can be configured and what the possible values are.

Traditionalists who wish to keep the current behaviour are also told
how to configure this once and never see the warning again.

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 Documentation/RelNotes-1.6.3.txt |    7 +++++++
 builtin-push.c                   |   23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Documentation/RelNotes-1.6.3.txt b/Documentation/RelNotes-1.6.3.txt
index 679ad28..d961bc8 100644
--- a/Documentation/RelNotes-1.6.3.txt
+++ b/Documentation/RelNotes-1.6.3.txt
@@ -22,6 +22,13 @@ branch pointed at by its HEAD, gets a large warning.  You can choose what
 should happen upon such a push by setting the configuration variable
 receive.denyDeleteCurrent in the receiving repository.
 
+In a future release, the default of "git push" without further
+arguments may be changed. Currently, it will push all matching
+refspecs to the current remote.  A configuration variable push.default
+has been introduced to select the default behaviour.  To ease the
+transition, a big warning is issued if this is not configured and a
+git push without arguments is attempted.
+
 
 Updates since v1.6.2
 --------------------
diff --git a/builtin-push.c b/builtin-push.c
index 45fe843..c8e559f 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -64,11 +64,34 @@ static void setup_push_tracking(void)
 	add_refspec(refspec.buf);
 }
 
+static const char *warn_unconfigured_push_msg[] = {
+	"You did not specify any refspecs to push, and the current remote",
+	"has not configured any push refspecs. The default action in this",
+	"case has been to push all matching refspecs, that is, all branches",
+	"that exist both locally and remotely will be updated.",
+	"This default may change in the future.",
+	"",
+	"You can specify what action you want to take in this case, and",
+	"avoid seeing this message again, by configuring 'push.default' to:",
+	"  'nothing'  : Do not push anythig",
+	"  'matching' : Push all matching branches (the current default)",
+	"  'tracking' : Push the current branch to whatever it is tracking",
+	"  'current'  : Push the current branch"
+};
+
+static void warn_unconfigured_push(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(warn_unconfigured_push_msg); i++)
+		warning("%s", warn_unconfigured_push_msg[i]);
+}
+
 static void setup_default_push_refspecs(void)
 {
 	git_config(git_default_config, NULL);
 	switch (push_default) {
 	case PUSH_DEFAULT_UNSPECIFIED:
+		warn_unconfigured_push();
 		/* fallthrough */
 
 	case PUSH_DEFAULT_MATCHING:
-- 
1.6.2.1.138.gc403b.dirty
