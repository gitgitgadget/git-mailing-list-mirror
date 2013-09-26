From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/10] fetch: new option to set preferred pack version for transfer
Date: Thu, 26 Sep 2013 09:26:43 +0700
Message-ID: <1380162409-18224-5-git-send-email-pclouds@gmail.com>
References: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 04:27:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP1If-0002fd-Fz
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 04:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361Ab3IZC1Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 22:27:25 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:46448 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab3IZC1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 22:27:24 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so473156pbc.32
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 19:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aWMKGOgeevpCRbl3F3WrbNkI8vYiU04v7I931Lmy28g=;
        b=i37xmuuxnKUN1yq0yod0ddDZFTYdCBue+TT1qZ+VqMtryFDbqynpBw/VRukI8UXLgV
         waWKLxbeTdnmmN/mVK6zO4gVpuzZrxj+RZe7aodCYiecPVMMCBWge0ZsnH2eMEcgJZfX
         UnfQRMIQtsk8fdKh0zeyXkNp6kjVw4nT1AcrMbrj84AjnjV25ZJ9VlNw0mzl0iSq9ZFn
         RUqymcBVnaHHIIoXjfFZ5EqVloJMYUxUbHCFoYO333fT/4NTEib/JfDFD3ixO9MSrIYB
         ZGw8F0n6rxyqzsqBdTcFNdRY1zxCpx8vywKlW+zhDQJEUA/FE+09Mn4LF3yY0vqRcW9A
         GWHg==
X-Received: by 10.68.232.3 with SMTP id tk3mr20954990pbc.121.1380162444452;
        Wed, 25 Sep 2013 19:27:24 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id yg3sm1322240pab.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 19:27:23 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 26 Sep 2013 09:27:18 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235391>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/fetch-options.txt |  5 +++++
 builtin/fetch.c                 | 10 ++++++++++
 fetch-pack.c                    |  3 +++
 fetch-pack.h                    |  1 +
 t/t5510-fetch.sh                | 13 +++++++++++++
 transport.c                     |  4 ++++
 transport.h                     |  5 +++++
 7 files changed, 41 insertions(+)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index ba1fe49..47d55e5 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -17,6 +17,11 @@
 	Convert a shallow repository to a complete one, removing all
 	the limitations imposed by shallow repositories.
=20
+--pack-version=3D<n>::
+	Define the preferred pack format version for data transfer.
+	Valid values are 2 and 4. Default value is specified by
+	core.preferredPackVersion setting. See linkgit:git-config[1].
+
 ifndef::git-pull[]
 --dry-run::
 	Show what would be done, without making any changes.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index d784b2e..695fbf1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -31,6 +31,7 @@ enum {
 };
=20
 static int all, append, dry_run, force, keep, multiple, prune, update_=
head_ok, verbosity;
+static int pack_version;
 static int progress =3D -1, recurse_submodules =3D RECURSE_SUBMODULES_=
DEFAULT;
 static int tags =3D TAGS_DEFAULT, unshallow;
 static const char *depth;
@@ -90,6 +91,8 @@ static struct option builtin_fetch_options[] =3D {
 	{ OPTION_STRING, 0, "recurse-submodules-default",
 		   &recurse_submodules_default, NULL,
 		   N_("default mode for recursion"), PARSE_OPT_HIDDEN },
+	OPT_INTEGER(0, "pack-version", &pack_version,
+		    N_("preferred pack version for transfer")),
 	OPT_END()
 };
=20
@@ -957,6 +960,8 @@ static int fetch_one(struct remote *remote, int arg=
c, const char **argv)
 		set_option(TRANS_OPT_KEEP, "yes");
 	if (depth)
 		set_option(TRANS_OPT_DEPTH, depth);
