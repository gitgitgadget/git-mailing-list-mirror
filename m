From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/4] git-gc --auto: add pre-auto-gc hook
Date: Mon, 31 Mar 2008 11:35:46 +0200
Message-ID: <7637ee64f43964d2e514c1598b2e7783d71b8608.1206929014.git.vmiklos@frugalware.org>
References: <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 11:36:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgGRM-0002js-0Y
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 11:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbYCaJfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 05:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754684AbYCaJfs
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 05:35:48 -0400
Received: from virgo.iok.hu ([193.202.89.103]:11258 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816AbYCaJfs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 05:35:48 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DF6B41B258A;
	Mon, 31 Mar 2008 11:35:46 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 803C244696;
	Mon, 31 Mar 2008 11:32:38 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7FFF91190547; Mon, 31 Mar 2008 11:35:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78575>

If such a hook is available and exits with a non-zero status, then
git-gc --auto won't run.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-gc.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 8cef36f..acd63be 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -157,6 +157,25 @@ static int too_many_packs(void)
 	return gc_auto_pack_limit <= cnt;
 }
 
+static int run_hook()
+{
+	const char *argv[2];
+	struct child_process hook;
+
+	argv[0] = git_path("hooks/pre-auto-gc");
+	argv[1] = NULL;
+
+	if (access(argv[0], X_OK) < 0)
+		return 0;
+
+	memset(&hook, 0, sizeof(hook));
+	hook.argv = argv;
+	hook.no_stdin = 1;
+	hook.stdout_to_stderr = 1;
+
+	return run_command(&hook);
+}
+
 static int need_to_gc(void)
 {
 	/*
@@ -176,6 +195,9 @@ static int need_to_gc(void)
 		append_option(argv_repack, "-A", MAX_ADD);
 	else if (!too_many_loose_objects())
 		return 0;
+
+	if (run_hook())
+		return 0;
 	return 1;
 }
 
-- 
1.5.5.rc2.4.g283c6
