Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ECFC433F5
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 00:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhLYATT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 19:19:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60835 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhLYATT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 19:19:19 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B16871742E9;
        Fri, 24 Dec 2021 19:19:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ybYMzoTmzFMpyUB1pT4tzj81QAK10mKVBXECnK
        FMo8g=; b=IseaLE1YsiOlM5H6ys0Qfo1Y4RXRybl6cSeOSM7PenoDeQQe4SMUJi
        JOX9udu8FQeLnObYxRSJCZq9PBsEvfeO4a2nFdTIB9LS5YBLk3Tm96XahaX0eM2V
        ptNJUvhcD4dUJ/DoP5DvGb/0vdDL3cdv7hyPYf66zJlTbJklyX20w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9A4F1742E8;
        Fri, 24 Dec 2021 19:19:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1656E1742E7;
        Fri, 24 Dec 2021 19:19:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [RFC/PATCH] grep: allow scripts to ignore configured pattern type
References: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
        <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
        <patch-v5-3.7-f02f246aa23-20211222T025214Z-avarab@gmail.com>
        <xmqq35mj7yd4.fsf@gitster.g> <xmqqfsqh35vu.fsf_-_@gitster.g>
Date:   Fri, 24 Dec 2021 16:19:13 -0800
In-Reply-To: <xmqqfsqh35vu.fsf_-_@gitster.g> (Junio C. Hamano's message of
        "Fri, 24 Dec 2021 16:06:13 -0800")
Message-ID: <xmqqa6gp35a6.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AD96592-6518-11EC-900B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We made a mistake to add grep.extendedRegexp configuration variable
long time ago, and made things even worse by introducing an even
more generalized grep.patternType configuration variable.

This was mostly because interactive users were lazy and wanted a way
to declare "I do not live in the ancient age, and my regexps are
always extended" and write "git grep" without having to type three
more letters " -E" on the command line.

But this in turn forces script writers to always specify what kind
of patterns they are writing, because without such command line
override, the interpretation of the patterns they write in their
scripts will be affected by the configuration variables of the user
who is running their script.

Introduce GIT_DISABLE_GREP_PATTERN_CONFIG environment variable that
script writers can set to "true" and export at the very beginning of
their script to defeat grep.extendedRegexp and grep.patternType
configuration variables.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is merely a weather balloon without proper documentation and
   test.  It might be even better idea to make such an environment
   variable to _specify_ what kind of pattern the script uses,
   instead of "we defeat end-user configuration and now we are
   forced to write in basic or have to write -E/-P etc.", which is
   what this patch does.

 grep.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index fe847a0111..0cfb698b51 100644
--- a/grep.c
+++ b/grep.c
@@ -77,10 +77,15 @@ int grep_config(const char *var, const char *value, void *cb)
 {
 	struct grep_opt *opt = &grep_defaults;
 	const char *slot;
+	static int disable_pattern_type_config = -1;
 
 	if (userdiff_config(var, value) < 0)
 		return -1;
 
+	if (disable_pattern_type_config < 0)
+		disable_pattern_type_config =
+			git_env_bool("GIT_DISABLE_GREP_PATTERN_CONFIG", 0);
+
 	/*
 	 * The instance of grep_opt that we set up here is copied by
 	 * grep_init() to be used by each individual invocation.
@@ -90,12 +95,14 @@ int grep_config(const char *var, const char *value, void *cb)
 	 */
 
 	if (!strcmp(var, "grep.extendedregexp")) {
-		opt->extended_regexp_option = git_config_bool(var, value);
+		if (!disable_pattern_type_config)
+			opt->extended_regexp_option = git_config_bool(var, value);
 		return 0;
 	}
 
 	if (!strcmp(var, "grep.patterntype")) {
-		opt->pattern_type_option = parse_pattern_type_arg(var, value);
+		if (!disable_pattern_type_config)
+			opt->pattern_type_option = parse_pattern_type_arg(var, value);
 		return 0;
 	}
 
-- 
2.34.1-563-g3368a7891b

