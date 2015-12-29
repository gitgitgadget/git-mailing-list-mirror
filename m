From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/20] upload-pack: add deepen-since to cut shallow repos based on time
Date: Tue, 29 Dec 2015 19:10:32 +0700
Message-ID: <1451391043-28093-10-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:11:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt85-0006cX-Nv
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbbL2MLv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:11:51 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32916 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbbL2MLt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:11:49 -0500
Received: by mail-pa0-f53.google.com with SMTP id cy9so123708655pac.0
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6NcgE/ngRL2yRg+6hNpUzxLB+38CKwpPzrL+Mhcw128=;
        b=bsvLIT8CZuIPWE8q1R0jdO7TAaG34oMfxoFW8lCIZIUHOaGRNyHH41Jp1CzbjL8HdN
         QMBnvlzWmMSVbvGWvWRqbJyLRQaDgUv3N+fDpEsXurEhQnBpQ5lqZoUTLqTWHC75RdYr
         U36nl0iLKn5DUjFYGsiV+iMK30YNnTyqK/T8A7WtPK00P+qC5cJvgFpyje7QsCrv2l95
         f9lY+emrKiL+KkxM1MZick5r+ze9QtyAFz01H3H5JXeNdEFDmOTzBYsTjh6IbCNqMyG8
         uCyIE2kcEkvxArs+xywY00EriyvYgWL+y/5EYMUJ0GCMb8iZ10KOab/g4WTPCkNfd2Iz
         qnWg==
X-Received: by 10.66.216.200 with SMTP id os8mr86125822pac.143.1451391108538;
        Tue, 29 Dec 2015 04:11:48 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id fc6sm87892451pac.44.2015.12.29.04.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:11:47 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:11:43 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283119>

This should allow the user to say "create a shallow clone containing th=
e
work from last year" (once the client side is fixed up, of course).

In theory deepen-since and deepen (aka --depth) can be used together to
draw the shallow boundary (whether it's intersection or union is up to
discussion, but if rev-list is used, it's likely intersection). However=
,
because deepen goes with a custom commit walker, we can't mix the two
yet.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/pack-protocol.txt         |  3 ++-
 Documentation/technical/protocol-capabilities.txt |  9 +++++++
 upload-pack.c                                     | 33 +++++++++++++++=
++++++--
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index c6977bb..9251df1 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -219,7 +219,8 @@ out of what the server said it could do with the fi=
rst 'want' line.
=20
   shallow-line      =3D  PKT-LINE("shallow" SP obj-id)
=20
-  depth-request     =3D  PKT-LINE("deepen" SP depth)
+  depth-request     =3D  PKT-LINE("deepen" SP depth) /
+		       PKT-LINE("deepen-since" SP timestamp)
=20
   first-want        =3D  PKT-LINE("want" SP obj-id SP capability-list)
   additional-want   =3D  PKT-LINE("want" SP obj-id)
diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
index eaab6b4..f08cc4e 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -179,6 +179,15 @@ This capability adds "deepen", "shallow" and "unsh=
allow" commands to
 the  fetch-pack/upload-pack protocol so clients can request shallow
 clones.
=20
+deepen-since
+------------
+
+This capability adds "deepen-since" command to fetch-pack/upload-pack
+protocol so the client can request shallow clones that are cut at a
+specific time, instead of depth. Internally it's equivalent of doing
+"rev-list --max-age=3D<timestamp>" on the server side. "deepen-since"
+cannot be used with "deepen".
+
 no-progress
 -----------
=20
diff --git a/upload-pack.c b/upload-pack.c
index 573ffa2..100b604 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -14,6 +14,7 @@
 #include "sigchain.h"
 #include "version.h"
 #include "string-list.h"
+#include "argv-array.h"
=20
 static const char upload_pack_usage[] =3D "git upload-pack [--strict] =
[--timeout=3D<n>] <dir>";
=20
@@ -618,6 +619,8 @@ static void receive_needs(void)
 	struct object_array shallows =3D OBJECT_ARRAY_INIT;
 	int depth =3D 0;
 	int has_non_tip =3D 0;
+	unsigned long deepen_since =3D 0;
+	int deepen_rev_list =3D 0;
=20
 	shallow_nr =3D 0;
 	for (;;) {
@@ -654,6 +657,16 @@ static void receive_needs(void)
 				die("Invalid deepen: %s", line);
 			continue;
 		}
+		if (skip_prefix(line, "deepen-since ", &arg)) {
+			char *end =3D NULL;
+			deepen_since =3D strtoul(arg, &end, 0);
+			if (!end || *end || !deepen_since ||
+			    /* revisions.c's max_age -1 is special */
+			    deepen_since =3D=3D -1)
+				die("Invalid deepen-since: %s", line);
+			deepen_rev_list =3D 1;
+			continue;
+		}
 		if (!skip_prefix(line, "want ", &arg) ||
 		    get_sha1_hex(arg, sha1_buf))
 			die("git upload-pack: protocol error, "
@@ -705,10 +718,26 @@ static void receive_needs(void)
 	if (!use_sideband && daemon_mode)
 		no_progress =3D 1;
=20
-	if (depth =3D=3D 0 && shallows.nr =3D=3D 0)
+	if (depth =3D=3D 0 && !deepen_rev_list && shallows.nr =3D=3D 0)
 		return;
+	if (depth > 0 && deepen_rev_list)
+		die("--depth and --since cannot be used together");
 	if (depth > 0)
 		deepen(depth, &shallows);
+	else if (deepen_rev_list) {
+		struct argv_array av =3D ARGV_ARRAY_INIT;
+		int i;
+
+		argv_array_push(&av, "rev-list");
+		if (deepen_since)
+			argv_array_pushf(&av, "--max-age=3D%lu", deepen_since);
+		for (i =3D 0; i < want_obj.nr; i++) {
+			struct object *o =3D want_obj.objects[i].item;
+			argv_array_push(&av, oid_to_hex(&o->oid));
+		}
+		deepen_by_rev_list(av.argc, av.argv, &shallows);
+		argv_array_clear(&av);
+	}
 	else
 		if (shallows.nr > 0) {
 			int i;
@@ -757,7 +786,7 @@ static int send_ref(const char *refname, const stru=
ct object_id *oid,
 		    int flag, void *cb_data)
 {
 	static const char *capabilities =3D "multi_ack thin-pack side-band"
-		" side-band-64k ofs-delta shallow no-progress"
+		" side-band-64k ofs-delta shallow deepen-since no-progress"
 		" include-tag multi_ack_detailed";
 	const char *refname_nons =3D strip_namespace(refname);
 	struct object_id peeled;
--=20
2.3.0.rc1.137.g477eb31
