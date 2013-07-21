From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Let index-pack help with connectivity check on cloning via smart http
Date: Sun, 21 Jul 2013 15:18:05 +0700
Message-ID: <1374394685-16589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 21 10:18:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0oqQ-000684-2x
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 10:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab3GUIRt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Jul 2013 04:17:49 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:55015 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510Ab3GUIRq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 04:17:46 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so12400360iea.25
        for <git@vger.kernel.org>; Sun, 21 Jul 2013 01:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Ujsvr7JJsDlVxkHmMxTW6d5OIkhBOIhh5Uivi7z3FY4=;
        b=E3kPtL28eIGtckjg7EYlgis8TiwPtudwsVLPSYWUQKI9TO/mR3DjjQGoHrV+XLXs41
         q/U3olWXCdEP2WcrYIw+WAxwVWvWshLN18NRctOaiInnwpjVDsdhAkgLD3twFcq35pwV
         Wchoy82XuvLz02lrYB1BhnpDHhF8fFO3+ijdMkR0JkfuzZci9dtmVKIUW3ZUu0WnhtLx
         HWHgaPIYzfEixr3qURA7M2F2jhO49gLMd0gZ0srXLZrMBlPH3ttZhaO+gmkBVXsL7OFU
         RBpQgvOf1OrZEmd2+tctdhAzK4pGW6bF3lpxDH+mwROh72NcRQvK83W6rRbBsgmFdSz0
         69Lw==
X-Received: by 10.50.109.134 with SMTP id hs6mr7044117igb.35.1374394666278;
        Sun, 21 Jul 2013 01:17:46 -0700 (PDT)
Received: from lanh ([115.73.233.57])
        by mx.google.com with ESMTPSA id nm17sm49826346igb.5.2013.07.21.01.17.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Jul 2013 01:17:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 21 Jul 2013 15:18:06 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230919>

This is an extension of c6807a4 (clone: open a shortcut for
connectivity check - 2013-05-26) to reduce the cost of connectivity
check at clone time, this time with smart http protocol.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-fetch-pack.txt    |  4 ++++
 Documentation/gitremote-helpers.txt | 10 ++++++++++
 builtin/fetch-pack.c                |  9 +++++++++
 remote-curl.c                       | 15 ++++++++++++++-
 transport-helper.c                  | 10 ++++++++++
 5 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch=
-pack.txt
index 1e71754..444b805 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -90,6 +90,10 @@ be in a separate packet, and the list must end with =
a flush packet.
 --no-progress::
 	Do not show the progress.
=20
+--check-self-contained-and-connected::
+	Output "connectivity-ok" if the received pack is
+	self-contained and connected.
+
 -v::
 	Run verbosely.
=20
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitrem=
ote-helpers.txt
index 0827f69..bc069c2 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -143,6 +143,10 @@ Supported commands: 'list', 'fetch'.
 +
 Supported commands: 'list', 'import'.
=20
+'check-connectivity'::
+	Can guarantee that when a clone is requested, the received
+	pack is self contained and is connected.
+
 If a helper advertises 'connect', Git will use it if possible and
 fall back to another capability if the helper requests so when
 connecting (see the 'connect' command under COMMANDS).
@@ -270,6 +274,9 @@ Optionally may output a 'lock <file>' line indicati=
ng a file under
 GIT_DIR/objects/pack which is keeping a pack until refs can be
 suitably updated.
 +
+If option 'check-connectivity' is requested, the helper must output
+'connectivity-ok' if the clone is self-contained and connected.
++
 Supported if the helper has the "fetch" capability.
=20
 'push' +<src>:<dst>::
@@ -416,6 +423,9 @@ set by Git if the remote helper has the 'option' ca=
pability.
 	must not rely on this option being set before
 	connect request occurs.
=20
+'option check-connectivity' \{'true'|'false'\}::
+	Request the helper to check connectivity of a clone.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index aba4465..3e19d71 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -100,6 +100,10 @@ int cmd_fetch_pack(int argc, const char **argv, co=
nst char *prefix)
 			pack_lockfile_ptr =3D &pack_lockfile;
 			continue;
 		}
