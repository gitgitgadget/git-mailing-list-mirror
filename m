From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/10] reflog-walk.c: request allocated buffer from resolve_ref()
Date: Tue, 15 Nov 2011 13:07:52 +0700
Message-ID: <1321337276-17803-6-git-send-email-pclouds@gmail.com>
References: <20111115060603.GA17585@tre>
 <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 07:06:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQC9x-0005p2-29
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 07:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451Ab1KOGFs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 01:05:48 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41979 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399Ab1KOGFr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 01:05:47 -0500
Received: by yenq3 with SMTP id q3so231832yen.19
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 22:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6BOlKym/pszIvMo+tKdBxN2HACb6DcSj1lgYmvliukU=;
        b=o1kSPn/zGMi9tbwHMlP33xXKNjQHabIXmGS5Hwg5yc9I4IrVOQmKBhbX4nwAt9AlHt
         vBzFIhbo6uixQ1d5cyn4a1MQP5A9mHxVU9kkkdDx33b4WaBgJXlR8JAVKO7/BcbvFIok
         qIdunB6THDqpxnb9CIPppwvgGf6P/cpHQieXk=
Received: by 10.68.24.65 with SMTP id s1mr56286149pbf.12.1321337146034;
        Mon, 14 Nov 2011 22:05:46 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id km16sm62410786pbb.9.2011.11.14.22.05.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 22:05:45 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 15 Nov 2011 13:08:30 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185428>

for_each_reflog_ent() can do anything, including calling resolve_ref()
again. Therefore it's not safe to use the static buffer returned by
resolve_ref(). Request it to allocate new buffer instead.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 reflog-walk.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index f71cca6..00bdff8 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -50,9 +50,11 @@ static struct complete_reflogs *read_complete_reflog=
(const char *ref)
 	for_each_reflog_ent(ref, read_one_reflog, reflogs);
 	if (reflogs->nr =3D=3D 0) {
 		unsigned char sha1[20];
-		const char *name =3D resolve_ref(ref, sha1, 1, NULL, 0);
-		if (name)
+		char *name =3D resolve_ref(ref, sha1, 1, NULL, 1);
+		if (name) {
 			for_each_reflog_ent(name, read_one_reflog, reflogs);
+			free(name);
+		}
 	}
 	if (reflogs->nr =3D=3D 0) {
 		int len =3D strlen(ref);
--=20
1.7.4.74.g639db
