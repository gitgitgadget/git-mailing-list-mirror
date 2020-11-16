Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02D0C388F9
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 23:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 680A020BED
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 23:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HH2BHaAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbgKPXlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 18:41:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51567 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbgKPXlv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 18:41:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68C5989E83;
        Mon, 16 Nov 2020 18:41:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ruWKEYmIj/IRcD/fvcgNHIRSFxU=; b=HH2BHa
        AKB730nakuIWc7b2N1Yqzur/5c3yWg7WsOFBo4ZYvgY7XPX/N4vF0qTgDNdgvYDj
        +pcciV77WSxkHydYIdr6b0hPN2ZAHpH0WqdO7obSoyx/XISxl0f9+bjMCbRtaKr2
        chM10lbyDKMGUIkW260+StdHF05Qn3Z/dlv3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M/M1MiYWjPtwEcAIkalErWnw5Am34Gvb
        U0LiuvD2psS6EVGtTKJBktpOVRDTqIkvbWuMu6138+IWocqD9GPQVzTs3VZBVxd2
        Tn1HG/UF6ahM3MNDqneJofnskHRuleCg1hF99ee8JBmJEDYPjtrvoGJDCjGu2tHG
        Zhgzr2eYArY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FD3E89E82;
        Mon, 16 Nov 2020 18:41:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2F4789E81;
        Mon, 16 Nov 2020 18:41:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, lanodan <contact+git@hacktivis.me>
Subject: Re: [PATCH] help.c: add advice.correctTypos option
References: <20201116185521.2276-1-sir@cmpwn.com>
Date:   Mon, 16 Nov 2020 15:41:46 -0800
In-Reply-To: <20201116185521.2276-1-sir@cmpwn.com> (Drew DeVault's message of
        "Mon, 16 Nov 2020 13:55:21 -0500")
Message-ID: <xmqqlff07ttx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A5F3A7E-2865-11EB-A19E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> This allows users to disable guessing the commands or options that they
> meant to use.
> ---
> Questions:
>
> - Is advice.* the right namespace?
> - How should this interact with help.autocorrect?

If you are declining help.autocorrect altogether, do you need to
still invent a new and separate configuration variable?  Isn't a new
value (e.g. 'never') given to help.autocorrect sufficient?

Something along this line (not even compile tested though)?

 help.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git c/help.c w/help.c
index 4fb93d5560..06f86152a6 100644
--- c/help.c
+++ w/help.c
@@ -469,6 +469,8 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 	return 0;
 }
 
+#define AUTOCORRECT_NEVER (-2)
+#define AUTOCORRECT_IMMEDIATELY (-1)
 static int autocorrect;
 static struct cmdnames aliases;
 
@@ -476,8 +478,19 @@ static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
 {
 	const char *p;
 
-	if (!strcmp(var, "help.autocorrect"))
-		autocorrect = git_config_int(var,value);
+	if (!strcmp(var, "help.autocorrect")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (!strcmp(value, "never"))
+			autocorrect = AUTOCORRECT_NEVER;
+		else {
+			int v = git_config_int(var,value);
+			if (v < 0)
+				autocorrect = AUTOCORRECT_IMMEDIATELY;
+			else
+				autocorrect = v;
+		}
+	}
 	/* Also use aliases for command lookup */
 	if (skip_prefix(var, "alias.", &p))
 		add_cmdname(&aliases, p, strlen(p));
@@ -519,6 +532,9 @@ const char *help_unknown_cmd(const char *cmd)
 	struct cmdnames main_cmds, other_cmds;
 	struct cmdname_help *common_cmds;
 
+	if (autocorrect == AUTOCORRECT_NEVER)
+		exit(1);
+
 	memset(&main_cmds, 0, sizeof(main_cmds));
 	memset(&other_cmds, 0, sizeof(other_cmds));
 	memset(&aliases, 0, sizeof(aliases));
@@ -594,7 +610,7 @@ const char *help_unknown_cmd(const char *cmd)
 			   _("WARNING: You called a Git command named '%s', "
 			     "which does not exist."),
 			   cmd);
-		if (autocorrect < 0)
+		if (autocorrect == AUTOCORRECT_IMMEDIATELY)
 			fprintf_ln(stderr,
 				   _("Continuing under the assumption that "
 				     "you meant '%s'."),
