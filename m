From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] config: allow inaccessible configuration under $HOME
Date: Fri, 12 Apr 2013 12:14:33 -0700
Message-ID: <20130412191433.GR27070@google.com>
References: <20130412005748.GA17116@odin.tremily.us>
 <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
 <20130412043501.GA12942@sigill.intra.peff.net>
 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
 <20130412112636.GC20178@odin.tremily.us>
 <20130412144855.GA17968@sigill.intra.peff.net>
 <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
 <20130412161600.GA20492@sigill.intra.peff.net>
 <20130412170505.GA2383@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 12 21:14:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQjQp-00088n-9k
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 21:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab3DLTOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 15:14:39 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:51970 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504Ab3DLTOi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 15:14:38 -0400
Received: by mail-pb0-f53.google.com with SMTP id un15so1560562pbc.40
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gIoUmMJ+jSKsnxH03hitYEZzexSqK0k7V3DS9wvojeY=;
        b=iZ6QjWEeHr18/teufxr4ebM7MuRbdwLF+D+4Ji221qFwBWbtNwn2iF681aEvXVx/fR
         SoxT/lb9UNkPrWme1/0PCgvgdSUCheFpP+S0M+h4zG4pi4wsx2D8aShLsji3dI7RHJ07
         mpm7973e31FIo35Hng7qyqjd+V2Kb6MdBbR8QYzJicTftkBBWnwcl5R2sdVZFrJTdM+W
         U2O62RfHkWz9lK+HfMtqpkOVuYbvjVRsGLmdPVwz+wH2npoEJR5PfU0RiVekoQ5sD7VQ
         q/csTpJB82kUP5zcUMrZUEGDezTDUTx1l7qJ6dqE+/dp++pXTp0y+G3+rSiJqz3yBJV4
         vUDg==
X-Received: by 10.66.172.77 with SMTP id ba13mr17097865pac.63.1365794077849;
        Fri, 12 Apr 2013 12:14:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ao5sm7509945pbc.25.2013.04.12.12.14.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 12:14:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130412170505.GA2383@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221017>

One unexpected downside to the changes v1.7.12.1~2^2~4 (config: warn
on inaccessible files, 2012-08-21) and v1.8.1.1~22^2~2 (config: treat
user and xdg config permission problems as errors, 2012-10-13) is that
they often trip when git is being run as a server.  The appropriate
daemon (sshd, inetd, git-daemon, etc) starts as "root", creates a
listening socket, and then drops privileges, meaning that when git
commands are invoked they cannot access $HOME and die with

 fatal: unable to access '/root/.config/git/config': Permission denied

The intent was always to prevent important configuration (think
"[transfer] fsckobjects") from being ignored when the configuration is
unintentionally unreadable (for example with ENOMEM due to a DoS
attack).  But that is not worth breaking these cases of
drop-privileges-without-resetting-HOME that were working fine before.

Treat user and xdg configuration that is inaccessible due to
permissions (EACCES) as though no user configuration was provided at
all.

An alternative approach would be to check if $HOME is readable, but
that would not solve the problem in cases where the user who dropped
privileges had a globally readable HOME with only .config or
.gitconfig being private.

This does not change the behavior when "git config" is being used to
write to a user's config file, when /etc/gitconfig or .git/config is
unreadable (since those are more serious configuration errors), or
when ~/.gitconfig or ~/.config/git is unreadable due to problems other
than permissions.

Thanks to Mike Galbraith, W. Trevor King, and Jeff King for their
patient explanations.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:

> Given how tight the exception is, I almost wonder if we should drop the
> environment variable completely, and just never complain about this case
> (in other words, just make it a loosening of 96b9e0e3).

Yeah, I think that would be better.

How about this?  (Still needs tests.)

 builtin/config.c  |  4 ++--
 config.c          | 10 +++++-----
 dir.c             |  4 ++--
 git-compat-util.h |  5 +++--
 wrapper.c         | 10 ++++++----
 5 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 33c9bf9..19ffcaf 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -379,8 +379,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			 */
 			die("$HOME not set");
 
