Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286ECC56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 21:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8366206F9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 21:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dI+X8+qJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbgKYVBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 16:01:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52507 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbgKYVBx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 16:01:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF2758D635;
        Wed, 25 Nov 2020 16:01:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BD/Gni6oyqFCTMXlY4aFYQCsziA=; b=dI+X8+
        qJAOiLNxvXxdwDUNtzPrTswllPlIq4eSAjjM4dGF75D79osDMB6Y/cBLRXVe6kWR
        tUsl60Quab3mco0mo2d6aw00UpU5nbGLds0JKEu2/xfMPjMHnFZxcUM3Mj5e0BOA
        Jk21OMxnaJsBwbogfiHG4O+ulqwkDExRQJkNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DnsGkPDHiMbX9Vh9WGZI3rmMLsUrTsh3
        mIWnIiroIxNB7fTgebLjCx7mXbTRf5yzRVajMh/lSKx6JhmFlPDHisZWnUrDtVIr
        GkvgEJlvPy6bGuf8mF3oJ8kEUbiYqNhXsTUv9I+Nf7V9s0p3xirA82vXJNBo0QPv
        yXWcqF5OyfY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6BCD8D634;
        Wed, 25 Nov 2020 16:01:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 733738D632;
        Wed, 25 Nov 2020 16:01:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, lanodan <contact+git@hacktivis.me>
Subject: [PATCH v6] help.c: help.autocorrect=never means "do not compute
 suggestions"
References: <20201124163752.20306-1-sir@cmpwn.com>
        <xmqqmtz6ig7h.fsf@gitster.c.googlers.com>
Date:   Wed, 25 Nov 2020 13:01:45 -0800
In-Reply-To: <xmqqmtz6ig7h.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 24 Nov 2020 13:43:14 -0800")
Message-ID: <xmqqft4xdubq.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DC52F8E-2F61-11EB-8145-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Drew DeVault <sir@cmpwn.com>

While help.autocorrect can be set to 0 to decline auto-execution of
possibly mistyped commands, it still spends cycles to compute the
suggestions, and it wastes screen real estate.

Update help.autocorrect to accept the string "never" to just exit
with error upon mistyped commands to help users who prefer to never
see suggested corrections at all.

While at it, introduce "immediate" as a more readable way to
immediately execute the auto-corrected command, which can be done
with negative value.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Took bugfix for the new test from SZEDER's review.

Range-diff against v5:
1:  59c61bb206 ! 1:  c4b6b18b2e help.c: help.autocorrect=never means "do not even compute suggestions"
    @@ t/t9003-help-autocorrect.sh: test_expect_success 'autocorrect showing candidates
     +	test_must_fail git lfg 2>actual &&
     +	if test_have_prereq C_LOCALE_OUTPUT
     +	then
    -+		: cannot test with poisoned i18n
    -+	else
     +		grep "is not a git command" actual &&
     +		test_line_count = 1 actual
     +	fi

 Documentation/config/help.txt | 15 ++++++++-------
 help.c                        | 25 ++++++++++++++++++++++---
 t/t9003-help-autocorrect.sh   | 30 ++++++++++++++++++++++--------
 3 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
index 224bbf5a28..783a90a0f9 100644
--- a/Documentation/config/help.txt
+++ b/Documentation/config/help.txt
@@ -8,13 +8,14 @@ help.format::
 	the default. 'web' and 'html' are the same.
 
 help.autoCorrect::
-	Automatically correct and execute mistyped commands after
-	waiting for the given number of deciseconds (0.1 sec). If more
-	than one command can be deduced from the entered text, nothing
-	will be executed.  If the value of this option is negative,
-	the corrected command will be executed immediately. If the
-	value is 0 - the command will be just shown but not executed.
-	This is the default.
+	If git detects typos and can identify exactly one valid command similar
+	to the error, git will automatically run the intended command after
+	waiting a duration of time defined by this configuration value in
+	deciseconds (0.1 sec).  If this value is 0, the suggested corrections
+	will be shown, but not executed. If it is a negative integer, or
+	"immediate", the suggested command
+	is run immediately. If "never", suggestions are not shown at all. The
+	default value is zero.
 
 help.htmlPath::
 	Specify the path where the HTML documentation resides. File system paths
diff --git a/help.c b/help.c
index 919cbb9206..3c3bdec213 100644
--- a/help.c
+++ b/help.c
@@ -472,12 +472,26 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 static int autocorrect;
 static struct cmdnames aliases;
 
+#define AUTOCORRECT_NEVER (-2)
+#define AUTOCORRECT_IMMEDIATELY (-1)
+
 static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
 {
 	const char *p;
 
-	if (!strcmp(var, "help.autocorrect"))
-		autocorrect = git_config_int(var,value);
+	if (!strcmp(var, "help.autocorrect")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (!strcmp(value, "never")) {
+			autocorrect = AUTOCORRECT_NEVER;
+		} else if (!strcmp(value, "immediate")) {
+			autocorrect = AUTOCORRECT_IMMEDIATELY;
+		} else {
+			int v = git_config_int(var, value);
+			autocorrect = (v < 0)
+				? AUTOCORRECT_IMMEDIATELY : v;
+		}
+	}
 	/* Also use aliases for command lookup */
 	if (skip_prefix(var, "alias.", &p))
 		add_cmdname(&aliases, p, strlen(p));
@@ -525,6 +539,11 @@ const char *help_unknown_cmd(const char *cmd)
 
 	read_early_config(git_unknown_cmd_config, NULL);
 
+	if (autocorrect == AUTOCORRECT_NEVER) {
+		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
+		exit(1);
+	}
+
 	load_command_list("git-", &main_cmds, &other_cmds);
 
 	add_cmd_list(&main_cmds, &aliases);
@@ -594,7 +613,7 @@ const char *help_unknown_cmd(const char *cmd)
 			   _("WARNING: You called a Git command named '%s', "
 			     "which does not exist."),
 			   cmd);
-		if (autocorrect < 0)
+		if (autocorrect == AUTOCORRECT_IMMEDIATELY)
 			fprintf_ln(stderr,
 				   _("Continuing under the assumption that "
 				     "you meant '%s'."),
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index b1c7919c4a..03cd5c5423 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -37,16 +37,30 @@ test_expect_success 'autocorrect showing candidates' '
 	grep "^	distimdistim" actual
 '
 
-test_expect_success 'autocorrect running commands' '
-	git config help.autocorrect -1 &&
+for immediate in -1 immediate
+do
+	test_expect_success 'autocorrect running commands' '
+		git config help.autocorrect $immediate &&
 
-	git lfg >actual &&
-	echo "a single log entry" >expect &&
-	test_cmp expect actual &&
+		git lfg >actual &&
+		echo "a single log entry" >expect &&
+		test_cmp expect actual &&
 
-	git distimdist >actual &&
-	echo "distimdistim was called" >expect &&
-	test_cmp expect actual
+		git distimdist >actual &&
+		echo "distimdistim was called" >expect &&
+		test_cmp expect actual
+	'
+done
+
+test_expect_success 'autocorrect can be declined altogether' '
+	git config help.autocorrect never &&
+
+	test_must_fail git lfg 2>actual &&
+	if test_have_prereq C_LOCALE_OUTPUT
+	then
+		grep "is not a git command" actual &&
+		test_line_count = 1 actual
+	fi
 '
 
 test_done
-- 
2.29.2-533-ge2694b469b

