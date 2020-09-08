Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B870AC43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 01:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AEE320738
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 01:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIHBay (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 21:30:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55460 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728195AbgIHBas (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Sep 2020 21:30:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 11D1E60457;
        Tue,  8 Sep 2020 01:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599528645;
        bh=sXtv5MLPF/kaeySYURdayPU+cXTbd0fbqr/7NvSOS8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=VBxfSpRWQwuvFv8y5Qb74XH3Xhg6ioqA9Uw+Qp+Md5uxbbFOYC0iqCfe8bOcl/Zjp
         mjac4BDG53S3YUhrNiSL1bzsutjRceSROCiZWY3Hfp+KXy8GivDLoUBSS9PavWSzAD
         Y9tKfwfUZgDvu+UIn4006KlnltmhTYFjbL/B9PGnZ/OIxWZRRdHGSetqjqp5mzpOzI
         KlvVQ4JjIMFSrGzKnS3mlzKrexyHD+vlkz9YE3qKhjI5Wa2ybIAK0mL1PB3449NnGC
         Z6hS4zXI/6p2BCAvEzXpkpPYefI2kp9nHBvv61MA3eNhg9rIGgT7MuKvDXCH/4elWw
         EhcGmkoJb4sx+msYX+eZWst/eyw0PaK8fpaXRQVzuHpr8m6G0bIiZEDk6Uclp58np4
         gl0EoKmlTvmzU3eZXLPyTSLhF3yrjOitGTH7E4IbNrWqH/ryPzMviIpOj/k4jmxf4K
         ub2tZ3xNnl/CFxSRCNrlTbbq+6IARoy3SNyDrZK/82enagS++MH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Patrick Fong <patrickf3139@gmail.com>
Subject: [PATCH] wt-status: quote paths identically whether tracked or untracked
Date:   Tue,  8 Sep 2020 01:30:13 +0000
Message-Id: <20200908013013.1099937-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
References: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for git status --short says this:

  If a filename contains whitespace or other nonprintable characters,
  that field will be quoted in the manner of a C string literal:
  surrounded by ASCII double quote (34) characters, and with interior
  special characters backslash-escaped.

Note that this differs from our typical quoting rule, which does not
include spaces.  If we did not quote spaces, our output would be
ambiguous for renames.

However, we failed to do this correctly for untracked files.  If we list
an untracked file that contains spaces, we fail to quote it.  Since this
is both inconsistent and not what was documented, let's fix it by
quoting untracked files in the same way as tracked files.  Users parsing
this output already need to handle quoted names for tracked files (or
use -z) so this shouldn't be an incompatible change.

Note that the test for this case should be portable because all known
modern systems support spaces in file names and our test trash
directories use them already.

Reported-by: Patrick Fong <patrickf3139@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7508-status.sh | 21 +++++++++++++++++++++
 wt-status.c       |  8 +++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e81759319f..ef8d19c151 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -814,6 +814,27 @@ test_expect_success 'status -s without relative paths' '
 
 '
 
+cat >expect <<\EOF
+ M dir1/modified
+A  dir2/added
+A  "file with spaces"
+?? dir1/untracked
+?? dir2/modified
+?? dir2/untracked
+?? "file with spaces 2"
+?? untracked
+EOF
+
+test_expect_success 'status -s without relative paths' '
+	test_when_finished "git rm --cached \"file with spaces\"; rm -f file*" &&
+	>"file with spaces" &&
+	>"file with spaces 2" &&
+	git add "file with spaces" &&
+	git status -s >output &&
+	test_cmp expect output
+
+'
+
 test_expect_success 'dry-run of partial commit excluding new file in index' '
 	cat >expect <<EOF &&
 On branch master
diff --git a/wt-status.c b/wt-status.c
index bb0f9120de..bea6cf98b1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1909,7 +1909,13 @@ static void wt_shortstatus_other(struct string_list_item *it,
 		const char *one;
 		one = quote_path(it->string, s->prefix, &onebuf);
 		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
-		printf(" %s\n", one);
+		putchar(' ');
+		if (*one != '"' && strchr(one, ' ') != NULL) {
+			putchar('"');
+			strbuf_addch(&onebuf, '"');
+			one = onebuf.buf;
+		}
+		printf("%s\n", one);
 		strbuf_release(&onebuf);
 	}
 }
