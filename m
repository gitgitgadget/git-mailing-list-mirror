Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ya98s6ce"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C54B4
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 20:58:57 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 90CC41EE29;
	Wed, 15 Nov 2023 23:58:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8MAiMlXcqAxpRyyPSqTkW5Fb1+FRCFIit4sZ0v
	95VDI=; b=ya98s6ce7hAc6qiRyZrGNFHEx1od0aj8iKf/idF69m/omukxf/D+AH
	b8Kx385MhecmDdGULMzHISMn7rpw1ELXftLEDIuooMKOmfsM8xS6+DEEXPjzF/fv
	dY1KqmlGP+tYTw7u3t9BRaUXc88TZPe7GSFnpEc1NUONG56J4f+g0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A5421EE28;
	Wed, 15 Nov 2023 23:58:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2ECDB1EE27;
	Wed, 15 Nov 2023 23:58:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?=
 <opohorel@redhat.com>
Subject: Re: [RFC PATCH v2 1/2] send-email: avoid duplicate specification
 warnings
In-Reply-To: <20231115173952.339303-2-tmz@pobox.com> (Todd Zullinger's message
	of "Wed, 15 Nov 2023 12:39:43 -0500")
References: <20231115173952.339303-1-tmz@pobox.com>
	<20231115173952.339303-2-tmz@pobox.com>
Date: Thu, 16 Nov 2023 13:58:51 +0900
Message-ID: <xmqq4jhmthtg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D6D1DB5C-843C-11EE-B687-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Todd Zullinger <tmz@pobox.com> writes:

> With perl-Getopt-Long >= 2.55 a warning is issued for options which are
> specified more than once.  In addition to causing users to see warnings,
> this results in test failures which compare the output.  An example,
> from t9001-send-email.37:
>
>   | +++ diff -u expect actual
>   | --- expect      2023-11-14 10:38:23.854346488 +0000
>   | +++ actual      2023-11-14 10:38:23.848346466 +0000
>   | @@ -1,2 +1,7 @@
>   | +Duplicate specification "no-chain-reply-to" for option "no-chain-reply-to"
>   | +Duplicate specification "to-cover|to-cover!" for option "to-cover"
>   | +Duplicate specification "cc-cover|cc-cover!" for option "cc-cover"
>   | +Duplicate specification "no-thread" for option "no-thread"
>   | +Duplicate specification "no-to-cover" for option "no-to-cover"
>   |  fatal: longline.patch:35 is longer than 998 characters
>   |  warning: no patches were sent
>   | error: last command exited with $?=1
>   | not ok 37 - reject long lines
>
> Remove the duplicate option specs.
>
> Teach `--git-completion-helper` to output the '--no-' options.  They are
> not included in the options hash and would otherwise be lost.

Nice to see a careful handling of potential fallouts.

> A little history:
>
>   Support for the '--no-' prefix was added in Getopt::Long >= 2.33, in
>   commit 8ca8b48 (Negatable options (with "!") now also support the
>   "no-" prefix., 2003-04-04).  Getopt::Long 2.34 was included in
>   perl-5.8.1 (2003-09-25), per Module::CoreList[1].
>   
>   We list perl-5.8 as the minimum version in INSTALL.  This would leave
>   users with perl-5.8.0 (2002-07-18) with non-working arguments for
>   options where we're removing the explicit 'no-' variant.
>   
>   The explicit 'no-' opts were added in f471494303 (git-send-email.perl:
>   support no- prefix with older GetOptions, 2015-01-30), specifically to
>   support perl-5.8.0 which includes the older Getopt::Long.

These are all very much relevant and deserve to be in the log
message, not hidden under the three-dash line, I would think.
Thanks for digging the history.  The first paragraph was a bit hard
to read as it wasn't clear "support" on which side is being
discussed, though.  If it were written perhaps like so:

   Getopt::Long >= 2.33 started supporting the '--no-' prefix
   natively by appending '!' to the option specification string,
   which was shipped with perl-5.8.1 and not present in perl-5.8.0

it would have been clear that it was talking about the support
given by Getopt module, not on our side.

> It may be time to bump the Perl requirement to 5.8.1 (2003-09-25) or
> even 5.10.0 (2007-12-18).  We last bumped the requirement from 5.6 to
> 5.8 in d48b284183 (perl: bump the required Perl version to 5.8 from
> 5.6.[21], 2010-09-24).

Isn't the position this patch takes a lot stronger than "It may be
time"?  If we applied this patch, it drops the support for folks
with Perl 5.8.0 (which I do not think is a bad thing, by the way).

This sounds like something that is worth describing in the log
message (and Release Notes).

> If there is a way to have our cake without any consequence, I'm happy to
> hear it.  If not, I'll add a commit which bumps the requirement in
> general or notes that some git-send-email requires perl >= 5.8.1 and
> adjusts the 'use' line there to `use 5.008001;`.

Sounds like a plan.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index cacdbd6bb2..94046e0fb7 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -119,13 +119,16 @@ sub completion_helper {
>  
>  	foreach my $key (keys %$original_opts) {
>  		unless (exists $not_for_completion{$key}) {
> -			$key =~ s/!$//;
> +			my $negate = ($key =~ s/!$//);

A very minor nit, but I'd call this $negatable if I were doing this
patch.

Just to make sure I did not misunderstand what you said below the
three-dash line, if we were to take the other option that allows us
to live with 5.8.0, we would make this hunk ...

>  		    "chain-reply-to!" => \$chain_reply_to,
> -		    "no-chain-reply-to" => sub {$chain_reply_to = 0},

... look more like this?

> -		    "chain-reply-to!" => \$chain_reply_to,
> +		    "chain-reply-to" => \$chain_reply_to,
>  		    "no-chain-reply-to" => sub {$chain_reply_to = 0},
> +		    "nochain-reply-to" => sub {$chain_reply_to = 0},

That is, by removing the "!" suffix, we reject the native support of
"--no-*" offered by Getopt::Long, and implement the negated variants
ourselves?

Thanks.
