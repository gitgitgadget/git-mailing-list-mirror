From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/16] Prevent diff machinery from examining worktree outside narrow checkout
Date: Sun, 14 Sep 2008 20:07:56 +0700
Message-ID: <1221397685-27715-8-git-send-email-pclouds@gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
 <1221397685-27715-6-git-send-email-pclouds@gmail.com>
 <1221397685-27715-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:10:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerMo-0005uG-V3
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbYINNJJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754103AbYINNJI
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:09:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21050 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099AbYINNJH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:09:07 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1590748wfd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=IN4rBhdFQd0M/WebIhMKLmJ7OBWZcizEKApmAJVqcOk=;
        b=jR+GDk9NPeJnTc2gK0PNbxkDRxuZP557hIteYBm+sVCZlJP3SneMFz00NyuFjARB6N
         R+Bzrj9I+K/kCvpqti50eWxqw/zhRr2TllIwpyt+g6eKrN1RreHkaUd8ZuWjMsyMKVNJ
         3Q8cmMcERp25K9MZ/0zCiTCcV6OESSotva3Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UAqcDtemW5ydcVhGr1lLma96DtVwSpw30WnGVSF0kisLLCfteiNVNhOVwkcI56lnGt
         fdsW/QWXyxAiZjhfM4ZQLzVnh2lrWEecCWO0mDP9P2OuO+MNcS/kpobWyPtQBcKhzzFM
         xzPNeEJrClfbsxK15IpmL5kTRRjqCRZbBGQP8=
Received: by 10.142.165.14 with SMTP id n14mr2265526wfe.77.1221397746766;
        Sun, 14 Sep 2008 06:09:06 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 28sm20025669wfg.15.2008.09.14.06.09.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:09:05 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:08:57 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95834>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-lib.c |    5 +++--
 diff.c     |    4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index ae96c64..992280b 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -161,7 +161,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 				continue;
 		}
=20
-		if (ce_uptodate(ce))
+		if (ce_uptodate(ce) || ce_no_checkout(ce))
 			continue;
=20
 		changed =3D check_removed(ce, &st);
@@ -348,6 +348,8 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	struct rev_info *revs =3D cbdata->revs;
 	int match_missing, cached;
=20
+	/* if the entry is not checked out, don't examine work tree */
+	cached =3D o->index_only || (idx && ce_no_checkout(idx));
 	/*
 	 * Backward compatibility wart - "diff-index -m" does
 	 * not mean "do not ignore merges", but "match_missing".
@@ -355,7 +357,6 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	 * But with the revision flag parsing, that's found in
 	 * "!revs->ignore_merges".
 	 */
-	cached =3D o->index_only;
 	match_missing =3D !revs->ignore_merges;
=20
 	if (cached && idx && ce_stage(idx)) {
diff --git a/diff.c b/diff.c
index a2f4850..7a8f520 100644
--- a/diff.c
+++ b/diff.c
@@ -1784,8 +1784,10 @@ static int reuse_worktree_file(const char *name,=
 const unsigned char *sha1, int
=20
 	/*
 	 * If ce matches the file in the work tree, we can reuse it.
+	 * For narrow checkout case, ce_uptodate() may be true although
+	 * the file may or may not exist in the work tree.
 	 */
-	if (ce_uptodate(ce) ||
+	if ((ce_uptodate(ce) && ce_checkout(ce)) ||
 	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
 		return 1;
=20
--=20
1.6.0.96.g2fad1.dirty
