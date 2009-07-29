From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] Prevent diff machinery from examining worktree outside sparse checkout
Date: Wed, 29 Jul 2009 16:49:10 +1000
Message-ID: <1248850154-5469-2-git-send-email-pclouds@gmail.com>
References: <1248850154-5469-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 08:49:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW2yh-0003lG-OK
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 08:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbZG2Gt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 02:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbZG2Gt1
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 02:49:27 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:57439 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbZG2Gt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 02:49:27 -0400
Received: by pzk42 with SMTP id 42so411469pzk.33
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 23:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=C2/cNryyOPDjPbp5uqpkp5htuaMf7PEIcSsGa0ByK1Q=;
        b=K/Bx+pwBMy0zsi3SDDIR386sVChBh7Y+xPin1Wtt4nbq9WiNm3pPbZ6aRa76dPGCpr
         J/ePXuhtUWRgmLNBYntFoGPON4F4bHRqurs3AreZpnkzLKGB/sQ4a7ua47s64qh7dddU
         0wzvHtjlUP3GS9vNZK9xpLAva8/Y/nSczT948=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vjgw0vSZgY99jGWTdin3zGQ/exNtqf2/t38sb3PpIE4GTDofXJUPRnVJqCeaDfrhBv
         +6sohEhWfqhV5wzFphJibbRFix9bYGjXA80/OlFpC141/TYyFzwJ1AGcACbdBK7O4kS0
         Jq1lh3Hnsr+RvJrBaGzpiucNqxP6LgZnVp00Q=
Received: by 10.115.90.8 with SMTP id s8mr13220960wal.20.1248850167297;
        Tue, 28 Jul 2009 23:49:27 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id n9sm860084wag.23.2009.07.28.23.49.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 23:49:26 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 29 Jul 2009 16:49:21 +1000
X-Mailer: git-send-email 1.6.3.2.448.gdf8b6
In-Reply-To: <1248850154-5469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124310>

---
 diff-lib.c |    5 +++--
 diff.c     |    4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index b7813af..4094f18 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -159,7 +159,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 		}
 
-		if (ce_uptodate(ce))
+		if (ce_uptodate(ce) || ce->ce_flags & CE_VALID)
 			continue;
 
 		changed = check_removed(ce, &st);
@@ -337,6 +337,8 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	struct rev_info *revs = o->unpack_data;
 	int match_missing, cached;
 
+	/* if the entry is not checked out, don't examine work tree */
+	cached = o->index_only || (idx && idx->ce_flags & CE_VALID);
 	/*
 	 * Backward compatibility wart - "diff-index -m" does
 	 * not mean "do not ignore merges", but "match_missing".
@@ -344,7 +346,6 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	 * But with the revision flag parsing, that's found in
 	 * "!revs->ignore_merges".
 	 */
-	cached = o->index_only;
 	match_missing = !revs->ignore_merges;
 
 	if (cached && idx && ce_stage(idx)) {
diff --git a/diff.c b/diff.c
index 91d6ea2..de1bd87 100644
--- a/diff.c
+++ b/diff.c
@@ -1810,8 +1810,10 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 
 	/*
 	 * If ce matches the file in the work tree, we can reuse it.
+	 * For sparse checkout case, ce_uptodate() may be true although
+	 * the file may or may not exist in the work tree.
 	 */
-	if (ce_uptodate(ce) ||
+	if ((ce_uptodate(ce) && !(ce->ce_flags & CE_VALID)) ||
 	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
 		return 1;
 
-- 
1.6.3.2.448.gdf8b6
