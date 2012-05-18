From: Jeff King <peff@peff.net>
Subject: [PATCH 09/13] drop length limitations on gecos-derived names and
 emails
Date: Fri, 18 May 2012 19:20:39 -0400
Message-ID: <20120518232039.GI30031@sigill.intra.peff.net>
References: <20120518230528.GA30510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 01:20:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVWTa-0008PD-4S
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 01:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967256Ab2ERXUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 19:20:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48790
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967068Ab2ERXUn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 19:20:43 -0400
Received: (qmail 7858 invoked by uid 107); 18 May 2012 23:21:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 19:21:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 19:20:39 -0400
Content-Disposition: inline
In-Reply-To: <20120518230528.GA30510@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197989>

When we pull the user's name from the GECOS field of the
passwd file (or generate an email address based on their
username and hostname), we put the result into a
static buffer. While it's extremely unlikely that anybody
ever hit these limits (after all, in such a case their
parents must have hated them), we still had to deal with the
error cases in our code.

Converting these static buffers to strbufs lets us simplify
the code and drop some error messages from the documentation
that have confused some users.

The conversion is mostly mechanical: replace string copies
with strbuf equivalents, and access the strbuf.buf directly.
There are a few exceptions:

  - copy_gecos and copy_email are the big winners in code
    reduction (since they no longer have to manage the
    string length manually)

  - git_ident_config wants to replace old versions of
    the default name (e.g., if we read the config multiple
    times), so it must reset+add to the strbuf instead of
    just adding

Note that there is still one length limitation: the
gethostname interface requires us to provide a static
buffer, so we arbitrarily choose 1024 bytes for the
hostname.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-commit-tree.txt |   4 --
 Documentation/git-var.txt         |   4 --
 ident.c                           | 100 +++++++++++++++-----------------------
 3 files changed, 39 insertions(+), 69 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index cfb9906..eb12b2d 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -92,10 +92,6 @@ Diagnostics
 -----------
 You don't exist. Go away!::
     The passwd(5) gecos field couldn't be read
-Your parents must have hated you!::
-    The passwd(5) gecos field is longer than a giant static buffer.
-Your sysadmin must hate you!::
-    The passwd(5) name field is longer than a giant static buffer.
 
 Discussion
 ----------
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 988a323..3f703e3 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -63,10 +63,6 @@ Diagnostics
 -----------
 You don't exist. Go away!::
     The passwd(5) gecos field couldn't be read
-Your parents must have hated you!::
-    The passwd(5) gecos field is longer than a giant static buffer.
-Your sysadmin must hate you!::
-    The passwd(5) name field is longer than a giant static buffer.
 
 SEE ALSO
 --------
diff --git a/ident.c b/ident.c
index f44bcb3..73a06a1 100644
--- a/ident.c
+++ b/ident.c
@@ -7,9 +7,8 @@
  */
 #include "cache.h"
 
-#define MAX_GITNAME (1000)
-static char git_default_name[MAX_GITNAME];
-static char git_default_email[MAX_GITNAME];
+static struct strbuf git_default_name = STRBUF_INIT;
+static struct strbuf git_default_email = STRBUF_INIT;
 static char git_default_date[50];
 int user_ident_explicitly_given;
 
@@ -19,42 +18,27 @@ int user_ident_explicitly_given;
 #define get_gecos(struct_passwd) ((struct_passwd)->pw_gecos)
 #endif
 
