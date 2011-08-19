From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] log: decorate "replaced" on to replaced commits
Date: Fri, 19 Aug 2011 19:43:50 +0700
Message-ID: <1313757830-30640-1-git-send-email-pclouds@gmail.com>
References: <7vippua433.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 14:44:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuOQg-00030Y-Ah
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 14:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab1HSMoA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 08:44:00 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:37504 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab1HSMn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 08:43:59 -0400
Received: by pzk37 with SMTP id 37so4791816pzk.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 05:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=68pm5SyWzeNR5ga8EWTVu2hxGTiNQzVcybUYi7baSIY=;
        b=ZjRkIhXOu1+6r7SeSAedBiZxgs/zwlR3vO0iYUB1cGmCVoS/Z9akURHEG9pkb7ii1w
         9PaepF0kGpoBsU4RW/kIegkRAFfeVqbcCDj4RVsZsinMQIbEEQQYjaFQ2n85xhTiymo6
         H7A30j10eoqU2Zc/CWaHaNIIpE86oT89+vwv0=
Received: by 10.142.143.11 with SMTP id q11mr1046939wfd.329.1313757839360;
        Fri, 19 Aug 2011 05:43:59 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id z8sm983386wff.7.2011.08.19.05.43.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Aug 2011 05:43:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 19 Aug 2011 19:43:51 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <7vippua433.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179698>

Old code also decorates "new" commits with "refs/replace/SHA1". This
is now gone, but I guess no one will miss it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2011/8/19 Junio C Hamano <gitster@pobox.com>:
 > If the argument is "we know only commits and tags are listed and blo=
bs and
 > trees are not shown with --decorate option" and "excluding the decor=
ation
 > that we know will never be used will avoid bloating the decorate has=
htable
 > with unused cruft", then add_name_decoration() should be doing the c=
heck
 > for all of its callers, not just this one, no?

 Makes sense. Moreover replacing blobs and trees are generally not safe=
=2E
 If people do that, they may have more issues to worry about than this.
 Let's keep it simple. We can fix add_name_decoration() later if it bec=
omes
 a real problem.

 log-tree.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index e945701..d73e69c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -92,8 +92,22 @@ static void add_name_decoration(enum decoration_type=
 type, const char *name, str
=20
 static int add_ref_decoration(const char *refname, const unsigned char=
 *sha1, int flags, void *cb_data)
 {
-	struct object *obj =3D parse_object(sha1);
+	struct object *obj;
 	enum decoration_type type =3D DECORATION_NONE;
+
+	if (!prefixcmp(refname, "refs/replace/")) {
+		unsigned char original_sha1[20];
+		if (get_sha1_hex(refname + 13, original_sha1)) {
+			warning("invalid replace ref %s", refname);
+			return 0;
+		}
+		obj =3D parse_object(original_sha1);
+		if (obj)
+			add_name_decoration(DECORATION_GRAFTED, "replaced", obj);
+		return 0;
+	}
+
+	obj =3D parse_object(sha1);
 	if (!obj)
 		return 0;
=20
--=20
1.7.4.74.g639db
