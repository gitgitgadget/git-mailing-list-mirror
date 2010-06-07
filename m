From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v4] commit::print_summary(): set rev_info.always_show_header to 1
Date: Mon,  7 Jun 2010 13:04:16 +0800
Message-ID: <1275887056-4788-1-git-send-email-rctay89@gmail.com>
References: <1275639660-5344-1-git-send-email-rctay89@gmail.com>, <AANLkTimuTIugURlYxwbk7wGW2IM11YTy4P91YDguLQUb@mail.gmail.com>, <7v4ohlatwn.fsf@alter.siamese.dyndns.org>, <1274974492-4692-4-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 07 07:04:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLUVo-0008KS-3U
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 07:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab0FGFEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 01:04:31 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38904 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab0FGFEa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 01:04:30 -0400
Received: by pvg16 with SMTP id 16so1282766pvg.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 22:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YmGWyj2WytK1Yiv6oDqkwGxzBYyQYT57eKB4oCyA7rk=;
        b=o+7MZf7WxeO2OvGuLM42zXCgkKaZuLP3F2gdujaXbcH+j48XEMKWiQREHxsenJR6fb
         LLb9dc646qJ/kiFp8IMhqE4n313pkiqVNEqK+fxkSjp6/FDX/eaPMjNaAaZOBIyEWmhp
         LUWhs/XpJZ9kFI1lfE9VqYGABCD2lnkmD9Uvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Oqo6aJlI2C5wTlX3Q0Rygk6dnO2J9PAPWBsUHxhOKkvs53l44x8nvTgRh4mqDNxuoc
         iKqIf0PCl9zflO+isoEe6HASYeOlF66RDAl9yOIIKAVkKtHDymdJSm/mFXs/3epf6wyO
         sLOp2rE7uuz1D3LIz3w3xcP7UtLbClvrab1HA=
Received: by 10.115.81.6 with SMTP id i6mr11176038wal.48.1275887069381;
        Sun, 06 Jun 2010 22:04:29 -0700 (PDT)
Received: from localhost.localdomain (cm69.zeta153.maxonline.com.sg [116.87.153.69])
        by mx.google.com with ESMTPS id r20sm35398215wam.5.2010.06.06.22.04.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 22:04:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.352.g12d15
In-Reply-To: <1275639660-5344-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148569>

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

Also, we now die() if log_tree_commit() returns false; add a comment in
the area, which may be helpful to future git hackers (eg. diagnosisng
trigger of the die()).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

This is a reworked version of the third patch of the
'tc/commit-abbrev-fix' series; there are no changes to the first and
second patches.

Changes from v3:
 - shift note on the die() and our assumption from the commit message into the
   code (as a comment), as suggested by Junio.

 builtin/commit.c  |   22 +++++++++++++---------
 t/t7502-commit.sh |    4 ++--
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a4e4966..b0c266c 100644
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
@@ -1162,14 +1162,18 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
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
+	/**
+	 * Based on the existing underlying codepaths (log_tree_commit(),
+	 * log_tree_diff(), log_tree_diff_flush(), to name a few), the die()
+	 * should not occur; changes to these codepaths may warrant a revision
+	 * of our handling of this situation.
+	 *
+	 * Tests #1-#3 in t7502 for output formats should aid in detecting such
+	 * breakages.
+	 */
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
