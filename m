Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4381E1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 22:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeIHD1y (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 23:27:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:59885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbeIHD1x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 23:27:53 -0400
Received: from p2520la.fritz.box ([217.235.87.235]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MH0SI-1g2Cqh2B0M-00Dnvx; Sat, 08
 Sep 2018 00:44:33 +0200
From:   Tim Schumacher <timschumi@gmx.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        pclouds@gmail.com
Subject: [RFC PATCH v4 1/3] Add support for nested aliases
Date:   Sat,  8 Sep 2018 00:44:28 +0200
Message-Id: <20180907224430.23859-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.0.rc2.1.g4c98b8d69.dirty
In-Reply-To: <20180905085427.4099-1-timschumi@gmx.de>
References: <20180905085427.4099-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v1uk70HZUh+Jp7goKIxGl7N5wY5DLnqjoAEFcu/d7g+rlvfRmzp
 PAuWaO5m3PKiHRXuJnaeOB7KOJz65rmmG45mxmri2W8R47RPuc761HeKjafItkFRtaFZ468
 2EmtikrZdgerE7YTmk/CS1AXX3jisowAAOOs3lAk+P9F/P9KPkTq+NPdCC46KKSyvudaXbu
 tUUc0XS5f5YFqqoj/KGrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4FVJaAYqiYo=:uYP5WOh+N/pocqqzVYqWZn
 HUy2JttRqXvlUpfvXo+Rh+ve1Nrp7cTuSYcowyt4bIPRdaf0qHsBegMOomkz3bRL5crjl+udS
 Sx1EvYZjXrlJgljGV5QDWlW/ueUwuBsnXgFZL3yqx9cx0cmrMoMPFLzyI87e0/w01k11jE/2X
 o1hSgWWtQSSviT3l3eI7tToioUXaanvvy/T//57kaRCJEewm8p4ZJLoc/uQ6VfeDTasdKzXPy
 Eq7KggYC2lWHkg3TFGl5m89Jvs9R6hpEq3yFSPvYDO4CsGXNSZqUBoCGrKkwM20DC2yWPN3S6
 2I+H8dJkUS87gT7CZkf2u4e28VdJ6rKSfS0RAnHP+d8Tq2K5GFnBTAP/dsJzdFlqDfgJjWU2v
 3GWZt+BsCylRJfFntkXXQBotW8e+yk76iTAemR9tPDZcJV9BM14I4+QMn4rfK+2jXx8Sdievs
 Kza503kWObisJelIGmfY2CaMkqgevAZxYcM+h7DBIzDnZoj0eogX7SdDT5TGj1xuP0CCKhDbm
 X4ixwfj3xYwhP2Az5+rRqSYqK7ie1AYnWLLqz+o6bluwiwzHwRVUmn4CAPnmXAEzfSXmGI0D5
 EGvmB9xGgKn63v6KP8NS7nvnUD6J3DEf6vH1gUn7Yjloqc7xfwbeL1Hi4WV5QEaZ09FlXyTcl
 /6fbvyXl+ZP9c/Z4TLQwIzZRSEdayx/+eFTSk2LD6uF22OzopYp/U+Rs59Xg3oizmns9rN6MU
 ygnyOEraxForVL7TBMmS6rRPYlRqbefLkOwV9J5CPEhmN0J4xGJxQZU1KLU=
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

