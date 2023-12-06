Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F08D44
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 11:40:36 -0800 (PST)
Received: (qmail 4823 invoked by uid 109); 6 Dec 2023 19:40:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Dec 2023 19:40:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27768 invoked by uid 111); 6 Dec 2023 19:40:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Dec 2023 14:40:37 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Dec 2023 14:40:35 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org,
	Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH] object-name: reject too-deep recursive ancestor queries
Message-ID: <20231206194035.GB103708@coredump.intra.peff.net>
References: <57c0b30ddfe7c0ae78069682ff8454791e54469f.1700496801.git.me@ttaylorr.com>
 <ZV9Za7iCL6WiE-Py@tanuki>
 <xmqqy1en7af2.fsf@gitster.g>
 <ZWB26TH0CFW1KC4L@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWB26TH0CFW1KC4L@tanuki>

On Fri, Nov 24, 2023 at 11:11:53AM +0100, Patrick Steinhardt wrote:

> > When we get "HEAD~~~~~~~~~^2~~~~~~" from the user, do we somehow try
> > to create a file or a directory with that name and fail due to
> > ENAMETOOLONG?
> 
> Sorry, this was a typo on my part. I didn't mean "revision", I meant
> "reference" here. References are limited to at most 4kB on most
> platforms due to filesystem limitations, whereas revisions currently
> have no limits in place.

Even without filesystem limitations, references are effectively limited
to 64kb due to the pkt-line format.

Revisions can be much longer than a reference, though. We accept
"some_ref:some/path/in/tree", for instance[1].  I think you could argue
that paths are likewise limited by the filesystem, though. Even on
systems like Linux where paths can grow arbitrarily long (by descending
and adding to the current directory), you're still limited in specifying
a full pathname. And Git will always use the full path from the project
root when creating worktree entries. Plus my recent tree-depth patches
effectively limit us to 16MB in the default config.

So I think it might be reasonable to limit revision lengths just as a
belt-and-suspenders against overflow attacks, etc. But I suspect that
the limits we'd choose there might not match what we'd want for
protection against stack exhaustion via recursion. E.g., I think 8k is
probably the minimum I'd want for a revision ("my/4k/ref:my/4k/path").
If one "~" character can create an expensive recursion, that might be
too much.

So we probably need something like Taylor's patch anyway (or to switch
to an iterative algorithm, though that might be tricky because of the
way we parse). I agree it needs to handle "^", though.

-Peff

[1] There are other more exotic revisions, too. The most arbitrary-sized
    that comes to mind is ":/some-string-to-match". I doubt anybody
    would be too mad if that were limited to 8k or even 4k, though.
