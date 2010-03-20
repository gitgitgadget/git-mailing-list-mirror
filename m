From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/5] Expose verify_tag()
Date: Sat, 20 Mar 2010 00:13:28 -0500
Message-ID: <20100320051327.GC24791@progeny.tock>
References: <20100320050953.GA24746@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos Rica <jasampler@gmail.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 06:12:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsqzK-0000Y3-Rj
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 06:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124Ab0CTFMi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 01:12:38 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54603 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab0CTFMg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 01:12:36 -0400
Received: by gyg8 with SMTP id 8so1853876gyg.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 22:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=St5kH6JH6Fv/q0VY+Z0PGqmqZzZZph7z6t0C+8v+FP0=;
        b=YfE3uq4is/n+krKnaBAdUNcuqCQh0MRYVKws3Wbqkx8peAjMSBN5hXs+pz+3UaMuCk
         nYPFEkZGq7RtePEhD72Ek8gMsrFQf0LnyLnevnp9N2kJFJ9mSSS7ZTpm/f7DTFjFQBd7
         E54a8yOuSmbXWsjiwfJDGPPpEC7Imgksgz/Rg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TrQubel2hfm8N+TKq0ujwmveRpKjIbard7N7xclVe9qwhhIHGlgcB1jFICWDgpDmQE
         0yzZ5QjievOqiC60UBqtsyR+/6kSKvsM4Eku/owbfENBfJJIlxl54FIPYt8eI6/tu4JS
         10Y/579jH/CFnzf6FwnsIFjgDVGrfHvxOG5ok=
Received: by 10.150.209.11 with SMTP id h11mr9165829ybg.300.1269061956045;
        Fri, 19 Mar 2010 22:12:36 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm299872iwn.0.2010.03.19.22.12.35
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 22:12:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100320050953.GA24746@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142685>

Expose the verify_tag() function so =E2=80=98git tag -v=E2=80=99 can us=
e it directly
in the future.  verify_tag() already frees all the memory it allocates
and does not call any functions that can exit, so this should be safe.

The function is renamed to verify_tag_signature() for clarity and to
avoid conflicting with builtin/tag.c and builtin/mktag.c=E2=80=99s unre=
lated
verify_tag().

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile                             |    1 +
 builtin/verify-tag.c                 |   85 +-------------------------=
--------
 tag.h                                |    1 +
 builtin/verify-tag.c =3D> verify-tag.c |   34 +-------------
 4 files changed, 4 insertions(+), 117 deletions(-)
 copy builtin/verify-tag.c =3D> verify-tag.c (71%)

diff --git a/Makefile b/Makefile
index 7c616f8..ed58261 100644
--- a/Makefile
+++ b/Makefile
@@ -616,6 +616,7 @@ LIB_OBJS +=3D unpack-trees.o
 LIB_OBJS +=3D usage.o
 LIB_OBJS +=3D userdiff.o
 LIB_OBJS +=3D utf8.o
+LIB_OBJS +=3D verify-tag.o
 LIB_OBJS +=3D walker.o
 LIB_OBJS +=3D wrapper.o
 LIB_OBJS +=3D write_or_die.o
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 91dd1c1..ca075bd 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -5,12 +5,8 @@
  *
  * Based on git-verify-tag.sh
  */
-#include "cache.h"
 #include "builtin.h"
 #include "tag.h"
-#include "run-command.h"
-#include <signal.h>
-#include "sigchain.h"
 #include "parse-options.h"
