From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH] receive-pack: send auto-gc output over sideband 2
Date: Sun,  5 Jun 2016 11:36:38 +0200
Message-ID: <20160605093638.16533-1-lfleischer@lfos.de>
References: <146489432847.688.11121862368709034386@typhoon>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 11:36:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9UUJ-0005Bo-Sv
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 11:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbcFEJgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2016 05:36:51 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:46448 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbcFEJgv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2016 05:36:51 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 2bfe75e0
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO
	for <git@vger.kernel.org>;
	Sun, 5 Jun 2016 11:36:46 +0200 (CEST)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <146489432847.688.11121862368709034386@typhoon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296471>

Redirect auto-gc output to the sideband such that it is visible to all
clients. As a side effect, all auto-gc error messages are now prefixed
with "remote: " before being printed to stderr on the client-side which
makes it easier to understand that those error messages originate from
the server.

Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
 builtin/receive-pack.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a744437..15c323a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1775,9 +1775,20 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			const char *argv_gc_auto[] = {
 				"gc", "--auto", "--quiet", NULL,
 			};
-			int opt = RUN_GIT_CMD | RUN_COMMAND_STDOUT_TO_STDERR;
+			struct child_process proc = CHILD_PROCESS_INIT;
+
+			proc.no_stdin = 1;
+			proc.stdout_to_stderr = 1;
+			proc.err = use_sideband ? -1 : 0;
+			proc.git_cmd = 1;
+			proc.argv = argv_gc_auto;
+
 			close_all_packs();
-			run_command_v_opt(argv_gc_auto, opt);
+			if (!start_command(&proc)) {
+				if (use_sideband)
+					copy_to_sideband(proc.err, -1, NULL);
+				finish_command(&proc);
+			}
 		}
 		if (auto_update_server_info)
 			update_server_info(0);
-- 
2.8.3
