From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] fetch-pack: support --subtree and --commit-subtree options
Date: Tue, 27 Jul 2010 06:36:10 +0700
Message-ID: <1280187370-23675-3-git-send-email-pclouds@gmail.com>
References: <1280187370-23675-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 15:16:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odk1F-0004XW-8G
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 15:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192Ab0G0NK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 09:10:27 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44938 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab0G0NKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 09:10:25 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so1338166pzk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=XmQmePoyQzM+v+ej/kzwXqqc5PsHqTAiLVU7ljNhkH4=;
        b=doc+aSAHxGRbdasywyVwOqbgRksSy8Ca444LzldFyhF1MI6dm3fCeK6yKp+7st9Ky3
         40flqXJ+rTg3+sPgSE84CWBSy6U0bA+Uln9O4vmiealvK3e0R63SkzJuYOk7LD1MfymM
         A+3S9RFKUQh80eNm4hO5Z8+wfMsDiklQoyhW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gdsAeAXT29E7BjPFlvHLonAe5fQvPxPnjeCaDjf9Hio8F5QcWsZqobzEQ6uT7txpHH
         8iPqeqX5gaf2Z24+d272TeK+Mamqifj1rh17TGL8U13Q1Oe/W9BBsHhW1XHlOSyoONQN
         U1x/TPRKEvp9c+9aDYjrdUK2fhjZSVZuAIrzw=
Received: by 10.142.147.7 with SMTP id u7mr10098015wfd.219.1280236225548;
        Tue, 27 Jul 2010 06:10:25 -0700 (PDT)
Received: from dektop ([119.12.193.247])
        by mx.google.com with ESMTPS id y16sm5635609wff.2.2010.07.27.06.10.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 06:10:24 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Tue, 27 Jul 2010 06:36:48 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280187370-23675-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151939>

These options are simply turned to upload-pack's "subtree" and "commit-=
tree" requests, respectively.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dbd8b7b..0bc7f6d 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -14,6 +14,8 @@ static int transfer_unpack_limit =3D -1;
 static int fetch_unpack_limit =3D -1;
 static int unpack_limit =3D 100;
 static int prefer_ofs_delta =3D 1;
+static const char *subtree;
+static int commit_subtree;
 static struct fetch_pack_args args =3D {
 	/* .uploadpack =3D */ "git-upload-pack",
 };
@@ -237,6 +239,8 @@ static int find_common(int fd[2], unsigned char *re=
sult_sha1,
 	for_each_ref(rev_list_insert_ref, NULL);
=20
 	fetching =3D 0;
+	if (subtree)
+		packet_buf_write(&req_buf, "%s %s\n", commit_subtree ? "commit-subtr=
ee" : "subtree", subtree);
 	for ( ; refs ; refs =3D refs->next) {
 		unsigned char *remote =3D refs->old_sha1;
 		const char *remote_hex;
@@ -692,6 +696,8 @@ static struct ref *do_fetch_pack(int fd[2],
=20
 	if (is_repository_shallow() && !server_supports("shallow"))
 		die("Server does not support shallow clients");
+	if (subtree && !server_supports("subtree"))
+		die("Server does not support subtree");
 	if (server_supports("multi_ack_detailed")) {
 		if (args.verbose)
 			fprintf(stderr, "Server supports multi_ack_detailed\n");
@@ -860,6 +866,15 @@ int cmd_fetch_pack(int argc, const char **argv, co=
nst char *prefix)
 				pack_lockfile_ptr =3D &pack_lockfile;
 				continue;
 			}
+			if (!prefixcmp(arg, "--subtree=3D")) {
+				subtree =3D arg + 10;
+				continue;
+			}
+			if (!prefixcmp(arg, "--commit-subtree=3D")) {
+				subtree =3D arg + 17;
+				commit_subtree =3D 1;
+				continue;
+			}
 			usage(fetch_pack_usage);
 		}
 		dest =3D (char *)arg;
--=20
1.7.1.rc1.69.g24c2f7