-		if (access_or_warn(user_config, R_OK) &&
-		    xdg_config && !access_or_warn(xdg_config, R_OK))
+		if (access_or_warn(user_config, R_OK, 0) &&
+		    xdg_config && !access_or_warn(xdg_config, R_OK, 0))
 			given_config_file = xdg_config;
 		else
 			given_config_file = user_config;
diff --git a/config.c b/config.c
index aefd80b..830ee14 100644
--- a/config.c
+++ b/config.c
@@ -58,7 +58,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 		path = buf.buf;
 	}
 
-	if (!access_or_die(path, R_OK)) {
+	if (!access_or_die(path, R_OK, 0)) {
 		if (++inc->depth > MAX_INCLUDE_DEPTH)
 			die(include_depth_advice, MAX_INCLUDE_DEPTH, path,
 			    cf && cf->name ? cf->name : "the command line");
@@ -954,23 +954,23 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 
 	home_config_paths(&user_config, &xdg_config, "config");
 
-	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK)) {
+	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
 					    data);
 		found += 1;
 	}
 
-	if (xdg_config && !access_or_die(xdg_config, R_OK)) {
+	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK)) {
 		ret += git_config_from_file(fn, xdg_config, data);
 		found += 1;
 	}
 
-	if (user_config && !access_or_die(user_config, R_OK)) {
+	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK)) {
 		ret += git_config_from_file(fn, user_config, data);
 		found += 1;
 	}
 
-	if (repo_config && !access_or_die(repo_config, R_OK)) {
+	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
 		ret += git_config_from_file(fn, repo_config, data);
 		found += 1;
 	}
diff --git a/dir.c b/dir.c
index 91cfd99..9cb2f3d 100644
--- a/dir.c
+++ b/dir.c
@@ -1637,9 +1637,9 @@ void setup_standard_excludes(struct dir_struct *dir)
 		home_config_paths(NULL, &xdg_path, "ignore");
 		excludes_file = xdg_path;
 	}
-	if (!access_or_warn(path, R_OK))
+	if (!access_or_warn(path, R_OK, 0))
 		add_excludes_from_file(dir, path);
-	if (excludes_file && !access_or_warn(excludes_file, R_OK))
+	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
 		add_excludes_from_file(dir, excludes_file);
 }
 
diff --git a/git-compat-util.h b/git-compat-util.h
index cde442f..51a29b8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -691,8 +691,9 @@ int remove_or_warn(unsigned int mode, const char *path);
  * Call access(2), but warn for any error except "missing file"
  * (ENOENT or ENOTDIR).
  */
-int access_or_warn(const char *path, int mode);
-int access_or_die(const char *path, int mode);
+#define ACCESS_EACCES_OK (1U << 0)
+int access_or_warn(const char *path, int mode, unsigned flag);
+int access_or_die(const char *path, int mode, unsigned flag);
 
 /* Warn on an inaccessible file that ought to be accessible */
 void warn_on_inaccessible(const char *path);
diff --git a/wrapper.c b/wrapper.c
index bac59d2..e860ad1 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -408,18 +408,20 @@ void warn_on_inaccessible(const char *path)
 	warning(_("unable to access '%s': %s"), path, strerror(errno));
 }
 
-int access_or_warn(const char *path, int mode)
+int access_or_warn(const char *path, int mode, unsigned flag)
 {
 	int ret = access(path, mode);
-	if (ret && errno != ENOENT && errno != ENOTDIR)
+	if (ret && errno != ENOENT && errno != ENOTDIR &&
+	    (!(flag & ACCESS_EACCES_OK) || errno != EACCES))
 		warn_on_inaccessible(path);
 	return ret;
 }
 
-int access_or_die(const char *path, int mode)
+int access_or_die(const char *path, int mode, unsigned flag)
 {
 	int ret = access(path, mode);
-	if (ret && errno != ENOENT && errno != ENOTDIR)
+	if (ret && errno != ENOENT && errno != ENOTDIR &&
+	    (!(flag & ACCESS_EACCES_OK) || errno != EACCES))
 		die_errno(_("unable to access '%s'"), path);
 	return ret;
 }
-- 
1.8.2.1
