From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] tree_entry_interesting: inline strncmp()
Date: Mon,  4 Apr 2011 21:46:26 +0700
Message-ID: <1301928386-25038-1-git-send-email-pclouds@gmail.com>
References: <1301535481-1085-3-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	dpmcgee@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 04 16:49:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6l5X-0005XC-3F
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 16:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641Ab1DDOtA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 10:49:00 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47303 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628Ab1DDOs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 10:48:59 -0400
Received: by gwaa18 with SMTP id a18so2185460gwa.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=/fGTCbqnFaEbOFllWx2bjL3BSZhr+VO8QR1VGgNH1Y8=;
        b=ByBOQCBlUVD5D84RdC6prqsRiBFsSvD3xb1B2F4Xbu1l71Kko/hJpXvzm0ZmoxoLeF
         FDQTV/FQliStoz4IZh3k+CFSMs2evxv4BXYyXXaY7ACdfOTGWholZ4O9UFVIeumyJnlR
         VMbh29VChsS9aNlte4jm3yivmQ3y9MjWZ+hhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xgJJEtK7qAZR3pa21a7kTY7EJBz+JSugRCBb1txxgzlvgwEnn2sC2nGaN0xNNRiIhC
         CIbZ5JXKtvioOdSmE7HeDOxQmgUQ5WrIU8FY2PKO4iuMY40Eg7Zzc5HRXuY4WBZf+eaI
         apnE0Hx6S70NyHqrYr2oMe9K6e/bHXqfVIkgk=
Received: by 10.42.135.193 with SMTP id q1mr8948975ict.41.1301928538678;
        Mon, 04 Apr 2011 07:48:58 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.251.245])
        by mx.google.com with ESMTPS id e9sm507875ibb.32.2011.04.04.07.48.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 07:48:56 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 04 Apr 2011 21:46:27 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1301535481-1085-3-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170813>

strncmp() is the function that takes most of the time inside
tree_entry_interesting(). Inline it so we can shave some seconds out
of function call time.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Turns out simplicity is the best. My straight copy of strncmp from
 glibc performed worse.

 With this I get a slightly better performance than Dan's 3/5:
 81.07-82.27 secs versus 82.02-82.92 (no other patches are applied).
 But I'm happy even if it gives the same or slightly worse
 performance because this applies to more cases than flat top tree
 case.

 Dan, match_dir_prefix() can also use some reordering to avoid
 strncmp(). But I suppose it won't give much gain on packages.git

 tree-walk.c |   28 ++++++++++++++++++++++++----
 1 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 322becc..80bfc3a 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -457,6 +457,26 @@ int get_tree_entry(const unsigned char *tree_sha1,=
 const char *name, unsigned ch
 	return retval;
 }
=20
+/* Static version of strncmp to reduce function call cost */
+static inline int strncmp_1(const char *s1, const char *s2, size_t n)
+{
+	unsigned char c1 =3D '\0';
+	unsigned char c2 =3D '\0';
+
+	if (!n)
+		return 0;
+
+	while (n > 0) {
+		c1 =3D (unsigned char) *s1++;
+		c2 =3D (unsigned char) *s2++;
+		if (c1 =3D=3D '\0' || c1 !=3D c2)
+			return c1 - c2;
+		n--;
+	}
+
+	return c1 - c2;
+}
+
 static int match_entry(const struct name_entry *entry, int pathlen,
 		       const char *match, int matchlen,
 		       int *never_interesting)
@@ -473,7 +493,7 @@ static int match_entry(const struct name_entry *ent=
ry, int pathlen,
 		 * Does match sort strictly earlier than path
 		 * with their common parts?
 		 */
-		m =3D strncmp(match, entry->path,
+		m =3D strncmp_1(match, entry->path,
 			    (matchlen < pathlen) ? matchlen : pathlen);
 		if (m < 0)
 			return 0;
@@ -509,7 +529,7 @@ static int match_entry(const struct name_entry *ent=
ry, int pathlen,
 		 * we cheated and did not do strncmp(), so we do
 		 * that here.
 		 */
-		m =3D strncmp(match, entry->path, pathlen);
+		m =3D strncmp_1(match, entry->path, pathlen);
=20
 	/*
 	 * If common part matched earlier then it is a hit,
@@ -525,7 +545,7 @@ static int match_entry(const struct name_entry *ent=
ry, int pathlen,
 static int match_dir_prefix(const char *base, int baselen,
 			    const char *match, int matchlen)
 {
-	if (strncmp(base, match, matchlen))
+	if (strncmp_1(base, match, matchlen))
 		return 0;
=20
 	/*
@@ -592,7 +612,7 @@ int tree_entry_interesting(const struct name_entry =
*entry,
 		}
=20
 		/* Does the base match? */
-		if (!strncmp(base_str, match, baselen)) {
+		if (!strncmp_1(base_str, match, baselen)) {
 			if (match_entry(entry, pathlen,
 					match + baselen, matchlen - baselen,
 					&never_interesting))
--=20
1.7.4.74.g639db
