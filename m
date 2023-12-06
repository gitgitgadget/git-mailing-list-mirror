Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7EAD46
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 11:49:54 -0800 (PST)
Received: (qmail 5175 invoked by uid 109); 6 Dec 2023 19:49:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Dec 2023 19:49:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28107 invoked by uid 111); 6 Dec 2023 19:49:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Dec 2023 14:49:55 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Dec 2023 14:49:52 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by
 default
Message-ID: <20231206194952.GC103708@coredump.intra.peff.net>
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
 <ZVNNXNRfrwc_0Sj3@tanuki>
 <xmqq7cmkz3fi.fsf@gitster.g>
 <xmqqzfzgxops.fsf@gitster.g>
 <20231114194310.GC2092538@coredump.intra.peff.net>
 <ZVTJFOSnVonoPgZk@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVTJFOSnVonoPgZk@tanuki>

On Wed, Nov 15, 2023 at 02:35:16PM +0100, Patrick Steinhardt wrote:

> > > Just to make sure we do not miscommunicate, I do not think we want
> > > to trigger the paranoia mode only in our tests.  We want to be
> > > paranoid to help real users who used "--missing" for their real use,
> > > so enabling PARANOIA in the test script is a wrong approach.  We
> > > should enable it inside "rev-list --missing" codepath.
> > 
> > Yeah. Just like we auto-enabled GIT_REF_PARANOIA for git-gc, etc, I
> > think we should do the same here.
> 
> I'm honestly still torn on this one. There are two cases that I can
> think of where missing objects would be benign and where one wants to
> use `git rev-list --missing`:
> 
>     - Repositories with promisor remotes, to find the boundary of where
>       we need to fetch new objects.
> 
>     - Quarantine directories where you only intend to list new objects
>       or find the boundary.
> 
> And in neither of those cases I can see a path for how the commit-graph
> would contain such missing commits when using regular tooling to perform
> repository maintenance.

Sorry for being unclear (and for the very slow response!). What I meant
by "here" was not "rev-list --missing" in particular, but rather that
"here" is "GIT_COMMIT_GRAPH_PARANOIA". And like GIT_REF_PARANOIA, we
should make sure it is turned on when checking for repository
corruption.

So specifically I meant that turning it off should:

  1. Not cause us to miss corruption with fsck.

  2. Not cause us to make corruption worse during a destructive repack
     (e.g., "repack -ad").

  3. Not admit corruption into the repository by fooling the rev-list
     invocation for check_connected().

I don't think the third one uses --missing at all, but even if it did,
the interesting thing to me is not "--missing", but rather that the
caller knows it is doing a corruption check. So it would set the
environment variable itself.

So in your loosening patch, I would have expected to see a couple of
those cases overriding the new "default to off" behavior. But it may be
that they are not necessary (e.g., I think fsck may turn off the commit
graph entirely already).

> So I'm still not sure why we think that this case is so much more
> special than others. If a user wants to check for repository corruption
> the tool shouldn't be `git rev-list --missing`, but git-fsck(1). To me,
> the former is only useful in very specific circumstances where the user
> knows what they are doing, and in none of the usecases I can think of
> should we have a stale commit-graph _unless_ we have actual repository
> corruption.
> 
> In reverse, to me this means that `--missing` is no more special than
> any of the other low-level tooling, where our stance seems to be "We
> assume that the repository is not corrupt". In that spirit, I'd argue
> that the same default value should apply here as for all the other
> cases.

Yeah, I think we are on the same page here. The need for paranoia is
really in the eyes of the caller, because only they know how careful
they want the operation to be.

> Oh, well. I'll wait for answers to this reply until tomorrow, and if I
> still haven't been able to convince anybody then I'll assume it's just
> me and adapt accordingly :)

Sorry, better late than never. ;)

-Peff
