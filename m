From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add revision range support on "-" and "@{-1}"
Date: Mon, 16 Mar 2015 11:22:48 -0700
Message-ID: <xmqqlhiwredj.fsf@gitster.dls.corp.google.com>
References: <1426518703-15785-1-git-send-email-kenny.lee28@gmail.com>
	<1426518703-15785-3-git-send-email-kenny.lee28@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 19:22:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXZfE-00088M-Sp
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 19:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802AbbCPSWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 14:22:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754657AbbCPSWu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 14:22:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C1EA40074;
	Mon, 16 Mar 2015 14:22:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5fNFH26S+haVNgdTubZwjLBgzBE=; b=p+bx+p
	hzwjqldHJ5sLwdcn0BYr3bxu3DvyI4nr+SSuwS3p69eH02pB7uUbyJ+oPMtB/gmG
	18m+KsC2miXbzcfZqukmQymxR8smzOmMTMF0XptWOAZ6UQKO2xE5gRkrFHQXRjqV
	P9ang1PL4DJkO/bn1TnYRbd8aH7NDRF9Dqxac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WFbr29thV5M1Lpu5WAgBhCXIF5qq2tC2
	zYM/1S/GGZv7+gyblpGVBFwdO1Mm4urxXDNFCAJg97W+eaPms6UhvOPdwEWLHMDJ
	RibKfl9r1nxa+FpuIj0gzyFY7zngMkc0dIVppr2gVYBPmkOmahlb1IdOO/OhtTF3
	XTlPdse5hK4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 358A740073;
	Mon, 16 Mar 2015 14:22:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8704340071;
	Mon, 16 Mar 2015 14:22:49 -0400 (EDT)
In-Reply-To: <1426518703-15785-3-git-send-email-kenny.lee28@gmail.com> (Kenny
	Lee Sin Cheong's message of "Mon, 16 Mar 2015 11:11:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 73B03DD8-CC09-11E4-9F4C-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265584>

Kenny Lee Sin Cheong <kenny.lee28@gmail.com> writes:

> diff --git a/revision.c b/revision.c
> index 7778bbd..a79b443 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1490,6 +1490,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
>  		int symmetric = *next == '.';
>  		unsigned int flags_exclude = flags ^ (UNINTERESTING | BOTTOM);
>  		static const char head_by_default[] = "HEAD";
> +		static const char prev_rev[] = "@{-1}";
>  		unsigned int a_flags;
>  
>  		*dotdot = 0;
> @@ -1499,6 +1500,13 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
>  			next = head_by_default;
>  		if (dotdot == arg)
>  			this = head_by_default;
> +		/*  Allows -..<rev> and <rev>..- */
> +		if (!strcmp(this, "-")) {
> +			this = prev_rev;
> +		}
> +		if (!strcmp(next, "-")) {
> +			next = prev_rev;
> +		}

The above two hunks are disappointing.  "this" and "next" are passed
to get_sha1_committish() and the point of the [1/2] patch was to
allow "-" to be just as usable as "@{-1}" anywhere a branch name can
be used.

>  		if (this == head_by_default && next == head_by_default &&
>  		    !symmetric) {
>  			/*
> @@ -2198,7 +2206,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  	read_from_stdin = 0;
>  	for (left = i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
> -		if (arg[0] == '-' && arg[1]) {
> +		if (arg[0] == '-' && !strstr(arg, "..")) {

Isn't this way too loose?  "--some-opt=I.wish..." would have ".."
in it, and we would want to leave room to add new options that may
take arbitrary string as an argument.

I would have expected it would be more like

		if (arg[0] == '-' && arg[1] && !starts_with(arg + 1, "..")) {

That is, "anything that begins with '-', if it is to be taken as an
option, must not begin with '-..'", which I think should be strict
enough.

> @@ -2220,6 +2228,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  				continue;
>  			}
>  
> +
>  			opts = handle_revision_opt(revs, argc - i, argv + i, &left, argv);
>  			if (opts > 0) {
>  				i += opts - 1;

Noise.

> @@ -2229,7 +2238,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  				exit(128);
>  			continue;
>  		}
> -
> +		if (strstr(arg, "..")) {
> +			handle_revision_arg(arg, revs, flags, revarg_opt);
> +			continue;
> +		}

What is this for?  We will call handle_revision_arg() whether arg
has ".." or not immediately after this one.

>  		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
>  			int j;
