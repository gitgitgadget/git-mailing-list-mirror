Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4012A1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 21:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfDZVRI (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 17:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfDZVRH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 17:17:07 -0400
Received: from localhost.localdomain (c-71-237-40-145.hsd1.co.comcast.net [71.237.40.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB0A206C1;
        Fri, 26 Apr 2019 21:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556313427;
        bh=gBImfZx1qIigxuZ47SUd3qEUGkZRD18Qzn5CU36e9DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vaEXdNgptdqYTALwpgYXhiqzty6pmTpC8b1m2e976MbV+zSa65gy8muA6ACjWByHy
         WPBcdEp8Y8dmKkoQRT+44inVA97Hh/amZ/U9jvKMZhPkL9eozPzywlGgUhaeJSKuQA
         XKO/jYTqht5moUntAKrFGofIatINZzb/tTwnnRZI=
From:   vishal@kernel.org
To:     git@vger.kernel.org
Cc:     Vishal Verma <vishal@stellar.sh>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
Subject: [PATCH v2] builtin/merges: clarify --squash behavior with --commit
Date:   Fri, 26 Apr 2019 15:17:03 -0600
Message-Id: <20190426211703.25604-1-vishal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <dfc0a40233677ce0e1d9d073c41b6f0fea3bf746.camel@stellar.sh>
References: <dfc0a40233677ce0e1d9d073c41b6f0fea3bf746.camel@stellar.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Vishal Verma <vishal@stellar.sh>

Convert option_commit to tristate, representing the states of
'default/untouched', 'enabled-by-cli', 'disabled-by-cli'. With this in
place, check whether option_commit was enabled by cli when squashing a
merge. If so, error out, as this is not supported.

Add a note to the --squash option for git-merge to clarify the
incompatibility.

Previously, when --squash was supplied, 'option_commit' was silently
dropped. This could have been surprising to a user who tried to override
the no-commit behavior of squash using --commit explicitly.

Cc: Junio C Hamano <gitster@pobox.com>
Cc: Rafael Ascensão <rafa.almas@gmail.com>
Signed-off-by: Vishal Verma <vishal@stellar.sh>
---

v2:
 - Error out when both --squash and --commit are supplied (Junio)
 - Adjust the documentation accordingly.

 Documentation/merge-options.txt |  2 ++
 builtin/merge.c                 | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 92a7d936c1..263b194247 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -95,6 +95,8 @@ merge.
 +
 With --no-squash perform the merge and commit the result. This
 option can be used to override --squash.
++
+With --squash, --commit is not allowed, and will fail.
 
 -s <strategy>::
 --strategy=<strategy>::
diff --git a/builtin/merge.c b/builtin/merge.c
index 5ce8946d39..98f268ac57 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -57,7 +57,7 @@ static const char * const builtin_merge_usage[] = {
 };
 
 static int show_diffstat = 1, shortlog_len = -1, squash;
-static int option_commit = 1;
+static int option_commit = -1;
 static int option_edit = -1;
 static int allow_trivial = 1, have_message, verify_signatures;
 static int overwrite_ignore = 1;
@@ -1304,9 +1304,25 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (verbosity < 0)
 		show_diffstat = 0;
 
+	/*
+	 * This indicates option_commit was influenced by the command line.
+	 * Check and error out for the squash case.
+	 */
+	if ((option_commit > 0) && squash)
+		die(_("You cannot combine --squash with --commit."));
+
+	/* If option_commit is the default '-1', we can 'enable' it */
+	if (option_commit < 0)
+		option_commit = 1;
+
 	if (squash) {
 		if (fast_forward == FF_NO)
 			die(_("You cannot combine --squash with --no-ff."));
+		/*
+		 * squash can now silently disable option_commit - this is not
+		 * a problem as it is only overriding the default, not a user
+		 * supplied option.
+		 */
 		option_commit = 0;
 	}
 
-- 
2.20.1

