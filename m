From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Wrap RUNTIME_PREFIX warning in a compile-time condition
Date: Tue, 23 Feb 2010 09:32:02 +0100
Message-ID: <4B839282.1020605@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 09:32:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjqBj-00007b-W6
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 09:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab0BWIcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 03:32:11 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31928 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750909Ab0BWIcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 03:32:09 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NjqBX-00075e-2F; Tue, 23 Feb 2010 09:32:03 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B1C1E1660F;
	Tue, 23 Feb 2010 09:32:02 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140776>

From: Johannes Sixt <j6t@kdbg.org>

When RUNTIME_PREFIX is enabled, the installation prefix is derived by
trying a limited set of known locations where the git executable can
reside. If none of these is found, a warning is emitted.

When git is built in a directory that matches neither of these known names,
the warning would always be emitted when the uninstalled executable is run.
This is a problem on Windows, where gitk picks the uninstalled git when
invoked on the build directory and gets confused by the warning.

With this patch, individual developers can disable the warning by setting

   BASIC_CFLAGS += -DNO_WARN_RUNTIME_PREFIX

in config.mak.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 exec_cmd.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 408e4e5..5a22635 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -28,9 +28,11 @@ const char *system_path(const char *path)
 	    !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
 	    !(prefix = strip_path_suffix(argv0_path, "git"))) {
 		prefix = PREFIX;
+#ifndef NO_WARN_RUNTIME_PREFIX
 		fprintf(stderr, "RUNTIME_PREFIX requested, "
 				"but prefix computation failed.  "
 				"Using static fallback '%s'.\n", prefix);
+#endif
 	}
 #endif

-- 
1.7.0.84.g6ef09
