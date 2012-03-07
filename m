From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] Make the largest pack the first one in the pack search queue
Date: Wed,  7 Mar 2012 10:01:48 +0700
Message-ID: <1331089308-16706-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 04:02:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S578y-0003W2-KA
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 04:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758944Ab2CGDCU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 22:02:20 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51417 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758751Ab2CGDCT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 22:02:19 -0500
Received: by pbcun15 with SMTP id un15so121298pbc.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 19:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=vn0P97hzL3tdYwBPK0VxHq6MoPy1GWwLqm5lg7SvNxU=;
        b=i/GdhaNy7SONfk2o6alGe7GWw9Vz1TpXI9uM2aDVr6Lve7c44Od2w8Iy7Rd9G11O0w
         2m8myQ0nAkUwAg3QppDCB483GLBaWu7hBDLW3OecabpzE/mUVrT0xhkADADwJyGIx2wp
         f7eGxKKXd4JJbH2CCH+pNvMJXq9A5fGJUT1S6GdixBCqs0f/6ZDVENYd5hzTn7NHX6Ev
         DfO8/FMk+xl4lxhJBGNmcgxGOXHQl+XoUrpZYfkAuroy+X95rc6rtdTsxMJVohVY+tUa
         cCiZAiPu0zJMVtc4QT6Z4YO+7jhXLysOyi04gOIQKfbq0TXeaFbs0DM0/czkAIFXX9yV
         6Grg==
Received: by 10.68.204.6 with SMTP id ku6mr1231252pbc.157.1331089338968;
        Tue, 06 Mar 2012 19:02:18 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id p2sm17272839pbb.14.2012.03.06.19.02.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 19:02:18 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 07 Mar 2012 10:01:51 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192425>

When git looks for an object in a pack, it has to go through all the
pack indexes. Pack order becomes important because if the pack is
found early, the search stops early. Git sorts packs by mostly by
mtime, favoring recent packs.

This strategy however puts the main pack at the bottom because the
main pack is usually created at clone time and occasional "repack -ad",
so likely the oldest. Though being the largest pack, this pack is
likely hit (even latest commits have unchanged parts, which is likely
in the main pack).

This patch changes pack order a little bit, putting the main pack on
top, the rest is ordered as usual. When we look for latest changes,
it'll likely miss the main pack. But after the first miss,
"last_found_pack" optimization kicks in, thus reduce the miss cost.

I modified find_pack_entry() to record pack misses, then do a few
commonly used commands like "git diff", "git diff --cached", "git diff
HEAD", "git status", "git branch -v", "git log"... Pack miss decreased
in all cases. So I think this might be a good heuristic. But this is
micro-optmization and probably does not give us any significant
performance gain.

A probably better way to improve too-many-packs situation is create
meta-index in memory for small packs.

An implementation note, packed_git->num_objects should be used to
determine the largest pack, but that field may not be available until
open_packed_git() is called. pack_size should be a good enough
approximation.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 798cd46..05ece2d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1072,6 +1072,24 @@ static int sort_pack(const void *a_, const void =
*b_)
 	return -1;
 }
=20
+static int sort_pack_by_size(const void *a_, const void *b_)
+{
+	struct packed_git *a =3D *((struct packed_git **)a_);
+	struct packed_git *b =3D *((struct packed_git **)b_);
+	int st;
+
+	/*
+	 * Local packs tend to contain objects specific to our
+	 * variant of the project than remote ones.  In addition,
+	 * remote ones could be on a network mounted filesystem.
+	 * Favor local ones for these reasons.
+	 */
+	st =3D a->pack_local - b->pack_local;
+	if (st)
+		return -st;
+	return b->pack_size - a->pack_size;
+}
+
 static void rearrange_packed_git(void)
 {
 	struct packed_git **ary, *p;
@@ -1087,7 +1105,8 @@ static void rearrange_packed_git(void)
 	for (n =3D 0, p =3D packed_git; p; p =3D p->next)
 		ary[n++] =3D p;
=20
-	qsort(ary, n, sizeof(struct packed_git *), sort_pack);
+	qsort(ary, n, sizeof(struct packed_git *), sort_pack_by_size);
+	qsort(ary + 1, n - 1, sizeof(struct packed_git *), sort_pack);
=20
 	/* link them back again */
 	for (i =3D 0; i < n - 1; i++)
--=20
1.7.3.1.256.g2539c.dirty
