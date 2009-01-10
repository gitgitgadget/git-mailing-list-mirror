From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 5/6] Modify setup_path() to only add git_exec_path() to PATH
Date: Sat, 10 Jan 2009 14:50:51 +0100
Message-ID: <1231595452-27698-5-git-send-email-prohaska@zib.de>
References: <1231595452-27698-1-git-send-email-prohaska@zib.de>
 <1231595452-27698-2-git-send-email-prohaska@zib.de>
 <1231595452-27698-3-git-send-email-prohaska@zib.de>
 <1231595452-27698-4-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 14:53:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLeH3-0006VW-Cb
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 14:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbZAJNvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 08:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbZAJNva
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 08:51:30 -0500
Received: from mailer.zib.de ([130.73.108.11]:45498 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051AbZAJNvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 08:51:25 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0ADos8w025836;
	Sat, 10 Jan 2009 14:51:03 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0ADorWP016764;
	Sat, 10 Jan 2009 14:50:54 +0100 (MET)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1231595452-27698-4-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105107>

Searching git programs only in the highest priority location is
sufficient.  It does not make sense that some of the required
programs are located at the highest priority location but other
programs are picked up from a lower priority exec-path.  If
exec-path is overridden a complete set of commands should be
provided, otherwise several different versions could get mixed,
which is likely to cause confusion.

If a user explicitly overrides the default location (by --exec-path
or GIT_EXEC_PATH), we now expect that all the required programs are
found there.  Instead of adding the directories "argv_exec_path",
"getenv(EXEC_PATH_ENVIRONMENT)", and "system_path(GIT_EXEC_PATH)"
to PATH, we now rely on git_exec_path(), which implements the same
order, but only returns the highest priority location to search for
executables.

Accessing only the location with highest priority is also required
for testing executables built with RUNTIME_PREFIX.  The call to
system_path() should be avoided if RUNTIME_PREFIX is set and the
executable is not installed at its final destination.  Because we
test before installing, we want to avoid calling system_path()
during tests.  The modifications in this commit avoid calling
system_path(GIT_EXEC_PATH) if a higher-priority location is
provided, which is the case when running the tests.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 exec_cmd.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 576c9ae..ec38b0a 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -117,9 +117,7 @@ void setup_path(void)
 	const char *old_path = getenv("PATH");
 	struct strbuf new_path = STRBUF_INIT;
 
-	add_path(&new_path, argv_exec_path);
-	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
-	add_path(&new_path, system_path(GIT_EXEC_PATH));
+	add_path(&new_path, git_exec_path());
 	add_path(&new_path, argv0_path);
 
 	if (old_path)
-- 
1.6.1.85.g32c5d
