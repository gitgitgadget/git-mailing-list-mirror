From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] clone: allow cloning local paths with colons in them
Date: Sat,  4 May 2013 09:19:33 +0700
Message-ID: <1367633973-26214-1-git-send-email-pclouds@gmail.com>
References: <1367033778-13923-1-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat May 04 04:19:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYS3w-0002ZT-Mr
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 04:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763397Ab3EDCSp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 May 2013 22:18:45 -0400
Received: from mail-da0-f53.google.com ([209.85.210.53]:32946 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759028Ab3EDCSo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 22:18:44 -0400
Received: by mail-da0-f53.google.com with SMTP id o9so1041193dan.40
        for <git@vger.kernel.org>; Fri, 03 May 2013 19:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=tPBKELqD7nL4YJJ9b7B7a61/XWKvqoaz0FBqIbdiS0k=;
        b=DvQ8QF6s9z/WsFajidsb2iVrbcF7BEM5q1AzEb8eZpPudtUFU2k2XrY12WFymSZRaU
         GPFINvXViNe1rdVP2+TuNnrol325NRhdDTUMe9ex0Mg70hHL/PQIligndR0s40iqB8v4
         qZ1UxYQoj8kk/M2XXIgXbmQZJ7aWBn0PV9tS7nlN+dkAQTyAyNoQmjqHX348EuBaeudB
         rByPn6mykNeCD+c80g4o9W4wI2ow4sLATu5dGE8X649KFW1SIEEmLO9TlWwuCcZhqWaa
         /7yvzuJ+6gDPSGqaCZu11LnOTzmAb/DZVNreF505U4FjRf9+YUkDExdj1hMDze20x29c
         6BLA==
X-Received: by 10.68.138.7 with SMTP id qm7mr16716031pbb.169.1367633924008;
        Fri, 03 May 2013 19:18:44 -0700 (PDT)
Received: from lanh ([115.74.38.7])
        by mx.google.com with ESMTPSA id t1sm15105944pab.12.2013.05.03.19.18.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 May 2013 19:18:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 04 May 2013 09:19:34 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367033778-13923-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223350>

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
 Changes from v1: replace strchr with strchrnul.

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
index f57efd0..a0783d4 100644
--- a/connect.c
+++ b/connect.c
@@ -551,8 +551,11 @@ struct child_process *git_connect(int fd[2], const=
 char *url_orig,
 	path =3D strchr(end, c);
 	if (path && !has_dos_drive_prefix(end)) {
 		if (c =3D=3D ':') {
-			protocol =3D PROTO_SSH;
-			*path++ =3D '\0';
+			if (path < strchrnul(host, '/')) {
+				protocol =3D PROTO_SSH;
+				*path++ =3D '\0';
+			} else /* '/' in the host part, assume local path */
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
