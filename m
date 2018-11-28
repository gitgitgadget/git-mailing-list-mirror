Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B3031F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 06:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeK1REI (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 12:04:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51383 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeK1REI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 12:04:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 725FE125B11;
        Wed, 28 Nov 2018 01:03:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MbT9pw50DfPg
        2WmX2y1oHY3W7qk=; b=uu1RPFqx1fdWaC7PLGFD2i1B43/1BDBqQrqOaPu6Plvu
        P4duViVgmWtRB0exoXdKrIC1D05WtynnpEX0r/3Rd7h96qMMgqzg6/LdRDgFNeCz
        bPQ0dGfbf+DRMqfcLGzNnIOm2mi17GqKn2Aiz+BQBkmwPK5wWkyf3GJ40sWzk2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tmwKTl
        NLT1M2n1gaAZ5QuUT3hY3ZFSj3W3QhFUnMkatjxtmQloWU9Pycd5W0qYPP10/Jc6
        +zM5+brrbecdPdWxXhe10aL2bACxmN7JPGD+Ek1a+K1vX9jb7exMg14vJWhGdvAA
        VJguXHkIRy2z6/G2UD+E8X79Al2CLQoKb6uSA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B948125B10;
        Wed, 28 Nov 2018 01:03:30 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3401125B0E;
        Wed, 28 Nov 2018 01:03:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>, t.gummerer@gmail.com
Subject: Re: [PATCH v2 6/7] checkout: split into switch-branch and checkout-files
References: <20181120174554.GA29910@duynguyen.home>
        <20181127165211.24763-1-pclouds@gmail.com>
        <20181127165211.24763-7-pclouds@gmail.com>
Date:   Wed, 28 Nov 2018 15:03:28 +0900
In-Reply-To: <20181127165211.24763-7-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 27 Nov 2018 17:52:10 +0100")
Message-ID: <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 54297FD4-F2D3-11E8-96B1-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The good old "git checkout" command is still here and will be until
> all (or most of users) are sick of it.

Two comments on the goal (the implementation looked reasonable
assuming the reader agrees with the gaol).

At least to me, the verb "switch" needs two things to switch
between, i.e. "switch A and B", unless it is "switch to X".
Either "switch-to-branch" or simply "switch-to", perhaps?

As I already hinted in my response to Stefan (?) about
checkout-from-tree vs checkout-from-index, a command with multiple
modes of operation is not confusing to people with the right mental
model, and I suspect that having two separate commands for "checking
out a branch" and "checking out paths" that is done by this step
would help users to form the right mental model.  So I tend to think
these two are "training wheels", and suspect that once they got it,
nobody will become "sick of" the single "checkout" command that can
be used to do either.  It's just the matter of being aware what can
be done (which requires the right mental model) and how to tell Git
what the user wants it do (two separate commands, operating mode
option, or just the implied command line syntax---once the user
knows what s/he is doing, these do not make that much a difference).

As to the implementation,

>  	int dwim_new_local_branch;
> +	int accept_pathspec;
> +	int empty_arg_ok;

I think this is a reasonable way to completely avoid the codepath
that considers an unknown arg being parsed could be a pathspec
element (e.g. switch-to-that-branch mode will never want to see
pathspec, so disambiguation logic and/or hint should not kick in).

At the beginning of cmd_switch_branches(), please "explicitly"
assign 0 to accept_pathspec field, after memset(0) clears the whole
structure.  When a reader sees memset(0), it is read as "giving a
clean and bland slate to futz with with a reasonable default", but
for this particular field, i.e. accept_pathspec, there is NO
reasoanble default.  It's not like switch-to-branch mode is the heir
to checkout and the other sibling checkout-files is doing a
non-default behaviour.

Same comment probably would apply to the other one, although I
didn't think too deeply about that one.


>  	/*
>  	 * If new checkout options are added, skip_merge_working_tree
> @@ -1056,7 +1068,7 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
>  	arg =3D argv[0];
>  	dash_dash_pos =3D -1;
>  	for (i =3D 0; i < argc; i++) {
> -		if (!strcmp(argv[i], "--")) {
> +		if (opts->accept_pathspec && !strcmp(argv[i], "--")) {
>  			dash_dash_pos =3D i;
>  			break;
>  		}
> @@ -1067,6 +1079,8 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
>  		has_dash_dash =3D 1; /* case (3) or (1) */
>  	else if (dash_dash_pos >=3D 2)
>  		die(_("only one reference expected, %d given."), dash_dash_pos);
> +	else if (!opts->accept_pathspec)
> +		has_dash_dash =3D 1;
> =20
>  	if (!strcmp(arg, "-"))
>  		arg =3D "@{-1}";
> @@ -1291,30 +1305,23 @@ static struct option *add_checkout_path_options=
(struct checkout_opts *opts,
>  	return newopts;
>  }
> =20
> -int cmd_checkout(int argc, const char **argv, const char *prefix)
> +static int checkout_main(int argc, const char **argv, const char *pref=
ix,
> +			 struct checkout_opts *opts, struct option *options,
> +			 const char * const usagestr[])
>  {
> -	struct checkout_opts real_opts;
> -	struct checkout_opts *opts =3D &real_opts;
>  	struct branch_info new_branch_info;
>  	int dwim_remotes_matched =3D 0;
> -	struct option *options =3D NULL;
> =20
> -	memset(opts, 0, sizeof(*opts));
>  	memset(&new_branch_info, 0, sizeof(new_branch_info));
>  	opts->overwrite_ignore =3D 1;
>  	opts->prefix =3D prefix;
>  	opts->show_progress =3D -1;
> -	opts->dwim_new_local_branch =3D 1;
> =20
>  	git_config(git_checkout_config, opts);
> =20
>  	opts->track =3D BRANCH_TRACK_UNSPECIFIED;
> =20
> -	options =3D add_common_options(opts, options);
> -	options =3D add_switch_branch_options(opts, options);
> -	options =3D add_checkout_path_options(opts, options);
> -
> -	argc =3D parse_options(argc, argv, prefix, options, checkout_usage,
> +	argc =3D parse_options(argc, argv, prefix, options, usagestr,
>  			     PARSE_OPT_KEEP_DASHDASH);
> =20
>  	if (opts->show_progress < 0) {
> @@ -1381,7 +1388,8 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
>  					     &dwim_remotes_matched);
>  		argv +=3D n;
>  		argc -=3D n;
> -	}
> +	} else if (!opts->empty_arg_ok)
> +		usage_with_options(usagestr, options);
> =20
>  	if (argc) {
>  		parse_pathspec(&opts->pathspec, 0,
> @@ -1443,3 +1451,60 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
>  		return checkout_branch(opts, &new_branch_info);
>  	}
>  }
> +
> +int cmd_checkout(int argc, const char **argv, const char *prefix)
> +{
> +	struct checkout_opts opts;
> +	struct option *options =3D NULL;
> +	int ret;
> +
> +	memset(&opts, 0, sizeof(opts));
> +	opts.dwim_new_local_branch =3D 1;
> +	opts.accept_pathspec =3D 1;
> +	opts.empty_arg_ok =3D 1;
> +
> +	options =3D add_common_options(&opts, options);
> +	options =3D add_switch_branch_options(&opts, options);
> +	options =3D add_checkout_path_options(&opts, options);
> +
> +	ret =3D checkout_main(argc, argv, prefix, &opts,
> +			    options, checkout_usage);
> +	FREE_AND_NULL(options);
> +	return ret;
> +}
> +
> +int cmd_switch_branch(int argc, const char **argv, const char *prefix)
> +{
> +	struct checkout_opts opts;
> +	struct option *options =3D NULL;
> +	int ret;
> +
> +	memset(&opts, 0, sizeof(opts));
> +	opts.dwim_new_local_branch =3D 1;
> +
> +	options =3D add_common_options(&opts, options);
> +	options =3D add_switch_branch_options(&opts, options);
> +
> +	ret =3D checkout_main(argc, argv, prefix, &opts,
> +			    options, switch_branch_usage);
> +	FREE_AND_NULL(options);
> +	return ret;
> +}
> +
> +int cmd_checkout_files(int argc, const char **argv, const char *prefix=
)
> +{
> +	struct checkout_opts opts;
> +	struct option *options =3D NULL;
> +	int ret;
> +
> +	memset(&opts, 0, sizeof(opts));
> +	opts.accept_pathspec =3D 1;
> +
> +	options =3D add_common_options(&opts, options);
> +	options =3D add_checkout_path_options(&opts, options);
> +
> +	ret =3D checkout_main(argc, argv, prefix, &opts,
> +			    options, checkout_files_usage);
> +	FREE_AND_NULL(options);
> +	return ret;
> +}
> diff --git a/git.c b/git.c
> index 2f604a41ea..3b86ba765c 100644
> --- a/git.c
> +++ b/git.c
> @@ -457,6 +457,7 @@ static struct cmd_struct commands[] =3D {
>  	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
>  	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT  },
>  	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
> +	{ "checkout-files", cmd_checkout_files, RUN_SETUP | NEED_WORK_TREE },
>  	{ "checkout-index", cmd_checkout_index,
>  		RUN_SETUP | NEED_WORK_TREE},
>  	{ "cherry", cmd_cherry, RUN_SETUP },
> @@ -557,6 +558,7 @@ static struct cmd_struct commands[] =3D {
>  	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>  	{ "stripspace", cmd_stripspace },
>  	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUP=
ER_PREFIX | NO_PARSEOPT },
> +	{ "switch-branch", cmd_switch_branch, RUN_SETUP | NEED_WORK_TREE },
>  	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
>  	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
>  	{ "unpack-file", cmd_unpack_file, RUN_SETUP | NO_PARSEOPT },
