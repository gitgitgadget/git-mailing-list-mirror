From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] pager: set LESS=FRSX also on Windows
Date: Fri, 11 Sep 2009 19:45:07 +0200
Message-ID: <200909111945.07842.j6t@kdbg.org>
References: <200909092337.39885.j6t@kdbg.org> <1252560077-1725-1-git-send-email-snaury@gmail.com> <200909111940.08652.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, Alexey Borzenkov <snaury@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 19:45:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmABQ-0005C6-Ew
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 19:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790AbZIKRpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 13:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755788AbZIKRpH
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 13:45:07 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:10124 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755781AbZIKRpG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 13:45:06 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 32F7710010;
	Fri, 11 Sep 2009 19:45:08 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id F042B435C7;
	Fri, 11 Sep 2009 19:45:07 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200909111940.08652.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128209>

Previously, this environment variable was set in the pager_preexec
callback, which is conditionally-compiled only on Unix, because it is not,
and cannot be, called on Windows.

With this patch the env member of struct child_process is used to set
the environment variable, which also works on Windows.

Noticed by Alexey Borzenkov.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Alexey,

 this will result in a conflict when you apply it to your msysgit because
 there is an extra patch that shuffled the setup of pager_process around.

 -- Hannes

 pager.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/pager.c b/pager.c
index 4921843..f416d38 100644
--- a/pager.c
+++ b/pager.c
@@ -21,8 +21,6 @@ static void pager_preexec(void)
 	FD_ZERO(&in);
 	FD_SET(0, &in);
 	select(1, &in, NULL, &in, NULL);
-
-	setenv("LESS", "FRSX", 0);
 }
 #endif
 
@@ -70,6 +68,10 @@ void setup_pager(void)
 	pager_argv[2] = pager;
 	pager_process.argv = pager_argv;
 	pager_process.in = -1;
+	if (!getenv("LESS")) {
+		static const char *env[] = { "LESS=FRSX", NULL };
+		pager_process.env = env;
+	}
 #ifndef __MINGW32__
 	pager_process.preexec_cb = pager_preexec;
 #endif
-- 
1.6.5.rc0.28.gfb9b
