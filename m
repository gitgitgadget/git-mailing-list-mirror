From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] format-patch: pick up branch description when no ref is specified
Date: Tue,  1 Jan 2013 16:30:54 +0700
Message-ID: <1357032655-21103-2-git-send-email-pclouds@gmail.com>
References: <1357032655-21103-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 10:31:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpyC2-00023H-Jd
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 10:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab3AAJbE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 04:31:04 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:45433 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab3AAJbD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 04:31:03 -0500
Received: by mail-pb0-f50.google.com with SMTP id wz7so7378882pbc.9
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 01:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=vIxAWIoPTzgaOi2rUNOzNlUEyo1dr80NQMl4LryK1Vc=;
        b=IYSc42qHqsvfYP/iSnT7hO/pEFyM73d2MGUe8I0/N/7ZWv4Ospf4RzdD9LPjwGcSW1
         F/fVmMbL+1C9vgbc2hM6oGPhJL9MsX43we3pDvYVkyi4cWQTkwZXwzHLlHPuLtbAF1Zm
         HB4CGPmRr58v7JHxQBDmokfbAWX/1JEE8DonWRPzh6z6tXqI/5lJvAAAHhBed5d6YYC/
         E5+L6cGko2CoALG9/4Vjiuxy256zxatMKHG7THG+rLsbdcPuNte2vPTpwnWX1PvQopxm
         smXYPPVE/aQAaMMqw+5wp90nRR0E8b8UomwTHSr+cnVXM9g1G+4QuiUO3Bn2aEa8DtB3
         CGWQ==
X-Received: by 10.66.79.74 with SMTP id h10mr107005135pax.25.1357032662311;
        Tue, 01 Jan 2013 01:31:02 -0800 (PST)
Received: from lanh ([115.74.57.25])
        by mx.google.com with ESMTPS id oi3sm26400691pbb.1.2013.01.01.01.30.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Jan 2013 01:31:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 01 Jan 2013 16:31:06 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357032655-21103-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212419>

find_branch_name() fails to detect "format-patch --cover-letter -3"
where no command line arguments are given and HEAD is automatically
added. Detect branch name in this case so we can pick up the branch's
description in cover letter.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/log.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index e7b7db1..115f118 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1027,8 +1027,22 @@ static char *find_branch_name(struct rev_info *r=
ev)
 		else
 			return NULL;
 	}
-	if (positive < 0)
+	if (positive < 0) {
+		/*
+		 * No actual ref from command line, but "HEAD" from
+		 * rev->def was added in setup_revisions()
+		 * e.g. format-patch --cover-letter -12
+		 */
+		if (!rev->cmdline.nr &&
+		    rev->pending.nr =3D=3D 1 &&
+		    !strcmp(rev->pending.objects[0].name, "HEAD")) {
+			const char *ref;
+			ref =3D resolve_ref_unsafe("HEAD", branch_sha1, 1, NULL);
+			if (ref && !prefixcmp(ref, "refs/heads/"))
+				return xstrdup(ref + strlen("refs/heads/"));
+		}
 		return NULL;
+	}
 	strbuf_addf(&buf, "refs/heads/%s", rev->cmdline.rev[positive].name);
 	branch =3D resolve_ref_unsafe(buf.buf, branch_sha1, 1, NULL);
 	if (!branch ||
--=20
1.8.0.rc2.23.g1fb49df
