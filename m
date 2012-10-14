From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/2] config: exit on error accessing any config file
Date: Sun, 14 Oct 2012 01:46:00 -0700
Message-ID: <20121014084600.GC7190@elie.Belkin>
References: <20121014000210.GA19094@elie.Belkin>
 <20121014000402.GB11399@elie.Belkin>
 <20121014062218.GB13477@sigill.intra.peff.net>
 <20121014084244.GA7190@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 14 10:46:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNJq0-0004M7-MJ
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 10:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab2JNIqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 04:46:09 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64526 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab2JNIqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 04:46:08 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4076963pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 01:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=K7Mp/ySbA/I3fBVyXjEe9ZmACincf2vjPWRjhBHiFOY=;
        b=Trc6cd5ccmo2WO0SRz8sS4RJlvwxTI0BWqCdvr9vR62WtTIUfZPgCBzJThOQidQxQJ
         OQPLcqXdKNi0vvOw1RiWHUf3IQW+iKRJP1huQxSobpzAdOdCwajUgySwB8WbJgNmY/FJ
         FEpSBSfjO5QQaLW+hAgZWBPD/7khKGVVY6CAHxMIyRXmv0cFnGp7o8WnMWswrHiB84X5
         FsPbDNECM1V34x1nRSukde7bPfXlFURFhZDA/XcwasffP3oq+IFWeDdxgruG/j7siraO
         hBu4z1q665gbEBOuJSX0hXgaF1/Isluitr3SbkoVuVUAb1A/792ikhQH6jTR9egq+vci
         APdw==
Received: by 10.66.77.74 with SMTP id q10mr23949472paw.81.1350204367688;
        Sun, 14 Oct 2012 01:46:07 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id bj7sm7186683pab.24.2012.10.14.01.46.06
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 01:46:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121014084244.GA7190@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207647>

There is convenience in warning and moving on when somebody has a
bogus permissions on /etc/gitconfig and cannot do anything about it.
But the cost in predictability and security is too high --- when
unreadable config files are skipped, it means an I/O error or
permissions problem causes important configuration to be bypassed.

For example, servers may depend on /etc/gitconfig to enforce security
policy (setting transfer.fsckObjects or receive.deny*).  Best to
always error out when encountering trouble accessing a config file.

This may add inconvenience in some cases:

  1. You are inspecting somebody else's repo, and you do not have
     access to their .git/config file.  Git typically dies in this
     case already since we cannot read core.repositoryFormatVersion,
     so the change should not be too noticeable.

  2. You have used "sudo -u" or a similar tool to switch uid, and your
     environment still points Git at your original user's global
     config, which is not readable.  In this case people really would
     be inconvenienced (they would rather see the harmless warning and
     continue the operation) but they can work around it by setting
     HOME appropriately after switching uids.

  3. You do not have access to /etc/gitconfig due to a broken setup.
     In this case, erroring out is a good way to put pressure on the
     sysadmin to fix the setup.  While they wait for a reply, users
     can set GIT_CONFIG_NOSYSTEM to true to keep Git working without
     complaint.

After this patch, errors accessing the repository-local and systemwide
config files and files requested in include directives cause Git to
exit, just like errors accessing ~/.gitconfig.

Explained-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index e8875b8a..a4d153f6 100644
--- a/config.c
+++ b/config.c
@@ -60,7 +60,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 		path = buf.buf;
 	}
 
-	if (!access_or_warn(path, R_OK)) {
+	if (!access_or_die(path, R_OK)) {
 		if (++inc->depth > MAX_INCLUDE_DEPTH)
 			die(include_depth_advice, MAX_INCLUDE_DEPTH, path,
 			    cf && cf->name ? cf->name : "the command line");
@@ -939,7 +939,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 
 	home_config_paths(&user_config, &xdg_config, "config");
 
-	if (git_config_system() && !access_or_warn(git_etc_gitconfig(), R_OK)) {
+	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK)) {
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
 					    data);
 		found += 1;
@@ -955,7 +955,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 		found += 1;
 	}
 
-	if (repo_config && !access_or_warn(repo_config, R_OK)) {
+	if (repo_config && !access_or_die(repo_config, R_OK)) {
 		ret += git_config_from_file(fn, repo_config, data);
 		found += 1;
 	}
-- 
1.8.0.rc2
