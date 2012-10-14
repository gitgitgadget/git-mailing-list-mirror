From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] config: treat user and xdg config permission problems as
 errors
Date: Sat, 13 Oct 2012 17:04:02 -0700
Message-ID: <20121014000402.GB11399@elie.Belkin>
References: <20121014000210.GA19094@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 14 02:04:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNBgr-0000hQ-Gw
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 02:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab2JNAEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 20:04:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58051 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab2JNAEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 20:04:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3916672pbb.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 17:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HU+REdNtAqI+AO8tHMOpMRjzpzapFsTbD+ZbpBfzI24=;
        b=O1sz1eHMzuJGXOtFwsVblZFsM1lxNQh+yC7AsOps9DEa9c7s3EK977GU4CQfApiYs4
         Glwk9h7go1NdeTgWzvWbcLi4UH+LSl9FDIA3nFLWSdoFuhXMcXjhnNM1r12zfhcaKU3K
         fd67JTRBQCEL4o1+pB/GJkDx+LiibkMlkPuSfy2XFGhIQxoM/Y/tZZ91hZYmDbdL04im
         6iRVTFjVQ0s7iajRyRMVHOmEv0D8L1dVVTH53SDZCxR/uU7WXDE9WeJFsJoWsw8uJ4ql
         SzF1987ve9CcAdXamH4nnLCdt9U02Tc1J/MID5H4VdLMPezKzR9ULgOwv7OmcgTGGpgA
         m+9w==
Received: by 10.68.216.74 with SMTP id oo10mr25672983pbc.92.1350173049301;
        Sat, 13 Oct 2012 17:04:09 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id o5sm6611621paz.32.2012.10.13.17.04.08
        (version=SSLv3 cipher=OTHER);
        Sat, 13 Oct 2012 17:04:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121014000210.GA19094@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207587>

Git reads multiple configuration files: settings come first from the
system config file (typically /etc/gitconfig), then the xdg config
file (typically ~/.config/git/config), then the user's dotfile
(~/.gitconfig), then the repository configuration (.git/config).

Git has always used access(2) to decide whether to use each file; as
an unfortunate side effect, that means that if one of these files is
unreadable (e.g., EPERM or EIO), git skips it.  So if I use
~/.gitconfig to override some settings but make a mistake and give it
the wrong permissions then I am subject to the settings the sysadmin
chose for /etc/gitconfig.

Better to error out and ask the user to correct the problem.

This only affects the user and xdg config files, since the user
presumably has enough access to fix their permissions.  If the system
config file is unreadable, the best we can do is to warn about it so
the user knows to notify someone and get on with work in the meantime.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 config.c          | 4 ++--
 git-compat-util.h | 1 +
 wrapper.c         | 8 ++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 08e47e2e..e8875b8a 100644
--- a/config.c
+++ b/config.c
@@ -945,12 +945,12 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 		found += 1;
 	}
 
-	if (xdg_config && !access_or_warn(xdg_config, R_OK)) {
+	if (xdg_config && !access_or_die(xdg_config, R_OK)) {
 		ret += git_config_from_file(fn, xdg_config, data);
 		found += 1;
 	}
 
-	if (user_config && !access_or_warn(user_config, R_OK)) {
+	if (user_config && !access_or_die(user_config, R_OK)) {
 		ret += git_config_from_file(fn, user_config, data);
 		found += 1;
 	}
diff --git a/git-compat-util.h b/git-compat-util.h
index f567767f..dfe2e318 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -640,6 +640,7 @@ int remove_or_warn(unsigned int mode, const char *path);
  * (ENOENT or ENOTDIR).
  */
 int access_or_warn(const char *path, int mode);
+int access_or_die(const char *path, int mode);
 
 /* Warn on an inaccessible file that ought to be accessible */
 void warn_on_inaccessible(const char *path);
diff --git a/wrapper.c b/wrapper.c
index c1b919f3..7cbe96a0 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -416,6 +416,14 @@ int access_or_warn(const char *path, int mode)
 	return ret;
 }
 
+int access_or_die(const char *path, int mode)
+{
+	int ret = access(path, mode);
+	if (ret && errno != ENOENT && errno != ENOTDIR)
+		die_errno(_("unable to access '%s'"), path);
+	return ret;
+}
+
 struct passwd *xgetpwuid_self(void)
 {
 	struct passwd *pw;
-- 
1.8.0.rc2
