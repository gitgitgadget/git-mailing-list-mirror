From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 14/25] upload-pack: add deepen-since to cut shallow repos based on time
Date: Tue, 23 Feb 2016 20:44:52 +0700
Message-ID: <1456235103-26317-15-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:46:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDIH-0000g5-Lr
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbcBWNqR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:46:17 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33719 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbcBWNqP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:46:15 -0500
Received: by mail-pa0-f48.google.com with SMTP id fl4so110806316pad.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PdjgtXBv2m1BTr43u1/Eu6qKUxz/EgHgR3g0H/Q+9SE=;
        b=pjJQv2TqTeljcJaVuQ3fDl066CSi+V3bLNAr+x+4PXX04HZWS/8fa3X4AtSSFtHAKc
         JaHPZUmMextPeOqSX5ISc1qD1NSgrzVajrSt3uobE83qI+7nKsOZPL2fWkDR55ebUY/g
         EMuVEcLo3Hb8HOBuAiHW1qkEA17dbQ7TaJhJ4Je8gkv9NBzokXQZXnXR/sZukYLGFwBX
         NZzNYHaWCPMRetH+42oCORtjajH/nZE6OyIXN+O5HI8rsHlM36q2DzjJvHHrrJTeZb5K
         jp2Yw/bCaZlQvxwnkyxQjdWZvGBRl1UWVYZCdPWrGPCydgkt1j3GhzjxjHDenwmi6Rlw
         +Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=PdjgtXBv2m1BTr43u1/Eu6qKUxz/EgHgR3g0H/Q+9SE=;
        b=XnvUTzWV/QqydWmVKGdfVl3QUcQnugiVP9f19c+eV9jHPfKr9OiOENhx45wYkk5m9F
         d7jeRJaL+wDoegzwwpFJbqb6Dwmaj64/j2+ixPgnsA47XdepqmBxZ9WhdUHa7bTE2RlO
         W03+xMI71ePu8xWvXAZWbL9jFXcV/2GPH0Uqpo9MwNL08e6qwOQgI9E/N4ff8jOlBdsU
         RFWmJLwGgLgv1ZEfUbHSKsOYW2EYjOIQMfE0iIotzQiU71LeOkK4aCYvLHn4xsTJ2Ju3
         baHOemTvMEFUqMIZgsNDSuHww+RKeRayATuDKgr5y+CHDT4KoRHJg7cjs0QjcTKo1SHC
         ha9A==
X-Gm-Message-State: AG10YOQbG5tt39RvccxpGj0aGkhvvqJ/tjL6mjO6phisfvQhWxht3b7aYNIB99AoHUUu+A==
X-Received: by 10.66.146.196 with SMTP id te4mr46229370pab.125.1456235175229;
        Tue, 23 Feb 2016 05:46:15 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id x12sm44403878pfi.88.2016.02.23.05.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:46:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:46:44 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287063>

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
index c8dafe8..58c0936 100644
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
@@ -612,11 +613,25 @@ static void deepen(int depth, const struct object=
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
@@ -653,6 +668,16 @@ static void receive_needs(void)
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
@@ -704,10 +729,26 @@ static void receive_needs(void)
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
@@ -756,7 +797,7 @@ static int send_ref(const char *refname, const stru=
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
2.7.1.532.gd9e3aaa
