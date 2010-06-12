From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v6 3/3] commit::print_summary(): don't use format_commit_message()
Date: Sat, 12 Jun 2010 22:15:39 +0800
Message-ID: <1276352139-2272-1-git-send-email-rctay89@gmail.com>
References: <20100609130558.000013a3@unknown>, <1275639660-5344-1-git-send-email-rctay89@gmail.com>, <AANLkTimuTIugURlYxwbk7wGW2IM11YTy4P91YDguLQUb@mail.gmail.com>, <7v4ohlatwn.fsf@alter.siamese.dyndns.org>, <1274974492-4692-4-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	Will Palmer <wmpalmer@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 12 16:16:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONRVP-0000Yk-Fq
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 16:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab0FLOQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 10:16:07 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49546 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370Ab0FLOQD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 10:16:03 -0400
Received: by pvg16 with SMTP id 16so1478495pvg.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:references;
        bh=MdZEN0NMIAL9WFoqnGMCY17/xHzHJHjIFghTUu3fDPs=;
        b=gSOHvvxlpjDXYhNFhdB45fl2Ex4/tuCNxUQ2SoOSXPrOO1qmtsVwbO/vNbg8bPVsGP
         Vb1iffIt0fjURoUuFfqrua9/Gn+eJZCeHfqyiekZoSVGZcV9mi4wwsXtIvUJ5tVK30ng
         UvC15HLRF08MyrgwyqhbdEOMC4dzyEYOCDky4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:references;
        b=nOptcXyejoQXzXTBRhJR8w3gkhJXQm+IZI1rlLv3YDh/0MD0d7TJQH75/gWWrYrfqb
         ZgEXrvxj5mfRkYjWTDSXaSCIbNX5bQKV2aBvsnfaOUcpvzVtun0vnuDPbT2S7uPnkUJw
         yixjsm0VlORH8rng8ljhe5AoEJQelzv1pDY54=
Received: by 10.114.187.11 with SMTP id k11mr2611745waf.153.1276352161572;
        Sat, 12 Jun 2010 07:16:01 -0700 (PDT)
Received: from localhost.localdomain (cm54.zeta152.maxonline.com.sg [116.87.152.54])
        by mx.google.com with ESMTPS id f11sm27776265wai.23.2010.06.12.07.15.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 07:16:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.352.g12d15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149007>

This attempts to fix a regression in git-commit, where non-abbreviated
SHA-1s were printed in the summary.

One possible fix would be to set ctx.abbrev to DEFAULT_ABBREV in the
`if` block, where format_commit_message() is used.

Instead, we do away with the format_commit_message() codeblock
altogether, replacing it with a re-run of log_tree_commit().

We re-run log_tree_commit() with rev.always_show_header set, to force
the invocation of show_log(). The effect of this flag can be seen from
this excerpt from log-tree.c:560, the only area that
rev.always_show_header is checked:

	shown = log_tree_diff(opt, commit, &log);
	if (!shown && opt->loginfo && opt->always_show_header) {
		log.parent = NULL;
		show_log(opt);
		shown = 1;
	}

We also set rev.use_terminator, so that a newline is appended at the end
of the log message. Note that callers in builtin/log.c that also set
rev.always_show_header don't have to set rev.use_terminator, but still
get a newline, because they are wrapped in a pager.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

This is a reworked version of the third patch of the
'tc/commit-abbrev-fix' series; there are no changes to the first and
second patches.

Changes from v5:

 - don't set rev.always_show_header immediately, so that when there is
   no diff, log_tree_commit() returns false, as before the patch;

 - when log_tree_commit() returns false (ie. no diff), set
   rev.always_show_header, and re-run log_tree_commit();

 - add a missing newline to summary output by setting
   rev.use_terminator.

See the patch message for more details.

In case you're wondering where's v5, it was sent in a private review:

  http://github.com/gitster/git/commit/c69160d

 builtin/commit.c  |   10 ++++------
 t/t7502-commit.sh |    4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a4e4966..aa92362 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1163,13 +1163,11 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 		initial_commit ? " (root-commit)" : "");

 	if (!log_tree_commit(&rev, commit)) {
-		struct pretty_print_context ctx = {0};
-		struct strbuf buf = STRBUF_INIT;
-		ctx.date_mode = DATE_NORMAL;
-		format_commit_message(commit, format.buf + 7, &buf, &ctx);
-		printf("%s\n", buf.buf);
-		strbuf_release(&buf);
+		rev.always_show_header = 1;
+		rev.use_terminator = 1;
+		log_tree_commit(&rev, commit);
 	}
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
