From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Fri,  9 Mar 2012 09:31:26 +0100
Message-ID: <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 09 09:31:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5vEl-0008L1-SB
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 09:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090Ab2CIIbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 03:31:39 -0500
Received: from mx2.imag.fr ([129.88.30.17]:44018 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601Ab2CIIbi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 03:31:38 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q298RfF5003999
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Mar 2012 09:27:41 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1S5vEX-0000T1-B7; Fri, 09 Mar 2012 09:31:29 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1S5vEX-000336-5H; Fri, 09 Mar 2012 09:31:29 +0100
X-Mailer: git-send-email 1.7.9.3.330.g598662
In-Reply-To: <vpqobs65gfc.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 09 Mar 2012 09:27:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q298RfF5003999
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1331886465.43201@SOyhe5AT3QL1y/8pQZKCpg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192694>

More inexperienced users will often push right after committing, and at
that time they're still very much in the "working-on-one-branch" state of
mind.  "upstream" would be a safer default mode of operation for 'git push'
for them even when they have their personal publishing repository (also in
a shared public repository settings, "matching" is rarely the right
default mode).

In preparation for flipping the default to the "upstream" mode from the
"matching" mode that is the upstream default, start warning users when they
rely on unconfigured "git push" to default to the "matching" mode.

Original patch and commit message by: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

This patch prepares a transition to 'upstream', unlike the previous
version which was advertizing 'current'. In most case, this would be
the same, but 'upstream' is probably more sensible in case it points
to a branch other than 'current'. I don't care much either way.

I've kept the wording from the original patch, which commits to a
future change. We may instead relax this commitment and just say "the
default is likely to change in a future version", or so.

 builtin/push.c |   22 ++++++++++++++++++++++
 cache.h        |    1 +
 environment.c  |    2 +-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index d315475..03545c0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -91,10 +91,32 @@ static void setup_push_upstream(struct remote *remote)
 	add_refspec(refspec.buf);
 }
 
+static void warn_unspecified_push_default_configuration(void)
+{
+	static int warn_once;
+
+	if (warn_once++)
+		return;
+	warning(_("push.default is unset; its implicit value is changing in 1.8.0 from\n"
+		  "'matching' to 'upstream'. To squelch this message and maintain the current\n"
+		  "behavior post-1.8.0, use:\n"
+		  "\n"
+		  "  git config --global push.default matching\n"
+		  "\n"
+		  "To squelch this message and adopt the 1.8.0 behavior now, use:\n"
+		  "\n"
+		  "  git config --global push.default upstream\n"
+		  "\n"
+		  "See 'git help config' and search for 'push.default' for further information.\n"));
+}
+
 static void setup_default_push_refspecs(struct remote *remote)
 {
 	switch (push_default) {
 	default:
+	case PUSH_DEFAULT_UNSPECIFIED:
+		warn_unspecified_push_default_configuration();
+		/* fallthru */
 	case PUSH_DEFAULT_MATCHING:
 		add_refspec(":");
 		break;
diff --git a/cache.h b/cache.h
index e12b15f..e5c3f26 100644
--- a/cache.h
+++ b/cache.h
@@ -622,6 +622,7 @@ enum rebase_setup_type {
 };
 
 enum push_default_type {
+	PUSH_DEFAULT_UNSPECIFIED = -1,
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
 	PUSH_DEFAULT_UPSTREAM,
diff --git a/environment.c b/environment.c
index c93b8f4..d7e6c65 100644
--- a/environment.c
+++ b/environment.c
@@ -52,7 +52,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
-enum push_default_type push_default = PUSH_DEFAULT_MATCHING;
+enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
-- 
1.7.9.3.330.g598662
