From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/4] push: start warning upcoming default change for push.default
Date: Fri, 20 Apr 2012 16:59:04 +0200
Message-ID: <1334933944-13446-5-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqfwbye9re.fsf@bauges.imag.fr>
 <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 20 16:59:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLFJV-000747-2T
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 16:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089Ab2DTO7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 10:59:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34504 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757096Ab2DTO7q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 10:59:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3KErAFh032186
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Apr 2012 16:53:10 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SLFIt-0008N3-Ib; Fri, 20 Apr 2012 16:59:19 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SLFIt-0003WF-HQ; Fri, 20 Apr 2012 16:59:19 +0200
X-Mailer: git-send-email 1.7.10.140.g8c333
In-Reply-To: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 20 Apr 2012 16:53:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3KErAFh032186
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335538393.29934@yfkRnqoex/+2Nn986J/4DQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195998>

In preparation for flipping the default to the "simple" mode from
the "matching" mode that is the historical default, start warning
users when they rely on unconfigured "git push" to default to the
"matching" mode.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
I've documented the upcomming change in Documentation/config.txt in
addition to the warning.

 Documentation/config.txt |    6 ++++--
 builtin/push.c           |   23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 05d1472..bda3f47 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1686,7 +1686,8 @@ push.default::
   repository, but may give surprising results when used on a
   repository shared by multiple users, since locally stalled
   branches will attempt a non-fast forward push if other users
-  updated the branch remotely. This is the default.
+  updated the branch remotely. This is currently the default, but Git
+  2.0 will change the default to `simple`.
 * `upstream` - push the current branch to its upstream branch. See
   "branch.<name>.merge" for how to configure the upstream branch. This
   makes `git push` and `git pull` symmetrical in the sense that `push`
@@ -1699,7 +1700,8 @@ push.default::
   conservative and safer way than `matching`.
 * `simple` - like `upstream`, but refuses to push if the upstream
   branch's name is different from the local one. This is the safest
-  option and is well-suited for beginners.
+  option and is well-suited for beginners. It will become the default
+  in Git 2.0.
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
diff --git a/builtin/push.c b/builtin/push.c
index ba0d6a0..23cedf0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -132,12 +132,35 @@ static void setup_push_upstream(struct remote *remote, int simple)
 	add_refspec(refspec.buf);
 }
 
+static char warn_unspecified_push_default_msg[] =
+N_("push.default is unset; its implicit value is changing in\n"
+   "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
+   "and maintain the current behavior after the default changes, use:\n"
+   "\n"
+   "  git config --global push.default matching\n"
+   "\n"
+   "To squelch this message and adopt the new behavior now, use:\n"
+   "\n"
+   "  git config --global push.default simple\n"
+   "\n"
+   "See 'git help config' and search for 'push.default' for further information.");
+
+static void warn_unspecified_push_default_configuration(void)
+{
+	static int warn_once;
+
+	if (warn_once++)
+		return;
+	warning("%s\n", _(warn_unspecified_push_default_msg));
+}
+
 static void setup_default_push_refspecs(struct remote *remote)
 {
 	switch (push_default) {
 	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
 		default_matching_used = 1;
+		warn_unspecified_push_default_configuration();
 		/* fallthru */
 	case PUSH_DEFAULT_MATCHING:
 		add_refspec(":");
-- 
1.7.10.140.g8c333
