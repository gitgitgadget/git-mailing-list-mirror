From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/27] upload-pack: support define shallow boundary by excluding revisions
Date: Fri, 10 Jun 2016 19:27:08 +0700
Message-ID: <20160610122714.3341-22-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:31:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLZG-0001at-FK
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932942AbcFJM3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:29:38 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34502 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932843AbcFJM3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:29:37 -0400
Received: by mail-pa0-f65.google.com with SMTP id ug1so5027710pab.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5fgRalptkJlADrPINZxo3nALXqpfUCc9FqGD4xNtIU=;
        b=SIP6+W10PfI7bVG6xw+46ljSQBhtRM3+l3mDdlPljFcgsikI2J64lxMHufSWjvKm9u
         qN0QL0OTcgChHF+/dfT50Vtx4CfoQbk7fJqjPITGjmLz7ULHHc1fM2iBPT3iZTrynLih
         6Gk4STgbVaGLoQkNbwM1EkwkPkniqTToDjeTjPNwzy4uzSP4YmjMR7LurLCcGswUy5BT
         Zb5qhcXGLT/EblXWu/i+yPWYfREuc7RFGR/nOtHnmfvmmUqHJYJpMVbMrh3VoP2gByS9
         FVzAZ7ab/GAuuVJfezgJ2bd7XNqVK+ruy9E5nD60PtSRivlTUYdfhK0aISAdU1MTmerc
         e65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5fgRalptkJlADrPINZxo3nALXqpfUCc9FqGD4xNtIU=;
        b=eW8GkXzrV/7X7jAWEse5aIRkciRCLxqToDQrk4efCi3D7IJy70K0ZVq/RZkbwErQFl
         BtlxFGqaVPu3JVyqnvZE0SbuHSLSm9pq2Rz6gBkv+YWzcWiaz8HNWm1z+2y5ifJvYvp5
         78bVH31fDOxgqY0vlf2fOj13Li1JUpCO390nbAiN3w9A8ij74TNI/fF71FwXo7gT1VHZ
         gW/8IGGMRC+R2ztu7wMXbZA16gt0xjxSBnEgUTx1MFLyabI4kOcTSMOy3gJZeS+GulJT
         zR9b6a7821zQropJMyObqUVjOcPpyHkJL4hxlbCtqOV9d/Is7CP6br+OBwO8djs8c6Xy
         pkyg==
X-Gm-Message-State: ALyK8tImsEi4q7QNCiFLGyOaB/Avo3Kg7WyzSM9AwepSjcc+XrP8Nzu8HsNMTbHtFZdYbw==
X-Received: by 10.66.182.194 with SMTP id eg2mr1999898pac.159.1465561776147;
        Fri, 10 Jun 2016 05:29:36 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id q127sm17533313pfb.34.2016.06.10.05.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:29:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:29:31 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296993>

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
index b0ddfff..3f40fcb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -643,6 +643,7 @@ static void deepen_by_rev_list(int ac, const char *=
*av,
 static void receive_needs(void)
 {
 	struct object_array shallows =3D OBJECT_ARRAY_INIT;
+	struct string_list deepen_not =3D STRING_LIST_INIT_DUP;
 	int depth =3D 0;
 	int has_non_tip =3D 0;
 	unsigned long deepen_since =3D 0;
@@ -693,6 +694,16 @@ static void receive_needs(void)
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
@@ -747,7 +758,7 @@ static void receive_needs(void)
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
@@ -757,6 +768,14 @@ static void receive_needs(void)
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
@@ -812,7 +831,7 @@ static int send_ref(const char *refname, const stru=
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
