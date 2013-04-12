From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] config: allow inaccessible configuration under $HOME
Date: Fri, 12 Apr 2013 14:03:18 -0700
Message-ID: <20130412210318.GU27070@google.com>
References: <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
 <20130412112636.GC20178@odin.tremily.us>
 <20130412144855.GA17968@sigill.intra.peff.net>
 <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
 <20130412161600.GA20492@sigill.intra.peff.net>
 <20130412170505.GA2383@sigill.intra.peff.net>
 <20130412191433.GR27070@google.com>
 <20130412193755.GA5329@sigill.intra.peff.net>
 <20130412203442.GT27070@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 12 23:03:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQl85-0005NX-8F
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 23:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500Ab3DLVDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 17:03:24 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:58472 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849Ab3DLVDY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 17:03:24 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so1651279pab.10
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=E6l2KBED4Y6y5CLeXuWuVHBeHLCQxPP+awVc9Ugybpk=;
        b=wu7YnrJFz1/O44hACc3y9dytQ69sMsHxweAwF20nD6rpMszRASXd593CXvEpgjJVvR
         BI0Nym95feUeOD6KGrVhNjxffwIr3Y/K52B6bDyZD1bjlvhT0JzhYZiW1oe7k+cC7XYx
         yqsdMpa01fVhdLmDLAfzdT5Knz1Dnj+MGdhT+JxDpqphV5kOZZTF8RmtK07e0VwSCu2n
         w+yO1n2AIutVyavbC/AQWF3DY5gRPcRpDg4GsSes+ssaztZQo+R9Ee4PNkBhU6HCyux+
         aPxegm5ukd44d3K9NA6LE4k2HbLF0y4RHu9hWzwxqf/qyz0MaxHew75ePSnbw+l9zgfU
         vSvw==
X-Received: by 10.66.187.5 with SMTP id fo5mr17804741pac.67.1365800603343;
        Fri, 12 Apr 2013 14:03:23 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id aj2sm9908006pbc.1.2013.04.12.14.03.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 14:03:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130412203442.GT27070@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221026>

The changes v1.7.12.1~2^2~4 (config: warn on inaccessible files,
2012-08-21) and v1.8.1.1~22^2~2 (config: treat user and xdg config
permission problems as errors, 2012-10-13) were intended to prevent
important configuration (think "[transfer] fsckobjects") from being
ignored when the configuration is unintentionally unreadable (for
example with EIO on a flaky filesystem, or with ENOMEM due to a DoS
attack).  Usually ~/.gitconfig and ~/.config/git are readable by the
current user, and if they aren't then it would be easy to fix those
permissions, so the damage from adding this check should have been
minimal.

Unfortunately the access() check often trips when git is being run as
a server.  A daemon (such as inetd or git-daemon) starts as "root",
creates a listening socket, and then drops privileges, meaning that
when git commands are invoked they cannot access $HOME and die with

 fatal: unable to access '/root/.config/git/config': Permission denied

Any patch to fix this would have one of three problems:

  1. We annoy sysadmins who need to take an extra step to handle HOME
     when dropping privileges (the current behavior, or any other
     proposal that they have to opt into).

  2. We annoy sysadmins who want to set HOME when dropping privileges,
     either by making what they want to do impossible, or making them
     set an extra variable or option to accomplish what used to work
     (e.g., a patch to git-daemon to set HOME when --user is passed).

  3. We loosen the check, so some cases which might be noteworthy are
     not caught.

This patch is of type (3).

Treat user and xdg configuration that are inaccessible due to
permissions (EACCES) as though no user configuration was provided at
all.

An alternative method would be to check if $HOME is readable, but that
would not help in cases where the user who dropped privileges had a
globally readable HOME with only .config or .gitconfig being private.

This does not change the behavior when /etc/gitconfig or .git/config
is unreadable (since those are more serious configuration errors),
nor when ~/.gitconfig or ~/.config/git is unreadable due to problems
other than permissions.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Jeff King <peff@peff.net>
---
Jonathan Nieder wrote:

> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -408,11 +408,16 @@ void warn_on_inaccessible(const char *path)
>  	warning(_("unable to access '%s': %s"), path, strerror(errno));
>  }
>  
> +static int access_error_is_ok(int err, unsigned flag)
> +{
> +	return errno == ENOENT || errno == ENOTDIR ||

Sigh, I can't spell "err".  Here's a v2 incorporating that change and
with commit message incorporating the latest discussion.

 builtin/config.c  |  4 ++--
 config.c          | 10 +++++-----
 dir.c             |  4 ++--
 git-compat-util.h |  5 +++--
 wrapper.c         | 14 ++++++++++----
 5 files changed, 22 insertions(+), 15 deletions(-)

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
index bac59d2..dd7ecbb 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -408,18 +408,24 @@ void warn_on_inaccessible(const char *path)
 	warning(_("unable to access '%s': %s"), path, strerror(errno));
 }
 
-int access_or_warn(const char *path, int mode)
+static int access_error_is_ok(int err, unsigned flag)
+{
+	return err == ENOENT || err == ENOTDIR ||
+		((flag & ACCESS_EACCES_OK) && err == EACCES);
+}
+
+int access_or_warn(const char *path, int mode, unsigned flag)
 {
 	int ret = access(path, mode);
-	if (ret && errno != ENOENT && errno != ENOTDIR)
+	if (ret && !access_error_is_ok(errno, flag))
 		warn_on_inaccessible(path);
 	return ret;
 }
 
-int access_or_die(const char *path, int mode)
+int access_or_die(const char *path, int mode, unsigned flag)
 {
 	int ret = access(path, mode);
-	if (ret && errno != ENOENT && errno != ENOTDIR)
+	if (ret && !access_error_is_ok(errno, flag))
 		die_errno(_("unable to access '%s'"), path);
 	return ret;
 }
-- 
1.8.2.1
