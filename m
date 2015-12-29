From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/20] upload-pack: support define shallow boundary by excluding revisions
Date: Tue, 29 Dec 2015 19:10:39 +0700
Message-ID: <1451391043-28093-17-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:12:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt8j-0007D1-8q
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbbL2MMa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:12:30 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36730 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbbL2MM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:12:28 -0500
Received: by mail-pa0-f41.google.com with SMTP id yy13so31302816pab.3
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VpaFT+YiaPiRVUilI8vb/EvgJY3GZyWL8puEbju0AlU=;
        b=zgYZ1qD6/tRCRRjXmLeYCfOTwCjF6m6d0+Yf5CGi/XQAAKhJVF+ErCI7psNbrbQE0J
         wvXOzBe6htqCKKyZfNlxrNQPzABrX/HoJuH0Oisycz/2Xr0Af9dAyDSmrQ1JXjUGiUPn
         EQMrWkYKyhA6bFtVeTemKB0eXJBP6ZRjKriqKBmzDZpfZ1M6bKqOzBUQKSZ/HK8HhPEU
         qP6fU8IUzkEaCAk4okpQeTKT7v7IxqF1n2l5+QLwKQq/Z4A+b45PNEX/+64C7Q9CM4QS
         r8KXmPyTxtNhe21zjYudf8uh72TunGRwQz62a5pLRYTPYcDig8RzDEjn1HhLVZHoS4yz
         pasA==
X-Received: by 10.67.5.2 with SMTP id ci2mr85482458pad.47.1451391148315;
        Tue, 29 Dec 2015 04:12:28 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id i66sm49385939pfj.28.2015.12.29.04.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:12:27 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:12:23 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283126>

This should allow the user to say "create a shallow clone of this branc=
h
after version <some-tag>".

deepen-not cannot be used with deepen the same way deepen-since cannot
be used with deepen. But deepen-not can be mixed with deepen-since. The
result is exactly how you do the command "git rev-list --since=3D... --=
not
ref".

=46IXME: restrict dwim_ref. Access to reflog at server side may not be =
a
good idea. Either that or force the user to specify full ref names at
client side (a bit annoying).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/pack-protocol.txt         |  3 ++-
 Documentation/technical/protocol-capabilities.txt |  9 +++++++++
 upload-pack.c                                     | 24 +++++++++++++++=
++++++--
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index 9251df1..dee33a6 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -220,7 +220,8 @@ out of what the server said it could do with the fi=
rst 'want' line.
   shallow-line      =3D  PKT-LINE("shallow" SP obj-id)
=20
   depth-request     =3D  PKT-LINE("deepen" SP depth) /
-		       PKT-LINE("deepen-since" SP timestamp)
+		       PKT-LINE("deepen-since" SP timestamp) /
+		       PKT-LINE("deepen-not" SP ref)
=20
   first-want        =3D  PKT-LINE("want" SP obj-id SP capability-list)
   additional-want   =3D  PKT-LINE("want" SP obj-id)
diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
index f08cc4e..0e6b57d 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -188,6 +188,15 @@ specific time, instead of depth. Internally it's e=
quivalent of doing
 "rev-list --max-age=3D<timestamp>" on the server side. "deepen-since"
 cannot be used with "deepen".
=20
+deepen-not
+----------
+
+This capability adds "deepen-not" command to fetch-pack/upload-pack
+protocol so the client can request shallow clones that are cut at a
+specific revision, instead of depth. Internally it's equivalent of
+doing "rev-list --not <rev>" on the server side. "deepen-not"
+cannot be used with "deepen", but can be used with "deepen-since".
+
 no-progress
 -----------
=20
diff --git a/upload-pack.c b/upload-pack.c
index 100b604..90ecb5b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -617,6 +617,7 @@ static void deepen_by_rev_list(int ac, const char *=
*av,
 static void receive_needs(void)
 {
 	struct object_array shallows =3D OBJECT_ARRAY_INIT;
+	struct string_list deepen_not =3D STRING_LIST_INIT_DUP;
 	int depth =3D 0;
 	int has_non_tip =3D 0;
 	unsigned long deepen_since =3D 0;
@@ -667,6 +668,18 @@ static void receive_needs(void)
 			deepen_rev_list =3D 1;
 			continue;
 		}
+		if (skip_prefix(line, "deepen-not ", &arg)) {
+			char *ref =3D NULL;
+			unsigned char sha1[20];
+			if (dwim_ref(arg, strlen(arg), sha1, &ref) !=3D 1)
+				die("Ambiguous deepen-not: %s", line);
+			if (!ref || check_refname_format(ref, 0))
+				die("Invalid deepen-not: %s", line);
+			string_list_append(&deepen_not, ref);
+			free(ref);
+			deepen_rev_list =3D 1;
+			continue;
+		}
 		if (!skip_prefix(line, "want ", &arg) ||
 		    get_sha1_hex(arg, sha1_buf))
 			die("git upload-pack: protocol error, "
@@ -721,7 +734,7 @@ static void receive_needs(void)
 	if (depth =3D=3D 0 && !deepen_rev_list && shallows.nr =3D=3D 0)
 		return;
 	if (depth > 0 && deepen_rev_list)
-		die("--depth and --since cannot be used together");
+		die("--depth and --since (or --not) cannot be used together");
 	if (depth > 0)
 		deepen(depth, &shallows);
 	else if (deepen_rev_list) {
@@ -735,6 +748,13 @@ static void receive_needs(void)
 			struct object *o =3D want_obj.objects[i].item;
 			argv_array_push(&av, oid_to_hex(&o->oid));
 		}
+		if (deepen_not.nr) {
+			argv_array_push(&av, "--not");
+			for (i =3D 0; i < deepen_not.nr; i++) {
+				struct string_list_item *s =3D deepen_not.items + i;
+				argv_array_push(&av, s->string);
+			}
+		}
 		deepen_by_rev_list(av.argc, av.argv, &shallows);
 		argv_array_clear(&av);
 	}
@@ -786,7 +806,7 @@ static int send_ref(const char *refname, const stru=
ct object_id *oid,
 		    int flag, void *cb_data)
 {
 	static const char *capabilities =3D "multi_ack thin-pack side-band"
-		" side-band-64k ofs-delta shallow deepen-since no-progress"
+		" side-band-64k ofs-delta shallow deepen-since deepen-not no-progres=
s"
 		" include-tag multi_ack_detailed";
 	const char *refname_nons =3D strip_namespace(refname);
 	struct object_id peeled;
--=20
2.3.0.rc1.137.g477eb31
