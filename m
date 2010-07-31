From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/16] upload-pack: use a separate variable to control whether internal rev-list is used
Date: Sat, 31 Jul 2010 23:18:15 +0700
Message-ID: <1280593105-22015-7-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:38:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfORe-0002ti-R3
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132Ab0HACi3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:38:29 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33077 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419Ab0HACi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:38:28 -0400
Received: by mail-pv0-f174.google.com with SMTP id 7so978167pvc.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=M/kOebzyMS7bwErGRQc7FWZ4a1Hgxt5rnUPdIjNKh+w=;
        b=kn7qs+f95Vuu7raRQydZhcH3iPSF0u5VxeZ9wA+sU0K1b7ApfcV0UDgay/C4y2eHe7
         oYrSEkXnCGrVV1PLJeewgAdU3r9YL6Dk+RKicwp8T649jPBZuF3miEn//xiz4QEO6HWU
         fpEjzYt7bm6N/G78NzqajfM1BPi5pqXlB6ekU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=R3voEjNd+cnfl+tWKjvkZl58LWCEO/Oi8mq7BE7SZkKCXXK58L9DWNPKu9xokCSjgP
         4RGxy++UTatc4WxIUEB1Ru8SwFbBiRGs1jGh1SPGINpJ6MC88jWogTgewL6PsFjsYur3
         7eYRrKsGCtsnOOSlJF3WF7A10DR8plUYO6Hus=
Received: by 10.142.223.14 with SMTP id v14mr3616017wfg.44.1280630308632;
        Sat, 31 Jul 2010 19:38:28 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id t11sm5242799wfc.16.2010.07.31.19.38.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:38:27 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:19:19 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152353>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index dc464d7..e432e83 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -160,8 +160,9 @@ static void create_pack_file(void)
 	ssize_t sz;
 	const char *argv[10];
 	int arg =3D 0;
+	int internal_rev_list =3D shallow_nr;
=20
-	if (shallow_nr) {
+	if (internal_rev_list) {
 		memset(&rev_list, 0, sizeof(rev_list));
 		rev_list.proc =3D do_rev_list;
 		rev_list.out =3D -1;
@@ -187,7 +188,7 @@ static void create_pack_file(void)
 	argv[arg++] =3D NULL;
=20
 	memset(&pack_objects, 0, sizeof(pack_objects));
-	pack_objects.in =3D shallow_nr ? rev_list.out : -1;
+	pack_objects.in =3D internal_rev_list ? rev_list.out : -1;
 	pack_objects.out =3D -1;
 	pack_objects.err =3D -1;
 	pack_objects.git_cmd =3D 1;
@@ -197,7 +198,7 @@ static void create_pack_file(void)
 		die("git upload-pack: unable to fork git-pack-objects");
=20
 	/* pass on revisions we (don't) want */
-	if (!shallow_nr) {
+	if (!internal_rev_list) {
 		FILE *pipe_fd =3D xfdopen(pack_objects.in, "w");
 		if (!create_full_pack) {
 			int i;
@@ -311,7 +312,7 @@ static void create_pack_file(void)
 		error("git upload-pack: git-pack-objects died with error.");
 		goto fail;
 	}
-	if (shallow_nr && finish_async(&rev_list))
+	if (internal_rev_list && finish_async(&rev_list))
 		goto fail;	/* error was already reported */
=20
 	/* flush the data */
--=20
1.7.1.rc1.69.g24c2f7
