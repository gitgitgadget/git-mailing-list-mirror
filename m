From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] gc: remove gc.pid file at end of execution
Date: Thu, 26 Sep 2013 11:18:18 +0200
Message-ID: <1380187098-8519-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: pclouds@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 26 11:18:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP7iW-0005mK-TY
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 11:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895Ab3IZJSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 05:18:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51105 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755884Ab3IZJSc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 05:18:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8Q9IPDM005447
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Sep 2013 11:18:25 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VP7iM-00023x-Cj; Thu, 26 Sep 2013 11:18:26 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VP7iM-0002E7-2J; Thu, 26 Sep 2013 11:18:26 +0200
X-Mailer: git-send-email 1.8.4.474.g128a96c
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 26 Sep 2013 11:18:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8Q9IPDM005447
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1380791907.07279@laJVWAT0qGzXftwC+9BJWQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235410>

This file isn't really harmful, but isn't useful either, and can create
minor annoyance for the user:

* It's confusing, as the presence of a *.pid file often implies that a
  process is currently running. A user running "ls .git/" and finding
  this file may incorrectly guess that a "git gc" is currently running.

* Leaving this file means that a "git gc" in an already gc-ed repo is
  no-longer a no-op. A user running "git gc" in a set of repositories,
  and then synchronizing this set (e.g. rsync -av, unison, ...) will see
  all the gc.pid files as changed, which creates useless noise.

This patch unlinks the file after the garbage collection is done, so that
gc.pid is actually present only during execution.

Future versions of Git may want to use the information left in the gc.pid
file (e.g. for policies like "don't attempt to run a gc if one has
already been ran less than X hours ago"). If so, this patch can safely be
reverted. For now, let's not bother the users.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/gc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 891a2c2..db39963 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -316,5 +316,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
 
+	/*
+	 * The file isn't harmful, but isn't useful either.
+	 */
+	unlink(git_path("gc.pid"));
 	return 0;
 }
-- 
1.8.4.474.g128a96c
