From: =?UTF-8?q?M=C3=A5rten=20Kongstad?= <marten.kongstad@gmail.com>
Subject: [PATCH] diff --shortstat --dirstat: remove duplicate output
Date: Sat, 28 Feb 2015 14:19:27 +0100
Message-ID: <1425129567-18693-1-git-send-email-marten.kongstad@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, johan@herland.net, marten.kongstad@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 14:19:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRhJ8-0006bI-Jw
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 14:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbbB1NTq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2015 08:19:46 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:44047 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbbB1NTp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 08:19:45 -0500
Received: by lams18 with SMTP id s18so22420820lam.11
        for <git@vger.kernel.org>; Sat, 28 Feb 2015 05:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=RdzQlXD/Csj+bcfFsH+Mw6WdpjYf9LEzZyYBB9ARlMA=;
        b=tDKFoQ4y+ihooiiCVZlT/fpScoMk+pjO6GrmuB2JNCiG3jvpUuvKpn7/vAAjV+PXlx
         ylsffr72BX7yWMYpKs804QqJ/e9GiWQyCGRyPE21wIwHp2YRuOLlXQV5zEPH22jAtOdY
         7IRx/aA/D48BB/6N9hhxSeFJbCQ94vZjkv6Y+DioEqEPYy0XTe3/SQoI4e9PCwPOVX90
         tUAxwqRdSVvx5a4doq+FYdnl+oCvNO3W0DSlB7CTOtoB7ne2GoeQ5kUhFPhHR588L76y
         z2TIO5imEoHhw/sGjslB+57QOolQw9BuEN2BJz0fN4iKEykCWLoBg//99Zt/LVgwclpQ
         8NIw==
X-Received: by 10.152.21.100 with SMTP id u4mr16628806lae.41.1425129584034;
        Sat, 28 Feb 2015 05:19:44 -0800 (PST)
Received: from localhost.localdomain ([95.109.106.222])
        by mx.google.com with ESMTPSA id n12sm1449438lbg.31.2015.02.28.05.19.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 28 Feb 2015 05:19:43 -0800 (PST)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264530>

When --shortstat is used in conjunction with --dirstat=3Dchanges, git d=
iff will
output the dirstat information twice: first as calculated by the 'lines=
'
algorithm, then as calculated by the 'changes' algorithm:

    $ git diff --dirstat=3Dchanges,10 --shortstat v2.2.0..v2.2.1
     23 files changed, 453 insertions(+), 54 deletions(-)
      33.5% Documentation/RelNotes/
      26.2% t/
      46.6% Documentation/RelNotes/
      16.6% t/

The same duplication happens for --shortstat together with --dirstat=3D=
files, but
not for --shortstat together with --dirstat=3Dlines.

Limit output to only include one dirstat part, calculated as specified
by the --dirstat parameter. Also, add test for this.

Signed-off-by: M=C3=A5rten Kongstad <marten.kongstad@gmail.com>
---
 diff.c                  |  2 +-
 t/t4047-diff-dirstat.sh | 52 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index d1bd534..abc32c8 100644
--- a/diff.c
+++ b/diff.c
@@ -4541,7 +4541,7 @@ void diff_flush(struct diff_options *options)
 			show_stats(&diffstat, options);
 		if (output_format & DIFF_FORMAT_SHORTSTAT)
 			show_shortstats(&diffstat, options);
-		if (output_format & DIFF_FORMAT_DIRSTAT)
+		if (output_format & DIFF_FORMAT_DIRSTAT && dirstat_by_line)
 			show_dirstat_by_line(&diffstat, options);
 		free_diffstat_info(&diffstat);
 		separator++;
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index ed7e093..208760e 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -973,4 +973,56 @@ test_expect_success 'diff.dirstat=3Dfuture_param,0=
,lines should warn, but still wo
 	test_i18ngrep -q "diff\\.dirstat" actual_error
 '
=20
+cat <<EOF >expect_diff_shortstat_dirstat_changes
+ 11 files changed, 62 insertions(+), 32 deletions(-)
+  10.8% dst/copy/changed/
+  10.8% dst/copy/rearranged/
+  10.8% dst/copy/unchanged/
+  10.8% dst/move/changed/
+  10.8% dst/move/rearranged/
+  10.8% dst/move/unchanged/
+  10.8% src/move/changed/
+  10.8% src/move/rearranged/
+  10.8% src/move/unchanged/
+EOF
+
+cat <<EOF >expect_diff_shortstat_dirstat_lines
+ 11 files changed, 62 insertions(+), 32 deletions(-)
+  10.6% dst/copy/changed/
+  10.6% dst/copy/rearranged/
+  10.6% dst/copy/unchanged/
+  10.6% dst/move/changed/
+  10.6% dst/move/rearranged/
+  10.6% dst/move/unchanged/
+  10.6% src/move/changed/
+  10.6% src/move/rearranged/
+  10.6% src/move/unchanged/
+EOF
+
+cat <<EOF >expect_diff_shortstat_dirstat_files
+ 11 files changed, 62 insertions(+), 32 deletions(-)
+   9.0% changed/
+   9.0% dst/copy/changed/
+   9.0% dst/copy/rearranged/
+   9.0% dst/copy/unchanged/
+   9.0% dst/move/changed/
+   9.0% dst/move/rearranged/
+   9.0% dst/move/unchanged/
+   9.0% rearranged/
+   9.0% src/move/changed/
+   9.0% src/move/rearranged/
+   9.0% src/move/unchanged/
+EOF
+
+test_expect_success '--shortstat --dirstat should output only one dirs=
tat' '
+	git diff --shortstat --dirstat=3Dchanges HEAD^..HEAD >actual_diff_sho=
rtstat_dirstat_changes &&
+	test_cmp expect_diff_shortstat_dirstat_changes actual_diff_shortstat_=
dirstat_changes &&
+
+	git diff --shortstat --dirstat=3Dlines HEAD^..HEAD >actual_diff_short=
stat_dirstat_lines &&
+	test_cmp expect_diff_shortstat_dirstat_lines actual_diff_shortstat_di=
rstat_lines &&
+
+	git diff --shortstat --dirstat=3Dfiles HEAD^..HEAD >actual_diff_short=
stat_dirstat_files &&
+	test_cmp expect_diff_shortstat_dirstat_files actual_diff_shortstat_di=
rstat_files
+'
+
 test_done
--=20
1.9.1
