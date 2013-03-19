From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/6] add: make pathless 'add [-u|-A]' warning a file-global
 function
Date: Tue, 19 Mar 2013 15:45:26 -0700
Message-ID: <20130319224526.GC19014@google.com>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
 <20130319224400.GA19014@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 23:46:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI5ID-0000Ps-8W
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 23:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934444Ab3CSWpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 18:45:36 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:33315 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933289Ab3CSWpb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 18:45:31 -0400
Received: by mail-pb0-f49.google.com with SMTP id xa12so810673pbc.36
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 15:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=NAX/u/66KOlSJwCldvGeI0DXHkzyneXP9hlMQfmfGac=;
        b=IJoTE9opgrnyLmvRW3hqbj/7YQdFx3g/Cf4Mn40FwtVgTOJmaR+jr3Te16/JrXuEfK
         26ZEawdLFVOjpn0eo8teSS+P7CWA7Tl+GCEB1C8o/iW1uNxKstsH0mHaaVlLQ+kOLiPq
         0BFPCgv8y9UcUeMgsHRGanLjZKS9zSb2M0I5UQ2LnLtyN6Tz0iEUbf4XB2yRYKCASW+b
         uCrQWOEPOm8aBFbJIpRurythRPkwH1BLodIZ1wdDLH112gVGZZJT5dVdt4tpN4jrCsML
         Uyw1zY6EqBtjXSlIn7B89VkVIXOrfr6ASUfiU7iyALD2HGoG/ufUt46zY8RtnPQ8Fi6H
         wnaw==
X-Received: by 10.68.8.69 with SMTP id p5mr5598440pba.212.1363733130985;
        Tue, 19 Mar 2013 15:45:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ol7sm25787934pbb.14.2013.03.19.15.45.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Mar 2013 15:45:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130319224400.GA19014@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218562>

Currently warn_pathless_add() is only called directly by cmd_add(),
but that is about to change.  Move its definition higher in the file
and pass the "--update" or "--all" option name used in its message
through globals instead of function arguments to make it easier to
call without passing values that will not change through the call
chain.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Unchanged.

 builtin/add.c | 69 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ab1c9e8..a4028ee 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -28,6 +28,41 @@ struct update_callback_data {
 	int add_errors;
 };
 
+static const char *option_with_implicit_dot;
+static const char *short_option_with_implicit_dot;
+
+static void warn_pathless_add(void)
+{
+	assert(option_with_implicit_dot && short_option_with_implicit_dot);
+
+	/*
+	 * To be consistent with "git add -p" and most Git
+	 * commands, we should default to being tree-wide, but
+	 * this is not the original behavior and can't be
+	 * changed until users trained themselves not to type
+	 * "git add -u" or "git add -A". For now, we warn and
+	 * keep the old behavior. Later, the behavior can be changed
+	 * to tree-wide, keeping the warning for a while, and
+	 * eventually we can drop the warning.
+	 */
+	warning(_("The behavior of 'git add %s (or %s)' with no path argument from a\n"
+		  "subdirectory of the tree will change in Git 2.0 and should not be used anymore.\n"
+		  "To add content for the whole tree, run:\n"
+		  "\n"
+		  "  git add %s :/\n"
+		  "  (or git add %s :/)\n"
+		  "\n"
+		  "To restrict the command to the current directory, run:\n"
+		  "\n"
+		  "  git add %s .\n"
+		  "  (or git add %s .)\n"
+		  "\n"
+		  "With the current Git version, the command is restricted to the current directory."),
+		option_with_implicit_dot, short_option_with_implicit_dot,
+		option_with_implicit_dot, short_option_with_implicit_dot,
+		option_with_implicit_dot, short_option_with_implicit_dot);
+}
+
 static int fix_unmerged_status(struct diff_filepair *p,
 			       struct update_callback_data *data)
 {
@@ -321,35 +356,6 @@ static int add_files(struct dir_struct *dir, int flags)
 	return exit_status;
 }
 
-static void warn_pathless_add(const char *option_name, const char *short_name) {
-	/*
-	 * To be consistent with "git add -p" and most Git
-	 * commands, we should default to being tree-wide, but
-	 * this is not the original behavior and can't be
-	 * changed until users trained themselves not to type
-	 * "git add -u" or "git add -A". For now, we warn and
-	 * keep the old behavior. Later, the behavior can be changed
-	 * to tree-wide, keeping the warning for a while, and
-	 * eventually we can drop the warning.
-	 */
-	warning(_("The behavior of 'git add %s (or %s)' with no path argument from a\n"
-		  "subdirectory of the tree will change in Git 2.0 and should not be used anymore.\n"
-		  "To add content for the whole tree, run:\n"
-		  "\n"
-		  "  git add %s :/\n"
-		  "  (or git add %s :/)\n"
-		  "\n"
-		  "To restrict the command to the current directory, run:\n"
-		  "\n"
-		  "  git add %s .\n"
-		  "  (or git add %s .)\n"
-		  "\n"
-		  "With the current Git version, the command is restricted to the current directory."),
-		option_name, short_name,
-		option_name, short_name,
-		option_name, short_name);
-}
-
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
@@ -360,8 +366,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int add_new_files;
 	int require_pathspec;
 	char *seen = NULL;
-	const char *option_with_implicit_dot = NULL;
-	const char *short_option_with_implicit_dot = NULL;
 
 	git_config(add_config, NULL);
 
@@ -392,8 +396,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (option_with_implicit_dot && !argc) {
 		static const char *here[2] = { ".", NULL };
 		if (prefix)
-			warn_pathless_add(option_with_implicit_dot,
-					  short_option_with_implicit_dot);
+			warn_pathless_add();
 		argc = 1;
 		argv = here;
 	}
-- 
1.8.2.rc3