+		if (!strcmp("--check-self-contained-and-connected", arg)) {
+			args.check_self_contained_and_connected =3D 1;
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
=20
@@ -152,6 +156,11 @@ int cmd_fetch_pack(int argc, const char **argv, co=
nst char *prefix)
 		printf("lock %s\n", pack_lockfile);
 		fflush(stdout);
 	}
+	if (args.check_self_contained_and_connected &&
+	    args.self_contained_and_connected) {
+		printf("connectivity-ok\n");
+		fflush(stdout);
+	}
 	close(fd[0]);
 	close(fd[1]);
 	if (finish_connect(conn))
diff --git a/remote-curl.c b/remote-curl.c
index 5b3ce9e..6918668 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -16,6 +16,7 @@ struct options {
 	int verbosity;
 	unsigned long depth;
 	unsigned progress : 1,
+		check_self_contained_and_connected : 1,
 		followtags : 1,
 		dry_run : 1,
 		thin : 1;
@@ -67,6 +68,15 @@ static int set_option(const char *name, const char *=
value)
 			return -1;
 		return 0;
 	}
+	else if (!strcmp(name, "check-connectivity")) {
+		if (!strcmp(value, "true"))
+			options.check_self_contained_and_connected =3D 1;
+		else if (!strcmp(value, "false"))
+			options.check_self_contained_and_connected =3D 0;
+		else
+			return -1;
+		return 0;
+	}
 	else {
 		return 1 /* unsupported */;
 	}
@@ -654,7 +664,7 @@ static int fetch_git(struct discovery *heads,
 	struct strbuf preamble =3D STRBUF_INIT;
 	char *depth_arg =3D NULL;
 	int argc =3D 0, i, err;
-	const char *argv[15];
+	const char *argv[16];
=20
 	argv[argc++] =3D "fetch-pack";
 	argv[argc++] =3D "--stateless-rpc";
@@ -668,6 +678,8 @@ static int fetch_git(struct discovery *heads,
 		argv[argc++] =3D "-v";
 		argv[argc++] =3D "-v";
 	}
+	if (options.check_self_contained_and_connected)
+		argv[argc++] =3D "--check-self-contained-and-connected";
 	if (!options.progress)
 		argv[argc++] =3D "--no-progress";
 	if (options.depth) {
@@ -939,6 +951,7 @@ int main(int argc, const char **argv)
 			printf("fetch\n");
 			printf("option\n");
 			printf("push\n");
+			printf("check-connectivity\n");
 			printf("\n");
 			fflush(stdout);
 		} else {
diff --git a/transport-helper.c b/transport-helper.c
index db9bd18..e39b032 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -27,6 +27,7 @@ struct helper_data {
 		push : 1,
 		connect : 1,
 		signed_tags : 1,
+		check_connectivity : 1,
 		no_disconnect_req : 1;
 	char *export_marks;
 	char *import_marks;
@@ -186,6 +187,8 @@ static struct child_process *get_helper(struct tran=
sport *transport)
 			data->bidi_import =3D 1;
 		else if (!strcmp(capname, "export"))
 			data->export =3D 1;
+		else if (!strcmp(capname, "check-connectivity"))
+			data->check_connectivity =3D 1;
 		else if (!data->refspecs && !prefixcmp(capname, "refspec ")) {
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
@@ -349,6 +352,9 @@ static int fetch_with_fetch(struct transport *trans=
port,
 	struct strbuf buf =3D STRBUF_INIT;
=20
 	standard_options(transport);
+	if (data->check_connectivity &&
+	    data->transport_options.check_self_contained_and_connected)
+		set_helper_option(transport, "check-connectivity", "true");
=20
 	for (i =3D 0; i < nr_heads; i++) {
 		const struct ref *posn =3D to_fetch[i];
@@ -372,6 +378,10 @@ static int fetch_with_fetch(struct transport *tran=
sport,
 			else
 				transport->pack_lockfile =3D xstrdup(name);
 		}
+		else if (data->check_connectivity &&
+			 data->transport_options.check_self_contained_and_connected &&
+			 !strcmp(buf.buf, "connectivity-ok"))
+			data->transport_options.self_contained_and_connected =3D 1;
 		else if (!buf.len)
 			break;
 		else
--=20
1.8.2.83.gc99314b
