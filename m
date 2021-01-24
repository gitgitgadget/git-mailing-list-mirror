Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AD6C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 19:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A787229C5
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 19:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbhAXTwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 14:52:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62778 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbhAXTwT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 14:52:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34A77A6B2E;
        Sun, 24 Jan 2021 14:51:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ujX50EuKDxPExTS/J1byEhhM8hk=; b=toZVcH
        Tg13d4vFBPaJnQpilX3wllMgK1LIo9ax04ckR8RJ7J6RWCb9V4H2x9xRcS7fYjfJ
        2N4b7dJ4w0sy3R6f/KDIDGOiFFQ0dWHH1gxh49ZdfyYXOkUh20blSz7Q3TQUxaCs
        KkkdlN5Q34QvEQlBUm9FmxvCrOPPBZWluW4Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NHWOBP5naT/26/JUelfm++FHTBUqG6wd
        21jSzEiGCzesQHnX2YXTyzAGjJdRElTqdE9eujZcSI1Dz1+rIORJcscPcBV8MwzJ
        C9lt5y9zwbJpoYpbj9uKLQM28tqvEu76pLwZN0gQpucpgzQVUzMkoXWalJZe+MHy
        mopKnBDVwcY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BA88A6B2D;
        Sun, 24 Jan 2021 14:51:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7EA4A6B27;
        Sun, 24 Jan 2021 14:51:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, random_n0body@icloud.com,
        evraiphilippeblain@gmail.com,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH/RFC v1 1/1] git restore -p . and precomposed unicode
References: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
        <20210124151306.23185-1-tboegi@web.de>
Date:   Sun, 24 Jan 2021 11:51:33 -0800
In-Reply-To: <20210124151306.23185-1-tboegi@web.de> (tboegi@web.de's message
        of "Sun, 24 Jan 2021 16:13:06 +0100")
Message-ID: <xmqqsg6qyuyi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9022A854-5E7D-11EB-8255-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> The solution is to read the config variable "core.precomposeunicode" early.

For a single command like "restore", we need to fail if it is run
outside a repository anyway, so it is OK, but code in "git.c" in
general can be called outside a repository, we may not know where
our configuration files are, though.  So I'd prefer to avoid
adding too many "do this thing early for every single command".

Where do we normally read that variable?  I see calls to
precompose_argv() on only a few codepaths

builtin/diff-files.c:38:	precompose_argv(argc, argv);
builtin/diff-index.c:28:	precompose_argv(argc, argv);
builtin/diff-tree.c:129:	precompose_argv(argc, argv);
builtin/diff.c:455:	precompose_argv(argc, argv);
builtin/submodule--helper.c:1260:	precompose_argv(diff_args.nr, diff_args.v);
parse-options.c:872:	precompose_argv(argc, argv);

I guess the reason we can get away with it is because most of the
newer commands use the parse_options() API, and the call to
precompose_argv() is used by the codepaths implementing these
commands.  And as a rule, these commands read config first before
calling parse_options(), so by the time the control reaches there,
the value of the variable may be already known.

The question is why "restore -p" is so special?  Or does this patch
mean everybody, even the ones that use parse_options() is broken?

I guess "prefix" needs to be munged for everybody, so "restore -p"
on the title of the patch is a red herring, and the problem applies
to all "git" commands---in which case, inside "git.c" would be the
right place to do so.

I wonder if everybody who calls precompoase_argv() has access to the
prefix, though.  If so, would it make more sense to extend the API
to

	precompose_argv(int argc, char **argv, char **prefix)

so that the callers only need to call a single function, without any
additional code like this patch does?

