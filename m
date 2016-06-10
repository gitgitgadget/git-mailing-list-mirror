From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/27] upload-pack: add deepen-since to cut shallow repos based on time
Date: Fri, 10 Jun 2016 19:27:03 +0700
Message-ID: <20160610122714.3341-17-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:30:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLYv-0001Kh-Sb
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbcFJM3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:29:10 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34232 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932843AbcFJM3J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:29:09 -0400
Received: by mail-pf0-f195.google.com with SMTP id 66so3245825pfy.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hdqbmvu4jldrRchV7GTOt45H6ClG1rB8WYk4bDspYeU=;
        b=gMdi2Z8u7mqOX+58+Ny6gMLazV830z2ohM9bAd5WuaEffmN+N2hWYOo4wOdKK6KfHy
         /ta7n+wbQmgziDLVkoVzO3ZiN3/RqsKVy/PPy+DE3RARwU8Vn53fFRUe3z5jKN+IDZiR
         IH7Aqr/yA+TEoTOvAxtndTlQC0RC3pQtlYYI6kGpvUWqU7kpCSwIMHcBzfmaYhzxqZAS
         osBhjjC2kDROiotEd+Cqr4KetI7GlghCjOmt1GN8D2hwlvGmYmKf7Yruq2dS9ZRj8dTT
         AUcZZwx6/OEHiEOG5LKl0h9VS0tI2htjoavkDcw7NTYY27YRYicxtkT3VZ49CKat5G48
         xKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hdqbmvu4jldrRchV7GTOt45H6ClG1rB8WYk4bDspYeU=;
        b=S0IwBcsN/uRHxT2EWmZTVjHxpaOt977LkeUNo5reEtXPs1XrYDOB++JBZ6xC6VPPw2
         xF5EHGqaHTFKL+gGyc8LtW99+oyx0FsqCAxgjLjHo5FG7rKUo5y0ARZroNsBt023YBd9
         8zlPlTAZDRcpEN7KWLW5Jfb6gBM690wi+nxZ0orr04OPnJuyVRi/+NuRwAqIykqz1BjY
         xp9DEG1lO8/bWSsnGlucVYhAqVUwFq2F+guE3RG8+hOjsu2zYNhqDWeCE93JvOzs1f4v
         Zzr4tCPAxKzosXsasYQ6sFraWOUGHZMdNh8tIpmjjsaFUr3AZbSlxrwUsvlX68eQDLJk
         7+PQ==
X-Gm-Message-State: ALyK8tLJpzQJ/TwB0Zvy2jXRp7jwKr+IQ/4J2mcrfLKR9oyZAaMjW1lEUOIhCCHE5GsbMg==
X-Received: by 10.98.86.72 with SMTP id k69mr2108656pfb.166.1465561748597;
        Fri, 10 Jun 2016 05:29:08 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id j65sm17511904pfj.44.2016.06.10.05.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:29:07 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:29:03 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296988>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/pack-protocol.txt         |  3 +-
 Documentation/technical/protocol-capabilities.txt |  9 +++++
 upload-pack.c                                     | 45 +++++++++++++++=
+++++++-
 3 files changed, 54 insertions(+), 3 deletions(-)

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
index b6f3756..b0ddfff 100644
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
@@ -627,11 +628,25 @@ static void deepen(int depth, const struct object=
_array *shallows)
 	packet_flush(1);
 }
=20
+static void deepen_by_rev_list(int ac, const char **av,
+			       struct object_array *shallows)
+{
+	struct commit_list *result;
+
+	result =3D get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALL=
OW);
+	send_shallow(result);
+	free_commit_list(result);
+	send_unshallow(shallows);
+	packet_flush(1);
+}
+
 static void receive_needs(void)
 {
 	struct object_array shallows =3D OBJECT_ARRAY_INIT;
 	int depth =3D 0;
 	int has_non_tip =3D 0;
+	unsigned long deepen_since =3D 0;
+	int deepen_rev_list =3D 0;
=20
 	shallow_nr =3D 0;
 	for (;;) {
@@ -668,6 +683,16 @@ static void receive_needs(void)
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
@@ -719,10 +744,26 @@ static void receive_needs(void)
 	if (!use_sideband && daemon_mode)
 		no_progress =3D 1;
=20
-	if (depth =3D=3D 0 && shallows.nr =3D=3D 0)
+	if (depth =3D=3D 0 && !deepen_rev_list && shallows.nr =3D=3D 0)
 		return;
+	if (depth > 0 && deepen_rev_list)
+		die("git upload-pack: deepen and deepen-since cannot be used togethe=
r");
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
@@ -771,7 +812,7 @@ static int send_ref(const char *refname, const stru=
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
2.8.2.524.g6ff3d78
