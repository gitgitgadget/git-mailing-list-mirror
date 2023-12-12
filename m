Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA76FCE
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 17:30:46 -0800 (PST)
Received: (qmail 5879 invoked by uid 109); 12 Dec 2023 01:30:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 01:30:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8985 invoked by uid 111); 12 Dec 2023 01:30:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Dec 2023 20:30:45 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Dec 2023 20:30:45 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Britton Kerin <britton.kerin@gmail.com>
Subject: Re: [PATCH] revision: parse integer arguments to --max-count,
 --skip, etc., more carefully
Message-ID: <20231212013045.GE376323@coredump.intra.peff.net>
References: <CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com>
 <xmqqy1e41lf5.fsf@gitster.g>
 <xmqq5y181fx0.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5y181fx0.fsf_-_@gitster.g>

On Sat, Dec 09, 2023 at 07:35:23AM +0900, Junio C Hamano wrote:

> The "rev-list" and other commands in the "log" family, being the
> oldest part of the system, use their own custom argument parsers,
> and integer values of some options are parsed with atoi(), which
> allows a non-digit after the number (e.g., "1q") to be silently
> ignored.  As a natural consequence, an argument that does not begin
> with a digit (e.g., "q") silently becomes zero, too.
> 
> Switch to use strtol_i() and parse_timestamp() appropriately to
> catch bogus input.
> 
> Note that one may naïvely expect that --max-count, --skip, etc., to
> only take non-negative values, but we must allow them to also take
> negative values, as an escape hatch to countermand a limit set by an
> earlier option on the command line; the underlying variables are
> initialized to (-1) and "--max-count=-1", for example, is a
> legitimate way to reinitialize the limit.

This all looks pretty reasonable to me.

I couldn't help but think, though, that surely we have some helpers for
this already? But the closest seems to be git_parse_int(), which also
allows unit factors. I'm not sure if allowing "-n 1k" would be a feature
or a bug. ;)

I guess "strtol_i()" maybe is that helper already, though I did not even
know it existed. Looks like it goes back to 2007, and is seldom used. I
wonder if there are more spots that could benefit.

I don't think there is any such helper for timestamps, but the checks in
your parser look good (strtol_i() checks for overflow as we cast to int,
but I don't think we need to do the same here since timestamp_t and
parse_timestamp() should be matched).

-Peff
