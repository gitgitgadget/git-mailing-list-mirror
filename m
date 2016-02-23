From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 19/25] upload-pack: support define shallow boundary by excluding revisions
Date: Tue, 23 Feb 2016 20:44:57 +0700
Message-ID: <1456235103-26317-20-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:46:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDIh-0000xz-Q1
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbcBWNqu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:46:50 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34022 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbcBWNqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:46:48 -0500
Received: by mail-pf0-f174.google.com with SMTP id x65so112641169pfb.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BlWCIT0QJbnBjQpY6CLwkFGIYxf8/sOMNs6mEueflGI=;
        b=m/eoHywMIDApU4NbDl/hqW4N1I0HzVh1gVmzG7Br/u2j4Q/4ftIuP6+XMxZSIPCaux
         zJLejOFtI4RWPOnYOkGIq1WVHTsqJy6EvaSkYlFEZRf9XHbXtB4kuTenX2yVzs5eM1QY
         bbaZre+3to8CTwI/TuMSKfTLaJDzNHphXYOjjA6OYcmTSScUtuKx3A3DBuiTnPX7JWU0
         3y342heCtBacIr+kJF9w5kLrbq7ZlOsoPoz+eWwk65vc8lsX6WUvELjWwgbsU7yK2ZDk
         L0NdtKgL1KXVJ0oyCun0Ec3NIwTdcWOlwn5orDGZaHlmyM6taNehmv1WDq/fwDKTzlVU
         nJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=BlWCIT0QJbnBjQpY6CLwkFGIYxf8/sOMNs6mEueflGI=;
        b=Op9jRf3zUWquz+Mv0hdkwetjj0Os6hiihES6xJk20/2Utcf1M10tz2dvbw72aaTB4G
         Si19YxrJ5eJZQOSWozBRmWbs39LWTGB8fen2XfgvTXGhDYhfyFK+JxfQaFvium/B0XSu
         VrpdLgAxh7/qxeSMbaAo9hKE1PouiXgUVXU0zuwIrGF70UQ+ENiXKgnxU5vFN+lE+aAK
         Uspjvo+XAOEJVx1sCDkVJKP6hMs92tLiWzsX5ONkLDesaQaSvA6nwjEzi1jnRgiysnbs
         O8PtMf2S/5xgPOl+J0PLCAjzavLalnEOfLc+M+bTzPiSWsyxK80+7qrx5Oo3v2wOllxA
         OiHQ==
X-Gm-Message-State: AG10YOQiWrjboUrniQeBudKHfFKAbsMOEUxUqBxUaHFMMgOUjvm3Rizu4T9qazxk0+BSbg==
X-Received: by 10.98.16.85 with SMTP id y82mr45845721pfi.90.1456235207669;
        Tue, 23 Feb 2016 05:46:47 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id v75sm44477267pfa.39.2016.02.23.05.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:46:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:47:16 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287067>

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
index 58c0936..95a0bfb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -628,6 +628,7 @@ static void deepen_by_rev_list(int ac, const char *=
*av,
 static void receive_needs(void)
 {
 	struct object_array shallows =3D OBJECT_ARRAY_INIT;
+	struct string_list deepen_not =3D STRING_LIST_INIT_DUP;
 	int depth =3D 0;
 	int has_non_tip =3D 0;
 	unsigned long deepen_since =3D 0;
@@ -678,6 +679,16 @@ static void receive_needs(void)
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
@@ -732,7 +743,7 @@ static void receive_needs(void)
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
@@ -742,6 +753,14 @@ static void receive_needs(void)
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
@@ -797,7 +816,7 @@ static int send_ref(const char *refname, const stru=
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
2.7.1.532.gd9e3aaa
