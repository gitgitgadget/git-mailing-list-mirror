From: Pierre Habouzit <madcoder@debian.org>
Subject: [SUPERSEDES PATCH 4/7] sq_quote_argv and add_to_string rework with strbuf's.
Date: Thu, 20 Sep 2007 10:44:41 +0200
Message-ID: <20070920084441.GC2053@artemis.corp>
References: <1190241736-30449-1-git-send-email-madcoder@debian.org> <1190241736-30449-2-git-send-email-madcoder@debian.org> <1190241736-30449-3-git-send-email-madcoder@debian.org> <7vwsumkll8.fsf@gitster.siamese.dyndns.org> <20070920082701.GA2053@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="EuxKj2iCbKjpUGkD";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 10:44:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYHeT-0005oJ-EV
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 10:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbXITIoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 04:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbXITIon
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 04:44:43 -0400
Received: from pan.madism.org ([88.191.52.104]:38092 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbXITIom (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 04:44:42 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 7997E1EF4F;
	Thu, 20 Sep 2007 10:44:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 221704B03; Thu, 20 Sep 2007 10:44:41 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070920082701.GA2053@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58764>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* sq_quote_buf is made public, and works on a strbuf.
* sq_quote_argv also works on a strbuf.
* make sq_quote_argv take a "maxlen" argument to check the buffer won't grow
  too big.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 connect.c |   21 ++++++--------
 git.c     |   16 +++-------
 quote.c   |   94 +++++++++++++++------------------------------------------=
---
 quote.h   |    9 ++----
 trace.c   |   25 +++++++---------
 5 files changed, 52 insertions(+), 113 deletions(-)

diff --git a/connect.c b/connect.c
index 1653a0e..06d279e 100644
--- a/connect.c
+++ b/connect.c
@@ -577,16 +577,13 @@ pid_t git_connect(int fd[2], char *url, const char *p=
rog, int flags)
 	if (pid < 0)
 		die("unable to fork");
 	if (!pid) {
-		char command[MAX_CMD_LEN];
-		char *posn =3D command;
-		int size =3D MAX_CMD_LEN;
-		int of =3D 0;
+		struct strbuf cmd;
=20
-		of |=3D add_to_string(&posn, &size, prog, 0);
-		of |=3D add_to_string(&posn, &size, " ", 0);
-		of |=3D add_to_string(&posn, &size, path, 1);
-
-		if (of)
+		strbuf_init(&cmd, MAX_CMD_LEN);
+		strbuf_addstr(&cmd, prog);
+		strbuf_addch(&cmd, ' ');
+		sq_quote_buf(&cmd, path);
+		if (cmd.len >=3D MAX_CMD_LEN)
 			die("command line too long");
=20
 		dup2(pipefd[1][0], 0);
@@ -606,10 +603,10 @@ pid_t git_connect(int fd[2], char *url, const char *p=
rog, int flags)
 				ssh_basename++;
=20
 			if (!port)
-				execlp(ssh, ssh_basename, host, command, NULL);
+				execlp(ssh, ssh_basename, host, cmd.buf, NULL);
 			else
 				execlp(ssh, ssh_basename, "-p", port, host,
-				       command, NULL);
+				       cmd.buf, NULL);
 		}
 		else {
 			unsetenv(ALTERNATE_DB_ENVIRONMENT);
@@ -618,7 +615,7 @@ pid_t git_connect(int fd[2], char *url, const char *pro=
g, int flags)
 			unsetenv(GIT_WORK_TREE_ENVIRONMENT);
 			unsetenv(GRAFT_ENVIRONMENT);
 			unsetenv(INDEX_ENVIRONMENT);
-			execlp("sh", "sh", "-c", command, NULL);
+			execlp("sh", "sh", "-c", cmd.buf, NULL);
 		}
 		die("exec failed");
 	}
