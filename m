Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96E9D1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 08:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeIENXt (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 09:23:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:55277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbeIENXs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 09:23:48 -0400
Received: from localhost.localdomain ([185.190.160.130]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lg0sd-1fYKBZ0uK3-00pchh; Wed, 05 Sep 2018 10:54:30 +0200
From:   Tim Schumacher <timschumi@gmx.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [RFC PATCH v2] Allow aliases that include other aliases
Date:   Wed,  5 Sep 2018 10:54:27 +0200
Message-Id: <20180905085427.4099-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.0.rc1.2.g8f4faccc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TLGGDandZ9wQzKOM55t9QXCdYaA2vtlxWMHfbLaXX3eaZvPFUIm
 LSqJhtTKDwoXWo0KI/eUWAsxcL8vpqzeyTbu6n8hEGQVINi/NOaPnwk5ulUgvZvwCjalpf5
 vgpaC6bXrufwzQfzrQ432Q766IJE/N872dqECbcbsdDjYQeodbpDofU5w8SFKbAgWmEI3QQ
 f6ISFSkfkoasZI3lqOajA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PhfszjIoeMU=:MHCvMc//DDBwfd5jyS6vc7
 uww3nLK+Lk+6eXDaGPJ2NyiPwJCsEGOoIquen4AZAsaCVD9tligM6k+eWNCN71rVpKHAxBcVC
 AebhdodeNjxqcBG3JHfRCDfLN1pPnh7Xw7m6MPA5ewJtm2l6jt6sXy4rwRVx5RQKnrpFNZ76J
 g59itf2jttqY0sbFaxZT/ZuQ9Vu89oruVz0+zI8xOiTNGoEqVGiv+P+Ul8z7HkK9j1xjCbex3
 dLmJ3eBThaJ4bcYcmSyftJlXQsLOUswCfxp255H6QRq2EfRjKJhur95GDcAbFxjPqwMFk+shU
 Qf1ga/VCvfu2kp5fBEwW7/y5tyzGn4+9Y3nRkA8aGCOMitdTA/f03E1JD7t27UJs3XdVlSVqD
 VMhJ6S869gUn2EkA1pcXWGDuRAbfKJgHr2sdJv1QAPFiB1qQWVHFjB1suRUjfh+QvqBoSZDkx
 BEi71x4C0eLSScN03c9RNx8E3Y8oLkeOBkk0IZWbfT0/YqBUy/7nGZ+KV/MFCQKaBJZF8+LJd
 KN1CFUDDj+dWGK8kh0DXL0dRgpWAvAHOSg7hgRT05D9OBq1RWQttsrbD38cMdXBRZ/uqOy3xy
 6jfGCALYu+9y02CKiqiYsepGiZ1tdMQTIzzUtbXQrIxVkf3IgyvatK6yV26naWeGN/tIGlR2w
 wXbn6PrvzfAkaPb6V+BaesHD8q3JyJMWFwBLeNBoGKfV+s0umh7LQpVso9ChX4BrSgBKLQwFT
 2eONfBUXR19ISImcXS+CcbM1UnXlUdfWK0eS4UcqlWlJ5CnI/RL9RuXErCI=
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
incrementing `done_alias` until `handle_alias()` fails, which means that
there are no further aliases that can be processed. Prevent looping
aliases by storing substituted commands in `cmd_list` and checking if
a command has been substituted previously.
---

This is what I've come up with to prevent looping aliases. I'm not too
happy with the number of indentations needed, but this seemed to be the
easiest way to search an array for a value.

---
 git.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index c27c38738..fd90a3341 100644
--- a/git.c
+++ b/git.c
@@ -674,6 +674,8 @@ static void execv_dashed_external(const char **argv)
 static int run_argv(int *argcp, const char ***argv)
 {
 	int done_alias = 0;
+	const char **cmd_list = NULL;
+	int cmd_list_alloc = 0;
 
 	while (1) {
 		/*
@@ -691,17 +693,34 @@ static int run_argv(int *argcp, const char ***argv)
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);
 
+		/* Increase the array size and add the current
+		 * command to it.
+		 */
+		cmd_list_alloc += strlen(*argv[0]) + 1;
+		REALLOC_ARRAY(cmd_list, cmd_list_alloc);
+		cmd_list[done_alias] = *argv[0];
+
+		/* Search the array for occurrences of that command,
+		 * abort if something has been found.
+		 */
+		for (int i = 0; i < done_alias; i++) {
+			if (!strcmp(cmd_list[i], *argv[0])) {
+				die("loop alias: %s is called twice",
+				    cmd_list[done_alias]);
+			}
+		}
+
 		/* It could be an alias -- this works around the insanity
 		 * of overriding "git log" with "git show" by having
 		 * alias.log = show
 		 */
-		if (done_alias)
-			break;
 		if (!handle_alias(argcp, argv))
 			break;
-		done_alias = 1;
+		done_alias++;
 	}
 
+	free(cmd_list);
+
 	return done_alias;
 }
 
-- 
2.19.0.rc1.2.g8f4faccc1

