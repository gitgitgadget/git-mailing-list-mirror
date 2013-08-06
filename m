From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] branch, commit, name-rev: ease up boolean conditions
Date: Tue,  6 Aug 2013 22:18:52 +0200
Message-ID: <1375820332-30816-1-git-send-email-stefanbeller@googlemail.com>
References: <52015A17.6040204@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: sunshine@sunshineco.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 06 22:19:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6nib-00050k-36
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 22:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756407Ab3HFUSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 16:18:53 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:42989 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756366Ab3HFUSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 16:18:52 -0400
Received: by mail-ee0-f42.google.com with SMTP id b45so432032eek.15
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 13:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4iNwYL+8oE0UkIbqLhmJqBI5pgMnbmQjG02j5/m/MZA=;
        b=DI421Kaxu6FLExGYjkG89g3oLJG5+fKq+lgVWgN2SG2Q1nNfXEOKC7exJD1IDdzfz4
         1gn/dgN8E+/QZDyVawj4VjdPz4uokB0kb1OrDxA46RK4BwMc8xOA2IlFkkdDTypf2Ewj
         bfKo936eaSpw2mqfqgORfWxtrBpl94mMJlfawXT+B0yzqOvQ0xmI4Z4a7YzOOboTTvyJ
         wADd4h7/6VuSNYGz5hhu2OpMVw/t29idSlhIRT9bZwG4TeU4495/FT1BfUIb2iO0GNQi
         OJ2WyCGrusu2IQ46ci/7F+cDkWKQLrFqqtN8bZzWJlvBCOdwQ7GcJMshFHax22aCajlM
         EdyQ==
X-Received: by 10.15.75.73 with SMTP id k49mr2698035eey.36.1375820331649;
        Tue, 06 Aug 2013 13:18:51 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a1sm4521390eem.1.2013.08.06.13.18.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 13:18:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.16.g7fca822.dirty
In-Reply-To: <52015A17.6040204@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231784>

Now that the variables are set by OPT_BOOL, which makes sure
to have the values being 0 or 1 after parsing, we do not need
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
