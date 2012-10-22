From: Jeff King <peff@peff.net>
Subject: Re: The config include mechanism doesn't allow for overwriting
Date: Mon, 22 Oct 2012 17:15:06 -0400
Message-ID: <20121022211505.GA3301@sigill.intra.peff.net>
References: <CACBZZX4cu9XuS5AtduWrNeXNUeZ4rqDUzRdmyz2b3cXtmo1nqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 23:15:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQPLL-0001jj-88
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 23:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190Ab2JVVPN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2012 17:15:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48777 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755548Ab2JVVPM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 17:15:12 -0400
Received: (qmail 13040 invoked by uid 107); 22 Oct 2012 21:15:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 22 Oct 2012 17:15:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Oct 2012 17:15:06 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX4cu9XuS5AtduWrNeXNUeZ4rqDUzRdmyz2b3cXtmo1nqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208204>

On Mon, Oct 22, 2012 at 05:55:00PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> I was hoping to write something like this:
>=20
>     [user]
>         name =3D Luser
>         email =3D some-default@example.com
>     [include]
>         path =3D ~/.gitconfig.d/user-email
>=20
> Where that file would contain:
>=20
>     [user]
>         email =3D local-email@example.com

The intent is that it would work as you expect, and produce
local-email@example.com.

> But when you do that git prints:
>=20
>     $ git config --get user.email
>      some-default@example.com
>      error: More than one value for the key user.email: local-email@e=
xample.com

Ugh. The config code just feeds all the values sequentially to the
callback. The normal callbacks within git will overwrite old values,
whether from earlier in the file, from a file with lower priority (e.g.=
,
/etc/gitconfig versus ~/.gitconfig), or from an earlier included. Which
you can check with:

  $ git var GIT_AUTHOR_IDENT
  Luser <local-email@example.com> 1350936694 -0400

But git-config takes it upon itself to detect duplicates in its
callback. Which is just silly, since it is not something that regular
git would do. git-config should behave as much like the internal git
parser as possible.

> I think config inclusion is much less useful when you can't clobber
> previously assigned values.

Agreed. But I think the bug is in git-config, not in the include
mechanism. I think I'd like to do something like the patch below, which
just reuses the regular config code for git-config, collects the values=
,
and then reports them. It does mean we use a little more memory (for th=
e
sake of simplicity, we store values instead of streaming them out), but
the code is much shorter, less confusing, and automatically matches wha=
t
regular git_config() does.

It fails a few tests in t1300, but it looks like those tests are testin=
g
for the behavior we have identified as wrong, and should be fixed.

---
 builtin/config.c | 111 ++++++++++++-----------------------
 1 file changed, 38 insertions(+), 73 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index d6a066b..72cb0a8 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -16,7 +16,6 @@ static int do_not_match;
 static int use_key_regexp;
 static int do_all;
 static int do_not_match;
-static int seen;
 static char delim =3D '=3D';
 static char key_delim =3D ' ';
 static char term =3D '\n';
@@ -110,12 +109,19 @@ static int show_config(const char *key_, const ch=
ar *value_, void *cb)
 	return 0;
 }
=20
-static int show_config(const char *key_, const char *value_, void *cb)
+struct strbuf_list {
+	struct strbuf *items;
+	int nr;
+	int alloc;
+};
+
+static int collect_config(const char *key_, const char *value_, void *=
cb)
 {
+	struct strbuf_list *values =3D cb;
+	struct strbuf *buf;
 	char value[256];
 	const char *vptr =3D value;
 	int must_free_vptr =3D 0;
-	int dup_error =3D 0;
 	int must_print_delim =3D 0;
=20
 	if (!use_key_regexp && strcmp(key_, key))
@@ -126,12 +132,15 @@ static int show_config(const char *key_, const ch=
ar *value_, void *cb)
 	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)=
))
 		return 0;
=20
+	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
+	buf =3D &values->items[values->nr++];
+	strbuf_init(buf, 0);
+
 	if (show_keys) {
-		printf("%s", key_);
+		strbuf_addstr(buf, key_);
 		must_print_delim =3D 1;
 	}
-	if (seen && !do_all)
-		dup_error =3D 1;
+
 	if (types =3D=3D TYPE_INT)
 		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
 	else if (types =3D=3D TYPE_BOOL)
@@ -153,16 +162,12 @@ static int show_config(const char *key_, const ch=
ar *value_, void *cb)
 		vptr =3D "";
 		must_print_delim =3D 0;
 	}
