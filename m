Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E040920441
	for <e@80x24.org>; Wed, 28 Dec 2016 22:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbcL1Wzx (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 17:55:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751906AbcL1Wzx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 17:55:53 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B2B2C056793;
        Wed, 28 Dec 2016 22:55:52 +0000 (UTC)
Received: from localhost (ovpn-116-29.gru2.redhat.com [10.97.116.29])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBSMtpej012961;
        Wed, 28 Dec 2016 17:55:51 -0500
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v3] am: add am.signoff add config variable
Date:   Wed, 28 Dec 2016 20:55:44 -0200
Message-Id: <20161228225544.16388-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 28 Dec 2016 22:55:52 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-am has options to enable --message-id and --3way by default,
but no option to enable --signoff by default. Add a "am.signoff"
config option.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Added documentation to Documentation/git-am.txt and
  Documentation/config.txt
* Added test cases to t4150-am.sh

Changes v2 -> v3:
* Fix doc to mention "--[no-]signoff" instead of "--[no]-signoff"
  * Reported-by: Andreas Schwab <schwab@linux-m68k.org>
* Add missing test_cmp line on test code
* Use "! grep" instead of "$(grep -c ...)" -eq 0
  * Suggested-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt |  5 +++++
 Documentation/git-am.txt |  6 ++++--
 builtin/am.c             |  2 ++
 t/t4150-am.sh            | 26 ++++++++++++++++++++++++++
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 30cb94610..6b2990203 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -822,6 +822,11 @@ am.keepcr::
 	by giving `--no-keep-cr` from the command line.
 	See linkgit:git-am[1], linkgit:git-mailsplit[1].
 
+am.signoff::
+	If true, git-am will add a `Signed-off-by:` line to the commit
+	message. See the signoff option in linkgit:git-commit[1] for
+	more information.
+
 am.threeWay::
 	By default, `git am` will fail if the patch does not apply cleanly. When
 	set to true, this setting tells `git am` to fall back on 3-way merge if
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 12879e402..1f14986c7 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -9,7 +9,7 @@ git-am - Apply a series of patches from a mailbox
 SYNOPSIS
 --------
 [verse]
-'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
+'git am' [--[no-]signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
 	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
@@ -32,10 +32,12 @@ OPTIONS
 	If you supply directories, they will be treated as Maildirs.
 
 -s::
---signoff::
+--[no-]-signoff::
 	Add a `Signed-off-by:` line to the commit message, using
 	the committer identity of yourself.
 	See the signoff option in linkgit:git-commit[1] for more information.
+	The `am.signoff` configuration variable can be used to specify the
+	default behaviour.  `--no-signoff` is useful to override `am.signoff`.
 
 -k::
 --keep::
diff --git a/builtin/am.c b/builtin/am.c
index 31fb60578..d2e02334f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -154,6 +154,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 
 	git_config_get_bool("am.messageid", &state->message_id);
 
+	git_config_get_bool("am.signoff", &state->signoff);
+
 	state->scissors = SCISSORS_UNSET;
 
 	argv_array_init(&state->git_apply_opts);
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 89a5bacac..d65c8e5c4 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -479,6 +479,32 @@ test_expect_success 'am --signoff adds Signed-off-by: line' '
 	test_cmp expected actual
 '
 
+test_expect_success '--no-signoff overrides am.signoff' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard first &&
+	test_config am.signoff true &&
+	git am --no-signoff <patch2 &&
+	printf "%s\n" "$signoff" >expected &&
+	git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
+	test_cmp expected actual &&
+	git cat-file commit HEAD > actual &&
+	! grep -q "Signed-off-by:" actual
+'
+
+test_expect_success 'am.signoff adds Signed-off-by: line' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard first &&
+	test_config am.signoff true &&
+	git am <patch2 &&
+	printf "%s\n" "$signoff" >expected &&
+	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >>expected &&
+	git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
+	test_cmp expected actual &&
+	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected &&
+	git cat-file commit HEAD | grep "Signed-off-by:" >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'am stays in branch' '
 	echo refs/heads/master2 >expected &&
 	git symbolic-ref HEAD >actual &&
-- 
2.11.0.259.g40922b1

