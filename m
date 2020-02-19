Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92D7C34050
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984B120675
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJXoRHrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgBSQOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:14:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38562 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgBSQOP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 11:14:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id e8so1223136wrm.5
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 08:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tm9EzeIgnSiuZuVB30bbVxlHxxUkGq1RLAp3brgJtUY=;
        b=SJXoRHrLLTfdOdr25Sx4BVU4O/CwVBnxvUwoeSNO6c7cNxa8YCxHc96ersC+PjVjHa
         kw1yntA/UAuHuPoUffmzPO+sbrW3k43mOr93e14ihQwqTNFMm95lvi/uqKi20o0BNfFM
         IBlZXvhjAgUDLvHJR+TfAC23dQ9Uv2TBDY/RPMSDdu59aGrAzuMYybcl+zw9TiOxEzIt
         G8RahtgoGGk8T605gVekQ0+hrWYQn84aIs4514lnTtFtzEDKiaVHp3hJltkTh5+eyyAg
         cDEC3p9k2sg/RwiiABDJlmTDi1Q2NhtyPR4Ab2JKPnX967rMysfR+ebtsn3aPr1sdnUd
         PIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tm9EzeIgnSiuZuVB30bbVxlHxxUkGq1RLAp3brgJtUY=;
        b=JCYYJQFp1PA1sv22cNGZnZVpdykL1nm35neJox+jWqI/muduokDQ/cZgig6iGNAHmY
         4B2sVfrxYAwucmqkCehabeId1CTXn1jhWQGBS9GP2f1igL1akvlSyU6k+AZDljLFRphV
         SfgK9yIdJvzCHK5gMwzP2PjEgmSQh0f0oMH5pIYnHsA92Yfx0BvYmlOrJm6yGL62XcwP
         cvZF2eW/tlnkK2hnGeYb/J2PdkmyS3qO+fAvAAkGV/WGqcispHyxF+opv/CYksAe72lR
         of2y8TNoNV26DvLqgiQfFdX42Jvo4/dmlnVSWqyuNa4cpEAV+tjXUgjoAByQvchWCMcw
         Chag==
X-Gm-Message-State: APjAAAWHxeyZma28RFGSOTnFxzHd5YVT0ZPKYA6wRp1tthAuKOXWzHo9
        DqUVMFqXrmos42nHIxXVSkY/peyy
X-Google-Smtp-Source: APXvYqw666pcO5cFsfimkvGJo/vSOUiygJGz0rl6cCnjwRO3n7zDEr3cLuuGhTYd9oXwEOzHKccv2g==
X-Received: by 2002:a5d:638f:: with SMTP id p15mr36380246wru.402.1582128853114;
        Wed, 19 Feb 2020 08:14:13 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
        by smtp.gmail.com with ESMTPSA id w7sm376771wmi.9.2020.02.19.08.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 08:14:12 -0800 (PST)
From:   pbonzini@redhat.com
To:     git@vger.kernel.org
Cc:     bfields@redhat.com
Subject: [PATCH 4/4] am: support --show-current-patch=diff to retrieve .git/rebase-apply/patch
Date:   Wed, 19 Feb 2020 17:13:52 +0100
Message-Id: <20200219161352.13562-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219161352.13562-1-pbonzini@redhat.com>
References: <20200219161352.13562-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

