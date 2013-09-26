From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/10] fetch: pack v4 support on smart http
Date: Thu, 26 Sep 2013 09:26:45 +0700
Message-ID: <1380162409-18224-7-git-send-email-pclouds@gmail.com>
References: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 04:27:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP1Ir-0002oj-59
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 04:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab3IZC1h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 22:27:37 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:38628 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab3IZC1g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 22:27:36 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so480742pbb.0
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 19:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gImg9aHTmh5xKLf69w3Y65yLAVUXKVfNN1wotjKWmQw=;
        b=B9IFqNFp4+dCnIUu5F1oYZVY2x20TaPTB717xL6TA8Aaq/slTmshSuFWM04Hif2qfu
         G/x8U2VAeftm7QnOoRptQGZjSz+IzM5Y4bTKAyYC+Nu0MXrtnGVOgl9tWTqlyTsfwiHn
         2eEM7sjccJZihPHttBZ05c+todKfxT6lxRqOUSX4oGM+A1mNs4wtMUD18IrBoz5sdlW3
         PiGyfVO0FAGnuUOw7dNONn7sC+S3o3DF283i9Te7D0kDIeJlEs9m7cjNJDdtxKPW4Jon
         ToJlAaUgpxtSx+zGrZCBe8A11s+8zKLG2qp+mWR2cv/VbXr4//UODkynF8GWpend8mPi
         i/dQ==
X-Received: by 10.66.217.166 with SMTP id oz6mr2632486pac.22.1380162456050;
        Wed, 25 Sep 2013 19:27:36 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id ar1sm50790162pbc.34.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 19:27:35 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 26 Sep 2013 09:27:30 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235393>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-fetch-pack.txt    |  4 ++++
 Documentation/gitremote-helpers.txt |  3 +++
 builtin/fetch-pack.c                |  7 +++++++
 remote-curl.c                       | 14 +++++++++++++-
 t/t5551-http-fetch.sh               |  9 +++++++++
 transport-helper.c                  |  3 +++
 6 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch=
-pack.txt
index 1e71754..b68cd45 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -87,6 +87,10 @@ be in a separate packet, and the list must end with =
a flush packet.
 	'git-upload-pack' treats the special depth 2147483647 as
 	infinite even if there is an ancestor-chain that long.
=20
+--pack-version=3D<n>::
+	Define the preferred pack format version for data transfer.
+	Valid values are 2 and 4. Default is 2.
+
 --no-progress::
 	Do not show the progress.
=20
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitrem=
ote-helpers.txt
index 0827f69..90dfc2e 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -416,6 +416,9 @@ set by Git if the remote helper has the 'option' ca=
pability.
 	must not rely on this option being set before
 	connect request occurs.
=20
+'option packv4 \{'true'|'false'\}::
+	Prefer pack version 4 (true) or 2 (false) for data transfer.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index aba4465..bfe940a 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -100,6 +100,13 @@ int cmd_fetch_pack(int argc, const char **argv, co=
nst char *prefix)
 			pack_lockfile_ptr =3D &pack_lockfile;
 			continue;
 		}
+		if (!prefixcmp(arg, "--pack-version=3D")) {
+			int ver =3D strtol(arg + 15, NULL, 0);
+			if (ver !=3D 2 && ver !=3D 4)
+				die(_("invalid pack version %d"), ver);
+			args.packv4 =3D ver =3D=3D 4;
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
=20
diff --git a/remote-curl.c b/remote-curl.c
index 5b3ce9e..1a3d215 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -18,6 +18,7 @@ struct options {
 	unsigned progress : 1,
 		followtags : 1,
 		dry_run : 1,
+		packv4 : 1,
 		thin : 1;
 };
 static struct options options;
@@ -67,6 +68,15 @@ static int set_option(const char *name, const char *=
value)
 			return -1;
 		return 0;
 	}
+	else if (!strcmp(name, "packv4")) {
+		if (!strcmp(value, "true"))
+			options.packv4 =3D 1;
+		else if (!strcmp(value, "false"))
+			options.packv4 =3D 0;
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
@@ -676,6 +686,8 @@ static int fetch_git(struct discovery *heads,
 		depth_arg =3D strbuf_detach(&buf, NULL);
 		argv[argc++] =3D depth_arg;
 	}
+	if (options.packv4)
+		argv[argc++] =3D "--pack-version=3D4";
 	argv[argc++] =3D url;
 	argv[argc++] =3D NULL;
=20
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 55a866a..5b4e6aa 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -222,5 +222,14 @@ test_expect_success EXPENSIVE 'clone the 50,000 ta=
g repo to check OS command lin
 	)
 '
=20
+test_expect_success 'clone http repository with pack v4' '
+	git -c transfer.unpackLimit=3D1 clone --pack-version=3D4 $HTTPD_URL/s=
mart/repo.git pv4 &&
+	P=3D`ls pv4/.git/objects/pack/pack-*.pack` &&
+	# Offset 4 is pack version
+	test-dump ntohl "$P" 4 >ver.actual &&
+	echo 4 >ver.expected &&
+	test_cmp ver.expected ver.actual
+'
+
 stop_httpd
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 63cabc3..07fbf6e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -350,6 +350,9 @@ static int fetch_with_fetch(struct transport *trans=
port,
=20
 	standard_options(transport);
=20
+	set_helper_option(transport, "packv4",
+			  data->transport_options.packv4 ? "true" : "false");
+
 	for (i =3D 0; i < nr_heads; i++) {
 		const struct ref *posn =3D to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
--=20
1.8.2.82.gc24b958
