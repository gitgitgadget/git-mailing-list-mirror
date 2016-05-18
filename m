From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: warn on --verify-signatures with --rebase
Date: Wed, 18 May 2016 09:04:24 -0700
Message-ID: <xmqq37pftks7.fsf@gitster.mtv.corp.google.com>
References: <20160518101827.GA14475@netblarch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Stefan Beller <sbeller@google.com>
To: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 18:04:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b33xi-0006WQ-RH
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 18:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbcERQE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 12:04:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932410AbcERQE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 12:04:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B1C8F1CBA1;
	Wed, 18 May 2016 12:04:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OM4AVcVI1qH1bK6ZkjA70S73kKI=; b=gIyGTF
	4OvhiqgF+LxfAbZHVrnbBLdEv+CJj9NSEcvr05q+/dDFcfhS7wP+lk5jZiO8G+6A
	jm6zU2AKD9p8pndvvsIVoHvfE46dbkDlBhEYbqeSVQuu0ZotGjeTePnYAXGyN4fz
	dWUBXWDvAhHFmyBKjdB5ajd6QcHP3bfx03p7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aYmHRl8yeMR2wCELKOUQYSyiTG3maIKa
	NfzEsenmm2KG9iw7jGp9foToqt57Gw1eT8OFa2MutT8bDfwKSjTpyH+V6wypBC6G
	2nF/CIe2Jw2Xpjw+EC4rmRsNmHr2s2VF1uLr4VW/B+U9NqK1aJJbNyleJDRdbTDV
	HS5pHNr/9+Q=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A8EAA1CBA0;
	Wed, 18 May 2016 12:04:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1BCE91CB9F;
	Wed, 18 May 2016 12:04:26 -0400 (EDT)
In-Reply-To: <20160518101827.GA14475@netblarch> (Alexander Hirsch's message of
	"Wed, 18 May 2016 12:18:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 31AAC52E-1D12-11E6-AF42-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294967>

Alexander 'z33ky' Hirsch <1zeeky@gmail.com> writes:

> Previously git-pull silently ignored the --verify-signatures option for
> --rebase.

Missing pieces information that would have made the patch more
complete are answers to these questions:

 - Is that a bad thing?  Why?

 - Assuming it is a bad thing, what is the solution this patch
   presents us?  Teach rebase about the option?  Error out the
   request?  What is the reason why "warn" was chosen as the best
   way forward?

>  builtin/pull.c  |  2 ++
>  t/t5520-pull.sh | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 1d7333c..0eafae7 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -815,6 +815,8 @@ static int run_rebase(const unsigned char *curr_head,
>  		argv_array_push(&args, "--no-autostash");
>  	else if (opt_autostash == 1)
>  		argv_array_push(&args, "--autostash");
> +	if (opt_verify_signatures && strcmp(opt_verify_signatures, "--verify-signatures") == 0)

The logic looks OK.  I would have written that long line as two
lines, e.g.

	if (opt_verify_signatures &&
            !strcmp(opt_verify_signatures, "--verify-signatures")

though.

> +		warning(_("git-rebase does not support --verify-signatures"));

Is this a good warning message?

As a casual reader, my reaction to this warning would be "Does not
support?  Then what did it do instead?  Did it refuse to integrate
my changes on top of what happened on the remote?"

Something like

    warning(_("ignored --verify-signatures as it is meaningless in rebase"));

may convey what is going on better, in that it makes it clear that
we are not failing "rebase" and instead we are ignoring "verify".

It is way too long for the final version, though.  A more concise
way to say the same thing needs to be found.

Thanks.
