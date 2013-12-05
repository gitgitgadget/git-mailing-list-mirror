From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 23/28] Support shallow fetch/clone over smart-http
Date: Thu,  5 Dec 2013 20:02:50 +0700
Message-ID: <1386248575-10206-24-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 14:00:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYXz-0002tz-8Y
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 14:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233Ab3LENAq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 08:00:46 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:37355 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab3LENAq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 08:00:46 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so24625096pdi.38
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 05:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wUlo5O3lq+Thnhu0QoWfC4tO5zrRZHM+MINo9oC7X80=;
        b=hnBekB9zlSrzqXLNmjUHaZeWRKAOmXjZAL3PC3Lm3ZqGfVw4tV2bkxFCYXpwpYZIHl
         zY7xPrKEMDSSewGmdTskd0smtu/eP7Qz3ZinzA4NdRkKVV8lvZkTSzdVm/ZYe7KYDoid
         f5VJ/vEdKnLTwC+Oai6OOXs5GhKvykVV6PAG4dx0mSjH2ftJlqGcBo6LDdtfEIFgEe5d
         MYkVcjgtFEEQcrGUeOUCw0FvDIFCtxajL0bXXoGlbiJ23pv1ypbVZMGDxxSRckr6CQ/J
         Kjv1n265ECgcwz2YNdaMS7yhDIzhiaQk4leMoQ1lGrMaZWdqK4uC772IFtzxVRvqaaBQ
         ZWWg==
X-Received: by 10.68.173.132 with SMTP id bk4mr8366089pbc.169.1386248445087;
        Thu, 05 Dec 2013 05:00:45 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id p1sm1935920pbo.12.2013.12.05.05.00.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 05:00:44 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:05:29 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238879>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitremote-helpers.txt |  7 +++++++
 builtin/fetch-pack.c                | 16 +++++++++++++---
 remote-curl.c                       | 31 +++++++++++++++++++++++++++++=
--
 t/t5536-fetch-shallow.sh            | 27 +++++++++++++++++++++++++++
 transport-helper.c                  |  6 ++++++
 upload-pack.c                       |  2 --
 6 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitrem=
ote-helpers.txt
index f1f4ca9..c2908db 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -437,6 +437,13 @@ set by Git if the remote helper has the 'option' c=
apability.
 'option check-connectivity' \{'true'|'false'\}::
 	Request the helper to check connectivity of a clone.
=20
+'option cloning \{'true'|'false'\}::
+	Notify the helper this is a clone request (i.e. the current
+	repository is guaranteed empty).
+
+'option update-shallow \{'true'|'false'\}::
+	Allow to extend .git/shallow if the new refs require it.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index aa6e596..81fae38 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -3,6 +3,7 @@
 #include "fetch-pack.h"
 #include "remote.h"
 #include "connect.h"
+#include "sha1-array.h"
=20
 static const char fetch_pack_usage[] =3D
 "git fetch-pack [--all] [--stdin] [--quiet|-q] [--keep|-k] [--thin] "
@@ -46,6 +47,7 @@ int cmd_fetch_pack(int argc, const char **argv, const=
 char *prefix)
 	char **pack_lockfile_ptr =3D NULL;
 	struct child_process *conn;
 	struct fetch_pack_args args;
+	struct sha1_array shallow =3D SHA1_ARRAY_INIT;
=20
 	packet_trace_identity("fetch-pack");
=20
@@ -113,6 +115,14 @@ int cmd_fetch_pack(int argc, const char **argv, co=
nst char *prefix)
 			args.check_self_contained_and_connected =3D 1;
 			continue;
 		}
+		if (!strcmp("--cloning", arg)) {
+			args.cloning =3D 1;
+			continue;
+		}
+		if (!strcmp("--update-shallow", arg)) {
+			args.update_shallow =3D 1;
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
=20
@@ -157,10 +167,10 @@ int cmd_fetch_pack(int argc, const char **argv, c=
onst char *prefix)
 				   args.verbose ? CONNECT_VERBOSE : 0);
 	}
=20
-	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, NULL);
+	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
=20
-	ref =3D fetch_pack(&args, fd, conn, ref, dest,
-			 sought, nr_sought, NULL, pack_lockfile_ptr);
+	ref =3D fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
+			 &shallow, pack_lockfile_ptr);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
 		fflush(stdout);
diff --git a/remote-curl.c b/remote-curl.c
index 25d6730..3d97e3d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -10,6 +10,7 @@
 #include "sideband.h"
 #include "argv-array.h"
 #include "credential.h"
+#include "sha1-array.h"
=20
 static struct remote *remote;
 /* always ends with a trailing slash */
