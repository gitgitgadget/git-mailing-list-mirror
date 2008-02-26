From: Johan Herland <johan@herland.net>
Subject: [PATCH] Fix premature call to git_config() causing t1020-subdirectory to fail
Date: Tue, 26 Feb 2008 16:40:48 +0100
Message-ID: <200802261640.48770.johan@herland.net>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Kristian =?utf-8?q?H=C3=B8gsberg?= <krh@redhat.com>,
	Santi =?utf-8?q?B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 16:43:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU1x0-0000n5-2W
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 16:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762658AbYBZPlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 10:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760915AbYBZPlj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 10:41:39 -0500
Received: from sam.opera.com ([213.236.208.81]:40616 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760292AbYBZPli (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 10:41:38 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m1QFengX011002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Feb 2008 15:40:49 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <200802260321.14038.johan@herland.net>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.1/6003/Tue Feb 26 11:34:31 2008 on smtp.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75146>

We need to call git_config(git_default_config) in order to get user.name and
user.email (so that reflogs will be correct), but if we do it too early, it
interferes with the setup of reference repos. Therefore, move git_config()
call to _after_ the reference has been setup (but before we start writing
reflogs). However, in order for git_config() to read in the global
configuration at that point, we must unset CONFIG_ENVIRONMENT.

There are probably better ways of resolving this issue.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Tuesday 26 February 2008, Johan Herland wrote:
> - Call git_config(git_default_config) in order to properly set up
>   user.name and user.email for reflogs (This BREAKS test #9 in
>   t1020-subdirectory.sh. Have yet to figure out why)

Here is a fix for this breakage, although I think it's ugly as hell.

But with this fix, and the other one I just sent out for the
for_each_ref() corruption, the whole test suite finally passes on my
box.

Feel free to incorporate this into the further builtin-clone work,
or ignore it, and find better ways of solving these issues.


Have fun! :)

...Johan


 builtin-clone.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index d5baffc..c02a04c 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -346,8 +346,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	char branch_top[256], key[256], refname[256], value[256];
 	struct strbuf reflog_msg;
 
-	git_config(git_default_config);
-
 	clone_pid = getpid();
 
 	argc = parse_options(argc, argv, builtin_clone_options,
@@ -423,6 +421,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	set_git_dir(make_absolute_path(git_dir));
 
+	/* This must happen _after_ git_dir has been set up */
+	unsetenv(CONFIG_ENVIRONMENT); /* need user/email from global config */
+	git_config(git_default_config);
+
 	if (option_bare)
 		git_config_set("core.bare", "true");
 
-- 
1.5.4.3.342.g99e8
