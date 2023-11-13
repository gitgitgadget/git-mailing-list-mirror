Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9922F07
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F55810E0
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 12:55:39 -0800 (PST)
Received: (qmail 20812 invoked by uid 109); 13 Nov 2023 20:55:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Nov 2023 20:55:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6576 invoked by uid 111); 13 Nov 2023 20:55:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Nov 2023 15:55:40 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Nov 2023 15:55:38 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: commit-graph paranoia performance, was Re: [ANNOUNCE] Git v2.43.0-rc1
Message-ID: <20231113205538.GA2028092@coredump.intra.peff.net>
References: <xmqq8r785ev1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8r785ev1.fsf@gitster.g>

On Thu, Nov 09, 2023 at 02:33:54AM +0900, Junio C Hamano wrote:

>  * The codepath to traverse the commit-graph learned to notice that a
>    commit is missing (e.g., corrupt repository lost an object), even
>    though it knows something about the commit (like its parents) from
>    what is in commit-graph.
>    (merge 7a5d604443 ps/do-not-trust-commit-graph-blindly-for-existence later to maint).

I happened to be timing "rev-list" for an unrelated topic today, and I
noticed that this change had a rather large effect. The commit message
for 7a5d604443 claims a 30% performance regression. But that's when
using "--topo-order", and actually writing out the result.

Running "rev-list --count" on a copy of linux.git with a fully-built
commit-graph shows that the run-time doubles:

  Benchmark 1: git.v2.42.1 rev-list --count HEAD
    Time (mean ± σ):     658.0 ms ±   5.2 ms    [User: 613.5 ms, System: 44.4 ms]
    Range (min … max):   650.2 ms … 666.0 ms    10 runs
  
  Benchmark 2: git.v2.43.0-rc1 rev-list --count HEAD
    Time (mean ± σ):      1.333 s ±  0.019 s    [User: 1.263 s, System: 0.069 s]
    Range (min … max):    1.302 s …  1.361 s    10 runs
  
  Summary
    git.v2.42.1 rev-list --count HEAD ran
      2.03 ± 0.03 times faster than git.v2.43.0-rc1 rev-list --count HEAD

Now in defense of that patch, this particular command is going to be one
of the most sensitive in terms of percent change, simply because it
isn't doing much besides walking the commits. And 650ms isn't _that_ big
in an absolute sense. But it also doesn't quite feel like nothing, even
tacked onto a command that might otherwise take 1000ms to run.

Should we default GIT_COMMIT_GRAPH_PARANOIA to "0"? Yes, some operations
might miss a breakage, but that is true of so much of Git. For day to
day commands we generally assume that the repository is not corrupted,
and avoid looking at any data we can. Other commands (like "commit-graph
verify", but maybe others) would probably want to be more careful
(either by checking this case explicitly, or by enabling the paranoia
flag themselves).

-Peff
