From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] ident: report passwd errors with a more friendly message
Date: Mon, 14 May 2012 12:36:22 -0400
Message-ID: <20120514163622.GB24457@sigill.intra.peff.net>
References: <20120511231303.GA24611@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 14 18:36:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STyG8-0003Y1-Og
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 18:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344Ab2ENQg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 12:36:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42852
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754971Ab2ENQg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 12:36:26 -0400
Received: (qmail 22577 invoked by uid 107); 14 May 2012 16:36:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 May 2012 12:36:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 May 2012 12:36:22 -0400
Content-Disposition: inline
In-Reply-To: <20120511231303.GA24611@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197783>

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
You earlier suggested to show a hint to set "user.name". That might be
complicated by the fact that this message can come from a remote server.
Or maybe since that is by far the minority case, we should disregard it
and show the hint. I left it out of this patch, as it can be trivially
added on top due to the refactoring.

I also noticed that the version of getpwuid in compat/mingw.c completely
disregards its uid argument. This isn't a problem in the current
codebase, since we always feed getuid(). But since the new wrapper is
explicitly about getting our _own_ pw entry, it might make more sense to
convert our getpwuid() replacement into an xgetpwuid_self() replacement,
which is slightly more accurate. I'll leave that cleanup to Johannes if
he cares to do it.

 Documentation/git-commit-tree.txt |  5 -----
 Documentation/git-var.txt         |  5 -----
 git-compat-util.h                 |  3 +++
 ident.c                           | 12 +++---------
 wrapper.c                         | 12 ++++++++++++
 5 files changed, 18 insertions(+), 19 deletions(-)

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
index c7bdb3f..72944ba 100644
--- a/ident.c
+++ b/ident.c
@@ -101,9 +101,7 @@ static void setup_ident(const char **name, const char **emailp)
 
 	/* Get the name ("gecos") */
 	if (!*name && !git_default_name.len) {
-		pw = getpwuid(getuid());
-		if (!pw)
-			die("You don't exist. Go away!");
+		pw = xgetpwuid_self();
 		copy_gecos(pw, &git_default_name);
 	}
 	if (!*name)
@@ -117,9 +115,7 @@ static void setup_ident(const char **name, const char **emailp)
 			user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		} else {
 			if (!pw)
-				pw = getpwuid(getuid());
-			if (!pw)
-				die("You don't exist. Go away!");
+				pw = xgetpwuid_self();
 			copy_email(pw, &git_default_email);
 		}
 	}
@@ -300,9 +296,7 @@ const char *fmt_ident(const char *name, const char *email,
 		}
 		if (error_on_no_name)
 			die("empty ident %s <%s> not allowed", name, email);
-		pw = getpwuid(getuid());
-		if (!pw)
-			die("You don't exist. Go away!");
+		pw = xgetpwuid_self();
 		strbuf_addstr(&git_default_name, pw->pw_name);
 		name = git_default_name.buf;
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
1.7.10.2.8.g1101eed
