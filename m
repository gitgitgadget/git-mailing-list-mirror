From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/3] git-gc --auto: add pre-auto-gc hook
Date: Wed, 2 Apr 2008 21:34:38 +0200
Message-ID: <4507d1e1d8973a621222c389fa22cd96266312a7.1207164676.git.vmiklos@frugalware.org>
References: <7vtzik848t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 21:35:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh8k1-0000i9-1A
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 21:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759681AbYDBTep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 15:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759988AbYDBTep
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 15:34:45 -0400
Received: from virgo.iok.hu ([193.202.89.103]:24894 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759681AbYDBTej (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 15:34:39 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id D02071B25B4;
	Wed,  2 Apr 2008 21:34:38 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E872B446A7;
	Wed,  2 Apr 2008 21:31:27 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id AF7831190A16; Wed,  2 Apr 2008 21:34:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzik848t.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78706>

If such a hook is available and exits with a non-zero status, then
git-gc --auto won't run.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-gc.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 8cef36f..9dc7a37 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -157,6 +157,34 @@ static int too_many_packs(void)
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
+	hook.stdout_to_stderr = 1;
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
@@ -176,6 +204,9 @@ static int need_to_gc(void)
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
