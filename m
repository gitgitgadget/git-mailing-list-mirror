From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 6/8] builtin-fetch: add --prune option
Date: Tue, 10 Nov 2009 09:15:47 +0100
Message-ID: <4AF92133.6070005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 09:15:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7ltM-0007pD-Iw
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 09:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbZKJIPp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 03:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbZKJIPp
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 03:15:45 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:52759 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbZKJIPo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 03:15:44 -0500
Received: by ewy3 with SMTP id 3so3974180ewy.37
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 00:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=Ld18yRHWj0sAfRiF/fOeL2AT5dgH7MU1be/lm2BJUjM=;
        b=ABcenvsXAykxo7P5kNzylUeZnH9DhKKhjoc72Q7JEjytqZKbUNnpL2FH78m+LUCo3k
         fV40nbC2h4mYFTqJzK+Qmrt/KRGbJ0vpiAKhbzChqjGtTui4fg4vCsPX7aL17c9MUKA4
         zxQRIplLjFFe8FbPc5JbohuBNSd6H6k1zKf5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=TAnMJ0sP91MQzsakpUZr8UPp5dcVkMFBuqqRkydTio22c0138oryd4zi3Ffdgdeopf
         pS/qS85NUUyyDjyZA8XWOXn7GmGRxA5uEAdL4naahxMxnUMFLrtlYC51F9YLBJLKWzKT
         JJCVF+SLfrtEbz+Yap51jwz+U4+DMTrVhoAyE=
Received: by 10.213.24.20 with SMTP id t20mr4574238ebb.49.1257840949004;
        Tue, 10 Nov 2009 00:15:49 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 23sm1156794eya.44.2009.11.10.00.15.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 00:15:48 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132546>

=46rom: Jay Soffian <jaysoffian@gmail.com>

Teach fetch to cull stale remote tracking branches after fetching via -=
-prune.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/fetch-options.txt |    4 ++++
 builtin-fetch.c                 |   32 ++++++++++++++++++++++++++++++-=
-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 8b0cf58..500637a 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -28,6 +28,10 @@ ifndef::git-pull[]
 --multiple::
 	Allow several <repository> and <group> arguments to be
 	specified. No <refspec>s may be specified.
+
+--prune::
+	After fetching, remove any remote tracking branches which
+	no longer exist	on the remote.
 endif::git-pull[]
=20
 ifdef::git-pull[]
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 945dfd8..fd31072 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -26,7 +26,7 @@ enum {
 	TAGS_SET =3D 2
 };
=20
-static int all, append, force, keep, multiple, update_head_ok, verbosi=
ty;
+static int all, append, force, keep, multiple, prune, update_head_ok, =
verbosity;
 static int tags =3D TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -49,6 +49,8 @@ static struct option builtin_fetch_options[] =3D {
 		    "fetch all tags and associated objects", TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
+	OPT_BOOLEAN('p', "prune", &prune,
+		    "prune tracking branches no longer on remote"),
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
 	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
 		    "allow updating of HEAD ref"),
@@ -492,6 +494,28 @@ static int fetch_refs(struct transport *transport,=
 struct ref *ref_map)
 	return ret;
 }
=20
+static int prune_refs(struct transport *transport, struct ref *ref_map=
)
+{
+	int result =3D 0;
+	struct ref *ref, *stale_refs =3D get_stale_heads(transport->remote, r=
ef_map);
+	const char *dangling_msg =3D dry_run
+		? "   (%s will become dangling)\n"
+		: "   (%s has become dangling)\n";
+
+	for (ref =3D stale_refs; ref; ref =3D ref->next) {
+		if (!dry_run)
+			result |=3D delete_ref(ref->name, NULL, 0);
+		if (verbosity >=3D 0) {
+			fprintf(stderr, " x %-*s %-*s -> %s\n",
+				SUMMARY_WIDTH, "[deleted]",
+				REFCOL_WIDTH, "(none)", prettify_refname(ref->name));
+			warn_dangling_symref(stderr, dangling_msg, ref->name);
+		}
+	}
+	free_refs(stale_refs);
+	return result;
+}
+
 static int add_existing(const char *refname, const unsigned char *sha1=
,
 			int flag, void *cbdata)
 {
@@ -657,6 +681,8 @@ static int do_fetch(struct transport *transport,
 		free_refs(ref_map);
 		return 1;
 	}
+	if (prune)
+		prune_refs(transport, ref_map);
 	free_refs(ref_map);
=20
 	/* if neither --no-tags nor --tags was specified, do automated tag
@@ -740,9 +766,11 @@ static int add_remote_or_group(const char *name, s=
truct string_list *list)
 static int fetch_multiple(struct string_list *list)
 {
 	int i, result =3D 0;
-	const char *argv[] =3D { "fetch", NULL, NULL, NULL, NULL };
+	const char *argv[] =3D { "fetch", NULL, NULL, NULL, NULL, NULL };
 	int argc =3D 1;
=20
+	if (prune)
+		argv[argc++] =3D "--prune";
 	if (verbosity >=3D 2)
 		argv[argc++] =3D "-v";
 	if (verbosity >=3D 1)
--=20
1.6.5.1.69.g36942
