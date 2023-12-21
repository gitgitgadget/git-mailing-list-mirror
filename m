Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E11A5A4
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21954 invoked by uid 109); 21 Dec 2023 08:36:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Dec 2023 08:36:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22277 invoked by uid 111); 21 Dec 2023 08:36:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Dec 2023 03:36:44 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Dec 2023 03:36:43 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH/RFC] sparse-checkout: take care of "--end-of-options" in
 set/add
Message-ID: <20231221083643.GA545870@coredump.intra.peff.net>
References: <xmqqbkakqx6s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbkakqx6s.fsf@gitster.g>

On Wed, Dec 20, 2023 at 03:19:23PM -0800, Junio C Hamano wrote:

> 93851746 (parse-options: decouple "--end-of-options" and "--",
> 2023-12-06) updated the world order to make callers of parse-options
> that set PARSE_OPT_KEEP_UNKNOWN_OPT responsible for deciding what to
> do with "--end-of-options" they may see after parse_options() returns.
> 
> This unfortunately broke "sparse-checkout set/add", and from this
> invocation,
> 
>   "git sparse-checkout [add|set] --[no-]cone --end-of-options pattern..."
> 
> we now see "--end-of-options" listed in .git/info/sparse-checkout as if
> it is one of the path patterns.

Thanks for finding this. Though I only half-agree with the
"unfortunately" part. ;)

As argued in 93851746, any caller passing KEEP_UNKNOWN_OPT but _not_
handling the now-returned end-of-options is rather suspicious. Because
if they are planning to parse those options further, they will have no
idea that we saw --end-of-options, and will err in the unsafe direction
of still treating any elements with dashes as options.

Which would mean that simply dropping --end-of-options from the list, as
your patch does, would be similarly unsafe. It is papering over the
problem of:

  git sparse-checkout --end-of-options foo

but leaving:

  git sparse-checkout --end-of-options --foo

broken.

But the plot thickens! Curiously, in both of these cases, we do not do
any further parsing of the options at all. We just treat them as
pattern arguments with no special meaning.

So your patch is actually OK, but I would argue that the correct fix
here is to drop the use of PARSE_OPT_KEEP_UNKNOWN_OPT at all. I cannot
find any indication in the history on why it was ever used. It was added
when the command was converted to parse-options in 7bffca95ea
(sparse-checkout: add '--stdin' option to set subcommand, 2019-11-21).
Back then it was just called KEEP_UNKNOWN. Later it was renamed to
KEEP_UNKNOWN_OPT in 99d86d60e5 (parse-options: PARSE_OPT_KEEP_UNKNOWN
only applies to --options, 2022-08-19) to clarify that it was only about
dashed options; we always keep non-option arguments.

So looking at that original patch, it makes me think that the author was
confused about the mis-named option, and really just wanted to keep the
non-option arguments. We never should have used the flag all along (and
the other cases were cargo-culted within the file).

There is one minor gotcha, though. Unlike most other Git commands,
sparse-checkout will happily accept random option names and treat them
as non-option arguments. E.g. this works:

  git sparse-checkout add --foo --bar

and will add "--foo" and "--bar" as patterns. If we remove the flag,
we'd be breaking that. But I'd argue that anybody relying on that is
asking for trouble. For example, this does not work in the same way:

  git sparse-checkout add --skip-checks --foo

because "--skip-checks" is a real option. Ditto for any other options,
including those we add in the future. If you don't trust the contents of
your arguments, you should be using "--" or "--end-of-options" to
communicate the intent to the command.

-Peff
