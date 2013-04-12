From: Jeff King <peff@peff.net>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 13:05:05 -0400
Message-ID: <20130412170505.GA2383@sigill.intra.peff.net>
References: <20130411222301.GA11283@sigill.intra.peff.net>
 <20130412005748.GA17116@odin.tremily.us>
 <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
 <20130412043501.GA12942@sigill.intra.peff.net>
 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
 <20130412112636.GC20178@odin.tremily.us>
 <20130412144855.GA17968@sigill.intra.peff.net>
 <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
 <20130412161600.GA20492@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 19:05:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQhPa-0005zt-EM
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 19:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab3DLRFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 13:05:10 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42956 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab3DLRFI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 13:05:08 -0400
Received: (qmail 27672 invoked by uid 107); 12 Apr 2013 17:07:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Apr 2013 13:07:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Apr 2013 13:05:05 -0400
Content-Disposition: inline
In-Reply-To: <20130412161600.GA20492@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221001>

On Fri, Apr 12, 2013 at 12:16:00PM -0400, Jeff King wrote:

> One option we have not explored is an environment variable
> to loosen git's requirement. I'm thinking something like
> GIT_INACCESSIBLE_HOMEDIR_OK, which could be set by default
> when git-daemon uses --user.
> 
> That would leave all existing setups working, but would
> still enable the extra protections for people not running
> git-daemon (and people who use git via sudo could choose to
> set it, too, if they would prefer that to setting up HOME).

So here's what I came up with. I tried to make the exception as tight as
possible by checking that $HOME was actually the problem, as that is the
common problem (you switch users, but HOME is pointing to the old user).

It means that we would still die if ~root is readable, but
~root/.gitconfig is not (or ~root/.config is not). I think that is
probably a good thing, though, as it is an indication of something more
interesting going on that the user should investigate.

Given how tight the exception is, I almost wonder if we should drop the
environment variable completely, and just never complain about this case
(in other words, just make it a loosening of 96b9e0e3).

-Peff

---
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6a875f2..e004ee8 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -806,6 +806,15 @@ for further details.
 	temporarily to avoid using a buggy `/etc/gitconfig` file while
 	waiting for someone with sufficient permissions to fix it.
 
+'GIT_INACCESSIBLE_HOME_OK'::
+	Normally git will complain and die if it cannot access
+	`$HOME/.gitconfig`. If this variable is set to "1", then
+	a `$HOME` directory which cannot be accessed will not be
+	considered an error. This can be useful if you are switching
+	user ids without resetting `$HOME`, and are willing to take the
+	risk that some configuration options might not be used (because
+	git could not read the config file that contained them).
+
 'GIT_FLUSH'::
 	If this environment variable is set to "1", then commands such
 	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
diff --git a/cache.h b/cache.h
index e1e8ce8..01f300f 100644
--- a/cache.h
+++ b/cache.h
@@ -358,6 +358,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NOTES_REWRITE_REF_ENVIRONMENT "GIT_NOTES_REWRITE_REF"
 #define GIT_NOTES_REWRITE_MODE_ENVIRONMENT "GIT_NOTES_REWRITE_MODE"
 #define GIT_LITERAL_PATHSPECS_ENVIRONMENT "GIT_LITERAL_PATHSPECS"
+#define GIT_INACCESSIBLE_HOME_OK_ENVIRONMENT "GIT_INACCESSIBLE_HOME_OK"
 
 /*
  * This environment variable is expected to contain a boolean indicating
diff --git a/daemon.c b/daemon.c
index 131b049..6c56cc0 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1091,7 +1091,7 @@ static void drop_privileges(struct credentials *cred)
 	if (cred && (initgroups(cred->pass->pw_name, cred->gid) ||
 	    setgid (cred->gid) || setuid(cred->pass->pw_uid)))
 		die("cannot drop privileges");
-	setenv("GIT_CONFIG_INACCESSIBLE_HOME_OK", "1", 0);
+	setenv(GIT_INACCESSIBLE_HOME_OK_ENVIRONMENT, "1", 0);
 }
 
 static struct credentials *prepare_credentials(const char *user_name,
diff --git a/wrapper.c b/wrapper.c
index bac59d2..644f867 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -416,11 +416,52 @@ int access_or_die(const char *path, int mode)
 	return ret;
 }
 
+/*
+ * Returns true iff the path is under $HOME, that directory is inaccessible,
+ * and the user has told us through the environment that an inaccessible HOME
+ * is OK. The results are cached so that repeated calls will not make multiple
+ * syscalls.
+ */
+static int inaccessible_home_ok(const char *path)
+{
+	static int gentle = -1;
+	static int home_inaccessible = -1;
+	const char *home;
+
+	if (gentle < 0)
+		gentle = git_env_bool(GIT_INACCESSIBLE_HOME_OK_ENVIRONMENT, 0);
+	if (!gentle)
+		return 0;
+
+	home = getenv("HOME");
+	if (!home)
+		return 0;
+	/*
+	 * We do not bother with normalizing PATHs to avoid symlinks
+	 * here, since the point is to catch paths that are
+	 * constructed as "$HOME/...".
+	 */
+	if (prefixcmp(path, home) && path[strlen(home)] == '/')
+		return 0;
+
+	if (home_inaccessible < 0)
+		home_inaccessible = access(home, R_OK|X_OK) < 0 && errno == EACCES;
+	return home_inaccessible;
+}
+
 int access_or_die(const char *path, int mode)
 {
 	int ret = access(path, mode);
-	if (ret && errno != ENOENT && errno != ENOTDIR)
+	if (ret && errno != ENOENT && errno != ENOTDIR) {
+		/*
+		 * We do not have to worry about clobbering errno
+		 * in inaccessible_home_ok, because we get either EACCES
+		 * again, or we die.
+		 */
+		if (errno == EACCES && inaccessible_home_ok(path))
+			return ret;
 		die_errno(_("unable to access '%s'"), path);
+	}
 	return ret;
 }
 

> 
> -Peff
