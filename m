Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF201C6FA8F
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 17:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbjH2RZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 13:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbjH2RZR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 13:25:17 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE23ACE6
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 10:24:44 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D78E1912A0;
        Tue, 29 Aug 2023 13:23:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FZ4WHesUZlRLejMrZ8GcoZ1y0m+T0TwK30uzuR
        D4Xos=; b=IDKiCi6Dts++z2gzMWUZaMM03nLo7Lu/s9OgsP4XPW+tb3bwvWdbDw
        Hwlm1kqXRb10NqKMPePO35xe+3yDn89+xTn2bT7afxGSy0jvtfpQ5ctrEStsm2ss
        p4fitFku4fv617hE9v/0GuwdX5wCSevYEukaagqO+rZWdb6mxw4Ow=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 339E219129F;
        Tue, 29 Aug 2023 13:23:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6016419129E;
        Tue, 29 Aug 2023 13:23:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH git v3] builtin/log.c: prepend "RFC" on --rfc
References: <20230829153509.27164-1-sir@cmpwn.com>
Date:   Tue, 29 Aug 2023 10:23:35 -0700
In-Reply-To: <20230829153509.27164-1-sir@cmpwn.com> (Drew DeVault's message of
        "Tue, 29 Aug 2023 17:34:42 +0200")
Message-ID: <xmqqbkepep9k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C973699C-4690-11EE-A055-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> Re: [PATCH git v3] builtin/log.c: prepend "RFC" on --rfc

This is only about format-patch and not other subcommands
implemented in that file, so let's retitle it.  E.g.

    Subject: [PATCH v3] format-patch: --rfc honors what --subject-prefix sets

> Rather than replacing the configured subject prefix (either through the
> git config or command line) entirely with "RFC PATCH", this change
> prepends RFC to whatever subject prefix was already in use.
>
> This is useful, for example, when a user is working on a repository that
> has a subject prefix considered to disambiguate patches:
>
> 	git config format.subjectPrefix 'PATCH my-project'
>
> Prior to this change, formatting patches with --rfc would lose the
> 'my-project' information.
>
> Signed-off-by: Drew DeVault <sir@cmpwn.com>
> ---
> v3 rewrites the --rfc handler to use OPT_BOOL and track the RFC status
> separately from the subject prefix as a whole, and updates the tests and
> documentation per Junio's feedback.

OPT_BOOL would be a very reasonable simplification at this point.  I
hadn't considered it back when I commented on the previous rounds,
as I thought people would want to do something like --rfc=WIP in the
future and using a string that can be given by the end-user was
inevitable, but we do not need to do that now.

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 373b46fc0d..698c197213 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -217,9 +217,15 @@ populated with placeholder text.
>  
>  --subject-prefix=<subject prefix>::
>  	Instead of the standard '[PATCH]' prefix in the subject
> -	line, instead use '[<subject prefix>]'. This
> -	allows for useful naming of a patch series, and can be
> -	combined with the `--numbered` option.
> +	line, instead use '[<subject prefix>]'. This can be used
> +	to name a patch series, and can be combined with the
> +	`--numbered` option.
> ++
> +The config option format.subjectPrefix may also be used to to configure
> +a subject prefix to apply to a given repository for all patches. This
> +is often useful on mailing lists which receive patches for several
> +repositories and can be used to disambiguate the patches (with a value
> +of e.g. "PATCH my-project").

Thanks for addressing this, too.  One minor thing is that we almost
never truncate and say "config option" in this document, and say
"configuration variable" instead more often.

I'd update the above to

	The configuration variable `format.subjectPrefix` may also...

locally while queuing, unless there is a strong reason not to (which
I do not expect).

> @@ -229,9 +235,9 @@ populated with placeholder text.
>  	variable, or 64 if unconfigured.
>  
>  --rfc::
> -	Alias for `--subject-prefix="RFC PATCH"`. RFC means "Request For
> -	Comments"; use this when sending an experimental patch for
> -	discussion rather than application.
> +	Prepends "RFC" to the subject prefix (producing "RFC PATCH" by
> +	default). RFC means "Request For Comments"; use this when sending
> +	an experimental patch for discussion rather than application.

OK.

> diff --git a/builtin/log.c b/builtin/log.c
> index db3a88bfe9..16f4343852 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1474,13 +1474,6 @@ static int subject_prefix_callback(const struct option *opt, const char *arg,
>  	return 0;
>  }
>  
> -static int rfc_callback(const struct option *opt, const char *arg, int unset)
> -{
> -	BUG_ON_OPT_NEG(unset);
> -	BUG_ON_OPT_ARG(arg);
> -	return subject_prefix_callback(opt, "RFC PATCH", unset);
> -}

