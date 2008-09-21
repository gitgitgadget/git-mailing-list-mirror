From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 6/7] Modify setup_path() to only add git_exec_path() to PATH
Date: Sun, 21 Sep 2008 18:24:37 +0200
Message-ID: <1222014278-11071-7-git-send-email-prohaska@zib.de>
References: <1222014278-11071-1-git-send-email-prohaska@zib.de>
 <1222014278-11071-2-git-send-email-prohaska@zib.de>
 <1222014278-11071-3-git-send-email-prohaska@zib.de>
 <1222014278-11071-4-git-send-email-prohaska@zib.de>
 <1222014278-11071-5-git-send-email-prohaska@zib.de>
 <1222014278-11071-6-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 21 18:27:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhRm9-0001PG-EL
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 18:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbYIUQZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 12:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbYIUQZz
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 12:25:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:50477 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbYIUQZy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 12:25:54 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m8LGOdpx005003;
	Sun, 21 Sep 2008 18:24:45 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m8LGOcxT015855;
	Sun, 21 Sep 2008 18:24:39 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1222014278-11071-6-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96405>

We should search git programs only in the highest-priority location.
The old code added the directories "argv_exec_path",
"getenv(EXEC_PATH_ENVIRONMENT)", and "system_path(GIT_EXEC_PATH)" to
PATH.  The same order is implemented in git_exec_path(), which returns
the highest priority location to search for executables.  If the user
explicitly overrides the default location (by --exec-path or
GIT_EXEC_PATH) we can expect that all the required programs are there.
It does not make sense that only some of the required programs are
located at the highest priority location and other programs are picked
up from a lower priority exec-path.  If exec-path is overridden
a complete set of commands should be provided, otherwise several
different versions might easily get mixed, which is likely to spread
confusion.

Accessing the location with highest priority only is also required for
testing of executables built with RUNTIME_PREFIX.  Calling
system_path(GIT_EXEC_PATH) is avoided if a higher-priority location is
provided, which is the case for the tests.  The call to system_path()
must be avoided, if RUNTIME_PREFIX is set, because the call would fail
if the executable is not installed at its final destination.  But we
test before installing.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 exec_cmd.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 46ebf7e..2a86670 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -111,9 +111,7 @@ void setup_path(void)
 
 	strbuf_init(&new_path, 0);
 
-	add_path(&new_path, argv_exec_path);
-	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
-	add_path(&new_path, system_path(GIT_EXEC_PATH));
+	add_path(&new_path, git_exec_path());
 	add_path(&new_path, argv0_path);
 
 	if (old_path)
-- 
1.6.0.2.GIT
