From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/23] Teach diff machinery to respect skip-worktree bit
Date: Mon, 14 Dec 2009 17:30:49 +0700
Message-ID: <1260786666-8405-7-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:35:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8Gr-0008VO-Ru
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619AbZLNKen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754906AbZLNKc3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:32:29 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:60353 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbZLNKcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:32:25 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so1838737pwj.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ODvL0v3RfCAolsneyBpe8HOSIn/W6rEghyW6EyaJHbE=;
        b=V8Sb47MmhzogTai7XEzNIGHCd9/EIFtYewh7GNflZiC1ASgJ1FXa0e99fx1lcWwlDS
         v7PaScwffoQBUlzp1kkmsZo4/Ez6DIejTa1v4Ax/pCqoYabxyxAyodYWA1qrR7eLeYNL
         8ubR2wOb35shXDa6vxmFt/fyyvENe0LLiPm+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OEsZOPEcwsMrlFLJfqIuyMD1HvOiYMK5ACo8a18+T2yEGJ4r/ErHW5NzwuNz0S6ZlC
         J3i0ndReSM7EQ7HhcEv97QmBalaihjVYpbMFX4xozq8YI1/DwYJ4F2OExlNYnN5vAUBZ
         WR81vpkOMKwLjMCiDBQnLStFPbt4UPuTlJxgQ=
Received: by 10.114.189.37 with SMTP id m37mr3132000waf.67.1260786745108;
        Mon, 14 Dec 2009 02:32:25 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 20sm4896310pzk.9.2009.12.14.02.32.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:32:23 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:31:42 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135194>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-lib.c                       |    5 +++--
 diff.c                           |    2 +-
 t/t7011-skip-worktree-reading.sh |   23 +++++++++++++++++++++++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 22da66e..b0b379d 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -159,7 +159,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 				continue;
 		}
=20
-		if (ce_uptodate(ce))
+		if (ce_uptodate(ce) || ce_skip_worktree(ce))
 			continue;
=20
 		/* If CE_VALID is set, don't look at workdir for file removal */
@@ -339,7 +339,8 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	int match_missing, cached;
=20
 	/* if the entry is not checked out, don't examine work tree */
-	cached =3D o->index_only || (idx && (idx->ce_flags & CE_VALID));
+	cached =3D o->index_only ||
+		(idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree(idx)));
 	/*
 	 * Backward compatibility wart - "diff-index -m" does
 	 * not mean "do not ignore merges", but "match_missing".
diff --git a/diff.c b/diff.c
index cd35e0c..3970df4 100644
--- a/diff.c
+++ b/diff.c
@@ -1805,7 +1805,7 @@ static int reuse_worktree_file(const char *name, =
const unsigned char *sha1, int
 	 * If ce is marked as "assume unchanged", there is no
 	 * guarantee that work tree matches what we are looking for.
 	 */
-	if (ce->ce_flags & CE_VALID)
+	if ((ce->ce_flags & CE_VALID) || ce_skip_worktree(ce))
 		return 0;
=20
 	/*
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-r=
eading.sh
index ede3ee1..5db93d0 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -111,4 +111,27 @@ test_expect_success 'ls-files --modified' '
 	test -z "$(git ls-files -m)"
 '
=20
+echo ":000000 100644 $ZERO_SHA1 $NULL_SHA1 A	1" > expected
+test_expect_success 'diff-index does not examine skip-worktree absent =
entries' '
+	setup_absent &&
+	git diff-index HEAD -- 1 > result &&
+	test_cmp expected result
+'
+
+test_expect_success 'diff-index does not examine skip-worktree dirty e=
ntries' '
+	setup_dirty &&
+	git diff-index HEAD -- 1 > result &&
+	test_cmp expected result
+'
+
+test_expect_success 'diff-files does not examine skip-worktree absent =
entries' '
+	setup_absent &&
+	test -z "$(git diff-files -- one)"
+'
+
+test_expect_success 'diff-files does not examine skip-worktree dirty e=
ntries' '
+	setup_dirty &&
+	test -z "$(git diff-files -- one)"
+'
+
 test_done
--=20
1.6.5.2.216.g9c1ec
