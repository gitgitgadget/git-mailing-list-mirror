From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] branch, commit, name-rev: ease up boolean conditions
Date: Tue,  6 Aug 2013 15:07:14 +0200
Message-ID: <1375794434-12257-1-git-send-email-stefanbeller@googlemail.com>
References: <5200F3D6.5040004@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Tue Aug 06 15:07:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6gyy-0001AD-LO
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 15:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755929Ab3HFNHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 09:07:20 -0400
Received: from mail-ea0-f179.google.com ([209.85.215.179]:55294 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693Ab3HFNHT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 09:07:19 -0400
Received: by mail-ea0-f179.google.com with SMTP id b10so212198eae.10
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d1ABCiAEggmpx86Ui/wjcn/m5pF+AaROb5Wh0qQb+jM=;
        b=FEmlbtF1tECY1K1BznhbA7YuRxZXX2YiupxhcGrqai5KL074qJb+eRBc+SZjIkqG9x
         AWA3gUyDK9f2EXlUXgVVIS/KhYCdq9PJjNF77Igm5lbwrj/C2U8vBrhMTxYbqm+pmtii
         mEh1meEEP/0Am2cx76xeoUpHQEZEuB7cZEk96Pct6U11QUQEr32NXTQCuExI6XrC0xPO
         hzZV4/+Vsh0BYYUUrZ0I0iSwAeBYBzquXUOld/YYM1oHu5lqb5/XwGNiTESsnPLgzaQc
         kavsfSJeX88oiM9JeNpLOMzWSbcxzsSK1glr/nDntZfedQgmL96AggmTH7kz3CwO09Aq
         X4dg==
X-Received: by 10.14.219.6 with SMTP id l6mr1061882eep.152.1375794437781;
        Tue, 06 Aug 2013 06:07:17 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id cg12sm2149921eeb.7.2013.08.06.06.07.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 06:07:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.16.g7fca822.dirty
In-Reply-To: <5200F3D6.5040004@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231738>

Now that the variables are readin by OPT_BOOL, which makes sure
to have the values being 0 or 1 after reading, we do not need
the double negation to map any other value to 1 for integer
variables.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/branch.c   | 3 ++-
 builtin/commit.c   | 2 +-
 builtin/name-rev.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4daed0b..0dca694 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -872,7 +872,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (with_commit || merge_filter != NO_FILTER)
 		list = 1;
 
-	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + !!unset_upstream > 1)
+	if (force_create + list + unset_upstream +
+	    !!delete + !!rename + !!new_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (abbrev == -1)
diff --git a/builtin/commit.c b/builtin/commit.c
index c20426b..b0f86c8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1072,7 +1072,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (patch_interactive)
 		interactive = 1;
 
-	if (!!also + !!only + !!all + !!interactive > 1)
+	if (also + only + all + interactive > 1)
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
 	if (argc == 0 && (also || (only && !amend)))
 		die(_("No paths with --include/--only does not make sense."));
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index a908a34..20fcf8c 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -331,7 +331,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
-	if (!!all + !!transform_stdin + !!argc > 1) {
+	if (all + transform_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
 		usage_with_options(name_rev_usage, opts);
 	}
-- 
1.8.4.rc0.16.g7fca822.dirty
