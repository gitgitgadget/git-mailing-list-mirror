From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/4] verify_packfile(): check as many object as possible in a pack
Date: Mon,  7 Nov 2011 09:59:24 +0700
Message-ID: <1320634766-24511-3-git-send-email-pclouds@gmail.com>
References: <1320634766-24511-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Stephen Boyd <bebarino@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 04:01:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNFSU-000864-9M
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 04:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab1KGDBJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 22:01:09 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50093 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103Ab1KGDBI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 22:01:08 -0500
Received: by mail-qw0-f46.google.com with SMTP id 25so281160qao.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 19:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lYvuDh7JiMpQD8f+B9k934JUSoql37+XW+aaNOm4B4E=;
        b=SolcBf/X/ur+D+FvrsBDUxkrLji9jKPq5xBi+dfkih2UlLF9PFd1viK/LXyF0B8W9Y
         Vt3490pxP05ekQQR0q7R9PvZCgpB1AUF6GxIzvk0un3Mm34V92gSjqTAD7NjTbu91fsS
         dLhYcw1cVY9rKNISWz7+Dzit80h4apBX2eJl4=
Received: by 10.50.194.229 with SMTP id hz5mr39475922igc.36.1320634867835;
        Sun, 06 Nov 2011 19:01:07 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.230.110])
        by mx.google.com with ESMTPS id p6sm20252602pbf.3.2011.11.06.19.01.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 19:01:06 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 07 Nov 2011 09:59:47 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1320634766-24511-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184941>

verify_packfile() checks for whole pack integerity first, then each
object individually. Once we get past whole pack check, we can
identify all objects in the pack. If there's an error with one object,
we should continue to check the next objects to salvage as many
objects as possible instead of stopping the process.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pack-check.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index 0c19b6e..7ac9b3a 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -113,18 +113,13 @@ static int verify_packfile(struct packed_git *p,
 					    p->pack_name, (uintmax_t)offset);
 		}
 		data =3D unpack_entry(p, entries[i].offset, &type, &size);
-		if (!data) {
+		if (!data)
 			err =3D error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    sha1_to_hex(entries[i].sha1), p->pack_name,
 				    (uintmax_t)entries[i].offset);
-			break;
-		}
-		if (check_sha1_signature(entries[i].sha1, data, size, typename(type)=
)) {
+		else if (check_sha1_signature(entries[i].sha1, data, size, typename(=
type)))
 			err =3D error("packed %s from %s is corrupt",
 				    sha1_to_hex(entries[i].sha1), p->pack_name);
-			free(data);
-			break;
-		}
 		free(data);
 	}
 	free(entries);
--=20
1.7.4.74.g639db
