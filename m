From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/16] upload-pack: support subtree pack
Date: Sat, 31 Jul 2010 23:18:16 +0700
Message-ID: <1280593105-22015-8-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:38:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfORm-0002wb-H2
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272Ab0HACih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:38:37 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58771 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab0HACig (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:38:36 -0400
Received: by pzk26 with SMTP id 26so976718pzk.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=eI6nT7qhaDBzFK1R4XoIiKJPszjxRNr2ieO2qPHgV20=;
        b=OKdieO62+vFsyIZQ92ERpqzS5NmDUY/FFGRFcf0IaDFepFn9CAC6sgACiBaNlPF0EQ
         PRrJXro1D27vqiQRaYQT6L5Nk6GQ5OfJLnu6D5B832XRfVtMDN+RT+TjMI8OeCb6masy
         wMt4sjAklEErJPAwmHw5pxhvAg9MR/u0VHops=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XsM4uJteudPFwSTOfRqZICjWyJ+TMGedtrtNvMeu/i9k3dnl71Ybk1EvIg1HFPtUWm
         nKeToRaDjWhxWoZ7J+VGn9ukPBw3+fm2/UqDxXFQq1rq6c/9WgVPEhnvZBNoKEDAlQ/U
         LVGe1vTvwS7+cpXf1E7bnp6a0LzvWRl0BtkgU=
Received: by 10.142.204.17 with SMTP id b17mr3637924wfg.4.1280630316083;
        Sat, 31 Jul 2010 19:38:36 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id v38sm5247000wfh.0.2010.07.31.19.38.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:38:35 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:19:29 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152354>

With core_subtree turned on (capability "subtree", request "subtree"
from fetch-pack), traverse_commit_list will be in "subtree mode",
which will not go farther than the given subtree.

As the result, the pack is broken be design, only contains enough
blobs/trees/commits to reach the given subtree.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index e432e83..9b6710a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -160,7 +160,7 @@ static void create_pack_file(void)
 	ssize_t sz;
 	const char *argv[10];
 	int arg =3D 0;
-	int internal_rev_list =3D shallow_nr;
+	int internal_rev_list =3D shallow_nr || core_subtree;
=20
 	if (internal_rev_list) {
 		memset(&rev_list, 0, sizeof(rev_list));
@@ -505,6 +505,20 @@ static void receive_needs(void)
 		if (debug_fd)
 			write_in_full(debug_fd, line, len);
=20
+		if (!prefixcmp(line, "subtree ")) {
+			int len;
+			char *subtree;
+			if (core_subtree)
+				die("sorry, only one subtree supported");
+			len =3D strlen(line+8);
+			subtree =3D malloc(len+1);
+			memcpy(subtree, line+8, len-1);
+			subtree[len-1] =3D '\0'; /* \n */
+			if (subtree[len-2] !=3D '/')
+				die("subtree request must end with a slash");
+			core_subtree =3D subtree;
+			continue;
+		}
 		if (!prefixcmp(line, "shallow ")) {
 			unsigned char sha1[20];
 			struct object *object;
@@ -624,7 +638,7 @@ static int send_ref(const char *refname, const unsi=
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
