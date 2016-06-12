From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 21/27] upload-pack: support define shallow boundary by excluding revisions
Date: Sun, 12 Jun 2016 17:54:03 +0700
Message-ID: <20160612105409.22156-22-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:56:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC34E-00040O-T9
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbcFLK4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:56:30 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35593 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbcFLK43 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:56:29 -0400
Received: by mail-pa0-f67.google.com with SMTP id hf6so606502pac.2
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fthrIHDBxH0ByS44WvR5IS7YxqhCHSWaGJOL0/dNV4g=;
        b=pduVfY2SAuATt0W5W8RLubhq3qrGebPSK0/no5je3PwC9h0opzwx/Zm0P9iaJy8xag
         GDId41vtYLPw5/bPB0TCzQWWeG73TH43S9Jpe7ZtgFxIsQgu6sNqkniwjwtbM/4yPcIE
         aMST+ub6ORNfqXf2EupR+6A9uUVmQT7IHVVT9LV1ubAtVUBqHpGV1AjybbutNwplUWrP
         LKBhwrjfy1Ao4kCnNkQSU2oKmA7/UlXUMpRKx89Hup8I33wyG8QfQTpwhQypUaWs9WqO
         44XHdIehFSozgViqoeAC/Bk6uSeubmcoyVJPd6Tq1D2MJUYg9dSxO2RhUY18sDlbQPnj
         +toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fthrIHDBxH0ByS44WvR5IS7YxqhCHSWaGJOL0/dNV4g=;
        b=IELbPpQWWaYrBUI3uW5D0Z+MDciiQMAP5PIyrR35hCSdtnCU+7urMac1qKmlIvtvat
         gyZUkEyrMLXmY00d8kYNVDnxCybz4cp/XSvTEwemcXe2HQCcZkg+2XSWDJ9lfzgXIiEH
         Xk4VtRo41aw2Yjvwwo9o7NyLcp/KrK31OMzNSQTeTSDMzfJhreYJL9SgoTC3YKazInHC
         0Lu1fRjiY/ZQ0Y9vVh/ppjh7872eM6SC/8FiuvryngRJSXwopHjA1nW1kLLEUQa82+jt
         NOB0r3QprSRAEpkXms32Q4ytgcyWXbzq6j6VXzKVah0DpSHGlVjrLPkLSrcaMt2DHpQH
         4TlA==
X-Gm-Message-State: ALyK8tLNrqekWVQVPIb0nh66+ojc3wSYHxYmoaCtFlQogvwHeKx9LQW+LibyM7tbcDPI/g==
X-Received: by 10.66.25.231 with SMTP id f7mr14659804pag.65.1465728988893;
        Sun, 12 Jun 2016 03:56:28 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id g86sm29761135pfd.67.2016.06.12.03.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:56:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:56:24 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297129>

This should allow the user to say "create a shallow clone of this branc=
h
after version <some-tag>".

Short refs are accepted and expanded at the server side with expand_ref=
()
because we cannot expand (unknown) refs from the client side.

Like deepen-since, deepen-not cannot be used with deepen. But deepen-no=
t
can be mixed with deepen-since. The result is exactly how you do the
command "git rev-list --since=3D... --not ref".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/pack-protocol.txt         |  3 ++-
 Documentation/technical/protocol-capabilities.txt |  9 +++++++++
 upload-pack.c                                     | 23 +++++++++++++++=
++++++--
 3 files changed, 32 insertions(+), 3 deletions(-)

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
index 5269461..acc6d97 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -645,6 +645,7 @@ static void deepen_by_rev_list(int ac, const char *=
*av,
 static void receive_needs(void)
 {
 	struct object_array shallows =3D OBJECT_ARRAY_INIT;
+	struct string_list deepen_not =3D STRING_LIST_INIT_DUP;
 	int depth =3D 0;
 	int has_non_tip =3D 0;
 	unsigned long deepen_since =3D 0;
@@ -695,6 +696,16 @@ static void receive_needs(void)
 			deepen_rev_list =3D 1;
 			continue;
 		}
+		if (skip_prefix(line, "deepen-not ", &arg)) {
+			char *ref =3D NULL;
+			unsigned char sha1[20];
+			if (expand_ref(arg, strlen(arg), sha1, &ref) !=3D 1)
+				die("git upload-pack: ambiguous deepen-not: %s", line);
+			string_list_append(&deepen_not, ref);
+			free(ref);
+			deepen_rev_list =3D 1;
+			continue;
+		}
 		if (!skip_prefix(line, "want ", &arg) ||
 		    get_sha1_hex(arg, sha1_buf))
 			die("git upload-pack: protocol error, "
@@ -749,7 +760,7 @@ static void receive_needs(void)
 	if (depth =3D=3D 0 && !deepen_rev_list && shallows.nr =3D=3D 0)
 		return;
 	if (depth > 0 && deepen_rev_list)
-		die("git upload-pack: deepen and deepen-since cannot be used togethe=
r");
+		die("git upload-pack: deepen and deepen-since (or deepen-not) cannot=
 be used together");
 	if (depth > 0)
 		deepen(depth, &shallows);
 	else if (deepen_rev_list) {
@@ -759,6 +770,14 @@ static void receive_needs(void)
 		argv_array_push(&av, "rev-list");
 		if (deepen_since)
 			argv_array_pushf(&av, "--max-age=3D%lu", deepen_since);
+		if (deepen_not.nr) {
+			argv_array_push(&av, "--not");
+			for (i =3D 0; i < deepen_not.nr; i++) {
+				struct string_list_item *s =3D deepen_not.items + i;
+				argv_array_push(&av, s->string);
+			}
+			argv_array_push(&av, "--not");
+		}
 		for (i =3D 0; i < want_obj.nr; i++) {
 			struct object *o =3D want_obj.objects[i].item;
 			argv_array_push(&av, oid_to_hex(&o->oid));
@@ -814,7 +833,7 @@ static int send_ref(const char *refname, const stru=
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
2.8.2.524.g6ff3d78
