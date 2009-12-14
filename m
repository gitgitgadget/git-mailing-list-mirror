From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/23] unpack-trees.c: generalize verify_* functions
Date: Mon, 14 Dec 2009 17:31:00 +0700
Message-ID: <1260786666-8405-18-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:35:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8Gl-0008VO-1X
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328AbZLNKdp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756233AbZLNKdc
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:33:32 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:34948 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202AbZLNKdR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:33:17 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so1839222pwj.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ppkof5tEmQZAKGyMmQWHbCs3EjIOU9pjEQYp4TMXsTQ=;
        b=bzeAPNYvsC/UJg3RT+XJZlsAlaiYzcD5rjrroT9DUUiZNwwE3gLk17T7ltIp+JEGqg
         O6gCjxpGcPadPiHcFry0n2mjF/NWg/KxgrnZrIz2UEwwowM865bNGu84ANz3C/0NnDXV
         dEKe4z3LaRkDpJhTMFtHMN0Y7MMyf4PC8EW9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XGfUazp+NUED3VotHGvwTulHnestULnwGe/77wK3/m/wY3Mb2aFP6eyDyfHL911Bu0
         VZqGyFi7/RhZRfogKkkQNZgcyopdi/CRjEtCeLPykyooiW34GS5+YkT1LGDrTqP1090k
         IXVYqGWDPSO9gUs8iMi2S0D1WmTsxdJZwtDYE=
Received: by 10.115.98.11 with SMTP id a11mr3121033wam.130.1260786796922;
        Mon, 14 Dec 2009 02:33:16 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 23sm4910792pzk.12.2009.12.14.02.33.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:33:16 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:32:35 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135189>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index eb1a818..5467265 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -452,8 +452,9 @@ static int same(struct cache_entry *a, struct cache=
_entry *b)
  * When a CE gets turned into an unmerged entry, we
  * want it to be up-to-date
  */
-static int verify_uptodate(struct cache_entry *ce,
-		struct unpack_trees_options *o)
+static int verify_uptodate_1(struct cache_entry *ce,
+				   struct unpack_trees_options *o,
+				   const char *error_msg)
 {
 	struct stat st;
=20
@@ -478,7 +479,13 @@ static int verify_uptodate(struct cache_entry *ce,
 	if (errno =3D=3D ENOENT)
 		return 0;
 	return o->gently ? -1 :
-		error(ERRORMSG(o, not_uptodate_file), ce->name);
+		error(error_msg, ce->name);
+}
+
+static int verify_uptodate(struct cache_entry *ce,
+			   struct unpack_trees_options *o)
+{
+	return verify_uptodate_1(ce, o, ERRORMSG(o, not_uptodate_file));
 }
=20
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_t=
rees_options *o)
@@ -586,8 +593,9 @@ static int icase_exists(struct unpack_trees_options=
 *o, struct cache_entry *dst,
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
  */
-static int verify_absent(struct cache_entry *ce, const char *action,
-			 struct unpack_trees_options *o)
+static int verify_absent_1(struct cache_entry *ce, const char *action,
+				 struct unpack_trees_options *o,
+				 const char *error_msg)
 {
 	struct stat st;
=20
@@ -667,6 +675,11 @@ static int verify_absent(struct cache_entry *ce, c=
onst char *action,
 	}
 	return 0;
 }
+static int verify_absent(struct cache_entry *ce, const char *action,
+			 struct unpack_trees_options *o)
+{
+	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_untracke=
d));
+}
=20
 static int merged_entry(struct cache_entry *merge, struct cache_entry =
*old,
 		struct unpack_trees_options *o)
--=20
1.6.5.2.216.g9c1ec
