Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDA3F1F859
	for <e@80x24.org>; Thu,  8 Sep 2016 01:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753043AbcIHBMJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 21:12:09 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52778 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752104AbcIHBMI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 21:12:08 -0400
Received: from mfilter20-d.gandi.net (mfilter20-d.gandi.net [217.70.178.148])
        by relay5-d.mail.gandi.net (Postfix) with ESMTP id 336F841C08B
        for <git@vger.kernel.org>; Thu,  8 Sep 2016 03:12:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter20-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
        by mfilter20-d.gandi.net (mfilter20-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id hbjH4mloD7E8 for <git@vger.kernel.org>;
        Thu,  8 Sep 2016 03:12:04 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
        (Authenticated sender: josh@joshtriplett.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id E7FDA41C07D
        for <git@vger.kernel.org>; Thu,  8 Sep 2016 03:12:02 +0200 (CEST)
Date:   Wed, 7 Sep 2016 18:12:01 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     git@vger.kernel.org
Subject: [PATCH] Move format-patch base commit and prerequisites before email
 signature
Message-ID: <20160908011200.qzvbdt4wjwiji4h5@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/ (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any text below the "-- " for the email signature gets treated as part of
the signature, and many mail clients will trim it from the quoted text
for a reply.  Move it above the signature, so people can reply to it
more easily.

Add tests for the exact format of the email signature, and add tests to
ensure the email signature appears last.

(Patch by Junio Hamano; tests by Josh Triplett.)
Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

Does the above seem reasonable, for a patch that incorporates the
proposed patch from Message-Id
xmqqh99rpud4.fsf@gitster.mtv.corp.google.com and adds tests?
Alternatively, feel free to split this patch into two, the first with
you as the author.  I can confirm that the code change doesn't break any
existing tests; only the new tests added here check for it.  So a
two-patch series wouldn't result in any breakage after the first patch.

 builtin/log.c           |  4 ++--
 t/t4014-format-patch.sh | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 92dc34d..d69d5e6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1042,7 +1042,6 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	diff_flush(&opts);
 
 	fprintf(rev->diffopt.file, "\n");
-	print_signature(rev->diffopt.file);
 }
 
 static const char *clean_message_id(const char *msg_id)
@@ -1720,6 +1719,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		make_cover_letter(&rev, use_stdout,
 				  origin, nr, list, branch_name, quiet);
 		print_bases(&bases, rev.diffopt.file);
+		print_signature(rev.diffopt.file);
 		total++;
 		start_number--;
 	}
@@ -1779,13 +1779,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (!use_stdout)
 			rev.shown_one = 0;
 		if (shown) {
+			print_bases(&bases, rev.diffopt.file);
 			if (rev.mime_boundary)
 				fprintf(rev.diffopt.file, "\n--%s%s--\n\n\n",
 				       mime_boundary_leader,
 				       rev.mime_boundary);
 			else
 				print_signature(rev.diffopt.file);
-			print_bases(&bases, rev.diffopt.file);
 		}
 		if (!use_stdout)
 			fclose(rev.diffopt.file);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b0579dd..a4af275 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -754,9 +754,22 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
 	git format-patch --ignore-if-in-upstream HEAD
 '
 
+git_version="$(git --version | sed "s/.* //")"
+
+signature() {
+	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
+}
+
+test_expect_success 'format-patch default signature' '
+	git format-patch --stdout -1 | tail -n 3 >output &&
+	signature >expect &&
+	test_cmp expect output
+'
+
 test_expect_success 'format-patch --signature' '
-	git format-patch --stdout --signature="my sig" -1 >output &&
-	grep "my sig" output
+	git format-patch --stdout --signature="my sig" -1 | tail -n 3 >output &&
+	signature "my sig" >expect &&
+	test_cmp expect output
 '
 
 test_expect_success 'format-patch with format.signature config' '
@@ -1502,12 +1515,11 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
 
 test_expect_success 'format-patch --base' '
 	git checkout side &&
-	git format-patch --stdout --base=HEAD~3 -1 >patch &&
-	grep "^base-commit:" patch >actual &&
-	grep "^prerequisite-patch-id:" patch >>actual &&
+	git format-patch --stdout --base=HEAD~3 -1 | tail -n 6 >actual &&
 	echo "base-commit: $(git rev-parse HEAD~3)" >expected &&
 	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expected &&
 	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expected &&
+	signature >> expected &&
 	test_cmp expected actual
 '
 
base-commit: 6ebdac1bab966b720d776aa43ca188fe378b1f4b
-- 
git-series 0.8.10
