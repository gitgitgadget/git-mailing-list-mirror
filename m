From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v3 1/8] Prevent diff machinery from examining assume-unchanged entries on worktree
Date: Tue, 11 Aug 2009 22:43:59 +0700
Message-ID: <1250005446-12047-2-git-send-email-pclouds@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:44:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MatWW-0006kj-Rx
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbZHKPoU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 11:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbZHKPoU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:44:20 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:57516 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbZHKPoT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 11:44:19 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1415154wfd.4
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=fWfnv/rJ8sgwfkVidEqjcV8SYxgVzCQ+qXhBFYqaG18=;
        b=MN/AX0P+O4dt++EK+cr30srkztKuWpkw+QmLU2QrviLEnJCmzcEd09ymusgUHFDYn4
         /+GyUO4qqEveYvG7y4ltOpTE21nrPY/Km/NY0sU2manEIaEUXX1yeuO5kB1qDdN/LauQ
         gBnbrJ1rYcTmuqFjh1nW282kOHVBotqZ0uPkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MAVykEk7ovHC+q6CmiBbp/cLty3c5qj/qYHX8904FjcFPbajAW4JSkTS/o3uQqYlIE
         2iusvhNpESXldqpjTLN455A6JtYMyDxzdsTxIw15GmHgtDE73xBymFh9+1GNeo+DH8lg
         9lNDSBOdJnjfYwHgk5kMKGetG92T6zHgOdx6w=
Received: by 10.140.165.7 with SMTP id n7mr486080rve.2.1250005460775;
        Tue, 11 Aug 2009 08:44:20 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.239.0])
        by mx.google.com with ESMTPS id g14sm32709306rvb.0.2009.08.11.08.44.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 08:44:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 11 Aug 2009 22:44:15 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125576>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-lib.c                       |    6 ++++--
 t/t4039-diff-assume-unchanged.sh |   31 ++++++++++++++++++++++++++++++=
+
 2 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100755 t/t4039-diff-assume-unchanged.sh

diff --git a/diff-lib.c b/diff-lib.c
index b7813af..e5b9fe0 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -162,7 +162,8 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 		if (ce_uptodate(ce))
 			continue;
=20
-		changed =3D check_removed(ce, &st);
+		/* If CE_VALID is set, don't look at workdir for file removal */
+		changed =3D (ce->ce_flags & CE_VALID) ? 0 : check_removed(ce, &st);
 		if (changed) {
 			if (changed < 0) {
 				perror(ce->name);
@@ -337,6 +338,8 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	struct rev_info *revs =3D o->unpack_data;
 	int match_missing, cached;
=20
+	/* if the entry is not checked out, don't examine work tree */
+	cached =3D o->index_only || (idx && (idx->ce_flags & CE_VALID));
 	/*
 	 * Backward compatibility wart - "diff-index -m" does
 	 * not mean "do not ignore merges", but "match_missing".
@@ -344,7 +347,6 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	 * But with the revision flag parsing, that's found in
 	 * "!revs->ignore_merges".
 	 */
-	cached =3D o->index_only;
 	match_missing =3D !revs->ignore_merges;
=20
 	if (cached && idx && ce_stage(idx)) {
diff --git a/t/t4039-diff-assume-unchanged.sh b/t/t4039-diff-assume-unc=
hanged.sh
new file mode 100755
index 0000000..9d9498b
--- /dev/null
+++ b/t/t4039-diff-assume-unchanged.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description=3D'diff with assume-unchanged entries'
+
+. ./test-lib.sh
+
+# external diff has been tested in t4020-diff-external.sh
+
+test_expect_success 'setup' '
+	echo zero > zero &&
+	git add zero &&
+	git commit -m zero &&
+	echo one > one &&
+	echo two > two &&
+	git add one two &&
+	git commit -m onetwo &&
+	git update-index --assume-unchanged one &&
+	echo borked >> one &&
+	test "$(git ls-files -v one)" =3D "h one"
+'
+
+test_expect_success 'diff-index does not examine assume-unchanged entr=
ies' '
+	git diff-index HEAD^ -- one | grep -q 5626abf0f72e58d7a153368ba57db4c=
673c0e171
+'
+
+test_expect_success 'diff-files does not examine assume-unchanged entr=
ies' '
+	rm one &&
+	test -z "$(git diff-files -- one)"
+'
+
+test_done
--=20
1.6.3.GIT
