From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] pack-objects: do not accept "--index-version=version,"
Date: Wed,  1 Feb 2012 22:17:18 +0700
Message-ID: <1328109440-9510-1-git-send-email-pclouds@gmail.com>
References: <1328017702-14489-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 16:19:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsbyP-0001ZC-0f
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 16:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575Ab2BAPTo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 10:19:44 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:57999 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859Ab2BAPTn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 10:19:43 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Feb 2012 10:19:43 EST
Received: by dado14 with SMTP id o14so1291029dad.11
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 07:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rTr/v6M7ji1DqK5tDGdxEzzkrXm9caI9jRJzAKcxmgM=;
        b=hpElS+iTLR9vEZoCLBGl9E88oPB8DRH/T3d8oz1eU7/24w3OieL4L0UgWqr2yBHBja
         +axnyzYESs3ayJnOk3hspm6XgIHGJppXXEHYss0k9UmKCJEFewicybQiiOMi90Czby5h
         W6rGsU7NIgin/0MEOnFrS8bOD451RYzYLfK/Q=
Received: by 10.68.238.68 with SMTP id vi4mr57918353pbc.65.1328109226894;
        Wed, 01 Feb 2012 07:13:46 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id p9sm63989954pbb.9.2012.02.01.07.13.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 07:13:45 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 01 Feb 2012 22:17:24 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328017702-14489-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189517>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c |    2 +-
 t/t5302-pack-index.sh  |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0f2e7b8..297f792 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2471,7 +2471,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 			pack_idx_opts.version =3D strtoul(arg + 16, &c, 10);
 			if (pack_idx_opts.version > 2)
 				die("bad %s", arg);
-			if (*c =3D=3D ',')
+			if (*c =3D=3D ',' && c[1])
 				pack_idx_opts.off32_limit =3D strtoul(c+1, &c, 0);
 			if (*c || pack_idx_opts.off32_limit & 0x80000000)
 				die("bad %s", arg);
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index f8fa924..fe82025 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -74,6 +74,10 @@ test_expect_success 'index-pack --verify on index ve=
rsion 2' '
 '
=20
 test_expect_success \
+    'pack-objects --index-version=3D2, is not accepted' \
+    'test_must_fail git pack-objects --index-version=3D2, test-3 <obj-=
list'
+
+test_expect_success \
     'index v2: force some 64-bit offsets with pack-objects' \
     'pack3=3D$(git pack-objects --index-version=3D2,0x40000 test-3 <ob=
j-list)'
=20
--=20
1.7.8.36.g69ee2
