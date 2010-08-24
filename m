From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/32] fetch-pack: support --narrow-tree
Date: Wed, 25 Aug 2010 08:20:04 +1000
Message-ID: <1282688422-7738-15-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1uJ-00030j-Ef
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273Ab0HXWWb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:22:31 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49107 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318Ab0HXWW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:22:29 -0400
Received: by pvg2 with SMTP id 2so2814108pvg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qfExqT7oxQufqAhD8pY4azxVtYHRMjzOgzbB37VEDrE=;
        b=awjT0CBk0SfbhHd5aTFBwbNKpRHTy7+IWnJftrtLQCSUNhdJx9qSrMbsnN5q7Mv7rB
         e4BoVThBR6Wqi7/9n2texp/y96gqSwR2jvzECM81RC+h1/pwrXimTFm0qF0TfDvBi07/
         m+qv6aTDY6ZAD3UET1/xSBCpm6dPnH5cR7MXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aVTpbyicdmaOK5UufWO7l+gpPjVenxdiLhpI/fR2KPa/NKZ2JxIlIMMPoNdkBIUQFF
         N07HsP6k0WWtrPAA4/MM23g8FesaiwtgbzOp+992ADx7mYlKWJFqDQW9cMWZnSTL1qPO
         j0z5OzLlaL5AxKUGvXZrCH98iPpLe0wNitGSY=
Received: by 10.142.143.20 with SMTP id q20mr6149962wfd.284.1282688549088;
        Tue, 24 Aug 2010 15:22:29 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id d4sm638314wfh.11.2010.08.24.15.22.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:22:27 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:22:22 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154359>

This options requires narrow-tree capability from upload-pack. It
simply sends narrow-tree line from argument to to upload-pack.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dbd8b7b..821b713 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -37,6 +37,7 @@ static int marked;
=20
 static struct commit_list *rev_list;
 static int non_common_revs, multi_ack, use_sideband;
+const char *narrow_prefix;
=20
 static void rev_list_push(struct commit *commit, int mark)
 {
@@ -237,6 +238,10 @@ static int find_common(int fd[2], unsigned char *r=
esult_sha1,
 	for_each_ref(rev_list_insert_ref, NULL);
=20
 	fetching =3D 0;
+	if (get_narrow_prefix() && !narrow_prefix)
+		narrow_prefix =3D get_narrow_prefix();
+	if (narrow_prefix)
+		packet_buf_write(&req_buf, "narrow-tree %s\n", narrow_prefix);
 	for ( ; refs ; refs =3D refs->next) {
 		unsigned char *remote =3D refs->old_sha1;
 		const char *remote_hex;
@@ -692,6 +697,8 @@ static struct ref *do_fetch_pack(int fd[2],
=20
 	if (is_repository_shallow() && !server_supports("shallow"))
 		die("Server does not support shallow clients");
+	if (narrow_prefix && !server_supports("narrow-tree"))
+		die("Server does not support narrow-tree");
 	if (server_supports("multi_ack_detailed")) {
 		if (args.verbose)
 			fprintf(stderr, "Server supports multi_ack_detailed\n");
@@ -860,6 +867,10 @@ int cmd_fetch_pack(int argc, const char **argv, co=
nst char *prefix)
 				pack_lockfile_ptr =3D &pack_lockfile;
 				continue;
 			}
+			if (!prefixcmp(arg, "--narrow-tree=3D")) {
+				narrow_prefix =3D arg + 14;
+				continue;
+			}
 			usage(fetch_pack_usage);
 		}
 		dest =3D (char *)arg;
--=20
1.7.1.rc1.69.g24c2f7
