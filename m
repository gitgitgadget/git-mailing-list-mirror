Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C23B3
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 14:05:07 -0800 (PST)
Received: (qmail 19375 invoked by uid 109); 12 Dec 2023 22:05:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 22:05:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19953 invoked by uid 111); 12 Dec 2023 22:05:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Dec 2023 17:05:06 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Dec 2023 17:05:05 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Britton Kerin <britton.kerin@gmail.com>
Subject: Re: [PATCH] revision: parse integer arguments to --max-count,
 --skip, etc., more carefully
Message-ID: <20231212220505.GA1220605@coredump.intra.peff.net>
References: <CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com>
 <xmqqy1e41lf5.fsf@gitster.g>
 <xmqq5y181fx0.fsf_-_@gitster.g>
 <20231212013045.GE376323@coredump.intra.peff.net>
 <xmqqjzpjsbjl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzpjsbjl.fsf@gitster.g>

On Tue, Dec 12, 2023 at 07:09:02AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This all looks pretty reasonable to me.
> >
> > I couldn't help but think, though, that surely we have some helpers for
> > this already? But the closest seems to be git_parse_int(), which also
> > allows unit factors. I'm not sure if allowing "-n 1k" would be a feature
> > or a bug. ;)
> 
> The change in question is meant to be a pure fix to replace a careless
> use of atoi().  I do not mind to see a separate patch to add such a
> feature later on top.

Oh, I mostly meant that I would have turned to git_parse_int() as that
already-existing helper, but it is not suitable because of the extra
unit-handling. I think your patch draws the line in the right place.

> > I wonder if there are more spots that could benefit.
> 
> "git grep -e 'atoi('" would give somebody motivated a decent set of
> #microproject ideas, but many hits are not suited for strtol_i(),
> which is designed to parse an integer at the end of a string.  Some
> places use atoi() immediately followed by strspn() to skip over
> digits, which means they are parsing an integer and want to continue
> reading after the integer, which is incompatible with what
> strtol_i() wants to do.  They need either a separate helper or an
> updated strtol_i() that optionally allows you to parse the prefix
> and report where the integer ended, e.g., something like:

Yeah, I agree this might be a good microproject (or leftoverbits) area,
and the semantics for the helper you propose make sense to me.

-Peff
