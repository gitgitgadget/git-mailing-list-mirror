From: =?UTF-8?q?M=C3=A5rten=20Kongstad?= <marten.kongstad@gmail.com>
Subject: [PATCH v3] diff --shortstat --dirstat: remove duplicate output
Date: Mon,  2 Mar 2015 16:05:39 +0100
Message-ID: <1425308739-13082-1-git-send-email-marten.kongstad@gmail.com>
References: <20150302020009.Horde.9sATpKnsrWQkGadaRTvxkA3@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: szeder@ira.uka.de, tboegi@web.de, gitster@pobox.com,
	johan@herland.net, marten.kongstad@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 16:06:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSRv8-0001XS-18
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 16:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022AbbCBPGE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2015 10:06:04 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:43372 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbbCBPGD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 10:06:03 -0500
Received: by labgf13 with SMTP id gf13so6288854lab.10
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 07:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TT+IUry3o+QWundJ9+sJFYGMbexvHxnzz1FBjyZFK2A=;
        b=O2CSEIKfnYjsvdVSfCt84trbZfv+L4DYNl3EkgKyJxA6L952B3ejhTcj9OE/YzxuIA
         PG/ICtzP0WO7VAAZMRtFpFTtj9wCzGtjxtefHi3FYEOUc5ohQotUpbtUp4y7M+n08iHA
         +xljiziqhwG5ALBTmGGyUsngpC+x1gN7X/SnrWezbpjo4bPo8CDe5UJUGSzTvJFYtH4O
         dYhyLSFMbvnykP1fkz4ZRNs/UtoK1TcAAclR5IKP+sQkHJHxIYtlIt6NRLmRkhDWhySh
         XKI6Z2OiuNhgvfImjkIHdlpQU+64nj1+YBobGrYleVyB5iVCaAr0/hWfiw1rZo9x9WIm
         uOzw==
X-Received: by 10.112.162.167 with SMTP id yb7mr23969698lbb.76.1425308761173;
        Mon, 02 Mar 2015 07:06:01 -0800 (PST)
Received: from localhost.localdomain ([95.109.106.222])
        by mx.google.com with ESMTPSA id rn9sm2592279lbb.23.2015.03.02.07.06.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Mar 2015 07:06:00 -0800 (PST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20150302020009.Horde.9sATpKnsrWQkGadaRTvxkA3@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264601>

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
v3: change how tests count (part of) the dirstat number of lines: inste=
ad of
'grep -c', use 'grep >filename && test_line_count'. Thanks to Torsten
B=C3=B6gershausen and SZEDER G=C3=A1bor for pointing out how to improve=
 the tests.

 diff.c                  |  2 +-
 t/t4047-diff-dirstat.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

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
index ed7e093..065d74f 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -973,4 +973,15 @@ test_expect_success 'diff.dirstat=3Dfuture_param,0=
,lines should warn, but still wo
 	test_i18ngrep -q "diff\\.dirstat" actual_error
 '
=20
+test_expect_success '--shortstat --dirstat should output only one dirs=
tat' '
+	git diff --shortstat --dirstat=3Dchanges HEAD^..HEAD | grep " dst/cop=
y/changed/$" >actual_diff_shortstat_dirstat_changes &&
+	test_line_count =3D 1 actual_diff_shortstat_dirstat_changes &&
+
+	git diff --shortstat --dirstat=3Dlines HEAD^..HEAD | grep " dst/copy/=
changed/$" >actual_diff_shortstat_dirstat_lines &&
+	test_line_count =3D 1 actual_diff_shortstat_dirstat_lines &&
+
+	git diff --shortstat --dirstat=3Dfiles HEAD^..HEAD | grep " dst/copy/=
changed/$" >actual_diff_shortstat_dirstat_files &&
+	test_line_count =3D 1 actual_diff_shortstat_dirstat_files
+'
+
 test_done
--=20
1.9.1