diff --git a/git.c b/git.c
index 6773c12..d7c6bca 100644
--- a/git.c
+++ b/git.c
@@ -187,19 +187,13 @@ static int handle_alias(int *argcp, const char ***arg=
v)
 	if (alias_string) {
 		if (alias_string[0] =3D=3D '!') {
 			if (*argcp > 1) {
-				int i, sz =3D PATH_MAX;
-				char *s =3D xmalloc(sz), *new_alias =3D s;
+				struct strbuf buf;
=20
-				add_to_string(&s, &sz, alias_string, 0);
+				strbuf_init(&buf, PATH_MAX);
+				strbuf_addstr(&buf, alias_string);
+				sq_quote_argv(&buf, (*argv) + 1, *argcp - 1, PATH_MAX);
 				free(alias_string);
-				alias_string =3D new_alias;
-				for (i =3D 1; i < *argcp &&
-					!add_to_string(&s, &sz, " ", 0) &&
-					!add_to_string(&s, &sz, (*argv)[i], 1)
-					; i++)
-					; /* do nothing */
-				if (!sz)
-					die("Too many or long arguments");
+				alias_string =3D buf.buf;
 			}
 			trace_printf("trace: alias to shell cmd: %s =3D> %s\n",
 				     alias_command, alias_string + 1);
diff --git a/quote.c b/quote.c
index d88bf75..edd1a09 100644
--- a/quote.c
+++ b/quote.c
@@ -12,37 +12,31 @@
  *  a'b      =3D=3D> a'\''b    =3D=3D> 'a'\''b'
  *  a!b      =3D=3D> a'\!'b    =3D=3D> 'a'\!'b'
  */
-#undef EMIT
-#define EMIT(x) do { if (++len < n) *bp++ =3D (x); } while(0)
-
 static inline int need_bs_quote(char c)
 {
 	return (c =3D=3D '\'' || c =3D=3D '!');
 }
=20
-static size_t sq_quote_buf(char *dst, size_t n, const char *src)
+void sq_quote_buf(struct strbuf *dst, const char *src)
 {
-	char c;
-	char *bp =3D dst;
-	size_t len =3D 0;
-
-	EMIT('\'');
-	while ((c =3D *src++)) {
-		if (need_bs_quote(c)) {
-			EMIT('\'');
-			EMIT('\\');
-			EMIT(c);
-			EMIT('\'');
-		} else {
-			EMIT(c);
+	char *to_free =3D NULL;
+
+	if (dst->buf =3D=3D src)
+		to_free =3D strbuf_detach(dst);
+
+	strbuf_addch(dst, '\'');
+	while (*src) {
+		size_t len =3D strcspn(src, "'\\");
+		strbuf_add(dst, src, len);
+		src +=3D len;
+		while (need_bs_quote(*src)) {
+			strbuf_addstr(dst, "'\\");
+			strbuf_addch(dst, *src++);
+			strbuf_addch(dst, '\'');
 		}
 	}
-	EMIT('\'');
-
-	if ( n )
-		*bp =3D 0;
-
-	return len;
+	strbuf_addch(dst, '\'');
+	free(to_free);
 }
=20
 void sq_quote_print(FILE *stream, const char *src)
@@ -62,11 +56,10 @@ void sq_quote_print(FILE *stream, const char *src)
 	fputc('\'', stream);
 }
=20
-char *sq_quote_argv(const char** argv, int count)
+void sq_quote_argv(struct strbuf *dst, const char** argv, int count,
+                   size_t maxlen)
 {
-	char *buf, *to;
 	int i;
-	size_t len =3D 0;
=20
 	/* Count argv if needed. */
 	if (count < 0) {
@@ -74,53 +67,14 @@ char *sq_quote_argv(const char** argv, int count)
 			; /* just counting */
 	}
=20
-	/* Special case: no argv. */
-	if (!count)
-		return xcalloc(1,1);
-
-	/* Get destination buffer length. */
-	for (i =3D 0; i < count; i++)
-		len +=3D sq_quote_buf(NULL, 0, argv[i]) + 1;
-
-	/* Alloc destination buffer. */
-	to =3D buf =3D xmalloc(len + 1);
-
 	/* Copy into destination buffer. */
+	strbuf_grow(dst, 32 * count);
 	for (i =3D 0; i < count; ++i) {
-		*to++ =3D ' ';
-		to +=3D sq_quote_buf(to, len, argv[i]);
+		strbuf_addch(dst, ' ');
+		sq_quote_buf(dst, argv[i]);
+		if (maxlen && dst->len > maxlen)
+			die("Too many or long arguments");
 	}
-
-	return buf;
-}
-
-/*
- * Append a string to a string buffer, with or without shell quoting.
- * Return true if the buffer overflowed.
- */
-int add_to_string(char **ptrp, int *sizep, const char *str, int quote)
-{
-	char *p =3D *ptrp;
-	int size =3D *sizep;
-	int oc;
-	int err =3D 0;
-
-	if (quote)
-		oc =3D sq_quote_buf(p, size, str);
-	else {
-		oc =3D strlen(str);
-		memcpy(p, str, (size <=3D oc) ? size - 1 : oc);
-	}
-
-	if (size <=3D oc) {
-		err =3D 1;
-		oc =3D size - 1;
-	}
-
-	*ptrp +=3D oc;
-	**ptrp =3D '\0';
-	*sizep -=3D oc;
-	return err;
 }
=20
 char *sq_dequote(char *arg)
diff --git a/quote.h b/quote.h
index 8a59cc5..78e8d3e 100644
--- a/quote.h
+++ b/quote.h
@@ -29,13 +29,10 @@
  */
=20
 extern void sq_quote_print(FILE *stream, const char *src);
-extern char *sq_quote_argv(const char** argv, int count);
=20
-/*
- * Append a string to a string buffer, with or without shell quoting.
- * Return true if the buffer overflowed.
- */
-extern int add_to_string(char **ptrp, int *sizep, const char *str, int quo=
te);
+extern void sq_quote_buf(struct strbuf *, const char *src);
+extern void sq_quote_argv(struct strbuf *, const char **argv, int count,
+                          size_t maxlen);
=20
 /* This unwraps what sq_quote() produces in place, but returns
  * NULL if the input does not look like what sq_quote would have
diff --git a/trace.c b/trace.c
index 91548a5..efc656b 100644
--- a/trace.c
+++ b/trace.c
@@ -85,32 +85,29 @@ void trace_printf(const char *fmt, ...)
=20
 void trace_argv_printf(const char **argv, int count, const char *fmt, ...)
 {
-	char buf[8192];
 	va_list ap;
-	char *argv_str;
-	size_t argv_len;
+	struct strbuf trace;
 	int fd, len, need_close =3D 0;
=20
 	fd =3D get_trace_fd(&need_close);
 	if (!fd)
 		return;
=20
+	strbuf_init(&trace, 0);
+	strbuf_grow(&trace, 8192);
+
 	va_start(ap, fmt);
-	len =3D vsnprintf(buf, sizeof(buf), fmt, ap);
+	len =3D vsnprintf(trace.buf, strbuf_avail(&trace) + 1, fmt, ap);
 	va_end(ap);
-	if (len >=3D sizeof(buf))
+	if (len >=3D strbuf_avail(&trace))
 		die("unreasonnable trace length");
+	strbuf_setlen(&trace, len);
=20
-	/* Get the argv string. */
-	argv_str =3D sq_quote_argv(argv, count);
-	argv_len =3D strlen(argv_str);
-
-	write_or_whine_pipe(fd, buf, len, err_msg);
-	write_or_whine_pipe(fd, argv_str, argv_len, err_msg);
-	write_or_whine_pipe(fd, "\n", 1, err_msg);
-
-	free(argv_str);
+	sq_quote_argv(&trace, argv, count, 0);
+	strbuf_addch(&trace, '\n');
+	write_or_whine_pipe(fd, trace.buf, trace.len, err_msg);
=20
+	strbuf_release(&trace);
 	if (need_close)
 		close(fd);
 }
--=20
1.5.3.2.1036.gca8d2


--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8jL5vGr7W6HudhwRAmzzAJ9R2kgaXSwzqPibn6KT6CMk/7UZBwCdHDN+
EKgUjOmAEWNfGAs4CQT9XOQ=
=bu93
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
