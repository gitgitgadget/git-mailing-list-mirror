From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 1/2] Call load_command_list() only when it is needed
Date: Mon, 30 Dec 2013 22:05:44 +0100
Message-ID: <52C1E028.8000004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: chriscool@tuxfamily.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 30 22:06:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vxk2E-0006hz-NV
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 22:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278Ab3L3VF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 16:05:59 -0500
Received: from plane.gmane.org ([80.91.229.3]:58463 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932169Ab3L3VF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 16:05:58 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Vxk28-0006d4-US
	for git@vger.kernel.org; Mon, 30 Dec 2013 22:05:56 +0100
Received: from p4fc96272.dip0.t-ipconnect.de ([79.201.98.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Dec 2013 22:05:56 +0100
Received: from sschuberth by p4fc96272.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Dec 2013 22:05:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p4fc96272.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239827>

This avoids list_commands_in_dir() being called when not needed which is
quite slow due to file I/O in order to list matching files in a directory.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 builtin/help.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index cc17e67..b6fc15e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -288,6 +288,7 @@ static struct cmdnames main_cmds, other_cmds;
 
 static int is_git_command(const char *s)
 {
+	load_command_list("git-", &main_cmds, &other_cmds);
 	return is_in_cmdlist(&main_cmds, s) ||
 		is_in_cmdlist(&other_cmds, s);
 }
@@ -449,7 +450,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	int nongit;
 	const char *alias;
 	enum help_format parsed_help_format;
-	load_command_list("git-", &main_cmds, &other_cmds);
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
@@ -458,6 +458,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	if (show_all) {
 		git_config(git_help_config, NULL);
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
+		load_command_list("git-", &main_cmds, &other_cmds);
 		list_commands(colopts, &main_cmds, &other_cmds);
 	}
 
-- 
1.8.4.msysgit.0
