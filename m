From: =?UTF-8?q?M=C3=A5rten=20Kongstad?= <marten.kongstad@gmail.com>
Subject: [PATCH v2] diff --shortstat --dirstat: remove duplicate output
Date: Sun,  1 Mar 2015 08:39:06 +0100
Message-ID: <1425195546-15637-1-git-send-email-marten.kongstad@gmail.com>
References: <xmqqegp9gyof.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, johan@herland.net, marten.kongstad@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 08:40:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRyTn-0006rn-I8
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 08:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbbCAHjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2015 02:39:37 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:41748 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbbCAHjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 02:39:36 -0500
Received: by labgd6 with SMTP id gd6so24794870lab.8
        for <git@vger.kernel.org>; Sat, 28 Feb 2015 23:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oEyVA60t7axVRsS/ytRwnss4UOoGwKGfqjcoI8ZGnuY=;
        b=NoqDqaq31RdRfF0bMYFIfMy/LiAOIhEubeGyw+4wTt7P1g7thfGWXMrW2T7yNlML3H
         wbvPAx2VvnkWaOjCbByASKhwpp1m8NXjdTS8o5IX4we4Iv46fHgeyFUBnrx95uwk1txU
         9teKcqZKmWYrhNJd1fns39OC/ZNS5eRywqgStbDbcvZyO/gEhk4vweaY5ZZkRVpRZZ6J
         JowBf8hmrHk7ciaCfzlWIYWG2mQazLLS5/OMADvObweFByekVY9ZYM4nV9/1isCVIHil
         bNK55D82UA0wNXjVariCeQEIYXimMRqSodtgsFmAsZJLPM2Ld1DtEq9cstizMnF6OJ9l
         TLqg==
X-Received: by 10.112.170.100 with SMTP id al4mr19757218lbc.42.1425195574530;
        Sat, 28 Feb 2015 23:39:34 -0800 (PST)
Received: from localhost.localdomain ([95.109.106.222])
        by mx.google.com with ESMTPSA id x9sm1831433lax.20.2015.02.28.23.39.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 28 Feb 2015 23:39:34 -0800 (PST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <xmqqegp9gyof.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264552>

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
Good point about hardcoded values in the tests. How about instead we ch=
eck that
a specific directory appears exactly once in the output?

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
index ed7e093..128f7bf 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -973,4 +973,15 @@ test_expect_success 'diff.dirstat=3Dfuture_param,0=
,lines should warn, but still wo
 	test_i18ngrep -q "diff\\.dirstat" actual_error
 '
=20
+test_expect_success '--shortstat --dirstat should output only one dirs=
tat' '
+	git diff --shortstat --dirstat=3Dchanges HEAD^..HEAD >actual_diff_sho=
rtstat_dirstat_changes &&
+	test $(grep -c " dst/copy/changed/$" actual_diff_shortstat_dirstat_ch=
anges) =3D 1 &&
+
+	git diff --shortstat --dirstat=3Dlines HEAD^..HEAD >actual_diff_short=
stat_dirstat_lines &&
+	test $(grep -c " dst/copy/changed/$" actual_diff_shortstat_dirstat_li=
nes) =3D 1 &&
+
+	git diff --shortstat --dirstat=3Dfiles HEAD^..HEAD >actual_diff_short=
stat_dirstat_files &&
+	test $(grep -c " dst/copy/changed/$" actual_diff_shortstat_dirstat_fi=
les) =3D 1
+'
+
 test_done
--=20
1.9.1
