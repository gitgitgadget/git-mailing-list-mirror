From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 20/25] upload-pack: support define shallow boundary by excluding revisions
Date: Thu,  4 Feb 2016 16:03:56 +0700
Message-ID: <1454576641-29615-21-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:06:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFrw-0007ih-4Q
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965480AbcBDJGW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:06:22 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36751 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965484AbcBDJGK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:06:10 -0500
Received: by mail-pf0-f170.google.com with SMTP id n128so38189054pfn.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pquWizpoiRUfyzlIS5taqFENr4xUf4toAnPEboifJpE=;
        b=d/OSXA9jmab9sC5QcXEWAzcvPCQ+dwDgwZqVZxUnCgYZdpmFQ/DwdqUG2es2gh5HWI
         iv9hqUibt41FIW2bveu+9jKwLwuzn14EGcMW4DaKjLM/KhZQLole37KkQ3yPNUinkyOk
         YV95R80SYTfb1wX5Kgul/9ir5ohQtkC+op9jnhxfgzZUJ1vfHsJgUKNsX9H7NG54wB/7
         TpjPT1RoNbWl6PgGdL/6XgLhnZnYwd6QVpGRWNQmyd1aQ4SvRvCp/sMiHTJM8+xQvpF6
         DdyomC6er96Y/ProIhEsc+zaj8EjPg3o54k1jFQEwiz5rs+9kZDYrb+dgTbpZ6IeAsku
         ZZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=pquWizpoiRUfyzlIS5taqFENr4xUf4toAnPEboifJpE=;
        b=jJWLrPhfzaCDggQhkkNuTYrpT+Vy2ceOwGbOWELEK+AwjfK6bvytbeNWbdSS6sjTd0
         0An8BsEvJXpRsCoGx4RUo+9HYd9RT3r3PDVDcxYOQvFlRRRYzXlVUhg9vewFm9rPLIUe
         UHfolxawBFwaHy6OSfGRnlVC2wdA4O0/+jVYBIkETCChSVP9TUtf1CuRR9LjXH5y/BXj
         8NnUJkh8qoaYo75QLOUG3fJYzLf+KDVPM5P2qUazg1BG4OSeb/oxwUXOkfoXtBC/dEG5
         IvcjrgLlZsfjJ0vkfRCW/GFg4irb+MYUD3nj71lXw8YWjJX7WVANSr2NXzixINQr848d
         cQ9A==
X-Gm-Message-State: AG10YOSmEC+H9smWezcp3DEbT4N8oj+t+wez63orOwN1xOFAqLVE1wp8hKBacQPZoCohmA==
X-Received: by 10.98.18.215 with SMTP id 84mr9365882pfs.131.1454576769609;
        Thu, 04 Feb 2016 01:06:09 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id n84sm15391336pfa.45.2016.02.04.01.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:06:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:06:22 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285433>

This should allow the user to say "create a shallow clone of this branc=
h
after version <some-tag>".

deepen-not cannot be used with deepen the same way deepen-since cannot
be used with deepen. But deepen-not can be mixed with deepen-since. The
result is exactly how you do the command "git rev-list --since=3D... --=
not
ref".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/pack-protocol.txt         |  3 ++-
 Documentation/technical/protocol-capabilities.txt |  9 +++++++++
 upload-pack.c                                     | 22 +++++++++++++++=
+++++--
 3 files changed, 31 insertions(+), 3 deletions(-)

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
index 794736c..a72ffc2 100644
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
+				die("Ambiguous deepen-not: %s", line);
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
-		die("--depth and --shallow-since cannot be used together");
+		die("--depth and --shallow-since (or --shallow-exclude) cannot be us=
ed together");
 	if (depth > 0)
 		deepen(depth, &shallows);
 	else if (deepen_rev_list) {
@@ -746,6 +757,13 @@ static void receive_needs(void)
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
@@ -797,7 +815,7 @@ static int send_ref(const char *refname, const stru=
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
2.7.0.377.g4cd97dd
