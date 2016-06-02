From: Lukas Fleischer <lfleischer@lfos.de>
Subject: Mark remote `gc --auto` error messages
Date: Thu, 02 Jun 2016 21:05:29 +0200
Message-ID: <146489432847.688.11121862368709034386@typhoon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 21:12:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Y2V-0000Gs-B6
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 21:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161558AbcFBTMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 15:12:15 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:11936 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161469AbcFBTMO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 15:12:14 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jun 2016 15:12:14 EDT
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 90d645f6
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO
	for <git@vger.kernel.org>;
	Thu, 2 Jun 2016 21:05:33 +0200 (CEST)
User-Agent: alot/0.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296225>

When running `git push`, it might occur that error messages are
transferred from the server to the client. While most messages (those
explicitly sent on sideband 2) are prefixed with "remote:", it seems
that error messages printed during the automatic householding performed
by git-gc(1) are displayed without any additional decoration. Thus, such
messages can easily be misinterpreted as git-gc failing locally, see [1]
for an actual example of where that happened.

Do we want anything like the following patch (completely untested)?

-- 8< --
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a744437..15c323a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1775,9 +1775,20 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
                        const char *argv_gc_auto[] = {
                                "gc", "--auto", "--quiet", NULL,
                        };
-                       int opt = RUN_GIT_CMD | RUN_COMMAND_STDOUT_TO_STDERR;
+                       struct child_process proc = CHILD_PROCESS_INIT;
+
+                       proc.no_stdin = 1;
+                       proc.stdout_to_stderr = 1;
+                       proc.err = use_sideband ? -1 : 0;
+                       proc.git_cmd = 1;
+                       proc.argv = argv_gc_auto;
+
                        close_all_packs();
-                       run_command_v_opt(argv_gc_auto, opt);
+                       if (!start_command(&proc)) {
+                               if (use_sideband)
+                                       copy_to_sideband(proc.err, -1, NULL);
+                               finish_command(&proc);
+                       }
                }
                if (auto_update_server_info)
                        update_server_info(0);
-- 8< --

More generally, do we care about making *all* "remote" strings easily
distinguishable from "local" strings? Even though it is unlikely to use
this for an actual attack, it seems that a malicious server can
currently trick a user into performing an action by printing a message
that looks like something coming from "local" Git. Prefixing every
server message by "remote:" might look a bit ugly but maybe we can
simply use a different color instead and fall back to the prefix on
terminals without color support. Opinions?

[1] https://lists.archlinux.org/pipermail/aur-general/2016-June/032340.html
