From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: [PATCH v5/GSoC/MICRO] revision: forbid combining --graph and --no-walk
Date: Wed, 18 Mar 2015 13:34:01 +0800
Message-ID: <075bb408bff8cbbd4dfaed91d2b21361546d2c39.1426643446.git.dongcan.jiang@gmail.com>
References: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com, l.s.r@web.de,
	Dongcan Jiang <dongcan.jiang@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 07:10:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY7Bs-0005mV-Vi
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 07:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbbCRGKZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2015 02:10:25 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34921 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbbCRGKY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 02:10:24 -0400
Received: by pabyw6 with SMTP id yw6so32618510pab.2
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 23:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lbQ35aWLIGH8sS0e50Mj31kdxGY7BPP6rSxLtGzIDfA=;
        b=nRrYdmgsN1h3XYg+i0TUZsuI854GN+84R9zGlhz50RhnI+ns9rHL/4navC11TKrRWk
         ZhD+zJXA1/uB0/v5LsckGXTeznW2xQUb5ZYCBH2Rn7Yz9wCeuPeGoQyczbIoxHjBsxuK
         d4S+HALJkTAk8r0vHCGbdDiZQq24+EVcVA7k3FbGyOe5SB2adIKw7fmLYPdVoEdQ+2qc
         BfFrJQztJUl8awd7o4iWerN3NZwB0170KzBsdAEGP35A+iBvIM5wgm8hfp9gUUwVBzF7
         hEAX9xno3QbZI+w8BkkwLXdguelB5cn849W/ynPPCcKeOnvG8Tf23axEE6zSkf4cl1dw
         bpgw==
X-Received: by 10.66.248.40 with SMTP id yj8mr40776792pac.141.1426659023532;
        Tue, 17 Mar 2015 23:10:23 -0700 (PDT)
Received: from localhost.localdomain ([162.105.205.253])
        by mx.google.com with ESMTPSA id tg14sm25515860pac.15.2015.03.17.23.10.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Mar 2015 23:10:22 -0700 (PDT)
X-Mailer: git-send-email 2.3.2.224.g6c2f212
In-Reply-To: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265680>

Because "--graph" is about connected history while --no-walk
is about discrete points, it does not make sense to allow
giving these two options at the same time. [1]

This change makes a few calls to "show --graph" fail in
t4052, but asking to show one commit with graph is a
nonsensical thing to do. Thus, tests on "show --graph" in
t4052 have been removed. [2,3] Same tests on "show" without
--graph option have already been tested in 4052.

3 testcases have been added to test this patch.

[1]: http://article.gmane.org/gmane.comp.version-control.git/216083
[2]: http://article.gmane.org/gmane.comp.version-control.git/264950
[3]: http://article.gmane.org/gmane.comp.version-control.git/265107

Helped-By: Eric Sunshine <sunshine@sunshineco.com>
Helped-By: Ren=C3=A9 Scharfe <l.s.r@web.de>
Helped-By: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
---
 Documentation/rev-list-options.txt |  2 ++
 revision.c                         |  2 ++
 t/t4052-stat-output.sh             | 14 +++++++-------
 t/t4202-log.sh                     |  4 ++++
 t/t6014-rev-list-all.sh            |  4 ++++
 t/t7007-show.sh                    |  4 ++++
 6 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 4ed8587..136abdf 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -679,6 +679,7 @@ endif::git-rev-list[]
 	given on the command line. Otherwise (if `sorted` or no argument
 	was given), the commits are shown in reverse chronological order
 	by commit time.
+	Cannot be combined with `--graph`.
=20
 --do-walk::
 	Overrides a previous `--no-walk`.
@@ -781,6 +782,7 @@ you would get an output like this:
 	on the left hand side of the output.  This may cause extra lines
 	to be printed in between commits, in order for the graph history
 	to be drawn properly.
+	Cannot be combined with `--no-walk`.
 +
 This enables parent rewriting, see 'History Simplification' below.
 +
diff --git a/revision.c b/revision.c
index 66520c6..6cd91dd 100644
--- a/revision.c
+++ b/revision.c
@@ -2339,6 +2339,8 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
=20
 	if (revs->reflog_info && revs->graph)
 		die("cannot combine --walk-reflogs with --graph");
