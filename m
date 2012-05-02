From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] fetch-pack: use parse_options()
Date: Wed,  2 May 2012 21:38:09 +0700
Message-ID: <1335969490-9181-3-git-send-email-pclouds@gmail.com>
References: <4FA13835.7080204@alum.mit.edu>
 <1335969490-9181-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 16:42:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPalE-0005Zz-CK
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 16:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab2EBOmG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 10:42:06 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62615 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab2EBOmC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 10:42:02 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1178845pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tYGFC+hkAP0dh/+3Od341MbMF/STf9GTSxQjK6yiA34=;
        b=o1kr+RK2d56TFjJAfTYuH5ceexCSPtaSGvUSug/75mTaD4KEMjnkW60nz/d9voYoTx
         RoFIv1C0JM1V9S36q9fznI84rafK4G88WUeCMEY+W+vMEy3E5SCua0m6Lwjs0qp6HtS3
         dQ+OmqMx5cruqwjHy770fc7aiJKvoPzLTCb2RuB1+MUPzQEtTI3BIopGiGER2krEaWyM
         kKl2eRIyvme2wCUbtmX0RINU1sjdFB8iMGD2Roe2V/U6lwFhlxgzVaSFpTaIP2vixoc3
         C2YA4jTlYOtZE6oRhZjsjROc0qGkOJtW0GpDj4L7H5zQ01qIvVWwB6EH09tyMTIK4RnG
         lbxw==
Received: by 10.68.225.104 with SMTP id rj8mr66952352pbc.135.1335969722182;
        Wed, 02 May 2012 07:42:02 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id vn10sm2149466pbc.43.2012.05.02.07.41.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 07:42:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 02 May 2012 21:38:32 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335969490-9181-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196831>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I _think_ this also fixes a case when --keep is passed twice, then
 lock_pack is set to 1, but pack_lockfile_ptr is not set while it is
 set when --lock-pack is given.

 builtin/fetch-pack.c |  110 ++++++++++++++++++------------------------=
--------
 fetch-pack.h         |   20 +++++-----
 2 files changed, 49 insertions(+), 81 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 7e9d62f..65ac111 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -10,6 +10,7 @@
 #include "remote.h"
 #include "run-command.h"
 #include "transport.h"
+#include "parse-options.h"
=20
 static int transfer_unpack_limit =3D -1;
 static int fetch_unpack_limit =3D -1;
@@ -22,10 +23,12 @@ static struct fetch_pack_args args =3D {
 	/* .uploadpack =3D */ "git-upload-pack",
 };
=20
-static const char fetch_pack_usage[] =3D
-"git fetch-pack [--all] [--stdin] [--quiet|-q] [--keep|-k] [--thin] "
-"[--include-tag] [--upload-pack=3D<git-upload-pack>] [--depth=3D<n>] "
-"[--no-progress] [-v] [<host>:]<directory> [<refs>...]";
+static const char* fetch_pack_usage[] =3D {
+	"git fetch-pack [--all] [--stdin] [--quiet|-q] [--keep|-k] [--thin] "
+	"[--include-tag] [--upload-pack=3D<git-upload-pack>] [--depth=3D<n>] =
"
+	"[--no-progress] [-v] [<host>:]<directory> [<refs>...]",
+	NULL
+};
=20
 #define COMPLETE	(1U << 0)
 #define COMMON		(1U << 1)
@@ -906,79 +909,44 @@ int cmd_fetch_pack(int argc, const char **argv, c=
onst char *prefix)
 	int fd[2];
 	char *pack_lockfile =3D NULL;
 	char **pack_lockfile_ptr =3D NULL;
+	int progress =3D 1;
 	struct child_process *conn;
