From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 7/9 - v2] builtin-checkout-index.c: use parse_options()
Date: Fri, 25 Jul 2008 18:25:55 +0200
Message-ID: <1217003155-12026-1-git-send-email-barra_cuda@katamail.com>
References: <48899657.5090209@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sverre@rabbelier.nl, Johannes.Schindelin@gmx.de,
	git@vger.kernel.org, gitster@pobox.com
To: rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Fri Jul 25 18:20:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQ1q-0006L1-R7
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 18:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbYGYQTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 12:19:24 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755285AbYGYQTY
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 12:19:24 -0400
Received: from smtp.katamail.com ([62.149.157.154]:53121 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754590AbYGYQTX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 12:19:23 -0400
Received: (qmail 19114 invoked by uid 89); 25 Jul 2008 16:19:15 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.197)
  by smtp1-pc with SMTP; 25 Jul 2008 16:19:13 -0000
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <48899657.5090209@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90063>

This changes "struct checkout" (now it uses ints and not bitfields) to
simplify the parsing code.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
On Friday 25 July 2008, Ren=C3=A9 Scharfe wrote:
> In the case of struct checkout, though, we could simply make the
> bitfield members full ints, because there are only a few instances of
> this structure in memory at any given time. Wasting a few bytes of RA=
M
> in order to gain much simpler code is OK in this case, I think.
> OPT_BOOLEAN looks a lot nicer than a callback.

Yes. I only wanted the changes to be minimal, and only affect the optio=
n
parsing. In this sense, I still think the old patch is better. Here it =
is
the one you suggested (maybe Johannes suggested the same, but I didn't
understand :).

 builtin-checkout-index.c |  113 +++++++++++++++++++-------------------=
--------
 cache.h                  |    8 ++--
 2 files changed, 50 insertions(+), 71 deletions(-)

diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 71ebabf..135348e 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -40,6 +40,7 @@
 #include "cache.h"
 #include "quote.h"
 #include "cache-tree.h"
+#include "parse-options.h"
=20
 #define CHECKOUT_ALL 4
 static int line_termination =3D '\n';
@@ -153,18 +154,43 @@ static void checkout_all(const char *prefix, int =
prefix_length)
 		exit(128);
 }
=20
-static const char checkout_cache_usage[] =3D
-"git checkout-index [-u] [-q] [-a] [-f] [-n] [--stage=3D[123]|all] [--=
prefix=3D<string>] [--temp] [--] <file>...";
+static const char * const checkout_cache_usage[] =3D {
+	"git checkout-index [options] [--] <file>...",
+	NULL
+};
=20
 static struct lock_file lock_file;
=20
 int cmd_checkout_index(int argc, const char **argv, const char *prefix=
)
 {
-	int i;
 	int newfd =3D -1;
 	int all =3D 0;
 	int read_from_stdin =3D 0;
 	int prefix_length;
+	char *stage =3D NULL;
+
+	const struct option options[] =3D {
+		OPT_BOOLEAN('a', "all", &all,
+			    "checks out all files in the index"),
+		OPT_BOOLEAN('f', "force", &state.force,
+			    "force overwrite of existing files"),
+		OPT__QUIET(&state.quiet),
+		OPT_SET_INT('n', "no-create", &state.not_new,
+			"do not checkout new files, refresh existing ones", 1),
+		OPT_BOOLEAN('u', "index", &state.refresh_cache,
+			    "update stat information in the index"),
+		OPT_SET_INT('z', NULL, &line_termination,
+			    "separate paths with NUL", 0),
+		OPT_BOOLEAN(0, "stdin", &read_from_stdin,
+			    "read paths from stdin"),
+		OPT_BOOLEAN(0, "temp", &to_tempfile,
+			    "write content to temporary files"),
+		OPT_STRING(0, "prefix", &state.base_dir, "string",
+			   "prepend <string> when creating files"),
+		OPT_STRING(0, "stage", &stage, "1|2|3|all",
+			   "copy out files from the named stage"),
+		OPT_END()
+	};
=20
 	git_config(git_default_config, NULL);
 	state.base_dir =3D "";
@@ -174,71 +200,24 @@ int cmd_checkout_index(int argc, const char **arg=
v, const char *prefix)
 		die("invalid cache");
 	}
