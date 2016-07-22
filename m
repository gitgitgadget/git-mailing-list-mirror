Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03226203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 19:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbcGVTVg (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:21:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750989AbcGVTVf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 15:21:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B663D2DDCD;
	Fri, 22 Jul 2016 15:21:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JnhZ1ZUfXABp0+s8Irgg5Adi/yc=; b=Uw6r5w
	cyX9LvPagF3oOX4rbTULDpRe4ArLh8HrMkSKpgf6tRBYO44f10IWPUwqcIaigITM
	6AzThzo5LqLiBxNpy1LQqZkhBGPpndO/l31uUlO1v//UDaldF0LxUD/odruPnjmU
	jBtVWBXYbhvR2NnSpPBmNVRkTaoSZGjGmE/HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aYIfo0aIVK91No7K0QH/2y2zPpkjqCd9
	/1zSLqyO9WQMlbvfRdX5dstRY0Nu1AYjJiZZmW2Uek3DWJlK5PU4w6AeW4FwILnF
	IcIs2qaYiOtf3IYL2jObvRMF4cZd8Qz60a/QWalstzIoqEdUmTfbRxHEQkkk3jA/
	yudwsEEzmnQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF40C2DDCB;
	Fri, 22 Jul 2016 15:21:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30B762DDCA;
	Fri, 22 Jul 2016 15:21:33 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Richard Soderberg <rsoderberg@gmail.com>, git@vger.kernel.org
Subject: Re: git-prompt.sh incompatible with non-basic global grep.patternType
References: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
	<20160720134211.GA19359@sigill.intra.peff.net>
	<xmqqwpkgcbp9.fsf@gitster.mtv.corp.google.com>
	<20160720205207.GA578@sigill.intra.peff.net>
Date:	Fri, 22 Jul 2016 12:21:31 -0700
In-Reply-To: <20160720205207.GA578@sigill.intra.peff.net> (Jeff King's message
	of "Wed, 20 Jul 2016 14:52:07 -0600")
Message-ID: <xmqqr3ala37o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 800221EC-5041-11E6-A5A2-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I gave a very cursory look when I wrote the other email, and your
> alternative solution is what looked like the most elegant fix to me.
>
> I suspect this bug has been there quite a while, so no rush. :)

Here is what I am going to queue.

One thing that I noticed is that there is this strange field
in grep_opt called .extended_regexp_option; it only is set from the
boolean configuration grep.extendedregexp and worse yet it takes
precedence over the command line option or grep.patternType, e.g.
t7810-grep expects crazy things like these:

 * "git -c grep.extendedregexp=true -c grep.patterntype=basic grep"
   wants to be like "git grep -E"

 * "git -c grep.extendedregexp=false -c grep.patterntype=extended grep"
   wants to be like "git grep -G"

This comes from b22520a3 (grep: allow -E and -n to be turned on by
default via configuration, 2011-03-30) back when we didn't have a
more generic grep.patternType configuration mechanism in v1.7.5
days, and it probably need to be deprecated to maintain our sanity.
I.e. when we see the configuration used, first we warn the user and
set grep.patternType to extended instead, and then eventually error
out in a backward-compatibility breaking release of Git we will make
in some future date, together with things like other compatibility
breaking topics like ex/deprecate-empty-pathspec-as-match-all.

But that is a separate topic after this fix goes in anyway.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 22 Jul 2016 11:43:14 -0700
Subject: [PATCH] grep: further simplify setting the pattern type

When c5c31d33 (grep: move pattern-type bits support to top-level
grep.[ch], 2012-10-03) introduced grep_commit_pattern_type() helper
function, the intention was to allow the users of grep API to having
to fiddle only with .pattern_type_option (which can be set to "fixed",
"basic", "extended", and "pcre"), and then immediately before compiling
the pattern strings for use, call grep_commit_pattern_type() to have
it prepare various bits in the grep_opt structure (like .fixed,
.regflags, etc.).

However, grep_set_pattern_type_option() helper function the grep API
internally uses were left as an external function by mistake.  This
function shouldn't have been made callable by the users of the API.

Later when the grep API was used in revision graversal machinery,
the caller then mistakenly started calling the function around
34a4ae55 (log --grep: use the same helper to set -E/-F options as
"git grep", 2012-10-03), instead of setting the .pattern_type_option
field and letting the grep_commit_pattern_type() to take care of the
details.

