From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 2/4] Call load_command_list() only when it is needed
Date: Thu, 02 Jan 2014 17:16:30 +0100
Message-ID: <52C590DE.6030305@gmail.com>
References: <52C58FD7.6010608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 02 17:16:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vykws-0006lQ-Ca
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 17:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbaABQQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 11:16:39 -0500
Received: from mail-bk0-f41.google.com ([209.85.214.41]:54201 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbaABQQi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 11:16:38 -0500
Received: by mail-bk0-f41.google.com with SMTP id v15so4720593bkz.28
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 08:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=TceiqgPrH6e5G21Bj3Dbixa/JZG+SA6R46oj7bkejSk=;
        b=KtURR7wATV3BzJQ0fOz+SebfHn8J0wUJOLB8p/QDk9dR9BgmrzH+ulfG01H0AvNcR1
         I4dXQU3e6oI1OnqJ/C/zxxltOIqZWxdpiMAIo84pqGW4Rd2KsbPIx8SJ9kJevpb5hSol
         KGYYtxGd7QKUiCyiZ50W+EHuZRTn2qNqfp2lnIlv1lL/mr2sjQEFbxIiHNMHHhsFFVrA
         ipFYfZxMTWEkcO0yCLJm9jLnzNzlpE0eGID1c+MDnQ6WRHtNsVLJXPy7Fw9sVmlTej6u
         6IBQfvMx9d+yAUsVwqZbX/LR9FemYMf9mL4AmlEDOYE/Ik0Df+YGtEj+UM+pGaZN7mcB
         Zbcw==
X-Received: by 10.204.231.207 with SMTP id jr15mr69002bkb.92.1388679397050;
        Thu, 02 Jan 2014 08:16:37 -0800 (PST)
Received: from [192.168.188.20] (p5DDB39A7.dip0.t-ipconnect.de. [93.219.57.167])
        by mx.google.com with ESMTPSA id sx5sm43540509bkb.0.2014.01.02.08.16.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 08:16:36 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <52C58FD7.6010608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239855>

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
1.8.3-mingw-1
