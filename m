From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 3/3] commit::print_summary(): set rev_info.always_show_header to 1
Date: Fri,  4 Jun 2010 16:21:00 +0800
Message-ID: <1275639660-5344-1-git-send-email-rctay89@gmail.com>
References: <AANLkTimuTIugURlYxwbk7wGW2IM11YTy4P91YDguLQUb@mail.gmail.com>, <7v4ohlatwn.fsf@alter.siamese.dyndns.org>, <1274974492-4692-4-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 04 10:22:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKSAT-0006uy-UJ
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 10:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab0FDIWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 04:22:10 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:35955 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab0FDIWH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 04:22:07 -0400
Received: by pzk15 with SMTP id 15so735509pzk.15
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Pogv5mu0yHspGjdWrBkMjeD+C5wcZasIk8n/Jbez42s=;
        b=PwiNwGGtFHIrT72pDigBwJQL9lMGei+vqkU3DVB45aQQFN94coxehEOqR7sQTjE/bK
         DTsyRO6GXNdxdF66nAp70sjB0oyrCLuu2Y2LsMd/BSdnRRzicf9S65GCEIG+EP1rWgVD
         JdJyUS/Mx6JUkDjaS3wKMvW9ntcY8jH8a7DQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lWk4u6LlLFEj9uOCpXMPhYQiKa/SEa3Tfuc1Jd/iAPvfbAl5G21fpeEDtWwHzN8Y6E
         lCS6VvCSPjJGJRgz6NdAbTUt0T5LQ9ZimZpHwlJM3kLLcW9uUgp9mcMPtjUUCc0tCrQp
         ON/s+iUwjJsdY8T0m4s3pwA372Vw5hMS3iU4w=
Received: by 10.115.134.10 with SMTP id l10mr8323092wan.138.1275639726436;
        Fri, 04 Jun 2010 01:22:06 -0700 (PDT)
Received: from localhost.localdomain (cm249.zeta152.maxonline.com.sg [116.87.152.249])
        by mx.google.com with ESMTPS id a23sm6681845wam.2.2010.06.04.01.21.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 01:22:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.352.g12d15
In-Reply-To: <AANLkTimuTIugURlYxwbk7wGW2IM11YTy4P91YDguLQUb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148385>

This attempts to fix a regression in git-commit, where non-abbreviated
SHA-1s were printed in the summary.

One possible fix would be to set ctx.abbrev to DEFAULT_ABBREV in the
`if` block.

However, we remove this codeblock altogether, and set
rev.always_show_header. This way, we use back the same show_log()
mechanism (instead of format_commit_message()).

Quoting log-tree.c:560:

	shown = log_tree_diff(opt, commit, &log);
	if (!shown && opt->loginfo && opt->always_show_header) {
		log.parent = NULL;
		show_log(opt);
		shown = 1;
	}

This is the only area that always_show_header is checked, so the
setting of this flag should only affect this area.

Also, we now die() if log_tree_commit() returns false. Based on the
existing underlying codepaths (log_tree_commit(), log_tree_diff(),
log_tree_diff_flush(), to name a few), this should not occur; changes to
these codepaths may warrant a revision of our handling of this
situation. Tests #2 and #3 in t7502 should aid in detecting such
breakages.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

This is a reworked version of the third patch of the
'tc/commit-abbrev-fix' series; there are no changes to the first and
second patches.

Changes from v2:
 - shift around 2nd and 3rd paras.
 - mention the die() and our assumption that it won't be triggered, as
   suggested by Junio.

 builtin/commit.c  |   13 ++++---------
 t/t7502-commit.sh |    4 ++--
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a4e4966..2884d0c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1148,7 +1148,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	rev.verbose_header = 1;
 	rev.show_root_diff = 1;
 	get_commit_format(format.buf, &rev);
-	rev.always_show_header = 0;
+	rev.always_show_header = 1;
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 100;
 	rev.diffopt.break_opt = 0;
@@ -1162,14 +1162,9 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 				head,
 		initial_commit ? " (root-commit)" : "");

-	if (!log_tree_commit(&rev, commit)) {
-		struct pretty_print_context ctx = {0};
-		struct strbuf buf = STRBUF_INIT;
-		ctx.date_mode = DATE_NORMAL;
-		format_commit_message(commit, format.buf + 7, &buf, &ctx);
-		printf("%s\n", buf.buf);
-		strbuf_release(&buf);
-	}
+	if (!log_tree_commit(&rev, commit))
+		die("unable to print summary");
+
 	strbuf_release(&format);
 }

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index b10541d..08c0247 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -36,12 +36,12 @@ test_expect_success 'output summary format' '
 	check_summary_oneline "" "a change"
 '

-test_expect_failure 'output summary format for commit with an empty diff' '
+test_expect_success 'output summary format for commit with an empty diff' '

 	check_summary_oneline "" "empty" "--allow-empty"
 '

-test_expect_failure 'output summary format for merges' '
+test_expect_success 'output summary format for merges' '

 	git checkout -b recursive-base &&
 	test_commit base file1 &&
--
1.7.1.189.g07419
