Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41B7C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 16:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B43520870
	for <git@archiver.kernel.org>; Fri,  8 May 2020 16:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nhA4Ti28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEHQS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 12:18:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56246 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgEHQS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 12:18:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D529AD7AC4;
        Fri,  8 May 2020 12:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=arS9L/N+hvzkksVvO/9lCYd9dJc=; b=nhA4Ti
        28sIL28eMmwx8fQCDe7CfERvT4885YoSRBLtzMfP8nv5n14E90fb1+UCfFw/FUvi
        vMkCDVCj+9eTnvHmFPM67/2/koX4gM+SMud9wUjIPVbUtqtoimz/G6p8luzaFULY
        8n5ytxxCHwMa9lxDJcFL1dGn/8J3J5BrhAoLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ot6YRgearMeXDLxFBfj/OsfbqYJQ3xhj
        aiHClzaiE/eraG8Pij3QkgTlc9nSlFxuWsYzCWZ9w8xHAZSSKLFdW5tNM57YuDw+
        S1GOfVR/ylrX1RSLmu+V3Q0wz374wfknG+5/neL19+g5dedHPRJnB4MIwaeyd72z
        HGr5UutX0+o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCED9D7AC3;
        Fri,  8 May 2020 12:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1E2A3D7AC1;
        Fri,  8 May 2020 12:18:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com
Subject: [PATCH v6] submodule: port subcommand 'set-url' from shell to C
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
        <20200508062136.15257-1-shouryashukla.oo@gmail.com>
Date:   Fri, 08 May 2020 09:18:48 -0700
In-Reply-To: <20200508062136.15257-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Fri, 8 May 2020 11:51:36 +0530")
Message-ID: <xmqqd07ez9g7.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A0BB850-9147-11EA-923A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Shourya Shukla <shouryashukla.oo@gmail.com>

Convert submodule subcommand 'set-url' to a builtin. Port 'set-url' to
'submodule--helper.c' and call the latter via 'git-submodule.sh'.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Here is what I'll queue with fixups for now.

 builtin/submodule--helper.c | 32 ++++++++++++++++++++++++++++++++
 git-submodule.sh            | 22 +---------------------
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1a4b391c88..46c03d2a12 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2246,6 +2246,37 @@ static int module_config(int argc, const char **argv, const char *prefix)
 	usage_with_options(git_submodule_helper_usage, module_config_options);
 }
 
+static int module_set_url(int argc, const char **argv, const char *prefix)
+{
+	int quiet = 0;
+	const char *newurl;
+	const char *path;
+	char *config_name;
+
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodule")),
+		OPT_END()
+	};
+	const char *const usage[] = {
+		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	if (argc != 2 || !(path = argv[0]) || !(newurl = argv[1]))
+		usage_with_options(usage, options);
+
+	config_name = xstrfmt("submodule.%s.url", path);
+
+	config_set_in_gitmodules_file_gently(config_name, newurl);
+	sync_submodule(path, prefix, quiet ? OPT_QUIET : 0);
+
+	free(config_name);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2276,6 +2307,7 @@ static struct cmd_struct commands[] = {
 	{"is-active", is_active, 0},
 	{"check-name", check_name, 0},
 	{"config", module_config, 0},
+	{"set-url", module_set_url, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 08e0439df0..39ebdf25b5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -805,27 +805,7 @@ cmd_set_url() {
 		shift
 	done
 
-	if test $# -ne 2
-	then
-		usage
-	fi
-
-	# we can't use `git submodule--helper name` here because internally, it
-	# hashes the path so a trailing slash could lead to an unintentional no match
-	name="$(git submodule--helper list "$1" | cut -f2)"
-	if test -z "$name"
-	then
-		exit 1
-	fi
-
-	url="$2"
-	if test -z "$url"
-	then
-		exit 1
-	fi
-
-	git submodule--helper config submodule."$name".url "$url"
-	git submodule--helper sync ${GIT_QUIET:+--quiet} "$name"
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-url ${GIT_QUIET:+--quiet} -- "$@"
 }
 
 #
-- 
2.26.2-561-g07d8ea56f2

