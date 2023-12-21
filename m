Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C050820310
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21989 invoked by uid 109); 21 Dec 2023 08:58:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Dec 2023 08:58:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22392 invoked by uid 111); 21 Dec 2023 08:58:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Dec 2023 03:58:08 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Dec 2023 03:58:08 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [RFC/PATCH] archive: "--list" does not take further options
Message-ID: <20231221085808.GC545870@coredump.intra.peff.net>
References: <xmqqbkakqx6s.fsf@gitster.g>
 <xmqqttocp98r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttocp98r.fsf@gitster.g>

On Wed, Dec 20, 2023 at 06:41:56PM -0800, Junio C Hamano wrote:

> ---
>  * This was done to convince myself that even though cmd_archive()
>    calls parse_options with PARSE_OPT_KEEP_UNKNOWN_OPT and then
>    uses the resulting argc/argv without apparent filtering of the
>    "--end-of-options" thing, it is correctly handling it, either
>    locally or remotely.
> 
>    - locally, write_archive() uses parse_archive_args(), which calls
>      parse_options() without KEEP_UNKNOWN_OPT and "--end-of-options"
>      is handled there just fine.

Right. Not only is it handled by the second parser, but _not_ keeping it
would be a bug, because that second parser would have no idea that we
saw end-of-options (and so "git archive --end-of-options --foo" would
try to treat "--foo" as an option).

The recent commit 9385174627 did fix a case like this for fast-export,
but git-archive was not changed. It passed KEEP_DASHDASH along with
KEEP_UNKNOWN_OPT, so it already retained and passed along
--end-of-options.

>    - remotely, run_remote_archiver() relays the local parameters,
>      including "--end-of-options" via the "argument" packet.  Then
>      the arguments are assembled into a strvec and used by the
>      upload-archive running on the other side to spawn an
>      upload-archive--writer process with.
>      cmd_upload_archive_writer() then makes the same write_archive()
>      call; "--end-of-options" would still be in argv[] if the
>      original "git archive --remote" invocation had one, but it is
>      consumed the same way as the local case in write_archive() by
>      calling parse_archive_args().

Right, and this is just the same case but with a lot of complicated
network-ferrying in between. :) We must retain --end-of-options so that
the next parser knows to stop treating them as arguments. And because it
doesn't use KEEP_UNKNOWN_OPT, the ferried "--end-of-options" is removed
then.

> diff --git c/archive.c w/archive.c
> index 9aeaf2bd87..3244e9f9f2 100644
> --- c/archive.c
> +++ w/archive.c
> @@ -641,6 +641,13 @@ static int parse_archive_args(int argc, const char **argv,
>  		base = "";
>  
>  	if (list) {
> +		if (argc) {
> +			if (!is_remote)
> +				die(_("extra command line parameter '%s'"), *argv);
> +			else
> +				printf("!ERROR! extra command line parameter '%s'\n",
> +				       *argv);
> +		}

This general direction seems reasonable to me, since we're letting the
user know that their extra argument was ignored (though note that if it
was a misspelled option, like "--otuput", we would complain about that).
It's largely orthogonal to end-of-options, but I see how you got here by
wondering about it. :)

-Peff