This caused an unnecessary bug that made a configured
grep.patternType take precedence over the command line options
(e.g. --basic-regexp, --fixed-strings) in "git log" family of
commands.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c         | 22 +++++++++++-----------
 grep.h         |  1 -
 revision.c     |  8 ++++----
 t/t4202-log.sh | 14 ++++++++++++++
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/grep.c b/grep.c
index b58c7c6..0bc5cc1 100644
--- a/grep.c
+++ b/grep.c
@@ -161,17 +161,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	strcpy(opt->color_sep, def->color_sep);
 }
 
-void grep_commit_pattern_type(enum grep_pattern_type pattern_type, struct grep_opt *opt)
-{
-	if (pattern_type != GREP_PATTERN_TYPE_UNSPECIFIED)
-		grep_set_pattern_type_option(pattern_type, opt);
-	else if (opt->pattern_type_option != GREP_PATTERN_TYPE_UNSPECIFIED)
-		grep_set_pattern_type_option(opt->pattern_type_option, opt);
-	else if (opt->extended_regexp_option)
-		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, opt);
-}
-
-void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
+static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
 {
 	switch (pattern_type) {
 	case GREP_PATTERN_TYPE_UNSPECIFIED:
@@ -203,6 +193,16 @@ void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct gr
 	}
 }
 
+void grep_commit_pattern_type(enum grep_pattern_type pattern_type, struct grep_opt *opt)
+{
+	if (pattern_type != GREP_PATTERN_TYPE_UNSPECIFIED)
+		grep_set_pattern_type_option(pattern_type, opt);
+	else if (opt->pattern_type_option != GREP_PATTERN_TYPE_UNSPECIFIED)
+		grep_set_pattern_type_option(opt->pattern_type_option, opt);
+	else if (opt->extended_regexp_option)
+		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, opt);
+}
+
 static struct grep_pat *create_grep_pat(const char *pat, size_t patlen,
 					const char *origin, int no,
 					enum grep_pat_token t,
diff --git a/grep.h b/grep.h
index 95f197a..9e9ec5f 100644
--- a/grep.h
+++ b/grep.h
@@ -144,7 +144,6 @@ struct grep_opt {
 extern void init_grep_defaults(void);
 extern int grep_config(const char *var, const char *value, void *);
 extern void grep_init(struct grep_opt *, const char *prefix);
-void grep_set_pattern_type_option(enum grep_pattern_type, struct grep_opt *opt);
 void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
 
 extern void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
diff --git a/revision.c b/revision.c
index 871812d..c46dca4 100644
--- a/revision.c
+++ b/revision.c
@@ -1964,16 +1964,16 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--grep-debug")) {
 		revs->grep_filter.debug = 1;
 	} else if (!strcmp(arg, "--basic-regexp")) {
-		grep_set_pattern_type_option(GREP_PATTERN_TYPE_BRE, &revs->grep_filter);
+		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_BRE;
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
-		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, &revs->grep_filter);
+		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_ERE;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
 		revs->grep_filter.regflags |= REG_ICASE;
 		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
-		grep_set_pattern_type_option(GREP_PATTERN_TYPE_FIXED, &revs->grep_filter);
+		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_FIXED;
 	} else if (!strcmp(arg, "--perl-regexp")) {
-		grep_set_pattern_type_option(GREP_PATTERN_TYPE_PCRE, &revs->grep_filter);
+		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_PCRE;
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
 	} else if (!strcmp(arg, "--invert-grep")) {
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1b2e981..f136a0f 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -232,6 +232,20 @@ test_expect_success 'log -F -E --grep=<ere> uses ere' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log with grep.patternType configuration' '
+	>expect &&
+	git -c grep.patterntype=fixed \
+	log -1 --pretty=tformat:%s --grep=s.c.nd >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log with grep.patternType configuration and command line' '
+	echo second >expect &&
+	git -c grep.patterntype=fixed \
+	log -1 --pretty=tformat:%s --basic-regexp --grep=s.c.nd >actual &&
+	test_cmp expect actual
+'
+
 cat > expect <<EOF
 * Second
 * sixth
-- 
2.9.2-587-gac3bda4

