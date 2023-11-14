Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645226ACF
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AFF10D
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:43:12 -0800 (PST)
Received: (qmail 2039 invoked by uid 109); 14 Nov 2023 19:43:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Nov 2023 19:43:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18708 invoked by uid 111); 14 Nov 2023 19:43:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Nov 2023 14:43:12 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Nov 2023 14:43:10 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by
 default
Message-ID: <20231114194310.GC2092538@coredump.intra.peff.net>
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
 <ZVNNXNRfrwc_0Sj3@tanuki>
 <xmqq7cmkz3fi.fsf@gitster.g>
 <xmqqzfzgxops.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzfzgxops.fsf@gitster.g>

On Wed, Nov 15, 2023 at 01:51:43AM +0900, Junio C Hamano wrote:

> >> Both of these are expected failures: we knowingly corrupt the repository
> >> and circumvent git-gc(1)/git-maintenance(1), thus no commit-graphs are
> >> updated. If we stick with the new stance that repository corruption
> >> should not require us to pessimize the common case,...
> >
> > Yeah, just like we try to be extra careful while running fsck,
> > because "--missing" is about finding these "corrupt" cases,
> > triggering the paranoia mode upon seeing the option would make
> > sense, no?  It would fix the failure in 6022, right?
> >
> > Thanks for working on this.
> 
> Just to make sure we do not miscommunicate, I do not think we want
> to trigger the paranoia mode only in our tests.  We want to be
> paranoid to help real users who used "--missing" for their real use,
> so enabling PARANOIA in the test script is a wrong approach.  We
> should enable it inside "rev-list --missing" codepath.

Yeah. Just like we auto-enabled GIT_REF_PARANOIA for git-gc, etc, I
think we should do the same here.

As we are closing in on the v2.43 release, there's one thing I'm not
sure about regarding release planning. Are these test cases that _used_
to detect the corruption, but now don't? I.e., I would have expected
that disabling GIT_COMMIT_GRAPH_PARANOIA would take us back to the same
state as v2.42. But I think it doesn't because of the hunk in e04838ea82
(commit-graph: introduce envvar to disable commit existence checks,
2023-10-31) that makes the has_object() call conditional (and now
defaults to off).

What I'm getting as it that I think we have three options for v2.43:

  1. Ship what has been in the release candidates, which has a known
     performance regression (though the severity is up for debate).

  2. Flip the default to "0" (i.e., Patrick's patch in this thread). We
     know that loosens some cases versus 2.42, which may be considered a
     regression.

  3. Sort it out before the release. We're getting pretty close to do
     a lot new work there, but I think the changes should be small-ish.
     The nuclear option is ejecting the topic and re-doing it in the
     next cycle.

I don't have a really strong preference between the three.

-Peff
