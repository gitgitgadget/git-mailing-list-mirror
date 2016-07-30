Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86C561F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 19:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbcG3TL1 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 15:11:27 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38385 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbcG3TL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 15:11:26 -0400
Received: from mfilter18-d.gandi.net (mfilter18-d.gandi.net [217.70.178.146])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id B30D641C09B;
	Sat, 30 Jul 2016 21:11:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter18-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter18-d.gandi.net (mfilter18-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 5G2jJ8dzOo6B; Sat, 30 Jul 2016 21:11:22 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id E23A741C095;
	Sat, 30 Jul 2016 21:11:20 +0200 (CEST)
Date:	Sat, 30 Jul 2016 12:11:18 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Subject: [PATCH v2 2/2] format-patch: Default to --from
Message-ID: <20160730191118.u35sq6ctt7psbnho@x>
References: <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This avoids spoofing mails when formatting commits not written by the
user.

Add tests for the new default, and fix tests whose expected output
depended on the old default.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 Documentation/config.txt |  2 +-
 builtin/log.c            |  1 +
 t/t4014-format-patch.sh  | 28 +++++++++++++++++++++++++---
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bd34774..2310877 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1261,7 +1261,7 @@ format.from::
 	`--from`, using your committer identity in the "From:" field of patch
 	mails and including a "From:" field in the body of the patch mail if
 	different.  If set to a non-boolean value, format-patch uses that
-	value instead of your committer identity.  Defaults to false.
+	value instead of your committer identity.  Defaults to true.
 
 format.numbered::
 	A boolean which can enable or disable sequence numbers in patch
diff --git a/builtin/log.c b/builtin/log.c
index dbd2da7..bcca974 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1486,6 +1486,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	set_from(FROM_USER, NULL);
 	extra_hdr.strdup_strings = 1;
 	extra_to.strdup_strings = 1;
 	extra_cc.strdup_strings = 1;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b0579dd..fa35cbe 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -652,7 +652,7 @@ EOF
 
 test_expect_success 'format-patch -p suppresses stat' '
 
-	git format-patch -p -2 &&
+	git format-patch --no-from -p -2 &&
 	sed -e "1,/^\$/d" -e "/^+5/q" < 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch > output &&
 	test_cmp expect output
 
@@ -973,7 +973,7 @@ check_author() {
 	echo content >>file &&
 	git add file &&
 	GIT_AUTHOR_NAME=$1 git commit -m author-check &&
-	git format-patch --stdout -1 >patch &&
+	git format-patch --no-from --stdout -1 >patch &&
 	sed -n "/^From: /p; /^ /p; /^$/q" <patch >actual &&
 	test_cmp expect actual
 }
@@ -1089,6 +1089,18 @@ test_expect_success '--from=ident replaces author' '
 	test_cmp expect patch.head
 '
 
+test_expect_success 'Default uses committer ident' '
+	git format-patch -1 --stdout >patch &&
+	cat >expect <<-\EOF &&
+	From: C O Mitter <committer@example.com>
+
+	From: A U Thor <author@example.com>
+
+	EOF
+	sed -ne "/^From:/p; /^$/p; /^---$/q" <patch >patch.head &&
+	test_cmp expect patch.head
+'
+
 test_expect_success '--from uses committer ident' '
 	git format-patch -1 --stdout --from >patch &&
 	cat >expect <<-\EOF &&
@@ -1101,6 +1113,16 @@ test_expect_success '--from uses committer ident' '
 	test_cmp expect patch.head
 '
 
+test_expect_success '--no-from suppresses default --from' '
+	git format-patch -1 --stdout --no-from >patch &&
+	cat >expect <<-\EOF &&
+	From: A U Thor <author@example.com>
+
+	EOF
+	sed -ne "/^From:/p; /^$/p; /^---$/q" <patch >patch.head &&
+	test_cmp expect patch.head
+'
+
 test_expect_success '--from omits redundant in-body header' '
 	git format-patch -1 --stdout --from="A U Thor <author@example.com>" >patch &&
 	cat >expect <<-\EOF &&
@@ -1129,7 +1151,7 @@ test_expect_success 'in-body headers trigger content encoding' '
 append_signoff()
 {
 	C=$(git commit-tree HEAD^^{tree} -p HEAD) &&
-	git format-patch --stdout --signoff $C^..$C >append_signoff.patch &&
+	git format-patch --no-from --stdout --signoff $C^..$C >append_signoff.patch &&
 	sed -n -e "1,/^---$/p" append_signoff.patch |
 		egrep -n "^Subject|Sign|^$"
 }
-- 
git-series 0.8.7