Nice to see this go.

> @@ -1907,6 +1900,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	struct strbuf rdiff_title = STRBUF_INIT;
>  	struct strbuf sprefix = STRBUF_INIT;
>  	int creation_factor = -1;
> +	int rfc = 0;
> ...
> -		OPT_CALLBACK_F(0, "rfc", &rev, NULL,
> -			    N_("use [RFC PATCH] instead of [PATCH]"),
> -			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback),
> +		OPT_BOOL(0, "rfc", &rfc, N_("use [RFC PATCH] instead of [PATCH]")),

OK, the help text is now a bit of white lie but I think favoring
brevity over preciseness is a good choice here.

> @@ -2048,13 +2040,19 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	if (cover_from_description_arg)
>  		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
>  
> +	if (rfc) {
> +		strbuf_addf(&sprefix, "RFC %s", rev.subject_prefix);
> +	} else {
> +		strbuf_addstr(&sprefix, rev.subject_prefix);
> +	}

Excess braces around single-statement blocks.  I would write this as

	strbuf_addf(&sprefix, "%s%s", rfc ? "RFC " : "", rev.subject_prefix);

if I were writing this code.

>  	if (reroll_count) {
> -		strbuf_addf(&sprefix, "%s v%s",
> -			    rev.subject_prefix, reroll_count);
> +		strbuf_addf(&sprefix, " v%s", reroll_count);
>  		rev.reroll_count = reroll_count;
> -		rev.subject_prefix = sprefix.buf;
>  	}
>  
> +	rev.subject_prefix = sprefix.buf;

OK.  The postimage somehow reads a lot more logical, which is funny.

The design philosophy of the preimage was "rev.subject_prefix is the
king, and anybody who wants to futz with the value would use a
temporary to update it".  In contrast, the new world order is "we
build the string in sprefix, and at the very end give the result to
rev.subject.prefix".  And when viewed from that angle, the above
"if" block that does something extra on sprefix only when
reroll_count is set makes perfect sense.

But then from that point of view, I wonder if we should use sprefix
from the very beginning?  That will make your new feature just like
how reroll_count futzes with sprefix.


> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 3cf2b7a7fb..5d5bc21fd1 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> +test_expect_success '--rfc does not overwrite prefix' '
> +	cat >expect <<-\EOF &&
> +	Subject: [RFC PATCH foobar 1/1] header with . in it
> +	EOF
> +	git -c format.subjectPrefix="PATCH foobar" \
> +		format-patch -n -1 --stdout --rfc >patch &&
> +	grep "^Subject:" patch >actual &&
>  	test_cmp expect actual
>  '

Looking good.  We would also pass a test that uses the two options
in the "wrong" order, i.e.

	git format-patch --rfc --subject-prefix ...

with the new implementation, which is great.

Just an illustration of the idea about "sprefix", which is not even
compile tested, looks like the following.  What do you think?

Thanks.

 builtin/log.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git c/builtin/log.c w/builtin/log.c
index 16f4343852..7f22af7ac3 100644
--- c/builtin/log.c
+++ w/builtin/log.c
@@ -1468,9 +1468,13 @@ static int subject_prefix = 0;
 static int subject_prefix_callback(const struct option *opt, const char *arg,
 			    int unset)
 {
+	struct strbuf *sprefix;
+
 	BUG_ON_OPT_NEG(unset);
 	subject_prefix = 1;
-	((struct rev_info *)opt->value)->subject_prefix = arg;
+	sprefix = (struct strbuf *)opt->value;
+	strbuf_reset(sprefix);
+	strbuf_addstr(sprefix, arg);
 	return 0;
 }
 
@@ -1928,7 +1932,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
 			    N_("cover-from-description-mode"),
 			    N_("generate parts of a cover letter based on a branch's description")),
-		OPT_CALLBACK_F(0, "subject-prefix", &rev, N_("prefix"),
+		OPT_CALLBACK_F(0, "subject-prefix", &sprefix, N_("prefix"),
 			    N_("use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback),
 		OPT_CALLBACK_F('o', "output-directory", &output_directory,
@@ -2008,11 +2012,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
 
@@ -2040,11 +2044,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
-	if (rfc) {
-		strbuf_addf(&sprefix, "RFC %s", rev.subject_prefix);
-	} else {
-		strbuf_addstr(&sprefix, rev.subject_prefix);
-	}
+	if (rfc)
+		strbuf_insertstr(&sprefix, 0, "RFC ");
 
 	if (reroll_count) {
 		strbuf_addf(&sprefix, " v%s", reroll_count);