+	if (revs->no_walk && revs->graph)
+		die("cannot combine --no-walk with --graph");
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die("cannot use --grep-reflog without --walk-reflogs");
=20
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index b68afef..54f10cf 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -99,7 +99,7 @@ do
 		test_cmp "$expect" actual
 	'
=20
-	test "$cmd" !=3D diff || continue
+	test "$cmd" !=3D diff && test "$cmd" !=3D show || continue
=20
 	test_expect_success "$cmd --graph $verb COLUMNS (big change)" '
 		COLUMNS=3D200 git $cmd $args --graph >output
@@ -127,7 +127,7 @@ do
 		test_cmp "$expect" actual
 	'
=20
-	test "$cmd" !=3D diff || continue
+	test "$cmd" !=3D diff && test "$cmd" !=3D show || continue
=20
 	test_expect_success "$cmd --graph $verb not enough COLUMNS (big chang=
e)" '
 		COLUMNS=3D40 git $cmd $args --graph >output
@@ -155,7 +155,7 @@ do
 		test_cmp "$expect" actual
 	'
=20
-	test "$cmd" !=3D diff || continue
+	test "$cmd" !=3D diff && test "$cmd" !=3D show || continue
=20
 	test_expect_success "$cmd --graph $verb statGraphWidth config" '
 		git -c diff.statGraphWidth=3D26 $cmd $args --graph >output
@@ -196,7 +196,7 @@ do
 		test_cmp expect actual
 	'
=20
-	test "$cmd" !=3D diff || continue
+	test "$cmd" !=3D diff && test "$cmd" !=3D show || continue
=20
 	test_expect_success "$cmd --stat-width=3Dwidth --graph with big chang=
e" '
 		git $cmd $args --stat-width=3D40 --graph >output
@@ -236,7 +236,7 @@ do
 		test_cmp expect actual
 	'
=20
-	test "$cmd" !=3D diff || continue
+	test "$cmd" !=3D diff && test "$cmd" !=3D show || continue
=20
 	test_expect_success "$cmd --stat=3Dwidth --graph with big change is b=
alanced" '
 		git $cmd $args --stat-width=3D60 --graph >output &&
@@ -270,7 +270,7 @@ do
 		test_cmp "$expect" actual
 	'
=20
-	test "$cmd" !=3D diff || continue
+	test "$cmd" !=3D diff && test "$cmd" !=3D show || continue
=20
 	test_expect_success "$cmd --graph $verb COLUMNS (long filename)" '
 		COLUMNS=3D200 git $cmd $args --graph >output
@@ -299,7 +299,7 @@ do
 		test_cmp "$expect" actual
 	'
=20
-	test "$cmd" !=3D diff || continue
+	test "$cmd" !=3D diff && test "$cmd" !=3D show || continue
=20
 	test_expect_success COLUMNS_CAN_BE_1 \
 		"$cmd --graph $verb prefix greater than COLUMNS (big change)" '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 5f2b290..f111705 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -887,4 +887,8 @@ test_expect_success GPG 'log --graph --show-signatu=
re for merged tag' '
 	grep "^| | gpg: Good signature" actual
 '
=20
+test_expect_success 'log --graph --no-walk is forbidden' '
+	test_must_fail git log --graph --no-walk
+'
+
 test_done
diff --git a/t/t6014-rev-list-all.sh b/t/t6014-rev-list-all.sh
index 991ab4a..c9bedd2 100755
--- a/t/t6014-rev-list-all.sh
+++ b/t/t6014-rev-list-all.sh
@@ -35,4 +35,8 @@ test_expect_success 'repack does not lose detached HE=
AD' '
=20
 '
=20
+test_expect_success 'rev-list --graph --no-walk is forbidden' '
+	test_must_fail git rev-list --graph --no-walk HEAD
+'
+
 test_done
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index 1b824fe..42d3db6 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -124,4 +124,8 @@ test_expect_success '--quiet suppresses diff' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'show --graph is forbidden' '
+  test_must_fail git show --graph HEAD
+'
+
 test_done
--=20
2.3.2.224.g6c2f212
