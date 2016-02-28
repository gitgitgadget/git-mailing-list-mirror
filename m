From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] lockfile: improve error message when lockfile exists
Date: Sun, 28 Feb 2016 21:11:16 +0100
Message-ID: <1456690276-13914-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Gregory.Mounie@grenoble-inp.fr, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 21:11:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa7gr-0003yw-2T
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 21:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbcB1ULh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 15:11:37 -0500
Received: from mx2.imag.fr ([129.88.30.17]:52263 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644AbcB1ULg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 15:11:36 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1SKBSsD021271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 28 Feb 2016 21:11:29 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1SKBVA8006198;
	Sun, 28 Feb 2016 21:11:31 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 28 Feb 2016 21:11:29 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1SKBSsD021271
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1457295091.65413@viOw/6onAZu2W7iU2fkq3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287790>

A common mistake leading a user to see this message is to launch "git
commit", let the editor open (and forget about it), and try again to
commit.

The previous message was going too quickly to "a git process crashed"
and to the advice "remove the file manually".

This patch modifies the message in two ways: first, it considers that
"another process is running" is the norm, not the exception, and it
explicitly hints the user to look at text editors.

The message is 2 lines longer, but this is not a problem since
experienced users do not see the message often.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This patch was written after seen one more time a student panicked
because he had a "git commit" backgrounded.

I'm not 100% satisfied with the new message. I don't think it harms to
have a 5-lines message here but it's probably possible to be a bit
more concise.

I'm the author of the previous version of the message, and I remember
writting it after debugging a segfaut in Git which led me to see the
message multiple times because of a crash. I guess that gave the wrong
biais to the message ;-).

 lockfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 80d056d..a7d6175 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -150,9 +150,11 @@ void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
 {
 	if (err == EEXIST) {
 		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
-		    "If no other git process is currently running, this probably means a\n"
-		    "git process crashed in this repository earlier. Make sure no other git\n"
-		    "process is running and remove the file manually to continue.",
+		    "Another git process seems to be running in this repository.\n"
+		    "Please terminate it (e.g. quit any text editor that git may be\n"
+		    "waiting for) and try again. If no other git process is running,\n"
+		    "then a process may have crashed in this repository earlier:\n"
+		    "remove the file manually to continue.",
 			    absolute_path(path), strerror(err));
 	} else
 		strbuf_addf(buf, "Unable to create '%s.lock': %s",
-- 
2.7.2.334.g35ed2ae.dirty
