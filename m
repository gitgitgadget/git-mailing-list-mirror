From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Rewrite builtin-fetch option parsing to use parse_options().
Date: Tue,  4 Dec 2007 02:25:47 -0500
Message-ID: <1196753147-20073-2-git-send-email-krh@redhat.com>
References: <1196753147-20073-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 04 07:42:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzRUd-0000lz-Gg
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 07:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbXLDGmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 01:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbXLDGmc
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 01:42:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46348 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbXLDGma (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 01:42:30 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lB46gRdQ000700;
	Tue, 4 Dec 2007 01:42:27 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lB46gRLK019197;
	Tue, 4 Dec 2007 01:42:27 -0500
Received: from localhost.localdomain (sebastian-int.corp.redhat.com [172.16.52.221])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lB46gPeR007314;
	Tue, 4 Dec 2007 01:42:26 -0500
X-Mailer: git-send-email 1.5.3.7.2108.g5cf27
In-Reply-To: <1196753147-20073-1-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67011>

This gets a little tricky because of the way --tags and --no-tags
are handled, and the "tag <name>" syntax needs a little hand-holding to=
o.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-fetch.c |  123 ++++++++++++++++++++---------------------------=
-------
 1 files changed, 46 insertions(+), 77 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index f6d16fe..320e235 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -9,14 +9,45 @@
 #include "remote.h"
 #include "transport.h"
 #include "run-command.h"
+#include "parse-options.h"
=20
-static const char fetch_usage[] =3D "git-fetch [-a | --append] [--uplo=
ad-pack <upload-pack>] [-f | --force] [--no-tags] [-t | --tags] [-k | -=
-keep] [-u | --update-head-ok] [--depth <depth>] [-v | --verbose] [<rep=
ository> <refspec>...]";
+static const char * const builtin_fetch_usage[] =3D {
+	"git-fetch [options] [<repository> <refspec>...]",
+	NULL
+};
=20
-static int append, force, tags, no_tags, update_head_ok, verbose, quie=
t;
+enum {
+	TAGS_UNSET =3D 0,
+	TAGS_DEFAULT =3D 1,
+	TAGS_SET =3D 2
+};
+
+static int append, force, keep, update_head_ok, verbose, quiet;
+static int tags =3D TAGS_DEFAULT;
 static const char *depth;
+static const char *upload_pack;
 static struct strbuf default_rla =3D STRBUF_INIT;
 static struct transport *transport;
