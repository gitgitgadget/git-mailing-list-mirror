From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] repack: call prune_packed_objects() and update_server_info()
 directly
Date: Sat, 13 Sep 2014 09:28:01 +0200
Message-ID: <5413F201.8030005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 13 09:28:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XShlH-0005dK-VF
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 09:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbaIMH2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 03:28:44 -0400
Received: from mout.web.de ([212.227.15.3]:57729 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbaIMH2n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 03:28:43 -0400
Received: from [192.168.178.27] ([79.253.169.236]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MMIdp-1XRKJp25wD-0080o4; Sat, 13 Sep 2014 09:28:40
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
X-Provags-ID: V03:K0:LqnKX64/d/wSHPj1nZ/dF5QUWuC9THEeHAJnJoSLOQhGlkMth37
 M588D9vCwCMR+Pe4Qu0bOAfSfB4cKiInJSfP7EOhf2hI7DpXuhoD3XdDbGO/irrMw83/YIi
 N1NU1UqNZm0xdUpGNWpNYP0+DUN6iNglBXO2jYHJBT5Hfck66XnMQYSerxlA4m3CH5syxdK
 9Qkx1jIn8Sl+yW8PyPjlA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256953>

Call the functions behind git prune-packed and git update-server-info
directly instead of using run_command().  This is shorter, easier and
quicker.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/repack.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index fc088db..2aae05d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -377,6 +377,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	/* End of pack replacement. */
 
 	if (delete_redundant) {
+		int opts = 0;
 		sort_string_list(&names);
 		for_each_string_list_item(item, &existing_packs) {
 			char *sha1;
@@ -387,25 +388,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			if (!string_list_has_string(&names, sha1))
 				remove_redundant_pack(packdir, item->string);
 		}
-		argv_array_push(&cmd_args, "prune-packed");
-		if (quiet)
-			argv_array_push(&cmd_args, "--quiet");
-
-		memset(&cmd, 0, sizeof(cmd));
-		cmd.argv = cmd_args.argv;
-		cmd.git_cmd = 1;
-		run_command(&cmd);
-		argv_array_clear(&cmd_args);
+		if (!quiet && isatty(2))
+			opts |= PRUNE_PACKED_VERBOSE;
+		prune_packed_objects(opts);
 	}
 
-	if (!no_update_server_info) {
-		argv_array_push(&cmd_args, "update-server-info");
-		memset(&cmd, 0, sizeof(cmd));
-		cmd.argv = cmd_args.argv;
-		cmd.git_cmd = 1;
-		run_command(&cmd);
-		argv_array_clear(&cmd_args);
-	}
+	if (!no_update_server_info)
+		update_server_info(0);
 	remove_temporary_files();
 	string_list_clear(&names, 0);
 	string_list_clear(&rollback, 0);
-- 
2.1.0
