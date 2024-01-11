Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB056468
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MHkCgrXc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1758B1913D;
	Thu, 11 Jan 2024 14:50:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Z0Lwm5GLPCjYfGfFxRP1/VOlk7AuJvM59G3eBK
	Z71R8=; b=MHkCgrXcAdXdFODFcXKRGKmMdcLlYxSLdN7wVFPb0itB9Rq5CtO2Yh
	1FqykTkCfooPQNKRHomvWc0zqAqv7xk023pUn+/0+Leur2DUwtMx08IcTh/cp3mY
	llRKk//BS4RN+u/RA9T05W7Jgq+tF22kzaQZ6++HCKqwAZuwMoq2g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F9981913C;
	Thu, 11 Jan 2024 14:50:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B073B19138;
	Thu, 11 Jan 2024 14:50:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <mi.al.lohmann@gmail.com>
Cc: phillip.wood123@gmail.com,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk,  wanja.hentze@bevuta.com
Subject: Re: [PATCH v2] builtin/revert.c: refactor using an enum for cmd-action
In-Reply-To: <20240111174727.55189-1-mi.al.lohmann@gmail.com> (Michael
	Lohmann's message of "Thu, 11 Jan 2024 18:47:27 +0100")
References: <1ed0e249-dab9-4cf3-9b76-c8797b97c9c5@gmail.com>
	<20240111174727.55189-1-mi.al.lohmann@gmail.com>
Date: Thu, 11 Jan 2024 11:50:46 -0800
Message-ID: <xmqqsf33fy3t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B719737E-B0BA-11EE-A779-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Michael Lohmann <mi.al.lohmann@gmail.com> writes:

>  	struct option base_options[] = {
> -		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
> -		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
> -		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
> -		OPT_CMDMODE(0, "skip", &cmd, N_("skip current commit and continue"), 's'),
> +		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), ACTION_QUIT),
> +		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), ACTION_CONTINUE),
> +		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), ACTION_ABORT),
> +		OPT_CMDMODE(0, "skip", &cmd, N_("skip current commit and continue"), ACTION_SKIP),
>  		OPT_CLEANUP(&cleanup_arg),
>  		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
>  		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),

I actually do not terribly mind reusing the single letter option
(e.g. 'x' in "-x") and the command mode, as it is descriptive
enough.  The argument that an enum allows compilers warn about
non-exhausitve switches is valid if we have such a switch.

> +	switch (cmd) {
> +	case ACTION_START:
> +		goto skip_opt_compatibility_verification;
> +	case ACTION_QUIT:
> +		this_operation = "--quit";
> +		break;
> +	case ACTION_CONTINUE:
> +		this_operation = "--continue";
> +		break;
> +	case ACTION_SKIP:
> +		this_operation = "--skip";
> +		break;
> +	case ACTION_ABORT:
> +		this_operation = "--abort";
> +		break;
>  	}
>  
> +	verify_opt_compatible(me, this_operation,

And indeed the if/elseif cascade in the original is easier to ensure
its exhaustiveness by turning it into a switch.

HOWEVER.

If I were writing this patch, I would rather do it like so:

	this_operation = NULL;
	switch (cmd) {
	case 'q':
		this_operation = '--quit";
                break;
	...
	case 'a':
		this_operation = '--abort";
                break;
	default: /* everything else is compatible with others */
		break;
	}
	if (this_operation)
		verify_opt_compatible(me, this_operation, ...);

Use of enum is optional; I just didn't like too much churning to
illustrate a single idea (here, the single idea being "switch is
more appropriate then if/else cascade in this case"), and I think
this is easier to read than with enums [*].

	Side note: After all the single letter option names are
	meant to be mnemonic.  "case 'q'" is just as descriptive as
	"case ACTION_QUIT" in the context of this switch statement.

HTH.
