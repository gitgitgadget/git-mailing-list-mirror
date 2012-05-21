From: Jeff King <peff@peff.net>
Subject: [PATCHv2 11/15] ident: report passwd errors with a more friendly
 message
Date: Mon, 21 May 2012 19:10:20 -0400
Message-ID: <20120521231020.GK10981@sigill.intra.peff.net>
References: <20120521230917.GA474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 01:11:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWbko-0000r2-Gb
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 01:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757394Ab2EUXKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 19:10:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51233
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757066Ab2EUXKX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 19:10:23 -0400
Received: (qmail 7911 invoked by uid 107); 21 May 2012 23:10:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 19:10:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 19:10:20 -0400
Content-Disposition: inline
In-Reply-To: <20120521230917.GA474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198159>

When getpwuid fails, we give a cute but cryptic message.
While it makes sense if you know that getpwuid or identity
functions are being called, this code is triggered behind
the scenes by quite a few git commands these days (e.g.,
receive-pack on a remote server might use it for a reflog;
the current message is hard to distinguish from an
authentication error).  Let's switch to something that gives
a little more context.

While we're at it, we can factor out all of the
cut-and-pastes of the "you don't exist" message into a
wrapper function. Rather than provide xgetpwuid, let's make
it even more specific to just getting the passwd entry for
the current uid. That's the only way we use getpwuid anyway,
and it lets us make an even more specific error message.

The current message also fails to mention errno. While the
usual cause for getpwuid failing is that the user does not
exist, mentioning errno makes it easier to diagnose these
problems.  Note that POSIX specifies that errno remain
untouched if the passwd entry does not exist (but will be
set on actual errors), whereas some systems will return
ENOENT or similar for a missing entry. We handle both cases
in our wrapper.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-commit-tree.txt |  5 -----
 Documentation/git-var.txt         |  5 -----
 git-compat-util.h                 |  3 +++
 ident.c                           | 20 +++++---------------
 wrapper.c                         | 12 ++++++++++++
 5 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index eb12b2d..eb8ee99 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -88,11 +88,6 @@ for one to be entered and terminated with ^D.
 
 include::date-formats.txt[]
 
-Diagnostics
------------
-You don't exist. Go away!::
-    The passwd(5) gecos field couldn't be read
-
 Discussion
 ----------
 
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 3f703e3..67edf58 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -59,11 +59,6 @@ ifdef::git-default-pager[]
     The build you are using chose '{git-default-pager}' as the default.
 endif::git-default-pager[]
 
-Diagnostics
------------
-You don't exist. Go away!::
-    The passwd(5) gecos field couldn't be read
-
 SEE ALSO
 --------
 linkgit:git-commit-tree[1]
diff --git a/git-compat-util.h b/git-compat-util.h
index ed11ad8..5bd9ad7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -595,4 +595,7 @@ int rmdir_or_warn(const char *path);
  */
 int remove_or_warn(unsigned int mode, const char *path);
 
+/* Get the passwd entry for the UID of the current process. */
+struct passwd *xgetpwuid_self(void);
+
 #endif
diff --git a/ident.c b/ident.c
index 73a06a1..5aec073 100644
--- a/ident.c
+++ b/ident.c
@@ -100,12 +100,8 @@ static void copy_email(const struct passwd *pw, struct strbuf *email)
 
 const char *ident_default_name(void)
 {
-	if (!git_default_name.len) {
-		struct passwd *pw = getpwuid(getuid());
-		if (!pw)
-			die("You don't exist. Go away!");
-		copy_gecos(pw, &git_default_name);
-	}
+	if (!git_default_name.len)
+		copy_gecos(xgetpwuid_self(), &git_default_name);
 	return git_default_name.buf;
 }
 
@@ -117,12 +113,8 @@ const char *ident_default_email(void)
 		if (email && email[0]) {
 			strbuf_addstr(&git_default_email, email);
 			user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-		} else {
-			struct passwd *pw = getpwuid(getuid());
-			if (!pw)
-				die("You don't exist. Go away!");
-			copy_email(pw, &git_default_email);
-		}
+		} else
+			copy_email(xgetpwuid_self(), &git_default_email);
 	}
 	return git_default_email.buf;
 }
@@ -303,9 +295,7 @@ const char *fmt_ident(const char *name, const char *email,
 				fputs(env_hint, stderr);
 			die("empty ident %s <%s> not allowed", name, email);
 		}
-		pw = getpwuid(getuid());
-		if (!pw)
-			die("You don't exist. Go away!");
+		pw = xgetpwuid_self();
 		name = pw->pw_name;
 	}
 
diff --git a/wrapper.c b/wrapper.c
index 6ccd059..b5e33e4 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -402,3 +402,15 @@ int remove_or_warn(unsigned int mode, const char *file)
 {
 	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
 }
+
+struct passwd *xgetpwuid_self(void)
+{
+	struct passwd *pw;
+
+	errno = 0;
+	pw = getpwuid(getuid());
+	if (!pw)
+		die(_("unable to look up current user in the passwd file: %s"),
+		    errno ? strerror(errno) : _("no such user"));
+	return pw;
+}
-- 
1.7.10.1.19.g711d603