+	struct option opts[] =3D {
+		OPT_STRING(0, "upload-pack", &args.uploadpack, "path",
+			   "path to upload pack on remote end"),
+		OPT_STRING( 0 , "exec", &args.uploadpack, "upload-pack",
+			    "path to upload pack on remote end"),
+		OPT__QUIET(&args.quiet, "do not print results to stdout"),
+		OPT_COUNTUP('k', "keep", &args.keep_pack, "keep downloaded pack"),
+		OPT_BOOL(0, "thin", &args.use_thin_pack, "create thin packs"),
+		OPT_BOOL(0, "include-tag", &args.include_tag,
+			 "include tag objects that refer to objects to be packed"),
+		OPT_BOOL(0, "all", &args.fetch_all, "fetch from all remotes" ),
+		OPT_BOOL(0, "stdin", &args.stdin_refs, "read refs from stdin" ),
+		OPT__VERBOSE(&args.verbose, "be more verbose"),
+		OPT_INTEGER(0, "depth", &args.depth,
+			    "deepen history of shallow clone"),
+		OPT_BOOL(0, "progress", &progress, "show progress"),
+		OPT_BOOL(0, "stateless-rpc", &args.stateless_rpc, "use stateless RPC=
"),
+		OPT_BOOL(0, "lock-pack", &args.lock_pack, "lock the downloaded pack"=
),
+		OPT_END()
+	};
=20
 	packet_trace_identity("fetch-pack");
=20
 	nr_heads =3D 0;
 	heads =3D NULL;
-	for (i =3D 1; i < argc; i++) {
-		const char *arg =3D argv[i];
-
-		if (*arg =3D=3D '-') {
-			if (!prefixcmp(arg, "--upload-pack=3D")) {
-				args.uploadpack =3D arg + 14;
-				continue;
-			}
-			if (!prefixcmp(arg, "--exec=3D")) {
-				args.uploadpack =3D arg + 7;
-				continue;
-			}
-			if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
-				args.quiet =3D 1;
-				continue;
-			}
-			if (!strcmp("--keep", arg) || !strcmp("-k", arg)) {
-				args.lock_pack =3D args.keep_pack;
-				args.keep_pack =3D 1;
-				continue;
-			}
-			if (!strcmp("--thin", arg)) {
-				args.use_thin_pack =3D 1;
-				continue;
-			}
-			if (!strcmp("--include-tag", arg)) {
-				args.include_tag =3D 1;
-				continue;
-			}
-			if (!strcmp("--all", arg)) {
-				args.fetch_all =3D 1;
-				continue;
-			}
-			if (!strcmp("--stdin", arg)) {
-				args.stdin_refs =3D 1;
-				continue;
-			}
-			if (!strcmp("-v", arg)) {
-				args.verbose =3D 1;
-				continue;
-			}
-			if (!prefixcmp(arg, "--depth=3D")) {
-				args.depth =3D strtol(arg + 8, NULL, 0);
-				continue;
-			}
-			if (!strcmp("--no-progress", arg)) {
-				args.no_progress =3D 1;
-				continue;
-			}
-			if (!strcmp("--stateless-rpc", arg)) {
-				args.stateless_rpc =3D 1;
-				continue;
-			}
-			if (!strcmp("--lock-pack", arg)) {
-				args.lock_pack =3D 1;
-				pack_lockfile_ptr =3D &pack_lockfile;
-				continue;
-			}
-			usage(fetch_pack_usage);
-		}
-		dest =3D arg;
-		heads =3D (char **)(argv + i + 1);
-		nr_heads =3D argc - i - 1;
-		break;
-	}
-	if (!dest)
-		usage(fetch_pack_usage);
+	argc =3D parse_options(argc, argv, prefix, opts, fetch_pack_usage, 0)=
;
+	args.no_progress =3D !progress;
+	if (args.keep_pack > 1)
+		args.lock_pack =3D 1;
+	if (args.lock_pack)
+		pack_lockfile_ptr =3D &pack_lockfile;
+	dest =3D argv[0];
+	if (!argc || !dest)
+		usage_with_options(fetch_pack_usage, opts);
+	heads =3D (char **)(argv + 1);
+	nr_heads =3D argc - 1;
=20
 	if (args.stdin_refs) {
 		/*
diff --git a/fetch-pack.h b/fetch-pack.h
index 7c2069c..d440162 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -5,16 +5,16 @@ struct fetch_pack_args {
 	const char *uploadpack;
 	int unpacklimit;
 	int depth;
-	unsigned quiet:1,
-		keep_pack:1,
-		lock_pack:1,
-		use_thin_pack:1,
-		fetch_all:1,
-		stdin_refs:1,
-		verbose:1,
-		no_progress:1,
-		include_tag:1,
-		stateless_rpc:1;
+	int quiet;
+	int keep_pack;
+	int lock_pack;
+	int use_thin_pack;
+	int fetch_all;
+	int stdin_refs;
+	int verbose;
+	int no_progress;
+	int include_tag;
+	int stateless_rpc;
 };
=20
 struct ref *fetch_pack(struct fetch_pack_args *args,
--=20
1.7.8.36.g69ee2
