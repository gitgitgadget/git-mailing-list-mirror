From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] drop length limitations on gecos-derived names and emails
Date: Mon, 14 May 2012 12:28:24 -0400
Message-ID: <20120514162824.GA24457@sigill.intra.peff.net>
References: <20120511231303.GA24611@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 14 18:28:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STy8O-0005ix-9n
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 18:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757139Ab2ENQ21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 12:28:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42839
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756974Ab2ENQ20 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 12:28:26 -0400
Received: (qmail 22446 invoked by uid 107); 14 May 2012 16:28:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 May 2012 12:28:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 May 2012 12:28:24 -0400
Content-Disposition: inline
In-Reply-To: <20120511231303.GA24611@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197780>

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

Note that there is still one length limitation: the
gethostname interface requires us to provide a static
buffer, so we arbitrarily choose 1024 bytes for the
hostname.

Signed-off-by: Jeff King <peff@peff.net>
---
I noticed in add_domainname that we look up the host via gethostname,
and then if it is not fully qualified, call gethostbyname and steal the
domain portion of the result, tacking it onto the hostname we got.

That seems oddly complex to me, and like it could result in a bogus
hostname if the unqualified name does not match the first part of the
returned qualified name. E.g., if the /etc/hosts file contains something
like:

  192.168.1.1 foo.example.com bar.example.com bar

(and your hostname is "bar"). I doubt it matters much in practice, and
it is outside the scope of this patch, so I left it for now.

 Documentation/git-commit-tree.txt |  4 --
 Documentation/git-var.txt         |  4 --
 builtin/fmt-merge-msg.c           | 14 +++---
 cache.h                           |  5 +--
 config.c                          |  4 +-
 environment.c                     |  4 +-
 http-push.c                       |  2 +-
 ident.c                           | 94 +++++++++++++++------------------------
 8 files changed, 50 insertions(+), 81 deletions(-)

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
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index a517f17..bb716c8 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -230,7 +230,8 @@ static void add_branch_desc(struct strbuf *out, const char *name)
 static void record_person(int which, struct string_list *people,
 			  struct commit *commit)
 {
-	char name_buf[MAX_GITNAME], *name, *name_end;
+	struct strbuf name_buf = STRBUF_INIT;
+	char *name, *name_end;
 	struct string_list_item *elem;
 	const char *field = (which == 'a') ? "\nauthor " : "\ncommitter ";
 
@@ -243,17 +244,18 @@ static void record_person(int which, struct string_list *people,
 		name_end--;
 	while (isspace(*name_end) && name <= name_end)
 		name_end--;
-	if (name_end < name || name + MAX_GITNAME <= name_end)
+	if (name_end < name)
 		return;
-	memcpy(name_buf, name, name_end - name + 1);
-	name_buf[name_end - name + 1] = '\0';
+	strbuf_add(&name_buf, name, name_end - name + 1);
 
-	elem = string_list_lookup(people, name_buf);
+	elem = string_list_lookup(people, name_buf.buf);
 	if (!elem) {
-		elem = string_list_insert(people, name_buf);
+		elem = string_list_insert(people, name_buf.buf);
 		elem->util = (void *)0;
 	}
 	elem->util = (void*)(util_as_integral(elem) + 1);
+
+	strbuf_release(&name_buf);
 }
 
 static int cmp_string_list_util_as_integral(const void *a_, const void *b_)
diff --git a/cache.h b/cache.h
index e14ffcd..0c1a332 100644
--- a/cache.h
+++ b/cache.h
@@ -1138,9 +1138,8 @@ struct config_include_data {
 #define CONFIG_INCLUDE_INIT { 0 }
 extern int git_config_include(const char *name, const char *value, void *data);
 
-#define MAX_GITNAME (1000)
-extern char git_default_email[MAX_GITNAME];
-extern char git_default_name[MAX_GITNAME];
+extern struct strbuf git_default_email;
+extern struct strbuf git_default_name;
 #define IDENT_NAME_GIVEN 01
 #define IDENT_MAIL_GIVEN 02
 #define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
diff --git a/config.c b/config.c
index eeee986..69cb08c 100644
--- a/config.c
+++ b/config.c
@@ -767,7 +767,7 @@ static int git_default_user_config(const char *var, const char *value)
 	if (!strcmp(var, "user.name")) {
 		if (!value)
 			return config_error_nonbool(var);
-		strlcpy(git_default_name, value, sizeof(git_default_name));
+		strbuf_addstr(&git_default_name, value);
 		user_ident_explicitly_given |= IDENT_NAME_GIVEN;
 		return 0;
 	}
@@ -775,7 +775,7 @@ static int git_default_user_config(const char *var, const char *value)
 	if (!strcmp(var, "user.email")) {
 		if (!value)
 			return config_error_nonbool(var);
-		strlcpy(git_default_email, value, sizeof(git_default_email));
+		strbuf_addstr(&git_default_email, value);
 		user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		return 0;
 	}
diff --git a/environment.c b/environment.c
index d7e6c65..f4e3b53 100644
--- a/environment.c
+++ b/environment.c
@@ -11,8 +11,8 @@
 #include "refs.h"
 #include "fmt-merge-msg.h"
 
-char git_default_email[MAX_GITNAME];
-char git_default_name[MAX_GITNAME];
+struct strbuf git_default_email = STRBUF_INIT;
+struct strbuf git_default_name = STRBUF_INIT;
 int user_ident_explicitly_given;
 int trust_executable_bit = 1;
 int trust_ctime = 1;
diff --git a/http-push.c b/http-push.c
index 1df7ab5..2362ffd 100644
--- a/http-push.c
+++ b/http-push.c
@@ -904,7 +904,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 		ep = strchr(ep + 1, '/');
 	}
 
-	escaped = xml_entities(git_default_email);
+	escaped = xml_entities(git_default_email.buf);
 	strbuf_addf(&out_buffer.buf, LOCK_REQUEST, escaped);
 	free(escaped);
 
diff --git a/ident.c b/ident.c
index 87c697c..c7bdb3f 100644
--- a/ident.c
+++ b/ident.c
@@ -15,42 +15,27 @@ static char git_default_date[50];
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
 
@@ -61,7 +46,7 @@ static int add_mailname_host(char *buf, size_t len)
 				strerror(errno));
 		return -1;
 	}