Also, as the current precompose_argv() begins like this:

        void precompose_argv(int argc, const char **argv)
        {
                int i = 0;
                const char *oldarg;
                char *newarg;
                iconv_t ic_precompose;

                if (precomposed_unicode != 1)
                        return;

and environment.c initializes the global to (-1), I wonder if we can
get away with an approach not to read the "config" anywhere outside
precompose_argv() function.  Instead, can't the above snippet become
more like:

                if (precomposed_unicode < 0)
                        precomposed_unicode = read from config;
		if (precomposed_unicode != 1)
			return;

That way, you do not even have to touch anything outside
compat/precompose_utf8.c, other than adjusting the callers to pass
the pointer to their prefix to be munged.

Namely

> +int precompose_read_config_gently(void)

This can become file-scope static.

> +{
> +	git_config_get_bool("core.precomposeunicode", &precomposed_unicode);
> +	return precomposed_unicode == 1;
> +}
>
>  void probe_utf8_pathname_composition(void)
>  {
> @@ -60,6 +65,25 @@ void probe_utf8_pathname_composition(void)
>  	strbuf_release(&path);
>  }
>
> +char *precompose_string_if_needed(const char *in)
> +{

This too.

> diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
> index 6f843d3e1a..ce82857d73 100644
> --- a/compat/precompose_utf8.h
> +++ b/compat/precompose_utf8.h
> @@ -28,6 +28,8 @@ typedef struct {
>  	struct dirent_prec_psx *dirent_nfc;
>  } PREC_DIR;
>
> +int precompose_read_config_gently(void);
> +char *precompose_string_if_needed(const char *in);
>  void precompose_argv(int argc, const char **argv);
>  void probe_utf8_pathname_composition(void);

And this can go away.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 104993b975..f34854b66f 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -252,6 +252,14 @@ typedef unsigned long uintptr_t;
>  #ifdef PRECOMPOSE_UNICODE
>  #include "compat/precompose_utf8.h"
>  #else
> +static inline int precompose_read_config_gently(void)
> +{
> +	return 0;
> +}
> +static inline char *precompose_string_if_needed(const char *in)
> +{
> +	return NULL; /* no need to precompose a string */
> +}

So do these.

> diff --git a/git.c b/git.c
> index a00a0a4d94..f09e14f733 100644
> --- a/git.c
> +++ b/git.c
> @@ -421,6 +421,15 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  			prefix = setup_git_directory_gently(&nongit_ok);
>  		}
>
> +		if (precompose_read_config_gently()) {
> +			precompose_argv(argc, argv);
> +			if (prefix) {
> +				const char *prec_pfx;
> +					prec_pfx = precompose_string_if_needed(prefix);
> +				if (prec_pfx)
> +					prefix = prec_pfx; /* memory lost */
> +			}
> +		}

And this would move to the beginning of precompose_argv()
implementation.

Also the code we currently use to read the core.precomposeunicode
configuration variable (presumably somewhere in git_default_config()
callchain; I didn't check) can go away.

Which would be much nicer outcome, if doable (again, I didn't check).

> diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
> index 54ce19e353..bbbc50da93 100755
> --- a/t/t3910-mac-os-precompose.sh
> +++ b/t/t3910-mac-os-precompose.sh
> @@ -191,6 +191,21 @@ test_expect_failure 'handle existing decomposed filenames' '
>  	test_must_be_empty untracked
>  '
>
> +test_expect_success "unicode decomposed: git restore -p . " '
> +	DIRNAMEPWD=dir.Odiarnfc &&
> +	DIRNAMEINREPO=dir.$Adiarnfc &&
> +	export DIRNAMEPWD DIRNAMEINREPO &&
> +	git init $DIRNAMEPWD &&
> +	( cd $DIRNAMEPWD &&
> +		mkdir $DIRNAMEINREPO &&

Style:

	(
		cd $DIRNAMEPWD &&
		mkdir $DIRNAMEINREPO &&

Is "restore" the only thing that has this issue?  

I would imagine that anything that takes '.' pathspec to limit its
operation to the current subdirectory (e.g. "cd sub && git diff .")
would be affected (clarification: I am *not* hinting that other
commands need to be tested---I am however hinting to update the
proposed log message to explain either (1) this applies in general
to commands that does X, or (2) this affects only "restore -p" which
does this unusual thing Y that no other commands do).

Thanks.


> +		cd $DIRNAMEINREPO &&
> +		echo "Initial" >file &&
> +		git add file &&
> +		echo "More stuff" >>file &&
> +		echo y | git restore -p .
> +	)
> +'
> +
>  # Test if the global core.precomposeunicode stops autosensing
>  # Must be the last test case
>  test_expect_success "respect git config --global core.precomposeunicode" '
> --
> 2.30.0.155.g66e871b664
