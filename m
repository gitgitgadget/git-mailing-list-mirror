Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5407E552
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753D210E4
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 03:00:26 -0700 (PDT)
Received: (qmail 15336 invoked by uid 109); 20 Oct 2023 10:00:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Oct 2023 10:00:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12595 invoked by uid 111); 20 Oct 2023 10:00:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Oct 2023 06:00:30 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Oct 2023 06:00:24 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] commit: detect commits that exist in commit-graph but
 not in the ODB
Message-ID: <20231020100024.GA2194074@coredump.intra.peff.net>
References: <ZSkCGS3JPEQ71dOF@tanuki>
 <b0bf576c51a706367a758b8e30eca37edb9c2734.1697200576.git.ps@pks.im>
 <xmqq1qdy1iyr.fsf@gitster.g>
 <ZS4rmtBTYnp2RMiY@tanuki>
 <xmqqjzrlhzci.fsf@gitster.g>
 <ZTDQjangLsQ1cSJl@tanuki>
 <ZTDn-Wd5xsFrBmqI@tanuki>
 <xmqqzg0ey1kn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzg0ey1kn.fsf@gitster.g>

On Thu, Oct 19, 2023 at 10:16:56AM -0700, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> > There's another way to handle this, which is to conditionally enable the
> > object existence check. This would be less of a performance hit compared
> > to disabling commit graphs altogether with `--missing`, but still ensure
> > that repository corruption was detected. Second, it would not regress
> > performance for all preexisting users of `repo_parse_commit_gently()`.
> 
> The above was what I meant to suggest when you demonstrated that the
> code with additional check is still much more performant than
> running without the commit-graph optimization, yet has observable
> impact on performance for normal codepaths that do not need the
> extra carefulness.
> 
> But I wasn't sure if it is easy to plumb the "do we want to double
> check?  in other words, are we running something like --missing that
> care the correctness a bit more than usual cases?" bit down from the
> caller, because this check is so deep in the callchain.

I wonder if we would want a "be extra careful" flag that is read from
the environment? That is largely how GIT_REF_PARANOIA works, and then
particular operations set it (though actually it is the default these
days, so they no longer do so explicitly).

I guess that is really like a global variable but even more gross. ;)
But it is nice that it can cross process boundaries, because "how
careful do we want to be" may be in the eye of the caller, especially
for plumbing commands. E.g., even without --missing, you may want
"rev-list" to be extra careful about checking the existence of commits.
The caller in check_connected() could arguably turn that on by default
(the way we used to turn on GIT_REF_PARANOIA for pruning repacks before
it became the default).

-Peff
