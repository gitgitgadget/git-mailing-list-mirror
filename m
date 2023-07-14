Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4477EEB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 20:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbjGNU5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 16:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbjGNU5t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 16:57:49 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0457A213C
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 13:57:47 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A03C919FCE;
        Fri, 14 Jul 2023 16:57:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gMjbJ+uHj0qRjbsK6eSBLjUwWcF8u5KGoYZQD8
        Mv5bs=; b=FXkrdeFWZCqQFHlNlyLSOQhwiMMV5t/0/ZwCP2W65teBEwpXQNI/hM
        KHlsyKau3dm27VkCCxfMAPtz9E5CN0rA+FYifY0WukMSbOVepgPfNPkIac1afzuC
        bDCytGrD2XsIU4vuC7jCxmBTKr9EV5ki7KYvT092L4Db+Brm5TKSs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9885C19FCD;
        Fri, 14 Jul 2023 16:57:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 354AA19FCC;
        Fri, 14 Jul 2023 16:57:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 2/3] ref-filter: add new "describe" atom
References: <20230705175942.21090-1-five231003@gmail.com>
        <20230714194249.66862-1-five231003@gmail.com>
        <20230714194249.66862-3-five231003@gmail.com>
Date:   Fri, 14 Jul 2023 13:57:40 -0700
In-Reply-To: <20230714194249.66862-3-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Sat, 15 Jul 2023 00:50:27 +0530")
Message-ID: <xmqqilamnrcr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13C0D344-2289-11EE-892A-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> +		struct {
> +			enum { D_BARE, D_TAGS, D_ABBREV,
> +			       D_EXCLUDE, D_MATCH } option;
> +			const char **args;
> +		} describe;

As you parse this into a strvec that has command line options for
the "git describe" invocation, I do not see the point of having the
"enum option" in this struct.  The describe->option member seems to
be unused throughout this patch.

In fact, a single "const char **describe_args" should be able to
replace the structure, no?

> +static int describe_atom_parser(struct ref_format *format UNUSED,
> +				struct used_atom *atom,
> +				const char *arg, struct strbuf *err)
> +{
> +	const char *describe_opts[] = {
> +		"",
> +		"tags",
> +		"abbrev",
> +		"match",
> +		"exclude",
> +		NULL
> +	};
> +
> +	struct strvec args = STRVEC_INIT;
> +	for (;;) {
> +		int found = 0;
> +		const char *argval;
> +		size_t arglen = 0;
> +		int optval = 0;
> +		int opt;
> +
> +		if (!arg)
> +			break;
> +
> +		for (opt = D_BARE; !found && describe_opts[opt]; opt++) {
> +			switch(opt) {
> +			case D_BARE:
> +				/*
> +				 * Do nothing. This is the bare describe
> +				 * atom and we already handle this above.
> +				 */
> +				break;
> +			case D_TAGS:
> +				if (match_atom_bool_arg(arg, describe_opts[opt],
> +							&arg, &optval)) {
> +					if (!optval)
> +						strvec_pushf(&args, "--no-%s",
> +							     describe_opts[opt]);
> +					else
> +						strvec_pushf(&args, "--%s",
> +							     describe_opts[opt]);
> +					found = 1;
> +				}

As match_atom_bool_arg() and ...

> +				break;
> +			case D_ABBREV:
> +				if (match_atom_arg_value(arg, describe_opts[opt],
> +							 &arg, &argval, &arglen)) {
> +					char *endptr;
> +					int ret = 0;
> +
> +					if (!arglen)
> +						ret = -1;
> +					if (strtol(argval, &endptr, 10) < 0)
> +						ret = -1;
> +					if (endptr - argval != arglen)
> +						ret = -1;
> +
> +					if (ret)
> +						return strbuf_addf_ret(err, ret,
> +								_("positive value expected describe:abbrev=%s"), argval);
> +					strvec_pushf(&args, "--%s=%.*s",
> +						     describe_opts[opt],
> +						     (int)arglen, argval);
> +					found = 1;
> +				}

... match_atom_arg_value() are both silent when they return false,
we do not see any diagnosis when these two case arms set the "found"
flag.  Shouldn't we have a corresponding "else" clause to these "if
(match_atom_blah())" blocks to issue an error message or something?

> +				break;
> +			case D_MATCH:
> +			case D_EXCLUDE:
> +				if (match_atom_arg_value(arg, describe_opts[opt],
> +							 &arg, &argval, &arglen)) {
> +					if (!arglen)
> +						return strbuf_addf_ret(err, -1,
> +								_("value expected describe:%s="), describe_opts[opt]);
> +					strvec_pushf(&args, "--%s=%.*s",
> +						     describe_opts[opt],
> +						     (int)arglen, argval);
> +					found = 1;
> +				}
> +				break;
> +			}
> +		}
> +		if (!found)
> +			break;
> +	}
> +	atom->u.describe.args = strvec_detach(&args);
> +	return 0;
> +}
> +
>  static int raw_atom_parser(struct ref_format *format UNUSED,
>  			   struct used_atom *atom,
>  			   const char *arg, struct strbuf *err)
> @@ -723,6 +819,7 @@ static struct {
>  	[ATOM_TAGGERDATE] = { "taggerdate", SOURCE_OBJ, FIELD_TIME },
>  	[ATOM_CREATOR] = { "creator", SOURCE_OBJ },
>  	[ATOM_CREATORDATE] = { "creatordate", SOURCE_OBJ, FIELD_TIME },
> +	[ATOM_DESCRIBE] = { "describe", SOURCE_OBJ, FIELD_STR, describe_atom_parser },
>  	[ATOM_SUBJECT] = { "subject", SOURCE_OBJ, FIELD_STR, subject_atom_parser },
>  	[ATOM_BODY] = { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
>  	[ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
> @@ -1542,6 +1639,54 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
>  	}
>  }
>  
> +static void grab_describe_values(struct atom_value *val, int deref,
> +				 struct object *obj)
> +{
> +	struct commit *commit = (struct commit *)obj;
> +	int i;
> +
> +	for (i = 0; i < used_atom_cnt; i++) {
> +		struct used_atom *atom = &used_atom[i];
> +		enum atom_type type = atom->atom_type;
> +		const char *name = atom->name;
> +		struct atom_value *v = &val[i];
> +
> +		struct child_process cmd = CHILD_PROCESS_INIT;
> +		struct strbuf out = STRBUF_INIT;
> +		struct strbuf err = STRBUF_INIT;
> +
> +		if (type != ATOM_DESCRIBE)
> +			continue;

We already have parsed the %(describe:...) and the result is stored
in the used_atom[] array.  We iterate over the array, and we just
found that its atom_type member is ATOM_DESCRIBE here (otherwise we
would have moved on to the next array element).

> +		if (!!deref != (*name == '*'))
> +			continue;

This is trying to avoid %(*describe) answering when the given object
is the tag itself, or %(describe) answering when the given object is
what the tag dereferences to, so having it here makes sense (by the
way, do you add any test for "%(*describe)?").

Now, is the code from here ...

> +		if (deref)
> +			name++;
> +
> +		if (!skip_prefix(name, "describe", &name) ||
> +		    (*name && *name != ':'))
> +			    continue;
> +		if (!*name)
> +			name = NULL;
> +		else
> +			name++;

... down to here doing anything useful?  After all, you already have
all you need to describe the commit in atom->u.describe_args to run
"git describe" with, no?  In fact, after computing "name" with the
above code with some complexity, nobody even looks at it.

Perhaps the above was copied from some other grab_* functions; the
reason why they were relevant there needs to be understood, and it
also has to be considered if the same reason to have the code here
applies to this codepath.

