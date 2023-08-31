Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CC5C88CB2
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 22:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbjHaWFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 18:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHaWFA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 18:05:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130F311B
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 15:04:57 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63FBA1AAD15;
        Thu, 31 Aug 2023 18:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=hwYVzgRs7pKVpSCTXx75r1c20bgq+gxGmrFgzF
        8Anqo=; b=h9isj84T8Niqs/qb8SchCK27rifDTjeHnrLTgmSIFcurWNj1L1t1CM
        WbTJz1X1RA6FFRtJ9O5vCj3zh2p8mjxwswgzjTNzyVnxeyvhruxeZdUJtEECwKlc
        eTaM/Hu5v6dC+3xNYi6TkvVV7vufTwynwOjg2aU/mmORz4VuDw/v4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C3091AAD14;
        Thu, 31 Aug 2023 18:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BBB11AAD13;
        Thu, 31 Aug 2023 18:04:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Subject: Re: [PATCH v4] format-patch: --rfc honors what --subject-prefix sets
In-Reply-To: <20230831212950.GA949706@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 31 Aug 2023 17:29:50 -0400")
References: <20230830064646.30904-1-sir@cmpwn.com>
        <xmqqsf808h4g.fsf@gitster.g>
        <20230831212950.GA949706@coredump.intra.peff.net>
Date:   Thu, 31 Aug 2023 15:04:54 -0700
Message-ID: <xmqqv8cuswah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B177A8A-484A-11EE-8CA6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 30, 2023 at 12:28:15PM -0700, Junio C Hamano wrote:
>
>> Will queue.  Let's wait to see if others find something fishy for a
>> day or two and then merge it down to 'next'.
>
> It looks good to me, and I'm much happier with where the refactoring
> ended up compared to the earlier versions. I did have two nits, but I'm
> content if neither is addressed.
>
> One is that the commit message doesn't really describe the refactoring
> of --subject-prefix. I'm OK with that rationale being in the list
> archive, though.

Yeah, I agree that the reason for the change deserves to be
recorded.

>> >  static int subject_prefix_callback(const struct option *opt, const char *arg,
>> >  			    int unset)
>> >  {
>> > +	struct strbuf *sprefix;
>> > +
>> >  	BUG_ON_OPT_NEG(unset);
>> > +	sprefix = (struct strbuf *)opt->value;
>> >  	subject_prefix = 1;
>> > -	((struct rev_info *)opt->value)->subject_prefix = arg;
>> > +	strbuf_reset(sprefix);
>> > +	strbuf_addstr(sprefix, arg);
>> >  	return 0;
>> >  }
>> 
>> OK.
>
> The cast is unnecessary here, since opt->value is a void pointer which
> allows implicit casts. Just:
>
>   struct strbuf *sprefix = opt->value;
>
> is IMHO a little more readable. But as we're just passing it along to
> strbuf functions anyway, it would also work to do:
>
>   strbuf_reset(opt->value);
>   strbuf_addstr(opt->value, arg);
>
> I think we're deep into questions of style / preference here, so I'm OK
> with any of them. It's probably only that I've recently been refactoring
> so many parseopt callbacks with the same pattern that I have opinions at
> all. ;)

Sure.  FWIW, I like giving a meaningful name to a thing that is used
more than once, so my preference is the original minus excess cast.

Thanks for a review.  Here is a tentative rewrite

--- >8 ---
From e0d7db7423a91673c001aaa5e580c815ce2f7f92 Mon Sep 17 00:00:00 2001
From: Drew DeVault <sir@cmpwn.com>
Date: Wed, 30 Aug 2023 08:43:33 +0200
Subject: [PATCH v5] format-patch: --rfc honors what --subject-prefix sets

Rather than replacing the configured subject prefix (either through the
git config or command line) entirely with "RFC PATCH", this change
prepends RFC to whatever subject prefix was already in use.

This is useful, for example, when a user is working on a repository that
has a subject prefix considered to disambiguate patches:

	git config format.subjectPrefix 'PATCH my-project'

Prior to this change, formatting patches with --rfc would lose the
'my-project' information.

The data flow for the subject-prefix was that rev.subject_prefix
were to be kept the authoritative version of the subject prefix even
while parsing command line options, and sprefix variable was used as
a temporary area to futz with it.  Now, the parsing code has been
refactored to build the subject prefix into the sprefix variable and
assigns its value at the end to rev.subject_prefix, which makes the
flow easier to grasp.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Range-diff:
1:  fcd7aa53d2 ! 1:  e0d7db7423 format-patch: --rfc honors what --subject-prefix sets
    @@ Commit message
         Prior to this change, formatting patches with --rfc would lose the
         'my-project' information.
     
    +    The data flow for the subject-prefix was that rev.subject_prefix
    +    were to be kept the authoritative version of the subject prefix even
    +    while parsing command line options, and sprefix variable was used as
    +    a temporary area to futz with it.  Now, the parsing code has been
    +    refactored to build the subject prefix into the sprefix variable and
    +    assigns its value at the end to rev.subject_prefix, which makes the
    +    flow easier to grasp.
    +
         Signed-off-by: Drew DeVault <sir@cmpwn.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ builtin/log.c: static int subject_prefix = 0;
     +	struct strbuf *sprefix;
     +
      	BUG_ON_OPT_NEG(unset);
    -+	sprefix = (struct strbuf *)opt->value;
    ++	sprefix = opt->value;
      	subject_prefix = 1;
     -	((struct rev_info *)opt->value)->subject_prefix = arg;
     +	strbuf_reset(sprefix);

 Documentation/git-format-patch.txt | 18 +++++++++++------
 builtin/log.c                      | 31 +++++++++++++++---------------
 t/t4014-format-patch.sh            | 22 ++++++++++++++++++++-
 3 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 373b46fc0d..62345ed764 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -217,9 +217,15 @@ populated with placeholder text.
 
 --subject-prefix=<subject prefix>::
 	Instead of the standard '[PATCH]' prefix in the subject