-	if (!fgets(buf, len, mailname)) {
+	if (strbuf_getline(buf, mailname, '\n') == EOF) {
 		if (ferror(mailname))
 			warning("cannot read /etc/mailname: %s",
 				strerror(errno));
@@ -73,48 +58,41 @@ static int add_mailname_host(char *buf, size_t len)
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
 
 static void setup_ident(const char **name, const char **emailp)
@@ -122,32 +100,31 @@ static void setup_ident(const char **name, const char **emailp)
 	struct passwd *pw = NULL;
 
 	/* Get the name ("gecos") */
-	if (!*name && !git_default_name[0]) {
+	if (!*name && !git_default_name.len) {
 		pw = getpwuid(getuid());
 		if (!pw)
 			die("You don't exist. Go away!");
-		copy_gecos(pw, git_default_name, sizeof(git_default_name));
+		copy_gecos(pw, &git_default_name);
 	}
 	if (!*name)
-		*name = git_default_name;
+		*name = git_default_name.buf;
 
-	if (!*emailp && !git_default_email[0]) {
+	if (!*emailp && !git_default_email.len) {
 		const char *email = getenv("EMAIL");
 
 		if (email && email[0]) {
-			strlcpy(git_default_email, email,
-				sizeof(git_default_email));
+			strbuf_addstr(&git_default_email, email);
 			user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		} else {
 			if (!pw)
 				pw = getpwuid(getuid());
 			if (!pw)
 				die("You don't exist. Go away!");
-			copy_email(pw);
+			copy_email(pw, &git_default_email);
 		}
 	}
 	if (!*emailp)
-		*emailp = git_default_email;
+		*emailp = git_default_email.buf;
 
 	/* And set the default date */
 	if (!git_default_date[0])
@@ -317,7 +294,7 @@ const char *fmt_ident(const char *name, const char *email,
 		struct passwd *pw;
 
 		if ((warn_on_no_name || error_on_no_name) &&
-		    name == git_default_name && env_hint) {
+		    name == git_default_name.buf && env_hint) {
 			fputs(env_hint, stderr);
 			env_hint = NULL; /* warn only once */
 		}
@@ -326,9 +303,8 @@ const char *fmt_ident(const char *name, const char *email,
 		pw = getpwuid(getuid());
 		if (!pw)
 			die("You don't exist. Go away!");
-		strlcpy(git_default_name, pw->pw_name,
-			sizeof(git_default_name));
-		name = git_default_name;
+		strbuf_addstr(&git_default_name, pw->pw_name);
+		name = git_default_name.buf;
 	}
 
 	strcpy(date, git_default_date);
-- 
1.7.10.2.8.g1101eed
