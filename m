From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/3] commit: fix abbrev-sha regression
Date: Mon, 24 May 2010 17:47:29 +0800
Message-ID: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 24 11:48:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGUGb-0007Tl-1c
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 11:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267Ab0EXJrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 05:47:48 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:47671 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397Ab0EXJrr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 05:47:47 -0400
Received: by pzk15 with SMTP id 15so2011588pzk.15
        for <git@vger.kernel.org>; Mon, 24 May 2010 02:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/QSJIxmS4BGyjt9KvOhui2E/BwS7/lDha5S7lNpPOu4=;
        b=uI5Ud9F0/aEZO8UsI+R/To251AeJkxd/+PcrddLZkmFwYbOaw4k0Rg6zGifKFztb4T
         h6FgqROQCJeCjJAx0r3zB4iL5n6UDYYrnYB1HBUzqGCP8BuElNybq2phpmAWpnavcIbk
         i40A5iw8GYbo2R2s8qTtmH/mD8beuVpClq3pI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qJI+050UdeZ4OaWrtowglZgOkx/YBWJehQPWSHZtzanMHoMBxCzndzT2ZEuDl5JGDo
         AJ4d3Iu+moV+uZC370fAcMuikps4btz80Ff7jz08/XWgBIatGwqu13AAEMKyCORuXAeC
         3tVVAfuURRU3/zh0tm8yw7Zn+/ibsN7eL08s0=
Received: by 10.114.237.2 with SMTP id k2mr4622117wah.214.1274694467271;
        Mon, 24 May 2010 02:47:47 -0700 (PDT)
Received: from localhost.localdomain (cm218.zeta152.maxonline.com.sg [116.87.152.218])
        by mx.google.com with ESMTPS id n29sm37041273wae.4.2010.05.24.02.47.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 02:47:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.259.g405af
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147619>

After c197702 (pretty: Respect --abbrev option), the summary output for
git-commit began to throw up non-abbreviated SHA-1s.

For example,

  $ git commit --allow-empty -m "empty"
  [master f869bf09c8eefee54094bb21387241aaf5f10324] empty

I also notice that this happens for merges after conflict resolutions.

This afflicts 'master', but not any release.

Here's the hunk that fixed it:

-->8--
diff --git a/builtin/commit.c b/builtin/commit.c
index a4e4966..ab4a7cf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1166,6 +1166,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 		struct pretty_print_context ctx = {0};
 		struct strbuf buf = STRBUF_INIT;
 		ctx.date_mode = DATE_NORMAL;
+		ctx.abbrev = DEFAULT_ABBREV;
 		format_commit_message(commit, format.buf + 7, &buf, &ctx);
 		printf("%s\n", buf.buf);
 		strbuf_release(&buf);
-->8--

However, I noticed that this would also work:

-->8--
diff --git a/builtin/commit.c b/builtin/commit.c
index ab4a7cf..13a30ab 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1148,7 +1148,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
        rev.verbose_header = 1;
        rev.show_root_diff = 1;
        get_commit_format(format.buf, &rev);
-       rev.always_show_header = 0;
+       rev.always_show_header = 1;
        rev.diffopt.detect_rename = 1;
        rev.diffopt.rename_limit = 100;
        rev.diffopt.break_opt = 0;
-->8--

This would make the code block that handled the situation in which
log_tree_commit() did not print any output redundant, so perhaps this
would also follow:

-->8--
diff --git a/builtin/commit.c b/builtin/commit.c
index ab4a7cf..e8def55 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1163,13 +1163,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
                initial_commit ? " (root-commit)" : "");

        if (!log_tree_commit(&rev, commit)) {
-               struct pretty_print_context ctx = {0};
-               struct strbuf buf = STRBUF_INIT;
-               ctx.date_mode = DATE_NORMAL;
-               ctx.abbrev = DEFAULT_ABBREV;
-               format_commit_message(commit, format.buf + 7, &buf, &ctx);
-               printf("%s\n", buf.buf);
-               strbuf_release(&buf);
+               die("unable to print summary");
        }
        strbuf_release(&format);
 }
-->8--

In a sense, it reverts parts of bf82a15 (commit: do not add extra LF at
the end of the summary.), except for the extra LF. Would this be a more
sensible route?

Contents:
[PATCH 0/3] commit: fix abbrev-sha regression
[PATCH 1/3] t7502-commit: add tests for summary output
[PATCH 2/3] t7502-commit: add summary output tests for empty and merge commits
[PATCH 3/3] commit: show abbreviated sha for commits with empty diffs
