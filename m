From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] upload-pack: support subtree packing
Date: Tue, 27 Jul 2010 06:36:09 +0700
Message-ID: <1280187370-23675-2-git-send-email-pclouds@gmail.com>
References: <1280187370-23675-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 15:10:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdjvN-0001XO-5D
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 15:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab0G0NKT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 09:10:19 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55316 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949Ab0G0NKR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 09:10:17 -0400
Received: by pwi5 with SMTP id 5so418288pwi.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 06:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JN2VdW6Jr2P/t6rpp0iFBGY8GglfU959HjWvgQpc7uE=;
        b=aa5OZME5J4A3y726s5yXBQISKs/87MEwAbzc58DpnXJgyxegc6aANKcULcnKS9plib
         MqnX50Z92r7YcRQnMtm+ZX7mJx327ksjrJ0LWEbmN8fRfgNlQA6vHg8EAhkEuOT11CNk
         n97JaRLur3DjnqDORswOzL3JKtIbksJK6k7aU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=s9qQvV6E0n0fN8h6Q+o44abPuz1UAkA3xz0mPS1Ipu0svoFfmD3/71D3t85iXvPAN3
         V/FG+fD9pC3Mr1CmPR5qDPcDrrrmd3a91hifIFm7bLMZDC6zF1J9DEFLmRP54VsThf6r
         JlQPd54MJHBuUazEQcnegc6eDjcAVEVbi5CoI=
Received: by 10.114.61.8 with SMTP id j8mr13328441waa.119.1280236216517;
        Tue, 27 Jul 2010 06:10:16 -0700 (PDT)
Received: from dektop ([119.12.193.247])
        by mx.google.com with ESMTPS id c24sm8832527wam.7.2010.07.27.06.10.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 06:10:15 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Tue, 27 Jul 2010 06:36:39 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280187370-23675-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151938>

This patch adds a new capability "subtree", which supports two new
requests "subtree" and "commit-subtree".

"subtree" asks upload-pack to create a pack that contains only blobs
from the given tree prefix (and necessary commits/trees to reach
those blobs).

"commit-tree" asks upload-pack to create a pack that contains trees of
the given prefix (and necessary commits/trees to reach those trees)

With "subtree" request, Git client may then rewrite commits to create
a valid commit tree again, so that users can work on it independently.
When users want to push from such a tree, "commit-tree" may then be
used to re-match what users have and what is in upstream, recreate
proper push commits.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index dc464d7..f97296a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -41,6 +41,8 @@ static int use_sideband;
 static int debug_fd;
 static int advertise_refs;
 static int stateless_rpc;
+static char *subtree;
+static int commit_subtree;
=20
 static void reset_timeout(void)
 {
@@ -89,6 +91,17 @@ static void show_object(struct object *obj, const st=
ruct name_path *path, const
 	 */
 	const char *name =3D path_name(path, component);
 	const char *ep =3D strchr(name, '\n');
+	if (subtree) {
+		int len =3D strlen(name);
+		/* parent trees should always be kept */
+		if (obj->type =3D=3D OBJ_TREE && !prefixcmp(subtree, name) && subtre=
e[len] =3D=3D '/')
+			; /* in */
+		else if (commit_subtree)
+			goto out;
+		else if (prefixcmp(name, subtree))
+			goto out;
+	}
+
 	if (ep) {
 		fprintf(pack_pipe, "%s %.*s\n", sha1_to_hex(obj->sha1),
 		       (int) (ep - name),
@@ -97,6 +110,7 @@ static void show_object(struct object *obj, const st=
ruct name_path *path, const
 	else
 		fprintf(pack_pipe, "%s %s\n",
 				sha1_to_hex(obj->sha1), name);
+out:
 	free((char *)name);
 }
=20
@@ -504,6 +518,21 @@ static void receive_needs(void)
 		if (debug_fd)
 			write_in_full(debug_fd, line, len);
=20
+		if (!prefixcmp(line, "subtree ")) {
+			int len =3D strlen(line+8);
+			subtree =3D malloc(len+1);
+			memcpy(subtree, line+8, len-1);
+			subtree[len-1] =3D '\0'; /* \n */
+			continue;
+		}
+		if (!prefixcmp(line, "commit-subtree ")) {
+			int len =3D strlen(line+15);
+			subtree =3D malloc(len+1);
+			memcpy(subtree, line+15, len-1);
+			subtree[len-1] =3D '\0'; /* \n */
+			commit_subtree =3D 1;
+			continue;
+		}
 		if (!prefixcmp(line, "shallow ")) {
 			unsigned char sha1[20];
 			struct object *object;
@@ -623,7 +652,7 @@ static int send_ref(const char *refname, const unsi=
gned char *sha1, int flag, vo
 {
 	static const char *capabilities =3D "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed";
+		" include-tag multi_ack_detailed subtree";
 	struct object *o =3D parse_object(sha1);
=20
 	if (!o)
--=20
1.7.1.rc1.69.g24c2f7
