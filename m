From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 3/3] commit::print_summary(): set rev_info.always_show_header to 1
Date: Thu, 27 May 2010 23:34:52 +0800
Message-ID: <1274974492-4692-4-git-send-email-rctay89@gmail.com>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
 <1274974492-4692-1-git-send-email-rctay89@gmail.com>
 <1274974492-4692-2-git-send-email-rctay89@gmail.com>
 <1274974492-4692-3-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 27 17:35:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHf7Z-00081i-Tz
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 17:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196Ab0E0Pfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 11:35:31 -0400
Received: from mail-pz0-f176.google.com ([209.85.222.176]:45698 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757945Ab0E0Pf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 11:35:29 -0400
Received: by mail-pz0-f176.google.com with SMTP id 6so93007pzk.1
        for <git@vger.kernel.org>; Thu, 27 May 2010 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=aTRbcCqFejChDqYvUe4zOeGEM1Whc2Ojon71pbntj7M=;
        b=s577ZAHEP1nJtTlN7QPT85kxSyqAY6rawO38spyzroZmFjy1PutdrRV1Qk5lgThC6N
         LvklPpC4I9qQeUrvZRgTU5vqdyNk8Nw0sOydAWXTDlfyxn48PySeSsjOmF+XPK5tX/6J
         6dgwo6Sn9og5GbaM5lHcolWv7mlJR7Xg+RdKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UF/FGRcDA7cYHnqmx+3CjxMgFWAsiuOya92n2L/g+hMvsHdpGiEejk7LT5Fbeh6XHg
         +vchUshIjdk1pJuOKA4jBCrDdQGSnp5eIYRhOptCOmZ9c+x74uiiP8SMflcf9io0cNMt
         /hFZHL7GmrnvtizWnjwXMglzWlb4XXmz+iXR4=
Received: by 10.114.188.8 with SMTP id l8mr9169153waf.179.1274974528927;
        Thu, 27 May 2010 08:35:28 -0700 (PDT)
Received: from localhost.localdomain (cm218.zeta152.maxonline.com.sg [116.87.152.218])
        by mx.google.com with ESMTPS id r20sm11007341wam.5.2010.05.27.08.35.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 08:35:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.352.g12d15
In-Reply-To: <1274974492-4692-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147877>

This attempts to fix a regression in git-commit, where non-abbreviated
SHA-1s were printed in the summary.

One possible fix would be to set ctx.abbrev to DEFAULT_ABBREV in the
`if` block. However, we remove this codeblock altogether, and set
rev.always_show_header.

This way, we use back the same show_log() mechanism (instead of
format_commit_message()).

Quoting log-tree.c:560:

	shown = log_tree_diff(opt, commit, &log);
	if (!shown && opt->loginfo && opt->always_show_header) {
		log.parent = NULL;
		show_log(opt);
		shown = 1;
	}

This is the only area that always_show_header is checked, so the
setting of this flag should only affect this area.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed from v1:
 - used an alternative fix - see patch message for more.

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