When "git am --show-current-patch" was added in commit 984913a210 ("am:
add --show-current-patch", 2018-02-12), "git am" started recommending it
as a replacement for .git/rebase-merge/patch.  Unfortunately the suggestion
is misguided, for example the output "git am --show-current-patch" cannot
be passed to "git apply" if it is encoded as quoted-printable or base64.
Add a new mode to "git am --show-current-patch" in order to straighten
the suggestion.

Reported-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/git-am.txt               | 10 ++++++----
 builtin/am.c                           |  7 ++++++-
 contrib/completion/git-completion.bash |  2 +-
 t/t4150-am.sh                          | 10 ++++++++++
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index bafb491ede..363d6ff665 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
 	 [(<mbox> | <Maildir>)...]
-'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=raw])
+'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=raw|diff])
 
 DESCRIPTION
 -----------
@@ -176,9 +176,11 @@ default.   You can use `--no-utf8` to override this.
 	Abort the patching operation but keep HEAD and the index
 	untouched.
 
---show-current-patch[=raw]::
-	Show the entire e-mail message "git am" has stopped at, because
-	of conflicts.
+--show-current-patch[=raw|diff]::
+	Show the message "git am" has stopped at, because of conflicts.
+	If the argument is absent or "raw", show the raw contents of
+	the e-mail message.  If the argument is "diff", show the diff
+	portion only.
 
 DISCUSSION
 ----------
diff --git a/builtin/am.c b/builtin/am.c
index ec4c743556..ad543882ed 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -83,6 +83,7 @@ enum signoff_type {
 
 enum show_patch_type {
 	SHOW_PATCH_RAW = 0,
+	SHOW_PATCH_DIFF = 1,
 };
 
 struct am_state {
@@ -1767,7 +1768,7 @@ static void am_run(struct am_state *state, int resume)
 				linelen(state->msg), state->msg);
 
 			if (advice_amworkdir)
-				advise(_("Use 'git am --show-current-patch' to see the failed patch"));
+				advise(_("Use 'git am --show-current-patch=diff' to see the failed patch"));
 
 			die_user_resolve(state);
 		}
@@ -2086,6 +2087,9 @@ static int show_patch(struct am_state *state, enum show_patch_type sub_mode)
 	case SHOW_PATCH_RAW:
 		patch_path = am_path(state, msgnum(state));
 		break;
+	case SHOW_PATCH_DIFF:
+		patch_path = am_path(state, "patch");
+		break;
 	default:
 		abort();
 	}
@@ -2154,6 +2158,7 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
 	 * when you add new options
 	 */
 	const char *valid_modes[] = {
+		[SHOW_PATCH_DIFF] = "diff",
 		[SHOW_PATCH_RAW] = "raw"
 	};
 	int new_value = SHOW_PATCH_RAW;
@@ -2284,7 +2288,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("abort the patching operation but keep HEAD where it is."),
 			RESUME_QUIT),
 		{ OPTION_CALLBACK, 0, "show-current-patch", &resume.mode,
-		  "raw",
+		  "diff|raw",
 		  N_("show the patch being applied"),
 		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 247f34f1fa..1151697f01 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1197,7 +1197,7 @@ __git_count_arguments ()
 
 __git_whitespacelist="nowarn warn error error-all fix"
 __git_patchformat="mbox stgit stgit-series hg mboxrd"
-__git_showcurrentpatch="raw"
+__git_showcurrentpatch="raw diff"
 __git_am_inprogress_options="--skip --continue --resolved --abort --quit --show-current-patch"
 
 _git_am ()
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index afe456e75e..cb45271457 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -671,11 +671,21 @@ test_expect_success 'am --show-current-patch=raw' '
 	test_cmp .git/rebase-apply/0001 actual.patch
 '
 
+test_expect_success 'am --show-current-patch=diff' '
+	git am --show-current-patch=diff >actual.patch &&
+	test_cmp .git/rebase-apply/patch actual.patch
+'
+
 test_expect_success 'am accepts repeated --show-current-patch' '
 	git am --show-current-patch --show-current-patch=raw >actual.patch &&
 	test_cmp .git/rebase-apply/0001 actual.patch
 '
 
+test_expect_success 'am detects incompatible --show-current-patch' '
+	test_must_fail git am --show-current-patch=raw --show-current-patch=diff &&
+	test_must_fail git am --show-current-patch --show-current-patch=diff
+'
+
 test_expect_success 'am --skip works' '
 	echo goodbye >expected &&
 	git am --skip &&
-- 
2.21.1