@@ -20,6 +21,8 @@ struct options {
 	unsigned long depth;
 	unsigned progress : 1,
 		check_self_contained_and_connected : 1,
+		cloning : 1,
+		update_shallow : 1,
 		followtags : 1,
 		dry_run : 1,
 		thin : 1;
@@ -88,6 +91,24 @@ static int set_option(const char *name, const char *=
value)
 		strbuf_release(&val);
 		return 0;
 	}
+	else if (!strcmp(name, "cloning")) {
+		if (!strcmp(value, "true"))
+			options.cloning =3D 1;
+		else if (!strcmp(value, "false"))
+			options.cloning =3D 0;
+		else
+			return -1;
+		return 0;
+	}
+	else if (!strcmp(name, "update-shallow")) {
+		if (!strcmp(value, "true"))
+			options.update_shallow =3D 1;
+		else if (!strcmp(value, "false"))
+			options.update_shallow =3D 0;
+		else
+			return -1;
+		return 0;
+	}
 	else {
 		return 1 /* unsupported */;
 	}
@@ -99,6 +120,7 @@ struct discovery {
 	char *buf;
 	size_t len;
 	struct ref *refs;
+	struct sha1_array shallow;
 	unsigned proto_git : 1;
 };
 static struct discovery *last_discovery;
@@ -107,7 +129,7 @@ static struct ref *parse_git_refs(struct discovery =
*heads, int for_push)
 {
 	struct ref *list =3D NULL;
 	get_remote_heads(-1, heads->buf, heads->len, &list,
-			 for_push ? REF_NORMAL : 0, NULL, NULL);
+			 for_push ? REF_NORMAL : 0, NULL, &heads->shallow);
 	return list;
 }
=20
@@ -168,6 +190,7 @@ static void free_discovery(struct discovery *d)
 	if (d) {
 		if (d =3D=3D last_discovery)
 			last_discovery =3D NULL;
+		free(d->shallow.sha1);
 		free(d->buf_alloc);
 		free_refs(d->refs);
 		free(d);
@@ -688,7 +711,7 @@ static int fetch_git(struct discovery *heads,
 	struct strbuf preamble =3D STRBUF_INIT;
 	char *depth_arg =3D NULL;
 	int argc =3D 0, i, err;
-	const char *argv[16];
+	const char *argv[17];
=20
 	argv[argc++] =3D "fetch-pack";
 	argv[argc++] =3D "--stateless-rpc";
@@ -704,6 +727,10 @@ static int fetch_git(struct discovery *heads,
 	}
 	if (options.check_self_contained_and_connected)
 		argv[argc++] =3D "--check-self-contained-and-connected";
+	if (options.cloning)
+		argv[argc++] =3D "--cloning";
+	if (options.update_shallow)
+		argv[argc++] =3D "--update-shallow";
 	if (!options.progress)
 		argv[argc++] =3D "--no-progress";
 	if (options.depth) {
diff --git a/t/t5536-fetch-shallow.sh b/t/t5536-fetch-shallow.sh
index 3ae9092..79ce472 100755
--- a/t/t5536-fetch-shallow.sh
+++ b/t/t5536-fetch-shallow.sh
@@ -173,4 +173,31 @@ EOF
 	)
 '
=20
+if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
+	say 'skipping remaining tests, git built without http support'
+	test_done
+fi
+
+LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5536'}
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'clone http repository' '
+	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.g=
it" &&
+	git clone $HTTPD_URL/smart/repo.git clone &&
+	(
+	cd clone &&
+	git fsck &&
+	git log --format=3D%s origin/master >actual &&
+	cat <<EOF >expect &&
+6
+5
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
+stop_httpd
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 673b7c2..e2b4203 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -360,6 +360,12 @@ static int fetch_with_fetch(struct transport *tran=
sport,
 	    data->transport_options.check_self_contained_and_connected)
 		set_helper_option(transport, "check-connectivity", "true");
=20
+	if (transport->cloning)
+		set_helper_option(transport, "cloning", "true");
+
+	if (data->transport_options.update_shallow)
+		set_helper_option(transport, "update-shallow", "true");
+
 	for (i =3D 0; i < nr_heads; i++) {
 		const struct ref *posn =3D to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
diff --git a/upload-pack.c b/upload-pack.c
index 28269c7..2d02297 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -836,8 +836,6 @@ int main(int argc, char **argv)
=20
 	if (!enter_repo(dir, strict))
 		die("'%s' does not appear to be a git repository", dir);
-	if (is_repository_shallow() && stateless_rpc)
-		die("attempt to push into a shallow repository");
=20
 	git_config(upload_pack_config, NULL);
 	upload_pack();
--=20
1.8.5.1.25.g8667982
