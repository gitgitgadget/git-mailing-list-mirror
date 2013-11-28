From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v7 05/10] git fetch-pack: Add --diag-url
Date: Thu, 28 Nov 2013 20:49:17 +0100
Message-ID: <201311282049.18196.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 20:49:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm7ac-0002p6-51
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 20:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759425Ab3K1Tt0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 14:49:26 -0500
Received: from mout.web.de ([212.227.17.11]:52785 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755994Ab3K1TtY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 14:49:24 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MQelV-1WDR5L26I9-00U09i for <git@vger.kernel.org>; Thu,
 28 Nov 2013 20:49:22 +0100
X-Provags-ID: V03:K0:P5+K0uuQVYSx8hJFY/SPR51O/YSJhjno811WnjYiHjme5nhDNKq
 7SrObfz1GbUvSnInjCZLA9thNtm/BAmEmzzApaHEgq7zoFx4ixnNzqot40ZKdAFbjvGgYmr
 pxegUzPlta8K4kjFjVhNkhOPzRr6iuoy7sU5XhDfa3wYpIbtXsbTV8UEZsCcYX45TpZEUuo
 iV9v+IanB4jBt0Z1VNOZg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238506>

The main purpose is to trace the URL parser called by git_connect() in
connect.c

The main features of the parser can be listed as this:
- parse out host and path for URLs with a scheme (git:// file:// ssh://=
)
- parse host names embedded by [] correctly
- extract the port number, if present
- separate URLs like "file" (which are local)
  from URLs like "host:repo" which should use ssh

Add the new parameter "--diag-url" to "git fetch-pack",
which prints the value for protocol, host and path to stderr and exits.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 builtin/fetch-pack.c | 14 +++++++++++---
 connect.c            | 28 ++++++++++++++++++++++++++++
 connect.h            |  1 +
 fetch-pack.h         |  1 +
 4 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c8e8582..758b5ac 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -7,7 +7,7 @@
 static const char fetch_pack_usage[] =3D
 "git fetch-pack [--all] [--stdin] [--quiet|-q] [--keep|-k] [--thin] "
 "[--include-tag] [--upload-pack=3D<git-upload-pack>] [--depth=3D<n>] "
-"[--no-progress] [-v] [<host>:]<directory> [<refs>...]";
+"[--no-progress] [--diag-url] [-v] [<host>:]<directory> [<refs>...]";
=20
 static void add_sought_entry_mem(struct ref ***sought, int *nr, int *a=
lloc,
 				 const char *name, int namelen)
@@ -81,6 +81,10 @@ int cmd_fetch_pack(int argc, const char **argv, cons=
t char *prefix)
 			args.stdin_refs =3D 1;
 			continue;
 		}
+		if (!strcmp("--diag-url", arg)) {
+			args.diag_url =3D 1;
+			continue;
+		}
 		if (!strcmp("-v", arg)) {
 			args.verbose =3D 1;
 			continue;
@@ -146,10 +150,14 @@ int cmd_fetch_pack(int argc, const char **argv, c=
onst char *prefix)
 		fd[0] =3D 0;
 		fd[1] =3D 1;
 	} else {
+		int flags =3D args.verbose ? CONNECT_VERBOSE : 0;
+		if (args.diag_url)
+			flags |=3D CONNECT_DIAG_URL;
 		conn =3D git_connect(fd, dest, args.uploadpack,
-				   args.verbose ? CONNECT_VERBOSE : 0);
+				   flags);
+		if (!conn)
+			return args.diag_url ? 0 : 1;
 	}
-
 	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL);
=20
 	ref =3D fetch_pack(&args, fd, conn, ref, dest,
diff --git a/connect.c b/connect.c
index a6cf345..a16bdaf 100644
--- a/connect.c
+++ b/connect.c
@@ -236,6 +236,20 @@ enum protocol {
 	PROTO_GIT
 };
=20
+static const char *prot_name(enum protocol protocol)
+{
+	switch (protocol) {
+		case PROTO_LOCAL:
+			return "file";
+		case PROTO_SSH:
+			return "ssh";
+		case PROTO_GIT:
+			return "git";
+		default:
+			return "unkown protocol";
+	}
+}
+
 static enum protocol get_protocol(const char *name)
 {
 	if (!strcmp(name, "ssh"))
@@ -670,6 +684,20 @@ struct child_process *git_connect(int fd[2], const=
 char *url,
 	signal(SIGCHLD, SIG_DFL);
=20
 	protocol =3D parse_connect_url(url, &host, &port, &path);
+	if (flags & CONNECT_DIAG_URL) {
+		printf("Diag: url=3D%s\n", url ? url : "NULL");
+		printf("Diag: protocol=3D%s\n", prot_name(protocol));
+		printf("Diag: hostandport=3D%s", host ? host : "NULL");
+		if (port)
+			printf(":%s\n", port);
+		else
+			printf("\n");
+		printf("Diag: path=3D%s\n", path ? path : "NULL");
+		free(host);
+		free(port);
+		free(path);
+		return NULL;
+	}
=20
 	if (protocol =3D=3D PROTO_GIT) {
 		/* These underlying connection commands die() if they
diff --git a/connect.h b/connect.h
index 64fb7db..527d58a 100644
--- a/connect.h
+++ b/connect.h
@@ -2,6 +2,7 @@
 #define CONNECT_H
=20
 #define CONNECT_VERBOSE       (1u << 0)
+#define CONNECT_DIAG_URL      (1u << 1)
 extern struct child_process *git_connect(int fd[2], const char *url, c=
onst char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
 extern int git_connection_is_socket(struct child_process *conn);
diff --git a/fetch-pack.h b/fetch-pack.h
index 461cbf3..20ccc12 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -14,6 +14,7 @@ struct fetch_pack_args {
 		use_thin_pack:1,
 		fetch_all:1,
 		stdin_refs:1,
+		diag_url:1,
 		verbose:1,
 		no_progress:1,
 		include_tag:1,
--=20
1.8.5.rc0.23.gaa27064
