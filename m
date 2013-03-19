From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] add: make pathless 'add [-u|-A]' warning a file-global
 function
Date: Mon, 18 Mar 2013 20:45:46 -0700
Message-ID: <20130319034545.GJ5062@elie.Belkin>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 04:46:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHnVC-00024d-G2
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 04:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035Ab3CSDpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 23:45:51 -0400
Received: from mail-da0-f48.google.com ([209.85.210.48]:48119 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab3CSDpv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 23:45:51 -0400
Received: by mail-da0-f48.google.com with SMTP id p8so29871dan.7
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 20:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=jdqsp+jPjEBDgj9OipwKATt1dJ14hi4wZx1Le4qGsJA=;
        b=yt08RMndp/sHu3KgW2Ah2ENLEj5XEzCqhSw8u/9YuZuqYUxrrA5fq8JTj8w9/teN+T
         XJ0XcmsiMgd1iAvdSE6lWoNNy+N4M2EEgXRLbeJzmSy1q6m8lCeCxVpX7u0xUcaET7wC
         gfCxlN5mh4PlM2Ki2Bp2HzE9KU1RLPoZdtua0d/2N49qNAaYWldEbAMJaaX+z6PYweu+
         TmgZv1gtK5tEbLmcf6fZwR+pJf0rOJEDmXGzRCHK7/zvyeQhVHh2EUVwFa5yUE8/ybVP
         eyN5UnQu68BOPDyr0OT674D6rHn5a/rFLWagGpMVyXtB1z2oygOm7VIYWA21q6qcWNqd
         rJ+w==
X-Received: by 10.68.129.197 with SMTP id ny5mr743220pbb.110.1363664750486;
        Mon, 18 Mar 2013 20:45:50 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id kb3sm22492588pbc.21.2013.03.18.20.45.48
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 20:45:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130319034415.GI5062@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218474>

Currently warn_pathless_add() is only called directly by cmd_add(),
but that is about to change.  Move its definition higher in the file
and pass the "--update" or "--all" option name used in its message
through globals instead of function arguments to make it easier to
call without passing values that will not change through the call
chain.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/add.c | 69 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ab1c9e8f..a4028eea 100644
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
