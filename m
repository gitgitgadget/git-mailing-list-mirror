From: Jeff King <peff@peff.net>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Tue, 21 Aug 2012 02:10:59 -0400
Message-ID: <20120821061059.GA26516@sigill.intra.peff.net>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
 <CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
 <7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
 <CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
 <7v628dght9.fsf@alter.siamese.dyndns.org>
 <20120821015738.GA20271@sigill.intra.peff.net>
 <7vpq6kgazt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 08:11:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3hgE-00058r-UF
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 08:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab2HUGLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 02:11:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43419 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724Ab2HUGLD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 02:11:03 -0400
Received: (qmail 28269 invoked by uid 107); 21 Aug 2012 06:11:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Aug 2012 02:11:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2012 02:10:59 -0400
Content-Disposition: inline
In-Reply-To: <7vpq6kgazt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203939>

On Mon, Aug 20, 2012 at 08:49:42PM -0700, Junio C Hamano wrote:

> > No, I do not think it was on purpose. And it would be very hard to do
> > so, anyway; config callbacks are not given any information about the
> > source of the config variable, and cannot distinguish between repo,
> > global, and system-level config variables.
> 
> I was looking for setenv() to refuse system wide defaults; that
> actually is fairly simple.

Ah. I was thinking we had ripped those out (since they were primarily
about the test suite, and we found other ways of working around them),
but we do indeed still have GIT_CONFIG_NOSYSTEM.  So yet another
possibility is that the OP has that environment variable set for some
odd reason.

> > That seems far more likely to me. Another possibility is that the
> > file is not readable by the user running receive-pack.
> 
> Good point. We explicitly use access(R_OK) and pretend as if a path
> that is known to exist but not readable is missing; perhaps we may
> want to diagnose this as a misconfiguration and issue a warning?

I think that makes sense. Like this patch?

-- >8 --
Subject: [PATCH] config: warn on inaccessible files

Before reading a config file, we check "!access(path, R_OK)"
to make sure that the file exists and is readable. If it's
not, then we silently ignore it.

For the case of ENOENT, this is fine, as the presence of the
file is optional. For other cases, though, it may indicate a
configuration error (e.g., not having permissions to read
the file). Let's print a warning in these cases to let the
user know.

Signed-off-by: Jeff King <peff@peff.net>
---
This catches the common code path of git itself trying to read the
config file.  The "git config foo.bar" lookup path does not warn, as it
just tries to fopen each file (and silently bails if a file cannot be
opened).  However, since before doing its actual lookup, it would run
git_config() anyway, you will already have seen the warning.

You can get multiple warnings from this, as some programs read the
config multiple times. I don't think it's really worth caring about, as
you would want to fix such a misconfiguration quickly anyway.

A bigger question is whether people are stuck living with such a
misconfiguration (e.g., inaccessible directories made by a clueless
admin), and would be annoyed at having no way to turn this feature off.

 builtin/config.c  |  4 ++--
 config.c          | 10 +++++-----
 git-compat-util.h |  3 +++
 wrapper.c         |  8 ++++++++
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8cd08da..b0394ef 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -396,8 +396,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			 */
 			die("$HOME not set");
 
-		if (access(user_config, R_OK) &&
-		    xdg_config && !access(xdg_config, R_OK))
+		if (access_or_warn(user_config, R_OK) &&
+		    xdg_config && !access_or_warn(xdg_config, R_OK))
 			given_config_file = xdg_config;
 		else
 			given_config_file = user_config;
diff --git a/config.c b/config.c
index 2b706ea..08e47e2 100644
--- a/config.c
+++ b/config.c
@@ -60,7 +60,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 		path = buf.buf;
 	}
 
-	if (!access(path, R_OK)) {
+	if (!access_or_warn(path, R_OK)) {
 		if (++inc->depth > MAX_INCLUDE_DEPTH)
 			die(include_depth_advice, MAX_INCLUDE_DEPTH, path,
 			    cf && cf->name ? cf->name : "the command line");
@@ -939,23 +939,23 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 
 	home_config_paths(&user_config, &xdg_config, "config");
 
-	if (git_config_system() && !access(git_etc_gitconfig(), R_OK)) {
+	if (git_config_system() && !access_or_warn(git_etc_gitconfig(), R_OK)) {
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
 					    data);
 		found += 1;
 	}
 
-	if (xdg_config && !access(xdg_config, R_OK)) {
+	if (xdg_config && !access_or_warn(xdg_config, R_OK)) {
 		ret += git_config_from_file(fn, xdg_config, data);
 		found += 1;
 	}
 
-	if (user_config && !access(user_config, R_OK)) {
+	if (user_config && !access_or_warn(user_config, R_OK)) {
 		ret += git_config_from_file(fn, user_config, data);
 		found += 1;
 	}
 
-	if (repo_config && !access(repo_config, R_OK)) {
+	if (repo_config && !access_or_warn(repo_config, R_OK)) {
 		ret += git_config_from_file(fn, repo_config, data);
 		found += 1;
 	}
diff --git a/git-compat-util.h b/git-compat-util.h
index 35b095e..5a520e2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -604,6 +604,9 @@ int rmdir_or_warn(const char *path);
  */
 int remove_or_warn(unsigned int mode, const char *path);
 
+/* Call access(2), but warn for any error besides ENOENT. */
+int access_or_warn(const char *path, int mode);
+
 /* Get the passwd entry for the UID of the current process. */
 struct passwd *xgetpwuid_self(void);
 
diff --git a/wrapper.c b/wrapper.c
index b5e33e4..b40c7e7 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -403,6 +403,14 @@ int remove_or_warn(unsigned int mode, const char *file)
 	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
 }
 
+int access_or_warn(const char *path, int mode)
+{
+	int ret = access(path, mode);
+	if (ret && errno != ENOENT)
+		warning(_("unable to access '%s': %s"), path, strerror(errno));
+	return ret;
+}
+
 struct passwd *xgetpwuid_self(void)
 {
 	struct passwd *pw;
-- 
1.7.12.4.g4e9f38f
