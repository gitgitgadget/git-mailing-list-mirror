Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF22C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 21:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbjHKVi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 17:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbjHKViX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 17:38:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1703F213F
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 14:38:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 488BC1A6B2D;
        Fri, 11 Aug 2023 17:38:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2GhqKYtTFKp9fUs2tcFsk1kdzJ5i3P/7ogvPCs
        PbRTk=; b=hHbxJdy4TsMWHJppCew9mo/rhtKy01PxwYgYaGj9AocpbW5dmw6/Uk
        NzP5UdneWoh2Smi6SwU8beWlq3hWH76/jt9ZUWX3/xSpPkWRUlMA0uY/tGo5Q31D
        NjcnRPCNUW6o7+J7AKe5STGeeQ4AFcNzcp37hlev1D5KHU7FOJSn8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F8371A6B2C;
        Fri, 11 Aug 2023 17:38:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 78CB51A6B28;
        Fri, 11 Aug 2023 17:38:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] format-patch: add --description-file option
References: <xmqqttta9h6a.fsf@gitster.g>
        <20230809171530.2564724-1-oswald.buddenhagen@gmx.de>
Date:   Fri, 11 Aug 2023 14:38:05 -0700
In-Reply-To: <20230809171530.2564724-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Wed, 9 Aug 2023 19:15:30 +0200")
Message-ID: <xmqq1qg9qmyq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C4D3FA0-388F-11EE-AAE8-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> This patch makes it possible to directly feed a branch description to
> derive the cover letter from. The use case is formatting dynamically
> created temporary commits which are not referenced anywhere.
>
> The most obvious alternative would be creating a temporary branch and
> setting a description on it, but that doesn't seem particularly elegant.

Elegance is quite subjective, but not having to create a temporary
branch is a good thing in itself.  Everything after ", but that
doesn't" is better left out of the message here.

In the longer term, the templating system is the way to go to
achieve more flexibility that is more general than the single
problem this patch is trying to solve, but we do not always have to
wait for such a most general solution.

> +--description-file=<file>::
> +	Use the contents of <file> instead of the branch's description
> +	for generating the cover letter.

OK.

> diff --git a/builtin/log.c b/builtin/log.c
> index 1b119eaf0b..9c4738bbde 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1255,7 +1255,15 @@ static void show_diffstat(struct rev_info *rev,
>  	fprintf(rev->diffopt.file, "\n");
>  }
>  
> +static void read_desc_file(struct strbuf *buf, const char *desc_file)
> +{
> +	if (strbuf_read_file(buf, desc_file, 2000) < 0)
> +		die_errno(_("unable to read branch description file '%s'"),
> +			  desc_file);
> +}

You would probably want to do "2000" -> "0" here.

>  static void prepare_cover_text(struct pretty_print_context *pp,
> +			       const char *description_file,
>  			       const char *branch_name,

This is kind of suboptimal, but let's let it pass.

A better design is to pass the description string itself to this
function and the make_cover_letter() function, and have the higher
level callers of the callchain prepare the either read_desc_file()
or read_branch_desc() to prepare that string before calling into the
callchain.  Such a division of labor between the callers and this
function will allow us to more easily add another option to the
command, to feed the description string itself (instead of having to
create a temporary file and storing the description in it).

But such a clean-up can be safely left for now and be done after the
dust settles.

> @@ -1269,7 +1277,9 @@ static void prepare_cover_text(struct pretty_print_context *pp,
>  	if (cover_from_description_mode == COVER_FROM_NONE)
>  		goto do_pp;
>  
> -	if (branch_name && *branch_name)
> +	if (description_file && *description_file)
> +		read_desc_file(&description_sb, description_file);
> +	else if (branch_name && *branch_name)
>  		read_branch_desc(&description_sb, branch_name);

This allows use of a custom description to override the branch
description, which makes quite a lot of sense.

> @@ -1315,6 +1325,7 @@ static void get_notes_args(struct strvec *arg, struct rev_info *rev)
>  static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  			      struct commit *origin,
>  			      int nr, struct commit **list,
> +			      const char *description_file,
>  			      const char *branch_name,

I've already touched on this.

>  			      int quiet)
>  {
> @@ -1354,7 +1365,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  	pp.rev = rev;
>  	pp.print_email_subject = 1;
>  	pp_user_info(&pp, NULL, &sb, committer, encoding);
> -	prepare_cover_text(&pp, branch_name, &sb, encoding, need_8bit_cte);
> +	prepare_cover_text(&pp, description_file, branch_name, &sb,
> +			   encoding, need_8bit_cte);
>  	fprintf(rev->diffopt.file, "%s\n", sb.buf);
>  
>  	strbuf_release(&sb);
> @@ -1895,6 +1907,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	int quiet = 0;
>  	const char *reroll_count = NULL;
>  	char *cover_from_description_arg = NULL;
> +	char *description_file = NULL;
>  	char *branch_name = NULL;
>  	char *base_commit = NULL;
>  	struct base_tree_info bases;
> @@ -1938,6 +1951,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
>  			    N_("cover-from-description-mode"),
>  			    N_("generate parts of a cover letter based on a branch's description")),
> +		OPT_FILENAME(0, "description-file", &description_file,
> +			     N_("use branch description from file")),
>  		OPT_CALLBACK_F(0, "subject-prefix", &rev, N_("prefix"),
>  			    N_("use [<prefix>] instead of [PATCH]"),
>  			    PARSE_OPT_NONEG, subject_prefix_callback),
> @@ -2323,7 +2338,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		if (thread)
>  			gen_message_id(&rev, "cover");
>  		make_cover_letter(&rev, !!output_directory,
> -				  origin, nr, list, branch_name, quiet);
> +				  origin, nr, list, description_file, branch_name, quiet);
>  		print_bases(&bases, rev.diffopt.file);
>  		print_signature(rev.diffopt.file);
>  		total++;
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 3cf2b7a7fb..b31401876b 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1991,6 +1991,18 @@ test_expect_success 'cover letter using branch description (6)' '
>  	grep hello actual
>  '
>  
> +test_expect_success 'cover letter with --description-file' '
> +	test_when_finished "rm -f description.txt" &&
> +	echo "subject from file
> +
> +body from file" > description.txt &&

It is more conventional to write a multi-line file like so:

	cat >description.txt <<\-EOF &&
	subject from file

	body from file
	EOF

which would allow readers not to get distracted by the unindented
second line.  Also redirection operator ">" (or "<") sticks to the
target file in our coding style.

> +	git checkout rebuild-1 &&
> +	git format-patch --stdout --cover-letter --cover-from-description auto \
> +		--description-file description.txt main >actual &&
> +	grep "^Subject: \[PATCH 0/2\] subject from file$" actual &&
> +	grep "^body from file$" actual

Nice.

> +'
> +
>  test_expect_success 'cover letter with nothing' '
>  	git format-patch --stdout --cover-letter >actual &&
>  	test_line_count = 0 actual

Thanks.