=20
-	for (i =3D 1; i < argc; i++) {
-		const char *arg =3D argv[i];
+	argc =3D parse_options(argc, argv, options, checkout_cache_usage, 0);
=20
-		if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		if (!strcmp(arg, "-a") || !strcmp(arg, "--all")) {
-			all =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "-f") || !strcmp(arg, "--force")) {
-			state.force =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet")) {
-			state.quiet =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "-n") || !strcmp(arg, "--no-create")) {
-			state.not_new =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "-u") || !strcmp(arg, "--index")) {
-			state.refresh_cache =3D 1;
-			if (newfd < 0)
-				newfd =3D hold_locked_index(&lock_file, 1);
-			continue;
-		}
-		if (!strcmp(arg, "-z")) {
-			line_termination =3D 0;
-			continue;
-		}
-		if (!strcmp(arg, "--stdin")) {
-			if (i !=3D argc - 1)
-				die("--stdin must be at the end");
-			read_from_stdin =3D 1;
-			i++; /* do not consider arg as a file name */
-			break;
-		}
-		if (!strcmp(arg, "--temp")) {
+	if ((state.refresh_cache) && (newfd < 0))
+		newfd =3D hold_locked_index(&lock_file, 1);
+	if (state.base_dir)
+		state.base_dir_len =3D strlen(state.base_dir);
+
+	if (stage) {
+		if (!strcmp(stage, "all")) {
 			to_tempfile =3D 1;
-			continue;
-		}
-		if (!prefixcmp(arg, "--prefix=3D")) {
-			state.base_dir =3D arg+9;
-			state.base_dir_len =3D strlen(state.base_dir);
-			continue;
-		}
-		if (!prefixcmp(arg, "--stage=3D")) {
-			if (!strcmp(arg + 8, "all")) {
-				to_tempfile =3D 1;
-				checkout_stage =3D CHECKOUT_ALL;
-			} else {
-				int ch =3D arg[8];
-				if ('1' <=3D ch && ch <=3D '3')
-					checkout_stage =3D arg[8] - '0';
-				else
-					die("stage should be between 1 and 3 or all");
-			}
-			continue;
+			checkout_stage =3D CHECKOUT_ALL;
+		} else {
+			int ch =3D stage[0];
+			if ('1' <=3D ch && ch <=3D '3')
+				checkout_stage =3D stage[0] - '0';
+			else
+				die("stage should be between 1 and 3 or all");
 		}
-		if (arg[0] =3D=3D '-')
-			usage(checkout_cache_usage);
-		break;
 	}
=20
 	if (state.base_dir_len || to_tempfile) {
@@ -253,8 +232,8 @@ int cmd_checkout_index(int argc, const char **argv,=
 const char *prefix)
 	}
=20
 	/* Check out named files first */
-	for ( ; i < argc; i++) {
-		const char *arg =3D argv[i];
+	while (argc-- > 0) {
+		const char *arg =3D *argv++;
 		const char *p;
=20
 		if (all)
diff --git a/cache.h b/cache.h
index 38985aa..0bbe33b 100644
--- a/cache.h
+++ b/cache.h
@@ -618,10 +618,10 @@ extern const char *fmt_name(const char *name, con=
st char *email);
 struct checkout {
 	const char *base_dir;
 	int base_dir_len;
-	unsigned force:1,
-		 quiet:1,
-		 not_new:1,
-		 refresh_cache:1;
+	int force;
+	int quiet;
+	int not_new;
+	int refresh_cache;
 };
=20
 extern int checkout_entry(struct cache_entry *ce, const struct checkou=
t *state, char *topath);
--=20
1.5.6.3
