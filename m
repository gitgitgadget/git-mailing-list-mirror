From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] diff: do not quit early on stat-dirty files
Date: Sat, 25 Jan 2014 13:46:50 +0700
Message-ID: <1390632411-3596-2-git-send-email-pclouds@gmail.com>
References: <20140123024525.B726248918@mail.valinux.co.jp>
 <1390632411-3596-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: iwamoto@valinux.co.jp, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 25 07:41:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6wwC-0000HS-Ap
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 07:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbaAYGlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jan 2014 01:41:44 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:65117 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbaAYGlY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 01:41:24 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so4073380pab.16
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 22:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5+ER1Fn7MkKnyypmvR1lUfinayBkTNTIIUNp4WVOiwE=;
        b=W5BIFWvnzclG5fPxLQTbxIG+00wZQaYz9oguKJQTh2uO3DpnpU4PFByVIWH+f1laMd
         +MTyqC0BXftRO4eIdsReUNsFTTJwJkojWkzoT8NCRnSxGhbJEdyRSAc/l4tDgkp8s5fk
         tDognhVFnMV5mraa8/1q+gZwCaoOpF/lkvpKFXR08/DWheBwaljuJsdzgTd4/PpfAaBN
         H/G2urIky5vCNYY1juoZPJWnUB7g1xgKYuNnEnHxsGrbJ6BURfOx/lH5N0KUAnOIwGCz
         L95hkwSMq0X8tZGS15FvXc9BuEyGJDpppXEH6xbiqBGCzHuNH8YkzN6MMt8Bf0f2GGXE
         F/Wg==
X-Received: by 10.66.149.73 with SMTP id ty9mr18657960pab.36.1390632084023;
        Fri, 24 Jan 2014 22:41:24 -0800 (PST)
Received: from lanh ([115.73.192.112])
        by mx.google.com with ESMTPSA id de3sm9610264pbb.33.2014.01.24.22.41.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 22:41:23 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 25 Jan 2014 13:46:58 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1390632411-3596-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241063>

When QUICK is set (i.e. with --quiet) we try to do as little work as
possible, stopping after seeing the first change. stat-dirty is
considered a "change" but it may turn out not, if no actual content is
changed. The actual content test is performed too late in the process
and the shortcut may be taken prematurely, leading to incorrect return
code.

Assume we do "git diff --quiet". If we have a stat-dirty file "a" and
a really dirty file "b". We break the loop in run_diff_files() and
stop after "a" because we have got a "change". Later in
diffcore_skip_stat_unmatch() we find out "a" is actually not
changed. But there's nothing else in the diff queue, we incorrectly
declare "no change", ignoring the fact that "b" is changed.

This also happens to "git diff --quiet HEAD" when it hits
diff_can_quit_early() in oneway_diff().

This patch does the content test earlier in order to keep going if "a"
is unchanged. The test result is cached so that when
diffcore_skip_stat_unmatch() is done in the end, we spend no cycles on
re-testing "a".

Reported-by: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c                | 22 +++++++++++++++++-----
 diffcore.h            |  2 ++
 t/t4035-diff-quiet.sh |  6 ++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 19460ff..ab85f7e 100644
--- a/diff.c
+++ b/diff.c
@@ -4699,6 +4699,11 @@ static int diff_filespec_is_identical(struct dif=
f_filespec *one,
=20
 static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
 {
+	if (p->done_skip_stat_unmatch)
+		return p->skip_stat_unmatch_result;
+
+	p->done_skip_stat_unmatch =3D 1;
+	p->skip_stat_unmatch_result =3D 0;
 	/*
 	 * 1. Entries that come from stat info dirtiness
 	 *    always have both sides (iow, not create/delete),
@@ -4720,8 +4725,8 @@ static int diff_filespec_check_stat_unmatch(struc=
t diff_filepair *p)
 	    diff_populate_filespec(p->two, 1) ||
 	    (p->one->size !=3D p->two->size) ||
 	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
-		return 1;
-	return 0;
+		p->skip_stat_unmatch_result =3D 1;
+	return p->skip_stat_unmatch_result;
 }
=20
 static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
@@ -4897,6 +4902,7 @@ void diff_change(struct diff_options *options,
 		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
 {
 	struct diff_filespec *one, *two;
+	struct diff_filepair *p;
=20
 	if (S_ISGITLINK(old_mode) && S_ISGITLINK(new_mode) &&
 	    is_submodule_ignored(concatpath, options))
@@ -4923,10 +4929,16 @@ void diff_change(struct diff_options *options,
 	fill_filespec(two, new_sha1, new_sha1_valid, new_mode);
 	one->dirty_submodule =3D old_dirty_submodule;
 	two->dirty_submodule =3D new_dirty_submodule;
+	p =3D diff_queue(&diff_queued_diff, one, two);
=20
-	diff_queue(&diff_queued_diff, one, two);
-	if (!DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
-		DIFF_OPT_SET(options, HAS_CHANGES);
+	if (DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
+		return;
+
+	if (DIFF_OPT_TST(options, QUICK) && options->skip_stat_unmatch &&
+	    !diff_filespec_check_stat_unmatch(p))
+		return;
+
+	DIFF_OPT_SET(options, HAS_CHANGES);
 }
=20
 struct diff_filepair *diff_unmerge(struct diff_options *options, const=
 char *path)
diff --git a/diffcore.h b/diffcore.h
index 1c16c85..6b538bc 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -70,6 +70,8 @@ struct diff_filepair {
 	unsigned broken_pair : 1;
 	unsigned renamed_pair : 1;
 	unsigned is_unmerged : 1;
+	unsigned done_skip_stat_unmatch : 1;
+	unsigned skip_stat_unmatch_result : 1;
 };
 #define DIFF_PAIR_UNMERGED(p) ((p)->is_unmerged)
=20
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index 231412d..e8ae2a0 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -148,4 +148,10 @@ test_expect_success 'git diff --ignore-all-space, =
both files outside repo' '
 	)
 '
=20
+test_expect_success 'git diff --quiet ignores stat-change only entries=
' '
+	test-chmtime +10 a &&
+	echo modified >>b &&
+	test_expect_code 1 git diff --quiet
+'
+
 test_done
--=20
1.8.5.2.240.g8478abd
