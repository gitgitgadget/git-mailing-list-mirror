Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3EF51FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 18:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753739AbcLBSty (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 13:49:54 -0500
Received: from mail.nottheoilrig.com ([52.27.13.164]:33392 "EHLO
        mail.nottheoilrig.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752790AbcLBStv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 13:49:51 -0500
Received: from mail.nottheoilrig.com (localhost [127.0.0.1])
        by mail.nottheoilrig.com (Postfix) with ESMTP id 57B2820293
        for <git@vger.kernel.org>; Fri,  2 Dec 2016 18:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nottheoilrig.com;
        s=3532ada; t=1480704590;
        bh=hW/Pynf4kmW6LpPqJdwYuVIaTjF/r3FuU/p1m3CBM0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sV5WlxNFQLnid7uuv3jrZ5SbhM0Wx+PlDqEborLqKmID9I66cb2IJKI24g8ooYAtu
         9723sNpybVySQI7BslZlkAj5FGouocW9sXO/kPyFvVARt9Eu81KFR8N/ns1528nKxK
         ut9Jnuhf9s4WeBqyjygewu59T6Fr1IPhJBuZPOqg=
Received: from debian (S0106c8fb26402908.ek.shawcable.net [24.66.132.201])
        by mail.nottheoilrig.com (Postfix) with ESMTPSA;
        Fri,  2 Dec 2016 18:49:50 +0000 (UTC)
Received: from nottheoilrig by debian with local (Exim 4.88)
        (envelope-from <nottheoilrig@debian>)
        id 1cCsu5-0000oE-B0; Fri, 02 Dec 2016 11:49:49 -0700
From:   Jack Bates <bk874k@nottheoilrig.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jack Bates <jack@nottheoilrig.com>
Subject: [PATCH v2] diff: handle --no-abbrev outside of repository
Date:   Fri,  2 Dec 2016 11:48:40 -0700
Message-Id: <20161202184840.2158-1-jack@nottheoilrig.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161129070637.eult6o3m34r2mima@sigill.intra.peff.net>
References: <20161129070637.eult6o3m34r2mima@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git diff --no-index" codepath didn't handle the --no-abbrev option.
Also it didn't behave the same as find_unique_abbrev()
in the case where abbrev == 0.
find_unique_abbrev() returns the full, unabbreviated string in that
case, but the "git diff --no-index" codepath returned an empty string.

Signed-off-by: Jack Bates <jack@nottheoilrig.com>
---
 diff.c                                                  | 6 +++++-
 t/t4013-diff-various.sh                                 | 7 +++++++
 t/t4013/diff.diff_--no-index_--raw_--abbrev=4_dir2_dir  | 3 +++
 t/t4013/diff.diff_--no-index_--raw_--no-abbrev_dir2_dir | 3 +++
 t/t4013/diff.diff_--no-index_--raw_dir2_dir             | 3 +++
 t/t4013/diff.diff_--raw_--abbrev=4_initial              | 6 ++++++
 t/t4013/diff.diff_--raw_--no-abbrev_initial             | 6 ++++++
 t/t4013/diff.diff_--raw_initial                         | 6 ++++++
 8 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 t/t4013/diff.diff_--no-index_--raw_--abbrev=4_dir2_dir
 create mode 100644 t/t4013/diff.diff_--no-index_--raw_--no-abbrev_dir2_dir
 create mode 100644 t/t4013/diff.diff_--no-index_--raw_dir2_dir
 create mode 100644 t/t4013/diff.diff_--raw_--abbrev=4_initial
 create mode 100644 t/t4013/diff.diff_--raw_--no-abbrev_initial
 create mode 100644 t/t4013/diff.diff_--raw_initial

diff --git a/diff.c b/diff.c
index ec87283..84dba60 100644
--- a/diff.c
+++ b/diff.c
@@ -3106,7 +3106,8 @@ static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev)
 			abbrev = FALLBACK_DEFAULT_ABBREV;
 		if (abbrev > GIT_SHA1_HEXSZ)
 			die("BUG: oid abbreviation out of range: %d", abbrev);
-		hex[abbrev] = '\0';
+		if (abbrev)
+			hex[abbrev] = '\0';
 		return hex;
 	}
 }
@@ -3364,6 +3365,7 @@ void diff_setup(struct diff_options *options)
 
 	options->file = stdout;
 
+	options->abbrev = DEFAULT_ABBREV;
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
@@ -4024,6 +4026,8 @@ int diff_opt_parse(struct diff_options *options,
 			    offending, optarg);
 		return argcount;
 	}
