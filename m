From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/4] pack-objects, streaming: turn "xx >= big_file_threshold" to ".. > .."
Date: Wed, 16 May 2012 19:02:09 +0700
Message-ID: <1337169731-23416-2-git-send-email-pclouds@gmail.com>
References: <1336818375-16895-1-git-send-email-pclouds@gmail.com>
 <1337169731-23416-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 14:06:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUczl-0000M4-JA
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 14:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757300Ab2EPMGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 08:06:15 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42323 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756376Ab2EPMGN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 08:06:13 -0400
Received: by pbbrp8 with SMTP id rp8so1019187pbb.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 05:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vDwna2/GEsRXhol2TwlmgszdmoQ1CzDOrjOhQgOVYYg=;
        b=iC/6EWQt5CrgULphiGNl65PrbvWWGlkdLlXRf5fyVZ7COniHo00sKJXUham9HwIDQU
         psgsJDgV28FgBhwSkjCa+4X70KMXjMsrvLrdBogUgVSK26xljFPO8Dhuon39mZ1DUl/t
         AIoqLg5KBnbJ8LummTi9fYD571UjP9WoeJmpq80C0Fsvd6+UsF84hSCV2rAzd0bhmjco
         +mnXLBno3pzybBSlHIB715ytjWs8J0+TyCvvhknNBYOPfyfn8JiGqltqEH/ROwJnmmLS
         CbXWk41k5qK8+EXdKn45GgwQQlTCj5iY7VMQXumDJs0vx5bFVAFzjZeZ7urd50DzFfqR
         rTXA==
Received: by 10.68.223.67 with SMTP id qs3mr15954647pbc.142.1337169973104;
        Wed, 16 May 2012 05:06:13 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.61.104])
        by mx.google.com with ESMTPS id wn3sm5251627pbc.74.2012.05.16.05.06.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 05:06:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 16 May 2012 19:02:22 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1337169731-23416-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197870>

This is because all other places do "xx > big_file_threshold"

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Without two comparisons I added recently in archive-*.c, it's still
 inconsistent (two xx >=3D big_file and one xx > big_file).  I have no
 preference between > and >=3D. If some of you vote >=3D, I'll update t=
he
 patch.

 builtin/pack-objects.c |    2 +-
 streaming.c            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1861093..b2e0940 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1327,7 +1327,7 @@ static void get_object_details(void)
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *entry =3D sorted_by_offset[i];
 		check_object(entry);
-		if (big_file_threshold <=3D entry->size)
+		if (big_file_threshold < entry->size)
 			entry->no_try_delta =3D 1;
 	}
=20
diff --git a/streaming.c b/streaming.c
index 38b39cd..829ce7d 100644
--- a/streaming.c
+++ b/streaming.c
@@ -121,7 +121,7 @@ static enum input_source istream_source(const unsig=
ned char *sha1,
 	case OI_LOOSE:
 		return loose;
 	case OI_PACKED:
-		if (!oi->u.packed.is_delta && big_file_threshold <=3D size)
+		if (!oi->u.packed.is_delta && big_file_threshold < size)
 			return pack_non_delta;
 		/* fallthru */
 	default:
--=20
1.7.8.36.g69ee2