-	seen++;
-	if (dup_error) {
-		error("More than one value for the key %s: %s",
-				key_, vptr);
-	}
-	else {
-		if (must_print_delim)
-			printf("%c", key_delim);
-		printf("%s%c", vptr, term);
-	}
+
+	if (must_print_delim)
+		strbuf_addch(buf, key_delim);
+	strbuf_addstr(buf, vptr);
+	strbuf_addch(buf, term);
+
 	if (must_free_vptr)
 		/* If vptr must be freed, it's a pointer to a
 		 * dynamically allocated buffer, it's safe to cast to
@@ -175,20 +180,8 @@ static int get_value(const char *key_, const char =
*regex_)
=20
 static int get_value(const char *key_, const char *regex_)
 {
-	int ret =3D CONFIG_GENERIC_ERROR;
-	char *global =3D NULL, *xdg =3D NULL, *repo_config =3D NULL;
-	const char *system_wide =3D NULL, *local;
-	struct config_include_data inc =3D CONFIG_INCLUDE_INIT;
-	config_fn_t fn;
-	void *data;
-
-	local =3D given_config_file;
-	if (!local) {
-		local =3D repo_config =3D git_pathdup("config");
-		if (git_config_system())
-			system_wide =3D git_etc_gitconfig();
-		home_config_paths(&global, &xdg, "config");
-	}
+	struct strbuf_list values =3D {0};
+	int i;
=20
 	if (use_key_regexp) {
 		char *tl;
@@ -211,14 +204,11 @@ static int get_value(const char *key_, const char=
 *regex_)
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
 			fprintf(stderr, "Invalid key pattern: %s\n", key_);
 			free(key);
-			ret =3D CONFIG_INVALID_PATTERN;
-			goto free_strings;
+			return CONFIG_INVALID_PATTERN;
 		}
 	} else {
-		if (git_config_parse_key(key_, &key, NULL)) {
-			ret =3D CONFIG_INVALID_KEY;
-			goto free_strings;
-		}
+		if (git_config_parse_key(key_, &key, NULL))
+			return CONFIG_INVALID_KEY;
 	}
=20
 	if (regex_) {
@@ -230,37 +220,12 @@ static int get_value(const char *key_, const char=
 *regex_)
 		regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(regexp, regex_, REG_EXTENDED)) {
 			fprintf(stderr, "Invalid pattern: %s\n", regex_);
-			ret =3D CONFIG_INVALID_PATTERN;
-			goto free_strings;
+			return CONFIG_INVALID_PATTERN;
 		}
 	}
=20
-	fn =3D show_config;
-	data =3D NULL;
-	if (respect_includes) {
-		inc.fn =3D fn;
-		inc.data =3D data;
-		fn =3D git_config_include;
-		data =3D &inc;
-	}
-
-	if (do_all && system_wide)
-		git_config_from_file(fn, system_wide, data);
-	if (do_all && xdg)
-		git_config_from_file(fn, xdg, data);
-	if (do_all && global)
-		git_config_from_file(fn, global, data);
-	if (do_all)
-		git_config_from_file(fn, local, data);
-	git_config_from_parameters(fn, data);
-	if (!do_all && !seen)
-		git_config_from_file(fn, local, data);
-	if (!do_all && !seen && global)
-		git_config_from_file(fn, global, data);
-	if (!do_all && !seen && xdg)
-		git_config_from_file(fn, xdg, data);
-	if (!do_all && !seen && system_wide)
-		git_config_from_file(fn, system_wide, data);
+	git_config_with_options(collect_config, &values,
+				given_config_file, respect_includes);
=20
 	free(key);
 	if (regexp) {
@@ -268,16 +233,16 @@ static int get_value(const char *key_, const char=
 *regex_)
 		free(regexp);
 	}
=20
-	if (do_all)
-		ret =3D !seen;
-	else
-		ret =3D (seen =3D=3D 1) ? 0 : seen > 1 ? 2 : 1;
+	if (!values.nr)
+		return 1;
=20
-free_strings:
-	free(repo_config);
-	free(global);
-	free(xdg);
-	return ret;
+	for (i =3D 0; i < values.nr; i++) {
+		struct strbuf *buf =3D values.items + i;
+		if (do_all || i =3D=3D values.nr - 1)
+			fwrite(buf->buf, 1, buf->len, stdout);
+		strbuf_release(buf);
+	}
+	return 0;
 }
=20
 static char *normalize_value(const char *key, const char *value)