=20
 static const char * const verify_tag_usage[] =3D {
@@ -18,85 +14,6 @@ static const char * const verify_tag_usage[] =3D {
 		NULL
 };
=20
-#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
-
-static int run_gpg_verify(const char *buf, unsigned long size, int ver=
bose)
-{
-	struct child_process gpg;
-	const char *args_gpg[] =3D {"gpg", "--verify", "FILE", "-", NULL};
-	char path[PATH_MAX], *eol;
-	size_t len;
-	int fd, ret;
-
-	fd =3D git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
-	if (fd < 0)
-		return error("could not create temporary file '%s': %s",
-						path, strerror(errno));
-	if (write_in_full(fd, buf, size) < 0)
-		return error("failed writing temporary file '%s': %s",
-						path, strerror(errno));
-	close(fd);
-
-	/* find the length without signature */
-	len =3D 0;
-	while (len < size && prefixcmp(buf + len, PGP_SIGNATURE)) {
-		eol =3D memchr(buf + len, '\n', size - len);
-		len +=3D eol ? eol - (buf + len) + 1 : size - len;
-	}
-	if (verbose)
-		write_in_full(1, buf, len);
-
-	memset(&gpg, 0, sizeof(gpg));
-	gpg.argv =3D args_gpg;
-	gpg.in =3D -1;
-	args_gpg[2] =3D path;
-	if (start_command(&gpg)) {
-		unlink(path);
-		return error("could not run gpg.");
-	}
-
-	/*
-	 * gpg will stop as soon as it knows the signature is bad,
-	 * which can result in SIGPIPE.
-	 */
-	sigchain_push(SIGPIPE, SIG_IGN);
-	write_in_full(gpg.in, buf, len);
-	close(gpg.in);
-	sigchain_pop(SIGPIPE);
-
-	ret =3D finish_command(&gpg);
-
-	unlink_or_warn(path);
-
-	return ret;
-}
-
-static int verify_tag(const char *name, int verbose)
-{
-	enum object_type type;
-	unsigned char sha1[20];
-	char *buf;
-	unsigned long size;
-	int ret;
-
-	if (get_sha1(name, sha1))
-		return error("tag '%s' not found.", name);
-
-	type =3D sha1_object_info(sha1, NULL);
-	if (type !=3D OBJ_TAG)
-		return error("%s: cannot verify a non-tag object of type %s.",
-				name, typename(type));
-
-	buf =3D read_sha1_file(sha1, &type, &size);
-	if (!buf)
-		return error("%s: unable to read file.", name);
-
-	ret =3D run_gpg_verify(buf, size, verbose);
-
-	free(buf);
-	return ret;
-}
-
 int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i =3D 1, verbose =3D 0, had_error =3D 0;
@@ -113,7 +30,7 @@ int cmd_verify_tag(int argc, const char **argv, cons=
t char *prefix)
 		usage_with_options(verify_tag_usage, verify_tag_options);
=20
 	while (i < argc)
-		if (verify_tag(argv[i++], verbose))
+		if (verify_tag_signature(argv[i++], verbose))
 			had_error =3D 1;
 	return had_error;
 }
diff --git a/tag.h b/tag.h
index 7a0cb00..1034109 100644
--- a/tag.h
+++ b/tag.h
@@ -16,5 +16,6 @@ extern struct tag *lookup_tag(const unsigned char *sh=
a1);
 extern int parse_tag_buffer(struct tag *item, void *data, unsigned lon=
g size);
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
+extern int verify_tag_signature(const char *name, int verbose);
=20
 #endif /* TAG_H */
diff --git a/builtin/verify-tag.c b/verify-tag.c
similarity index 71%
copy from builtin/verify-tag.c
copy to verify-tag.c
index 91dd1c1..7152e99 100644
--- a/builtin/verify-tag.c
+++ b/verify-tag.c
@@ -1,22 +1,11 @@
 /*
- * Builtin "git verify-tag"
- *
  * Copyright (c) 2007 Carlos Rica <jasampler@gmail.com>
- *
- * Based on git-verify-tag.sh
  */
 #include "cache.h"
-#include "builtin.h"
 #include "tag.h"
 #include "run-command.h"
 #include <signal.h>
 #include "sigchain.h"
-#include "parse-options.h"
-
-static const char * const verify_tag_usage[] =3D {
-		"git verify-tag [-v|--verbose] <tag>...",
-		NULL
-};
=20
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
=20
@@ -71,7 +60,7 @@ static int run_gpg_verify(const char *buf, unsigned l=
ong size, int verbose)
 	return ret;
 }
=20
-static int verify_tag(const char *name, int verbose)
+int verify_tag_signature(const char *name, int verbose)
 {
 	enum object_type type;
 	unsigned char sha1[20];
@@ -96,24 +85,3 @@ static int verify_tag(const char *name, int verbose)
 	free(buf);
 	return ret;
 }
-
-int cmd_verify_tag(int argc, const char **argv, const char *prefix)
-{
-	int i =3D 1, verbose =3D 0, had_error =3D 0;
-	const struct option verify_tag_options[] =3D {
-		OPT__VERBOSE(&verbose),
-		OPT_END()
-	};
-
-	git_config(git_default_config, NULL);
-
-	argc =3D parse_options(argc, argv, prefix, verify_tag_options,
-			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
-	if (argc <=3D i)
-		usage_with_options(verify_tag_usage, verify_tag_options);
-
-	while (i < argc)
-		if (verify_tag(argv[i++], verbose))
-			had_error =3D 1;
-	return had_error;
-}
--=20
1.7.0.2
