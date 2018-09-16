Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70071F404
	for <e@80x24.org>; Sun, 16 Sep 2018 07:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeIPNMO (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 09:12:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:41335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbeIPNMN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 09:12:13 -0400
Received: from p2520la.lan ([79.218.121.221]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MI5Ve-1fxajM448k-003r8G; Sun, 16
 Sep 2018 09:50:03 +0200
From:   Tim Schumacher <timschumi@gmx.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        pclouds@gmail.com
Subject: [PATCH v5 1/3] Add support for nested aliases
Date:   Sun, 16 Sep 2018 09:50:00 +0200
Message-Id: <20180916075002.3303-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.0.rc2.1.g4c98b8d69.dirty
In-Reply-To: <20180907224430.23859-1-timschumi@gmx.de>
References: <20180907224430.23859-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eSOKoJYbjwAlfoiI/2U8wmLeIYWA505mtVm6z4pQYxvIOV7AO3Q
 s8wcZUxumjIsN2V+xtxJWEqOPMdbo36LxFIxHkgiX2U/lBFVEE/BQ0ip5NhhAEBT0xS7UHN
 IhKCS6GEAlvXZsoefD42LwxAudYdkcK9gJVkzngzl1PQ5pc+U+ckjrrQhJeb17dYbtTQguh
 oWIOnUP3DMVS6FSwn4RYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ErNADtEPXcs=:EbZN0Cq2FNCHsTng6wS2t2
 34IABLEyP5LGcABiywPznqwulByx13add3wjreGZsynhexQ+Ea9FGHlzxrm6RrsioxY2ZyQoT
 yX5cTTWhTZwg7tP1f3WeOa8QtB+k6MdtvQ6GBjT/e5TfE5YkDldXZzM3KlpN31+EgWdyFjAyq
 HR3NIOCsDTC1bUrx5KrcrhO/tgDo64rVRr7xlVGyXNzQ1La+gNh51eR23dE2WxE/VqY1YCWWD
 3MCn3qPP5045sgQbHzcb1jWKDXF3W5BxPXCuZ0UWI2Lak9sxIpFX0rTv4UT4sx/ibujG1XXB7
 fSKqpZw04vaT9k0jwd/jf0IE2zWd1IVqe44G4IbVuDXN7dbgKKs0TESTownEiLfBaDiLzjoNF
 zErE3KbS87M5K1HqGDSgiJyB2stzYvy6aH01A9GNSqMvttGxxeflWJuFhJp88wsJjz7TZu8pD
 sx9+i3/I8xR5Gi5T1QVkX3/zQvf18q9EACeY/d8/eGXJ+S5nlybI3yDWebRiUhVPb+lHFHGR8
 irAjpekVBZSnjxWDD0SsZubi6HKmMtQ5K57SMJn1HjlkCyrtKBMHDgy39eJjJ6ZzXCDLEEMY7
 xKjnQBYCNA4y1B7GdmDRQ5wYyR2Flu+IMEZGkYGryB/vkran2UV0YAJb8OMCrF8Cx08fB1P/a
 v3NRySbSqOujlZQjz5qakxBI9mP0jvYjSiG5yGScuzQweRo+eVdHUIPw/JRA5Yk4hlmTnx59W
 GSa3NP+CnkFKPsxktLDKtj4sA87l0AWvOfdI4/Y4+xmg6Nb7nOu7uHLQt2pcp5gf9eRsiad5Q
 seSYc2gJelVW8IpLDrbcwSjw0Xv/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aliases can only contain non-alias git commands and their
arguments, not other user-defined aliases. Resolving further
(nested) aliases is prevented by breaking the loop after the
first alias was processed. Git then fails with a command-not-found
error.

Allow resolving nested aliases by not breaking the loop in
run_argv() after the first alias was processed. Instead, continue
the loop until `handle_alias()` fails, which means that there are
no further aliases that can be processed. Prevent looping aliases
by storing substituted commands in `cmd_list` and checking if
a command has been substituted previously.

While we're at it, fix a styling issue just below the added code.

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
---
Changes since v3:
 - Print the command that the user entered instead of the command
   which caused the loop (and a nicer, more explanatory error message)
 - Use unsorted_string_list_has_string() instead of the sorted version
 - Fix a code style issue just below the modified code
 - done_alias is a simple boolean again (instead of a counter)

Changes since v4: None.

 git.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index c27c38738..15727c17f 100644
--- a/git.c
+++ b/git.c
@@ -674,6 +674,7 @@ static void execv_dashed_external(const char **argv)
 static int run_argv(int *argcp, const char ***argv)
 {
 	int done_alias = 0;
+	struct string_list cmd_list = STRING_LIST_INIT_NODUP;
 
 	while (1) {
 		/*
@@ -691,17 +692,25 @@ static int run_argv(int *argcp, const char ***argv)
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);
 
-		/* It could be an alias -- this works around the insanity
+		if (unsorted_string_list_has_string(&cmd_list, *argv[0])) {
+			die(_("alias loop detected: expansion of '%s' does"
+			      " not terminate"), cmd_list.items[0].string);
+		}
+
+		string_list_append(&cmd_list, *argv[0]);
+
+		/*
+		 * It could be an alias -- this works around the insanity
 		 * of overriding "git log" with "git show" by having
 		 * alias.log = show
 		 */
-		if (done_alias)
-			break;
 		if (!handle_alias(argcp, argv))
 			break;
 		done_alias = 1;
 	}
 
+	string_list_clear(&cmd_list, 0);
+
 	return done_alias;
 }
 
-- 
2.19.0.rc2.1.g4c98b8d69.dirty

