From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/10] send-pack: support pack v4
Date: Thu, 26 Sep 2013 09:26:47 +0700
Message-ID: <1380162409-18224-9-git-send-email-pclouds@gmail.com>
References: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 04:27:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP1J5-00033U-62
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 04:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553Ab3IZC1u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 22:27:50 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:58627 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab3IZC1s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 22:27:48 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so631062pab.40
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 19:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lAkqy4JTyani2d5cfnfbUck5j/WRRHvafmRRZ9ykjZY=;
        b=kCUFqnU+wV036P5G6taGAOv3L3lVgHk5v1NnejA3Xe+sgQmmaTsAWGOR7eSKZU/fes
         BoHC0tl/ZmMEPQmEpr0Cgm4XLhIJCdSVXIZP44EwVi2kdD9y9rTus2WWxNtmvb6uTDRR
         bprQk58mn+sh0PYa+RNtNngVGvXh+FXQhk+81+CXwiiNkMEGieIRB5ZMBFMJNIjFk7jd
         jQmeFQ4oqQIDy31hbEPRz0mzHiT4KQZgeHMcs5UiJKNjb7zASPYk3ZIL6rgERfwmn7km
         FXI6kpJoHeMvlf/HQlWDJ14EqnLivHlqvtrg964FGecxtq2XjqzXEd69I3RQb3YIzLPp
         b5Aw==
X-Received: by 10.66.196.110 with SMTP id il14mr2533346pac.130.1380162467899;
        Wed, 25 Sep 2013 19:27:47 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id om2sm50801145pbc.30.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 19:27:47 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 26 Sep 2013 09:27:42 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235395>

Contrary to the fetch direction, whether send-pack sends packv4 is
totally controlled by the server. This is in favor of lowering load at
the server side. More logic may be added later to allow the client to
stick to v2 even if the server requests v4.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 send-pack.c           |  5 +++++
 send-pack.h           |  1 +
 t/t5516-fetch-push.sh | 12 ++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index 7d172ef..977c14b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -44,6 +44,7 @@ static int pack_objects(int fd, struct ref *refs, str=
uct extra_have_objects *ext
 		NULL,
 		NULL,
 		NULL,
+		NULL,
 	};
 	struct child_process po;
 	int i;
@@ -57,6 +58,8 @@ static int pack_objects(int fd, struct ref *refs, str=
uct extra_have_objects *ext
 		argv[i++] =3D "-q";
 	if (args->progress)
 		argv[i++] =3D "--progress";
+	if (args->packv4)
+		argv[i++] =3D "--version=3D4";
 	memset(&po, 0, sizeof(po));
 	po.argv =3D argv;
 	po.in =3D -1;
@@ -205,6 +208,8 @@ int send_pack(struct send_pack_args *args,
 		quiet_supported =3D 1;
 	if (server_supports("agent"))
 		agent_supported =3D 1;
+	if (server_supports("packv4"))
+		args->packv4 =3D 1;
=20
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing=
=2E\n"
diff --git a/send-pack.h b/send-pack.h
index 05d7ab1..cda770c 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -11,6 +11,7 @@ struct send_pack_args {
 		use_thin_pack:1,
 		use_ofs_delta:1,
 		dry_run:1,
+		packv4:1,
 		stateless_rpc:1;
 };
=20
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4691d51..d0c116f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1172,4 +1172,16 @@ test_expect_success 'push --follow-tag only push=
es relevant tags' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'push pack v4' '
+	git init pv4 &&
+	git --git-dir pv4/.git config core.preferredPackVersion 4 &&
+	git --git-dir pv4/.git config transfer.unpackLimit 1 &&
+	git push pv4 HEAD:refs/heads/head &&
+	P=3D`ls pv4/.git/objects/pack/pack-*.pack` &&
+	# Offset 4 is pack version
+	test-dump ntohl "$P" 4 >ver.actual &&
+	echo 4 >ver.expected &&
+	test_cmp ver.expected ver.actual
+'
+
 test_done
--=20
1.8.2.82.gc24b958
