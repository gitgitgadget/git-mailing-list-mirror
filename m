From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 2/2] find_pack_entry(): do not keep packed_git pointer locally
Date: Thu,  2 Feb 2012 20:53:51 +0700
Message-ID: <1328190831-26580-1-git-send-email-pclouds@gmail.com>
References: <alpine.LFD.2.02.1202011100010.2759@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 14:50:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsx3L-0001Gw-Ai
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 14:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab2BBNuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 08:50:07 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61507 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab2BBNuB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 08:50:01 -0500
Received: by pbdu11 with SMTP id u11so2025206pbd.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 05:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nA0dIW+pA8vKkoJSrwaCrwENJ3tCByv65voPalK+UAo=;
        b=a8bWe2GcRH6OBb7QVHWLkg5YKYq4WfWUXpZzK9nAZ2oIc7ojfb65MFu61T+WZn9Enj
         p9E4oimAX/FVzLYcu2AwUBHanD11+XwlkAyi82+pFC5DwiGWEomj1M91bhGB7+aLIdXh
         LdPpEUHLOo7WSU4nkul7FUSPTpKOr3CDMQwPw=
Received: by 10.68.195.73 with SMTP id ic9mr8088107pbc.72.1328190601009;
        Thu, 02 Feb 2012 05:50:01 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id a5sm5834872pbh.15.2012.02.02.05.49.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 05:49:59 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 02 Feb 2012 20:53:53 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <alpine.LFD.2.02.1202011100010.2759@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189643>

Commit f7c22cc (always start looking up objects in the last used pack
first - 2007-05-30) introduce a static packed_git* pointer as an
optimization.  The kept pointer however may become invalid if
free_pack_by_name() happens to free that particular pack.

Current code base does not access packs after calling
free_pack_by_name() so it should not be a problem. Anyway, move the
pointer out so that free_pack_by_name() can reset it to avoid running
into troubles in future.

Thanks to Junio for code layout suggestions.

Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Credit where credit is due. No code changes from pu.

 sha1_file.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 61e51ed..6b1b512 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -54,6 +54,8 @@ static struct cached_object empty_tree =3D {
 	0
 };
=20
+static struct packed_git *last_found_pack;
+
 static struct cached_object *find_cached_object(const unsigned char *s=
ha1)
 {
 	int i;
@@ -720,6 +722,8 @@ void free_pack_by_name(const char *pack_name)
 			close_pack_index(p);
 			free(p->bad_object_sha1);
 			*pp =3D p->next;
+			if (last_found_pack =3D=3D p)
+				last_found_pack =3D NULL;
 			free(p);
 			return;
 		}
@@ -2046,27 +2050,22 @@ static int fill_pack_entry(const unsigned char =
*sha1,
=20
 static int find_pack_entry(const unsigned char *sha1, struct pack_entr=
y *e)
 {
-	static struct packed_git *last_found =3D (void *)1;
 	struct packed_git *p;
=20
 	prepare_packed_git();
 	if (!packed_git)
 		return 0;
-	p =3D (last_found =3D=3D (void *)1) ? packed_git : last_found;
=20
-	do {
-		if (fill_pack_entry(sha1, e, p)) {
-			last_found =3D p;
-			return 1;
-		}
+	if (last_found_pack && fill_pack_entry(sha1, e, last_found_pack))
+		return 1;
=20
-		if (p =3D=3D last_found)
-			p =3D packed_git;
-		else
-			p =3D p->next;
-		if (p =3D=3D last_found)
-			p =3D p->next;
-	} while (p);
+	for (p =3D packed_git; p; p =3D p->next) {
+		if (p =3D=3D last_found_pack || !fill_pack_entry(sha1, e, p))
+			continue;
+
+		last_found_pack =3D p;
+		return 1;
+	}
 	return 0;
 }
=20
--=20
1.7.8.36.g69ee2
