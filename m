From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/32] upload-pack: support narrow-tree capability
Date: Wed, 25 Aug 2010 08:20:03 +1000
Message-ID: <1282688422-7738-14-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:22:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1t0-0001Xh-4Z
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303Ab0HXWWY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:22:24 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43052 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270Ab0HXWWW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:22:22 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so50255pwi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OtLm/bwrHqRwtgssKxc7CjXKBXQV4KuUyxgc2Qt8l2c=;
        b=UUcYYtEBGL/JyYM3DAtD8fu0WPtwyHklR8eAsu3SR2yVma1rLcaJg3NAQXlfwd/Exp
         FaCvfakutGyqM5gf/Nm1bf7Rtxx29jc6qy32VQyOUsNeJWOl/bmHNVSJWdZ9D/2ow9Yx
         9JJLLkAWVt8pcw6vq0mGN68ckGb/4+Nty+5d8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tCSdERQyZJpPdYSpb5GweBck8G4pj2h+UHwh9Ci053EwoZgq72z0O+TfX2xcAtORRS
         7pId5kCqfelRXPP8VFQmEtlhIxR61NxNn/jYTTHVy9nhCiVCJVKnVCcvRQJLcN8oQhu0
         QuAosAh23xkZCReSPw0FVgU0AkO1T5+uI47aU=
Received: by 10.142.223.14 with SMTP id v14mr6164345wfg.275.1282688542067;
        Tue, 24 Aug 2010 15:22:22 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id 33sm641184wfg.9.2010.08.24.15.22.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:22:20 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:22:16 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154353>

If narrow-tree line is sent from fetch-pack, rev-walk will be put in
narrow mode.

Currently only one narrow-tree is supported.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index fc79dde..571fcb6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -41,6 +41,7 @@ static int use_sideband;
 static int debug_fd;
 static int advertise_refs;
 static int stateless_rpc;
+char *narrow_prefix;
=20
 static void reset_timeout(void)
 {
@@ -117,6 +118,10 @@ static int do_rev_list(int in, int out, void *user=
_data)
 	revs.blob_objects =3D 1;
 	if (use_thin_pack)
 		revs.edge_hint =3D 1;
+	if (narrow_prefix) {
+		revs.narrow_tree =3D 1;
+		revs.narrow_prefix =3D narrow_prefix;
+	}
=20
 	for (i =3D 0; i < want_obj.nr; i++) {
 		struct object *o =3D want_obj.objects[i].item;
@@ -153,7 +158,8 @@ static void create_pack_file(void)
 		"corruption on the remote side.";
 	int buffered =3D -1;
 	ssize_t sz;
-	const char *argv[10];
+	const char *argv[11];
+	char arg_narrow[PATH_MAX];
 	int arg =3D 0;
=20
 	if (shallow_nr) {
@@ -173,6 +179,10 @@ static void create_pack_file(void)
 	}
=20
 	argv[arg++] =3D "--stdout";
+	if (narrow_prefix) {
+		sprintf(arg_narrow, "--narrow-tree=3D%s", narrow_prefix);
+		argv[arg++] =3D arg_narrow;
+	}
 	if (!no_progress)
 		argv[arg++] =3D "--progress";
 	if (use_ofs_delta)
@@ -499,6 +509,18 @@ static void receive_needs(void)
 		if (debug_fd)
 			write_in_full(debug_fd, line, len);
=20
+		if (!prefixcmp(line, "narrow-tree ")) {
+			int len;
+			if (narrow_prefix)
+				die("sorry, only one narrow prefix is supported");
+			len =3D strlen(line+12);
+			narrow_prefix =3D malloc(len+1);
+			memcpy(narrow_prefix, line+12, len-1);
+			narrow_prefix[len-1] =3D '\0'; /* \n */
+			if (narrow_prefix[len-2] =3D=3D '/')
+				die("trailing slash in narrow prefix not allowed");
+			continue;
+		}
 		if (!prefixcmp(line, "shallow ")) {
 			unsigned char sha1[20];
 			struct object *object;
@@ -562,6 +584,9 @@ static void receive_needs(void)
 	if (!use_sideband && daemon_mode)
 		no_progress =3D 1;
=20
+	if (narrow_prefix)
+		use_thin_pack =3D 0;
+
 	if (depth =3D=3D 0 && shallows.nr =3D=3D 0)
 		return;
 	if (depth > 0) {
@@ -619,7 +644,7 @@ static int send_ref(const char *refname, const unsi=
gned char *sha1, int flag, vo
 {
 	static const char *capabilities =3D "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed";
+		" include-tag multi_ack_detailed narrow-tree";
 	struct object *o =3D parse_object(sha1);
=20
 	if (!o)
@@ -724,6 +749,8 @@ int main(int argc, char **argv)
 		die("'%s' does not appear to be a git repository", dir);
 	if (is_repository_shallow())
 		die("attempt to fetch/clone from a shallow repository");
+	if (get_narrow_prefix())
+		die("attempt to fetch/clone from a narrow repository");
 	if (getenv("GIT_DEBUG_SEND_PACK"))
 		debug_fd =3D atoi(getenv("GIT_DEBUG_SEND_PACK"));
 	upload_pack();
--=20
1.7.1.rc1.69.g24c2f7
