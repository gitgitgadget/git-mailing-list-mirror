From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] clone: allow cloning local paths with colons in them
Date: Sat, 27 Apr 2013 10:36:18 +0700
Message-ID: <1367033778-13923-1-git-send-email-pclouds@gmail.com>
References: <20130422153516.GB11886@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Niedier <jrnieder@gmail.com>,
	William Giokas <1007380@gmail.com>, fsckdaemon@gmail.com,
	Daniel Barkalow <barkalow@iabervon.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 05:35:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVvvM-0002ul-Pw
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 05:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381Ab3D0Dfk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Apr 2013 23:35:40 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:41528 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757340Ab3D0Dfj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 23:35:39 -0400
Received: by mail-pd0-f180.google.com with SMTP id u10so2763711pdi.39
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 20:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=1y+dAKNHo0kQKb261h+RPK8MVyD43WP8zI5h4KwQreM=;
        b=G8KzNfoTZVmUJF+QeaQY/Ta6aIPvABLywdKbOT7wUH+tTlThSpj1lWwbFcK919ve8W
         w2hZ43oqDutyB5QmoTvXWhiJZqygdkY8fKu0j1vYfMV6lnjKvSsQfJ4qrPKoUcsHuEGb
         yH4CPD7mscPya1xvzMurFgiSaO4UejZX5FLPWXGR2sG3JlPzeJwJUCGL6oc0ZzWziLk7
         QN59NIVpm/Yv6jpJCht6e0xrdiQTgnAN587sjD4lnsPMfqFmw+YSWkwAokQgAUhaleZ2
         Y5F96RpLupFBN2d7E64oIxRv7nwCEb7TxXN7HL67mqlP6Vj8B5zl7kVy3ZPJ8JdBEXkj
         5vIA==
X-Received: by 10.66.233.167 with SMTP id tx7mr33637597pac.110.1367033739097;
        Fri, 26 Apr 2013 20:35:39 -0700 (PDT)
Received: from lanh ([115.74.40.61])
        by mx.google.com with ESMTPSA id to7sm15335453pab.0.2013.04.26.20.35.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 20:35:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Apr 2013 10:36:24 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <20130422153516.GB11886@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222619>

Usually "foo:bar" is interpreted as an ssh url. This patch allows to
clone from such paths by putting at least one slash before the colon
(i.e. /path/to/foo:bar or just ./foo:bar).

file://foo:bar should also work, but local optimizations are off in
that case, which may be unwanted. While at there, warn the users about
--local being ignored in this case.

Reported-by: William Giokas <1007380@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Mon, Apr 22, 2013 at 10:35 PM, Jeff King <peff@peff.net> wrote:
 > So I think one reasonable path would be:
 >
 > =C2=A0 1. Do not treat "host:path" as ssh if "host" has a slash, whi=
ch should
 > =C2=A0 =C2=A0 =C2=A0not regress anybody. It does not allow unadorned=
 relative paths
 > =C2=A0 =C2=A0 =C2=A0with colons, but it lets you use absolute paths =
or "./" to
 > =C2=A0 =C2=A0 =C2=A0disambiguate.
 >
 > =C2=A0 2. Teach git-clone to ask the transport code to parse the sou=
rce repo
 > =C2=A0 =C2=A0 =C2=A0spec, and decide from that whether it is local o=
r not. That would
 > =C2=A0 =C2=A0 =C2=A0harmonize the implementations and avoid errors w=
hen you _did_ mean
 > =C2=A0 =C2=A0 =C2=A0to use ssh, but "host:path" happens to exist in =
your filesystem. I
 > =C2=A0 =C2=A0 =C2=A0also would not be surprised if there are problem=
s with
 > =C2=A0 =C2=A0 =C2=A0URL-encoding, but maybe clone handles that prope=
rly (I didn't
 > =C2=A0 =C2=A0 =C2=A0check).
 >
 > And the "host contains slash" rule is pretty easy to explain in the
 > documentation, which is good.

 I totally agree with this. But doing #2 seems to require a bit of
 code reorganization. How about just this for now?

 Documentation/urls.txt | 6 ++++++
 builtin/clone.c        | 2 ++
 connect.c              | 7 +++++--
 t/t5601-clone.sh       | 5 +++++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 3ca122f..476e338 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -23,6 +23,12 @@ An alternative scp-like syntax may also be used with=
 the ssh protocol:
=20
 - {startsb}user@{endsb}host.xz:path/to/repo.git/
=20
+This syntax is only recognized if there are no slashes before the
+first colon. This helps differentiate a local path that contains a
+colon. For example the local path `foo:bar` could be specified as an
+absolute path or `./foo:bar` to avoid being misinterpreted as an ssh
+url.
+
 The ssh and git protocols additionally support ~username expansion:
=20
 - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/~{startsb}us=
er{endsb}/path/to/repo.git/
diff --git a/builtin/clone.c b/builtin/clone.c
index 58fee98..e13da4d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -783,6 +783,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	is_local =3D option_local !=3D 0 && path && !is_bundle;
 	if (is_local && option_depth)
 		warning(_("--depth is ignored in local clones; use file:// instead."=
));
+	if (option_local > 0 && !is_local)
+		warning(_("--local is ignored"));
=20
 	if (argc =3D=3D 2)
 		dir =3D xstrdup(argv[1]);
diff --git a/connect.c b/connect.c
index f57efd0..b568f10 100644
--- a/connect.c
+++ b/connect.c
@@ -551,8 +551,11 @@ struct child_process *git_connect(int fd[2], const=
 char *url_orig,
 	path =3D strchr(end, c);
 	if (path && !has_dos_drive_prefix(end)) {
 		if (c =3D=3D ':') {
-			protocol =3D PROTO_SSH;
-			*path++ =3D '\0';
+			if (!strchr(url, '/') || strchr(url, '/') >=3D path) {
+				protocol =3D PROTO_SSH;
+				*path++ =3D '\0';
+			} else
+				path =3D end;
 		}
 	} else
 		path =3D end;
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 67869b4..0629149 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -280,4 +280,9 @@ test_expect_success 'clone checking out a tag' '
 	test_cmp fetch.expected fetch.actual
 '
=20
+test_expect_success NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar' '
+	cp -R src "foo:bar" &&
+	git clone "./foo:bar" foobar
+'
+
 test_done
--=20
1.8.2.83.gc99314b