=20
+static struct option builtin_fetch_options[] =3D {
+	OPT__QUIET(&quiet),
+	OPT__VERBOSE(&verbose),
+	OPT_BOOLEAN('a', "append", &append,
+		    "append to .git/FETCH_HEAD instead of overwriting"),
+	OPT_STRING(0, "upload-pack", &upload_pack, "PATH",
+		   "path to upload pack on remote end"),
+	OPT_BOOLEAN('f', "force", &force,
+		    "force overwrite of local branch"),
+	OPT_SET_INT('t', "tags", &tags,
+		    "fetch all tags and associated objects", TAGS_SET),
+	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
+	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
+		    "allow updating of HEAD ref"),
+	OPT_STRING(0, "depth", &depth, "DEPTH",
+		   "deepen history of shallow clone"),
+	OPT_END()
+};
+
 static void unlock_pack(void)
 {
 	if (transport)
@@ -81,7 +112,7 @@ static struct ref *get_ref_map(struct transport *tra=
nsport,
=20
 	const struct ref *remote_refs =3D transport_get_remote_refs(transport=
);
=20
-	if (ref_count || tags) {
+	if (ref_count || tags =3D=3D TAGS_SET) {
 		for (i =3D 0; i < ref_count; i++) {
 			get_fetch_map(remote_refs, &refs[i], &tail, 0);
 			if (refs[i].dst && refs[i].dst[0])
@@ -90,7 +121,7 @@ static struct ref *get_ref_map(struct transport *tra=
nsport,
 		/* Merge everything on the command line, but not --tags */
 		for (rm =3D ref_map; rm; rm =3D rm->next)
 			rm->merge =3D 1;
-		if (tags) {
+		if (tags =3D=3D TAGS_SET) {
 			struct refspec refspec;
 			refspec.src =3D "refs/tags/";
 			refspec.dst =3D "refs/tags/";
@@ -482,10 +513,10 @@ static int do_fetch(struct transport *transport,
 	struct ref *ref_map, *fetch_map;
 	struct ref *rm;
 	int autotags =3D (transport->remote->fetch_tags =3D=3D 1);
-	if (transport->remote->fetch_tags =3D=3D 2 && !no_tags)
-		tags =3D 1;
+	if (transport->remote->fetch_tags =3D=3D 2 && tags !=3D TAGS_UNSET)
+		tags =3D TAGS_SET;
 	if (transport->remote->fetch_tags =3D=3D -1)
-		no_tags =3D 1;
+		tags =3D TAGS_UNSET;
=20
 	if (!transport->get_refs_list || !transport->fetch)
 		die("Don't know how to fetch from %s", transport->url);
@@ -515,7 +546,7 @@ static int do_fetch(struct transport *transport,
=20
 	/* if neither --no-tags nor --tags was specified, do automated tag
 	 * following ... */
-	if (!(tags || no_tags) && autotags) {
+	if (tags =3D=3D TAGS_DEFAULT && autotags) {
 		ref_map =3D find_non_local_tags(transport, fetch_map);
 		if (ref_map) {
 			transport_set_option(transport, TRANS_OPT_DEPTH, "0");
@@ -546,80 +577,19 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
 	int i;
 	static const char **refs =3D NULL;
 	int ref_nr =3D 0;
-	const char *upload_pack =3D NULL;
-	int keep =3D 0;
=20
 	/* Record the command line for the reflog */
 	strbuf_addstr(&default_rla, "fetch");
 	for (i =3D 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
=20
-	for (i =3D 1; i < argc; i++) {
-		const char *arg =3D argv[i];
-
-		if (arg[0] !=3D '-')
-			break;
-		if (!strcmp(arg, "--append") || !strcmp(arg, "-a")) {
-			append =3D 1;
-			continue;
-		}
-		if (!prefixcmp(arg, "--upload-pack=3D")) {
-			upload_pack =3D arg + 14;
-			continue;
-		}
-		if (!strcmp(arg, "--upload-pack")) {
-			i++;
-			if (i =3D=3D argc)
-				usage(fetch_usage);
-			upload_pack =3D argv[i];
-			continue;
-		}
-		if (!strcmp(arg, "--force") || !strcmp(arg, "-f")) {
-			force =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--no-tags")) {
-			no_tags =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--tags") || !strcmp(arg, "-t")) {
-			tags =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--keep") || !strcmp(arg, "-k")) {
-			keep =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--update-head-ok") || !strcmp(arg, "-u")) {
-			update_head_ok =3D 1;
-			continue;
-		}
-		if (!prefixcmp(arg, "--depth=3D")) {
-			depth =3D arg + 8;
-			continue;
-		}
-		if (!strcmp(arg, "--depth")) {
-			i++;
-			if (i =3D=3D argc)
-				usage(fetch_usage);
-			depth =3D argv[i];
-			continue;
-		}
-		if (!strcmp(arg, "--quiet") || !strcmp(arg, "-q")) {
-			quiet =3D 1;
-			continue;
-		}
-		if (!strcmp(arg, "--verbose") || !strcmp(arg, "-v")) {
-			verbose++;
-			continue;
-		}
-		usage(fetch_usage);
-	}
+	argc =3D parse_options(argc, argv,
+			     builtin_fetch_options, builtin_fetch_usage, 0);
=20
-	if (i =3D=3D argc)
+	if (argc =3D=3D 0)
 		remote =3D remote_get(NULL);
 	else
-		remote =3D remote_get(argv[i++]);
+		remote =3D remote_get(argv[0]);
=20
 	transport =3D transport_get(remote, remote->url[0]);
 	if (verbose >=3D 2)
@@ -636,10 +606,10 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
 	if (!transport->url)
 		die("Where do you want to fetch from today?");
=20
-	if (i < argc) {
+	if (argc > 1) {
 		int j =3D 0;
-		refs =3D xcalloc(argc - i + 1, sizeof(const char *));
-		while (i < argc) {
+		refs =3D xcalloc(argc + 1, sizeof(const char *));
+		for (i =3D 1; i < argc; i++) {
 			if (!strcmp(argv[i], "tag")) {
 				char *ref;
 				i++;
@@ -651,7 +621,6 @@ int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
 				refs[j++] =3D ref;
 			} else
 				refs[j++] =3D argv[i];
-			i++;
 		}
 		refs[j] =3D NULL;
 		ref_nr =3D j;
--=20
1.5.3.4