+	else if (!strcmp(arg, "--no-abbrev"))
+		options->abbrev = 0;
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev = DEFAULT_ABBREV;
 	else if (skip_prefix(arg, "--abbrev=", &arg)) {
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 566817e..d7b71a0 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -311,6 +311,13 @@ diff --line-prefix=abc master master^ side
 diff --dirstat master~1 master~2
 diff --dirstat initial rearrange
 diff --dirstat-by-file initial rearrange
+# --abbrev and --no-abbrev outside of repository
+diff --raw initial
+diff --raw --abbrev=4 initial
+diff --raw --no-abbrev initial
+diff --no-index --raw dir2 dir
+diff --no-index --raw --abbrev=4 dir2 dir
+diff --no-index --raw --no-abbrev dir2 dir
 EOF
 
 test_expect_success 'log -S requires an argument' '
diff --git a/t/t4013/diff.diff_--no-index_--raw_--abbrev=4_dir2_dir b/t/t4013/diff.diff_--no-index_--raw_--abbrev=4_dir2_dir
new file mode 100644
index 0000000..a71b38a
--- /dev/null
+++ b/t/t4013/diff.diff_--no-index_--raw_--abbrev=4_dir2_dir
@@ -0,0 +1,3 @@
+$ git diff --no-index --raw --abbrev=4 dir2 dir
+:000000 100644 0000... 0000... A	dir/sub
+$
diff --git a/t/t4013/diff.diff_--no-index_--raw_--no-abbrev_dir2_dir b/t/t4013/diff.diff_--no-index_--raw_--no-abbrev_dir2_dir
new file mode 100644
index 0000000..e0f0097
--- /dev/null
+++ b/t/t4013/diff.diff_--no-index_--raw_--no-abbrev_dir2_dir
@@ -0,0 +1,3 @@
+$ git diff --no-index --raw --no-abbrev dir2 dir
+:000000 100644 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 A	dir/sub
+$
diff --git a/t/t4013/diff.diff_--no-index_--raw_dir2_dir b/t/t4013/diff.diff_--no-index_--raw_dir2_dir
new file mode 100644
index 0000000..3cb4ee7
--- /dev/null
+++ b/t/t4013/diff.diff_--no-index_--raw_dir2_dir
@@ -0,0 +1,3 @@
+$ git diff --no-index --raw dir2 dir
+:000000 100644 0000000... 0000000... A	dir/sub
+$
diff --git a/t/t4013/diff.diff_--raw_--abbrev=4_initial b/t/t4013/diff.diff_--raw_--abbrev=4_initial
new file mode 100644
index 0000000..c3641db
--- /dev/null
+++ b/t/t4013/diff.diff_--raw_--abbrev=4_initial
@@ -0,0 +1,6 @@
+$ git diff --raw --abbrev=4 initial
+:100644 100644 35d2... 9929... M	dir/sub
+:100644 100644 01e7... 10a8... M	file0
+:000000 100644 0000... b1e6... A	file1
+:100644 000000 01e7... 0000... D	file2
+$
diff --git a/t/t4013/diff.diff_--raw_--no-abbrev_initial b/t/t4013/diff.diff_--raw_--no-abbrev_initial
new file mode 100644
index 0000000..c87a125
--- /dev/null
+++ b/t/t4013/diff.diff_--raw_--no-abbrev_initial
@@ -0,0 +1,6 @@
+$ git diff --raw --no-abbrev initial
+:100644 100644 35d242ba79ae89ac695e26b3d4c27a8e6f028f9e 992913c5aa0a5476d10c49ed0f21fc0c6d1aedf3 M	dir/sub
+:100644 100644 01e79c32a8c99c557f0757da7cb6d65b3414466d 10a8a9f3657f91a156b9f0184ed79a20adef9f7f M	file0
+:000000 100644 0000000000000000000000000000000000000000 b1e67221afe8461efd244b487afca22d46b95eb8 A	file1
+:100644 000000 01e79c32a8c99c557f0757da7cb6d65b3414466d 0000000000000000000000000000000000000000 D	file2
+$
diff --git a/t/t4013/diff.diff_--raw_initial b/t/t4013/diff.diff_--raw_initial
new file mode 100644
index 0000000..a3e9780
--- /dev/null
+++ b/t/t4013/diff.diff_--raw_initial
@@ -0,0 +1,6 @@
+$ git diff --raw initial
+:100644 100644 35d242b... 992913c... M	dir/sub
+:100644 100644 01e79c3... 10a8a9f... M	file0
+:000000 100644 0000000... b1e6722... A	file1
+:100644 000000 01e79c3... 0000000... D	file2
+$
-- 
2.10.2