-	line, instead use '[<subject prefix>]'. This
-	allows for useful naming of a patch series, and can be
-	combined with the `--numbered` option.
+	line, instead use '[<subject prefix>]'. This can be used
+	to name a patch series, and can be combined with the
+	`--numbered` option.
++
+The configuration variable `format.subjectPrefix` may also be used
+to configure a subject prefix to apply to a given repository for
+all patches. This is often useful on mailing lists which receive
+patches for several repositories and can be used to disambiguate
+the patches (with a value of e.g. "PATCH my-project").
 
 --filename-max-length=<n>::
 	Instead of the standard 64 bytes, chomp the generated output
@@ -229,9 +235,9 @@ populated with placeholder text.
 	variable, or 64 if unconfigured.
 
 --rfc::
-	Alias for `--subject-prefix="RFC PATCH"`. RFC means "Request For
-	Comments"; use this when sending an experimental patch for
-	discussion rather than application.
+	Prepends "RFC" to the subject prefix (producing "RFC PATCH" by
+	default). RFC means "Request For Comments"; use this when sending
+	an experimental patch for discussion rather than application.
 
 -v <n>::
 --reroll-count=<n>::
diff --git a/builtin/log.c b/builtin/log.c
index db3a88bfe9..75762b497d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1468,19 +1468,16 @@ static int subject_prefix = 0;
 static int subject_prefix_callback(const struct option *opt, const char *arg,
 			    int unset)
 {
+	struct strbuf *sprefix;
+
 	BUG_ON_OPT_NEG(unset);
+	sprefix = opt->value;
 	subject_prefix = 1;
-	((struct rev_info *)opt->value)->subject_prefix = arg;
+	strbuf_reset(sprefix);
+	strbuf_addstr(sprefix, arg);
 	return 0;
 }
 
-static int rfc_callback(const struct option *opt, const char *arg, int unset)
-{
-	BUG_ON_OPT_NEG(unset);
-	BUG_ON_OPT_ARG(arg);
-	return subject_prefix_callback(opt, "RFC PATCH", unset);
-}
-
 static int numbered_cmdline_opt = 0;
 
 static int numbered_callback(const struct option *opt, const char *arg,
@@ -1907,6 +1904,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf rdiff_title = STRBUF_INIT;
 	struct strbuf sprefix = STRBUF_INIT;
 	int creation_factor = -1;
+	int rfc = 0;
 
 	const struct option builtin_format_patch_options[] = {
 		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
@@ -1930,13 +1928,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("mark the series as Nth re-roll")),
 		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
 			    N_("max length of output filename")),
-		OPT_CALLBACK_F(0, "rfc", &rev, NULL,
-			    N_("use [RFC PATCH] instead of [PATCH]"),
-			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback),
+		OPT_BOOL(0, "rfc", &rfc, N_("use [RFC PATCH] instead of [PATCH]")),
 		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
 			    N_("cover-from-description-mode"),
 			    N_("generate parts of a cover letter based on a branch's description")),
-		OPT_CALLBACK_F(0, "subject-prefix", &rev, N_("prefix"),
+		OPT_CALLBACK_F(0, "subject-prefix", &sprefix, N_("prefix"),
 			    N_("use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback),
 		OPT_CALLBACK_F('o', "output-directory", &output_directory,
@@ -2016,11 +2012,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.max_parents = 1;
 	rev.diffopt.flags.recursive = 1;
 	rev.diffopt.no_free = 1;
-	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def = "HEAD";
 	s_r_opt.revarg_opt = REVARG_COMMITTISH;
 
+	strbuf_addstr(&sprefix, fmt_patch_subject_prefix);
 	if (format_no_prefix)
 		diff_set_noprefix(&rev.diffopt);
 
@@ -2048,13 +2044,16 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
+	if (rfc)
+		strbuf_insertstr(&sprefix, 0, "RFC ");
+
 	if (reroll_count) {
-		strbuf_addf(&sprefix, "%s v%s",
-			    rev.subject_prefix, reroll_count);
+		strbuf_addf(&sprefix, " v%s", reroll_count);
 		rev.reroll_count = reroll_count;
-		rev.subject_prefix = sprefix.buf;
 	}
 
+	rev.subject_prefix = sprefix.buf;
+
 	for (i = 0; i < extra_hdr.nr; i++) {
 		strbuf_addstr(&buf, extra_hdr.items[i].string);
 		strbuf_addch(&buf, '\n');
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 3cf2b7a7fb..9fa1f3bc7a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1373,7 +1373,27 @@ test_expect_success '--rfc' '
 	Subject: [RFC PATCH 1/1] header with . in it
 	EOF
 	git format-patch -n -1 --stdout --rfc >patch &&
-	grep ^Subject: patch >actual &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--rfc does not overwrite prefix' '
+	cat >expect <<-\EOF &&
+	Subject: [RFC PATCH foobar 1/1] header with . in it
+	EOF
+	git -c format.subjectPrefix="PATCH foobar" \
+		format-patch -n -1 --stdout --rfc >patch &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--rfc is argument order independent' '
+	cat >expect <<-\EOF &&
+	Subject: [RFC PATCH foobar 1/1] header with . in it
+	EOF
+	git format-patch -n -1 --stdout --rfc \
+		--subject-prefix="PATCH foobar" >patch &&
+	grep "^Subject:" patch >actual &&
 	test_cmp expect actual
 '
 
-- 
2.42.0-100-g3525f1dbc1

