From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 2/2] lockfile: improve error message when lockfile exists
Date: Tue,  1 Mar 2016 18:04:10 +0100
Message-ID: <1456851850-24759-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1456690276-13914-1-git-send-email-Matthieu.Moy@imag.fr>
 <1456851850-24759-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Gregory.Mounie@grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 18:04:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aanj0-0004JQ-1Q
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 18:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbcCAREi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 12:04:38 -0500
Received: from mx1.imag.fr ([129.88.30.5]:34995 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbcCAREh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 12:04:37 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u21H4CUZ019140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 1 Mar 2016 18:04:12 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u21H4C3R018006;
	Tue, 1 Mar 2016 18:04:14 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456851850-24759-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 01 Mar 2016 18:04:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u21H4CUZ019140
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1457456654.27588@Hh1VU1Ht+lBZsdijU2gDBA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288038>

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

Helped-by: Moritz Neeb <lists@moritzneeb.de>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 lockfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 62583d1..9268cdf 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -150,9 +150,11 @@ void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
 {
 	if (err == EEXIST) {
 		strbuf_addf(buf, _("Unable to create '%s.lock': %s.\n\n"
-		    "If no other git process is currently running, this probably means a\n"
-		    "git process crashed in this repository earlier. Make sure no other git\n"
-		    "process is running and remove the file manually to continue."),
+		    "Another git process seems to be running in this repository, e.g.\n"
+		    "an editor opened by 'git commit'. Please make sure all processes\n"
+		    "are terminated then try again. If it still fails, a git process\n"
+		    "may have crashed in this repository earlier:\n"
+		    "remove the file manually to continue."),
 			    absolute_path(path), strerror(err));
 	} else
 		strbuf_addf(buf, _("Unable to create '%s.lock': %s"),
-- 
2.7.2.334.g35ed2ae.dirty
