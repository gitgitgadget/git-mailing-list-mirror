From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] {fetch,upload}-pack: allow --depth=0 to deepen into full repo again
Date: Thu, 19 Aug 2010 20:40:37 +1000
Message-ID: <1282214437-16384-3-git-send-email-pclouds@gmail.com>
References: <201008180854.18474.ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, computerdruid@gmail.com, joey@kitenet.net
X-From: git-owner@vger.kernel.org Thu Aug 19 13:27:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om3HN-0002Y3-G4
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 13:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab0HSL1R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 07:27:17 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51059 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786Ab0HSL1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 07:27:16 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so471942pwi.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 04:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=52PcbcdD/arEHNJ4HYuebJw/TVEB20udE9O7TUdLcy8=;
        b=nfD0Dk1A3lKhlBmpX7wDfT+hErk59+eR1sd5VfqPHaRBiMp/xGmO3xMM14zPC7gD7E
         jIn4ha4bfdKxnoN7KEbxFNCmwjP4oZgHj31W4vm9WlImBJiwrnMLI1QeR17sW/tBppwO
         8touXO7uZ1qRyXpC14j2ukhoGPUMkn540QfiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qHeD84SsBM1zXKh8zbM+BOjDXItBJH7jp5EBkb9pGcijikFzSvjalQz44FGCPnL5kt
         uBpCyWFm53OkTgQNR2iD1qZGOrz+z/Vt/KrYdzDgXWYGupIt3oGul/WxxbLBVltFDZQR
         wjVwdScYWVmqaxMBfYZeNgFEM6zb+YStkbe+8=
Received: by 10.114.137.13 with SMTP id k13mr11063365wad.221.1282217236227;
        Thu, 19 Aug 2010 04:27:16 -0700 (PDT)
Received: from dektop ([121.91.127.5])
        by mx.google.com with ESMTPS id x9sm2480858waj.3.2010.08.19.04.27.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 04:27:15 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 19 Aug 2010 20:41:01 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <201008180854.18474.ComputerDruid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153917>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The funny thing is, even with --depth=3D0, I still have two commit gra=
fts
 in $GIT_DIR/shallow, which are grafts of tags. I think there is a bug =
somewhere..

 builtin/fetch-pack.c |    2 +-
 shallow.c            |    2 +-
 upload-pack.c        |    8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 45d1824..7d7af2e 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -845,7 +845,7 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 			}
 			if (!prefixcmp(arg, "--depth=3D")) {
 				args.depth =3D strtol(arg + 8, NULL, 0);
-				if (args.depth <=3D 0)
+				if (args.depth < 0)
 					die("Invalid depth %d", args.depth);
 				args.shallow =3D 1;
 				continue;
diff --git a/shallow.c b/shallow.c
index 4d90eda..eab97c6 100644
--- a/shallow.c
+++ b/shallow.c
@@ -85,7 +85,7 @@ struct commit_list *get_shallow_commits(struct object=
_array *heads, int depth,
 					continue;
 				*pointer =3D cur_depth;
 			}
-			if (cur_depth < depth) {
+			if (!depth || cur_depth < depth) {
 				if (p->next)
 					add_object_array(&p->item->object,
 							NULL, &stack);
diff --git a/upload-pack.c b/upload-pack.c
index fc79dde..7b004b9 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -484,7 +484,7 @@ static void receive_needs(void)
 {
 	struct object_array shallows =3D {0, 0, NULL};
 	static char line[1000];
-	int len, depth =3D 0;
+	int len, depth =3D -1;
=20
 	shallow_nr =3D 0;
 	if (debug_fd)
@@ -514,7 +514,7 @@ static void receive_needs(void)
 		if (!prefixcmp(line, "deepen ")) {
 			char *end;
 			depth =3D strtol(line + 7, &end, 0);
-			if (end =3D=3D line + 7 || depth <=3D 0)
+			if (end =3D=3D line + 7 || depth < 0)
 				die("Invalid deepen: %s", line);
 			continue;
 		}
@@ -562,9 +562,9 @@ static void receive_needs(void)
 	if (!use_sideband && daemon_mode)
 		no_progress =3D 1;
=20
-	if (depth =3D=3D 0 && shallows.nr =3D=3D 0)
+	if (depth =3D=3D -1 && shallows.nr =3D=3D 0)
 		return;
-	if (depth > 0) {
+	if (depth >=3D 0) {
 		struct commit_list *result, *backup;
 		int i;
 		backup =3D result =3D get_shallow_commits(&want_obj, depth,
--=20
1.7.1.rc1.69.g24c2f7
