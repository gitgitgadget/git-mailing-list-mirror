Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7715E20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 17:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeLLRKz (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 12:10:55 -0500
Received: from avasout06.plus.net ([212.159.14.18]:60250 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeLLRKz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 12:10:55 -0500
Received: from hashpling.plus.com ([212.159.69.125])
        by smtp with ESMTP
        id X829gGsmVuugZX82AgxYB6; Wed, 12 Dec 2018 17:10:54 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=bLE43s2Z c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=BNFp--SqAAAA:8
 a=A1X0JdhQAAAA:8 a=gZhEERMA3JooW-Zfbv0A:9 a=wCHOS_8tIzIYXQCUOVd6:22
 a=Df3jFdWbhGDLdZNm0fyq:22
From:   CB Bailey <cb@hashpling.org>
To:     git@vger.kernel.org
Subject: [PATCH] shortlog: pass the mailmap into the revision walker
Date:   Wed, 12 Dec 2018 17:10:52 +0000
Message-Id: <20181212171052.13415-1-cb@hashpling.org>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20181212164134.12922-1-cb@hashpling.org>
References: <20181212164134.12922-1-cb@hashpling.org>
X-CMAE-Envelope: MS4wfBzHrdPCI+BMoPLavpgJu78Fqmv6J2l/Qxkfl48P0NSSs5AjT7ZKjv5/qPadfdRhTg1WozBmFSju8Lr9TH+T4824sQyFghkQj0P4Gyx7kssiqsz2WAMx
 saPgwAkLiJUqObUAGPYfd9fBa+QAzduJA2hz025IcB5V5F9Q2nfUu9XKQsvxptVn/D03KnQw6sNGpw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: CB Bailey <cbailey32@bloomberg.net>

shortlog always respects the mailmap in its output. Pass the mailmap
into the revision walker to allow the mailmap to be used with revision
limiting options such as '--author'.

This removes some apparently inconsistent behaviors when using
'--author', such as not finding some or all commits for a given author
which do appear under that author in an unrestricted invocation of
shortlog or commits being summarized under a different author than the
specified author.

Signed-off-by: CB Bailey <cbailey32@bloomberg.net>
---

Resending with omitted s-o-b.

 builtin/shortlog.c |  2 ++
 t/t4203-mailmap.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 88f88e97b2..a6fb00ade8 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -188,6 +188,8 @@ static void get_from_rev(struct rev_info *rev, struct shortlog *log)
 {
 	struct commit *commit;
 
+	rev->mailmap = &log->mailmap;
+
 	if (prepare_revision_walk(rev))
 		die(_("revision walk setup failed"));
 	while ((commit = get_revision(rev)) != NULL)
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 43b1522ea2..9bee35b06c 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -383,6 +383,34 @@ test_expect_success 'Shortlog output (complex mapping)' '
 
 '
 
+test_expect_success 'Shortlog output (complex mapping, filtered)' '
+
+	printf "     1\tA U Thor <author@example.com>\n" >expect &&
+
+	git shortlog -es --author="A U Thor" HEAD >actual &&
+	test_cmp expect actual &&
+
+	printf "     1\tCTO <cto@company.xx>\n" >expect &&
+
+	git shortlog -es --author=CTO HEAD >actual &&
+	test_cmp expect actual &&
+
+	printf "     2\tOther Author <other@author.xx>\n" >expect &&
+
+	git shortlog -es --author="Other Author" HEAD >actual &&
+	test_cmp expect actual &&
+
+	printf "     2\tSanta Claus <santa.claus@northpole.xx>\n" >expect &&
+
+	git shortlog -es --author="Santa Claus" HEAD >actual &&
+	test_cmp expect actual &&
+
+	printf "     1\tSome Dude <some@dude.xx>\n" >expect &&
+
+	git shortlog -es --author="Some Dude" HEAD >actual &&
+	test_cmp expect actual
+'
+
 # git log with --pretty format which uses the name and email mailmap placemarkers
 cat >expect <<\EOF
 Author CTO <cto@coompany.xx> maps to CTO <cto@company.xx>
-- 
2.17.0.rc0