+	if (pack_version =3D=3D 4)
+		set_option(TRANS_OPT_PACKV4, "yes");
=20
 	if (argc > 0) {
 		int j =3D 0;
@@ -1010,6 +1015,11 @@ int cmd_fetch(int argc, const char **argv, const=
 char *prefix)
 	argc =3D parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
=20
+	if (!pack_version)
+		pack_version =3D core_default_pack_version;
+	if (pack_version !=3D 2 && pack_version !=3D 4)
+		die(_("invalid pack version %d"), pack_version);
+
 	if (unshallow) {
 		if (depth)
 			die(_("--depth and --unshallow cannot be used together"));
diff --git a/fetch-pack.c b/fetch-pack.c
index 6684348..16aa3d0 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -324,6 +324,7 @@ static int find_common(struct fetch_pack_args *args=
,
 			if (args->no_progress)   strbuf_addstr(&c, " no-progress");
 			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
 			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
+			if (args->packv4)       strbuf_addstr(&c, " packv4");
 			if (agent_supported)    strbuf_addf(&c, " agent=3D%s",
 							    git_user_agent_sanitized());
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
@@ -869,6 +870,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
 		args->no_progress =3D 0;
 	if (!server_supports("include-tag"))
 		args->include_tag =3D 0;
+	if (!server_supports("packv4"))
+		args->packv4 =3D 0;
 	if (server_supports("ofs-delta")) {
 		if (args->verbose)
 			fprintf(stderr, "Server supports ofs-delta\n");
diff --git a/fetch-pack.h b/fetch-pack.h
index 40f08ba..5f03739 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -17,6 +17,7 @@ struct fetch_pack_args {
 		no_progress:1,
 		include_tag:1,
 		stateless_rpc:1,
+		packv4:1,
 		check_self_contained_and_connected:1,
 		self_contained_and_connected:1;
 };
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index fde6891..d3da088 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -512,4 +512,17 @@ test_expect_success 'all boundary commits are excl=
uded' '
 	test_bundle_object_count .git/objects/pack/pack-${pack##pack	}.pack 3
 '
=20
+test_expect_success 'fetch --pack-version=3D4' '
+	git init pv4 &&
+	(
+		cd pv4 &&
+		git fetch --pack-version=3D4 --keep file://"$D"/.git &&
+		P=3D`ls .git/objects/pack/pack-*.pack` &&
+		# Offset 4 is pack version
+		test-dump ntohl "$P" 4 >ver.actual &&
+		echo 4 >ver.expected &&
+		test_cmp ver.expected ver.actual
+	)
+'
+
 test_done
diff --git a/transport.c b/transport.c
index e15db98..ad5a4f1 100644
--- a/transport.c
+++ b/transport.c
@@ -473,6 +473,9 @@ static int set_git_option(struct git_transport_opti=
ons *opts,
 	} else if (!strcmp(name, TRANS_OPT_KEEP)) {
 		opts->keep =3D !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_PACKV4)) {
+		opts->packv4 =3D !!value;
+		return 0;
 	} else if (!strcmp(name, TRANS_OPT_DEPTH)) {
 		if (!value)
 			opts->depth =3D 0;
@@ -534,6 +537,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 	args.quiet =3D (transport->verbose < 0);
 	args.no_progress =3D !transport->progress;
 	args.depth =3D data->options.depth;
+	args.packv4 =3D data->options.packv4;
 	args.check_self_contained_and_connected =3D
 		data->options.check_self_contained_and_connected;
=20
diff --git a/transport.h b/transport.h
index ea70ea7..59785c0 100644
--- a/transport.h
+++ b/transport.h
@@ -8,6 +8,7 @@ struct git_transport_options {
 	unsigned thin : 1;
 	unsigned keep : 1;
 	unsigned followtags : 1;
+	unsigned packv4 : 1;
 	unsigned check_self_contained_and_connected : 1;
 	unsigned self_contained_and_connected : 1;
 	int depth;
@@ -135,6 +136,10 @@ struct transport *transport_get(struct remote *, c=
onst char *);
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"
=20
+/* Prefer pack version 4 as the transport format */
+#define TRANS_OPT_PACKV4 "packv4"
+
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
--=20
1.8.2.82.gc24b958
