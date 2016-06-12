From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 16/27] upload-pack: add deepen-since to cut shallow repos based on time
Date: Sun, 12 Jun 2016 17:53:58 +0700
Message-ID: <20160612105409.22156-17-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Jun 12 12:56:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC33t-0003mn-Vk
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbcFLK4J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:56:09 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33389 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbcFLK4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:56:05 -0400
Received: by mail-pa0-f68.google.com with SMTP id ts6so1382125pac.0
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7bQwzpBjvV0ISd4vuf6eQq50awZW28ZQs994EY2SAxg=;
        b=YEnblKacGjyjfFO5zvYPMttwZj8nw7v7arrD7dVOna7acP0Zp2eO25BXGj9DpEVmzX
         VxaK/4HW0Dz3TIX9wbo7Pf75VXYhhgzIo17IGzSJ42X/qxHQCymdYdWJAsn6mdUgpQXh
         L1ggFqtZKDIIAeLu7f9Um1sOrNTcGMObbXQOVfmYgjfMWMNx7oxvpb8IGqu5elyDzyVD
         3yXc3HbC4DzKQXfPPLEI9zDkfVxLrCV+mXzCynvW/d43YkJIwwo0LoeBf83RYWQyNd8r
         PEJJ+MSf/oceOPLcOw3PpWi03yuFQ11eqRtxftI1GkdjfP0XM3bfMeOPRm3KZhKdR4mA
         3tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bQwzpBjvV0ISd4vuf6eQq50awZW28ZQs994EY2SAxg=;
        b=SeoLO4qFJ0l12nSNmI3I93+qTgeKhpbf+HEbrVFQIDmwHNTcXXF3UD0W1XHcnDgJGk
         cI9B69XO98bwb21ZhlSg020/JVOgdSnkRA3HgGMT7cxJ1gzBEUNnaKGK8prRSnHsiMt/
         mC4b/Xv8hfM1nw8c0Uf9GMIcXQm7oszfu8kSpgA1umtO08h7zCX9w1phHm7Hbj2lNKSK
         zto+CfUnU+TGIjypUcUMQcoezbwKTFh6/yOXMJXVXVkgzV0EuzK0LYtZceLkQymYUKOZ
         PSaNks0e0tH0OjnmYVzG24l/eXUNUrhTpWHBqow3o7mMwatw8b2s8I/KLG6JvMjj3hWa
         18xw==
X-Gm-Message-State: ALyK8tKAYTGDLVwTFUOB0tya9yiVSTvQA9HK1jNyNHJx7473FCD3zjSRo0QLEsyQwo71mw==
X-Received: by 10.66.62.196 with SMTP id a4mr14470961pas.25.1465728964655;
        Sun, 12 Jun 2016 03:56:04 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id n66sm29806165pfb.38.2016.06.12.03.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:56:03 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:56:00 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297123>

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
index 93c0522..5269461 100644
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
@@ -629,11 +630,25 @@ static void deepen(int depth, const struct object=
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
@@ -670,6 +685,16 @@ static void receive_needs(void)
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
@@ -721,10 +746,26 @@ static void receive_needs(void)
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
@@ -773,7 +814,7 @@ static int send_ref(const char *refname, const stru=
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