-static void copy_gecos(const struct passwd *w, char *name, size_t sz)
+static void copy_gecos(const struct passwd *w, struct strbuf *name)
 {
-	char *src, *dst;
-	size_t len, nlen;
-
-	nlen = strlen(w->pw_name);
+	char *src;
 
 	/* Traditionally GECOS field had office phone numbers etc, separated
 	 * with commas.  Also & stands for capitalized form of the login name.
 	 */
 
-	for (len = 0, dst = name, src = get_gecos(w); len < sz; src++) {
+	for (src = get_gecos(w); *src && *src != ','; src++) {
 		int ch = *src;
-		if (ch != '&') {
-			*dst++ = ch;
-			if (ch == 0 || ch == ',')
-				break;
-			len++;
-			continue;
-		}
-		if (len + nlen < sz) {
+		if (ch != '&')
+			strbuf_addch(name, ch);
+		else {
 			/* Sorry, Mr. McDonald... */
-			*dst++ = toupper(*w->pw_name);
-			memcpy(dst, w->pw_name + 1, nlen - 1);
-			dst += nlen - 1;
-			len += nlen;
+			strbuf_addch(name, toupper(*w->pw_name));
+			strbuf_addstr(name, w->pw_name + 1);
 		}
 	}
-	if (len < sz)
-		name[len] = 0;
-	else
-		die("Your parents must have hated you!");
-
 }
 
-static int add_mailname_host(char *buf, size_t len)
+static int add_mailname_host(struct strbuf *buf)
 {
 	FILE *mailname;
 
@@ -65,7 +49,7 @@ static int add_mailname_host(char *buf, size_t len)
 				strerror(errno));
 		return -1;
 	}
-	if (!fgets(buf, len, mailname)) {
+	if (strbuf_getline(buf, mailname, '\n') == EOF) {
 		if (ferror(mailname))
 			warning("cannot read /etc/mailname: %s",
 				strerror(errno));
@@ -77,78 +61,70 @@ static int add_mailname_host(char *buf, size_t len)
 	return 0;
 }
 
-static void add_domainname(char *buf, size_t len)
+static void add_domainname(struct strbuf *out)
 {
+	char buf[1024];
 	struct hostent *he;
-	size_t namelen;
 	const char *domainname;
 
-	if (gethostname(buf, len)) {
+	if (gethostname(buf, sizeof(buf))) {
 		warning("cannot get host name: %s", strerror(errno));
-		strlcpy(buf, "(none)", len);
+		strbuf_addstr(out, "(none)");
 		return;
 	}
-	namelen = strlen(buf);
-	if (memchr(buf, '.', namelen))
+	strbuf_addstr(out, buf);
+	if (strchr(buf, '.'))
 		return;
 
 	he = gethostbyname(buf);
-	buf[namelen++] = '.';
-	buf += namelen;
-	len -= namelen;
+	strbuf_addch(out, '.');
 	if (he && (domainname = strchr(he->h_name, '.')))
-		strlcpy(buf, domainname + 1, len);
+		strbuf_addstr(out, domainname + 1);
 	else
-		strlcpy(buf, "(none)", len);
+		strbuf_addstr(out, "(none)");
 }
 
-static void copy_email(const struct passwd *pw)
+static void copy_email(const struct passwd *pw, struct strbuf *email)
 {
 	/*
 	 * Make up a fake email address
 	 * (name + '@' + hostname [+ '.' + domainname])
 	 */
-	size_t len = strlen(pw->pw_name);
-	if (len > sizeof(git_default_email)/2)
-		die("Your sysadmin must hate you!");
-	memcpy(git_default_email, pw->pw_name, len);
-	git_default_email[len++] = '@';
-
-	if (!add_mailname_host(git_default_email + len,
-				sizeof(git_default_email) - len))
+	strbuf_addstr(email, pw->pw_name);
+	strbuf_addch(email, '@');
+
+	if (!add_mailname_host(email))
 		return;	/* read from "/etc/mailname" (Debian) */
-	add_domainname(git_default_email + len,
-			sizeof(git_default_email) - len);
+	add_domainname(email);
 }
 
 const char *ident_default_name(void)
 {
-	if (!git_default_name[0]) {
+	if (!git_default_name.len) {
 		struct passwd *pw = getpwuid(getuid());
 		if (!pw)
 			die("You don't exist. Go away!");
-		copy_gecos(pw, git_default_name, sizeof(git_default_name));
+		copy_gecos(pw, &git_default_name);
 	}
-	return git_default_name;
+	return git_default_name.buf;
 }
 
 const char *ident_default_email(void)
 {
-	if (!git_default_email[0]) {
+	if (!git_default_email.len) {
 		const char *email = getenv("EMAIL");
 
 		if (email && email[0]) {
-			strlcpy(git_default_email, email,
-				sizeof(git_default_email));
+			strbuf_addstr(&git_default_email, email);
 			user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		} else {
 			struct passwd *pw = getpwuid(getuid());
 			if (!pw)
 				die("You don't exist. Go away!");
-			copy_email(pw);
+			copy_email(pw, &git_default_email);
 		}
 	}
-	return git_default_email;
+	return git_default_email.buf;
 }
 
 const char *ident_default_date(void)
@@ -323,7 +299,7 @@ const char *fmt_ident(const char *name, const char *email,
 		struct passwd *pw;
 
 		if (error_on_no_name) {
-			if (name == git_default_name)
+			if (name == git_default_name.buf)
 				fputs(env_hint, stderr);
 			die("empty ident %s <%s> not allowed", name, email);
 		}
@@ -393,7 +369,8 @@ int git_ident_config(const char *var, const char *value, void *data)
 	if (!strcmp(var, "user.name")) {
 		if (!value)
 			return config_error_nonbool(var);
-		strlcpy(git_default_name, value, sizeof(git_default_name));
+		strbuf_reset(&git_default_name);
+		strbuf_addstr(&git_default_name, value);
 		user_ident_explicitly_given |= IDENT_NAME_GIVEN;
 		return 0;
 	}
@@ -401,7 +378,8 @@ int git_ident_config(const char *var, const char *value, void *data)
 	if (!strcmp(var, "user.email")) {
 		if (!value)
 			return config_error_nonbool(var);
-		strlcpy(git_default_email, value, sizeof(git_default_email));
+		strbuf_reset(&git_default_email);
+		strbuf_addstr(&git_default_email, value);
 		user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		return 0;
 	}
-- 
1.7.10.1.16.g53a707b
