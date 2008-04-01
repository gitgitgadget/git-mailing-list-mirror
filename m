From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/4] git-gc --auto: add pre-auto-gc hook
Date: Tue, 1 Apr 2008 13:39:12 +0200
Message-ID: <a402ae0587d99797b7fb48d7f885add1aaba45e4.1207049697.git.vmiklos@frugalware.org>
References: <7vsky6jhz3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 13:39:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgeqK-00021T-Fr
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 13:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757113AbYDALjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 07:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757094AbYDALjO
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 07:39:14 -0400
Received: from virgo.iok.hu ([193.202.89.103]:18400 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757048AbYDALjN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 07:39:13 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 663C91B25A5;
	Tue,  1 Apr 2008 13:39:12 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id F40F944659;
	Tue,  1 Apr 2008 13:36:02 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 435581190A3B; Tue,  1 Apr 2008 13:39:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsky6jhz3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78647>

If such a hook is available and exits with a non-zero status, then
git-gc --auto won't run.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-gc.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 8cef36f..6561639 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -157,6 +157,33 @@ static int too_many_packs(void)
 	return gc_auto_pack_limit <= cnt;
 }
 
+static int run_hook()
+{
+	const char *argv[2];
+	struct child_process hook;
+	int ret;
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
+
+	ret = start_command(&hook);
+	if (ret) {
+		warning("Could not spawn %s", argv[0]);
+		return ret;
+	}
+	ret = finish_command(&hook);
+	if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
+		warning("%s exited due to uncaught signal", argv[0]);
+	return ret;
+}
+
 static int need_to_gc(void)
 {
 	/*
@@ -176,6 +203,9 @@ static int need_to_gc(void)
 		append_option(argv_repack, "-A", MAX_ADD);
 	else if (!too_many_loose_objects())
 		return 0;
+
+	if (run_hook())
+		return 0;
 	return 1;
 }
 
-- 
1.5.5.rc2.4.gec07.dirty
