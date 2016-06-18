Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5528B1F744
	for <e@80x24.org>; Sat, 18 Jun 2016 10:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbcFRKDx (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 06:03:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:51867 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbcFRKDw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 06:03:52 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M3S2C-1bW10D0bbs-00r1NV; Sat, 18 Jun 2016 12:03:45
 +0200
Date:	Sat, 18 Jun 2016 12:03:44 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] Let log-tree and friends respect diffopt's `file`
 field
Message-ID: <cover.1466244194.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:T44PDr+1BjgxvpnzYSg8lQoJwDyed3qKzhafxbWVreRlHzzbYZ5
 Mk+F+4NGdcuxYxKW2NP8GLZMhzZC6AXaZXiU+bNGOFhKhxArUtwS2hcrYhG3K5bgHR3Qa0I
 Fqo+xNb0RvIp5s831B6qCtj+hKJH/WLV+aj6eQBxMb9xM8jrXqhMboxuAOpaWrVuF+6VAlP
 ZOoeABZuR5G5lK1EIyYxA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:jvFc/Lp70ig=:ij1+ORnjW4Podz7HgWZtZr
 Jnkty4ELAOvSbiyJ5AA96XuYBQ6RO85b9BitkYnd+Wsuh1EvmG6jwdhbbicBeQZJaXixgbCej
 jtFLjUKGIb13Km1qMbgL1oFAo0JFzhmaKYfadaqZR/MW+aWXhT/lBIUs0JjjvDZUkdEfKDoDo
 wfkf6adNEC+0gbxkwx+VfrS3km6bio6slDjPtOOhUgKcl46PMV4nQ0GmRU2S6tYHGCqhFa1CZ
 seGPzuJR5BReuwZ6ymPMkxqXy6hobGyzqUxZMXa+Gwq6gnF4Yzh/CkfzsDPKpPxjX9sxPTDvw
 oVn7i8mUSXhXV6i8CU7TmcYti2dlxQMID2+x2IoX2Mcvu5Fs4qUefWgo9RBNlecpJusKcqEP3
 E5PhjstHPIRmYOmV0b+3XYUm64PNaF8NmzotWKqrd2fH7DSL2AkfhFBfyGv1TcPJ0Mn3eOwIv
 97nqN+prORzunnE0BD/T6yywHaCrQmbIYpOXJ33erG+CjTWL2S/brSF7pbnRbZNI3dCcI3+Hy
 0HH1CIV0SvBuUYhHzx+dVGR2xNXSh0MLD0x0nQe7jSnMt/ElBL86DYtS0pQ5zgZXzWe8JSk9S
 18T9WeMJqK0eBONA55N0ML2OKwUvazRm9iPQSEl6U330A6IbUIYki6KpQBoUGOTfTovZ6lJSQ
 CjgsJte+SeCun4hGNRx4gtV+zwVaEhbudvTgINCgXQxCZBd6o9pPiFW9fDv890YWwSBagCVj+
 oNwytxWvIiIQSV3EMUQEZGdHjrSusoY/mc8ybH5Y8pUPL6cxEKqxFcGfqUTwjs9yiNEPg9R6a
 kjt/IlD
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The idea is to allow callers to redirect log-tree's output to a file
without having to freopen() stdout (which would modify global state,
a big no-no-no for library functions).

I reviewed log-tree.c, graph.c, line-log.c, builtin/shortlog.c and
builtin/log.c line by line to ensure that all calls that assumed stdout
previously now use the `file` field instead, of course. I would
welcome additional eyes to go over the code to confirm that I did not
miss anything.

This patch series ends up removing the freopen() call in the
format-patch command, but that is only a by-product. The ulterior motive
behind this series is to allow the sequencer to write a `patch` file as
part of my endeavor to move large chunks of rebase -i into a builtin.

Speaking of said endeavor: it is going a lot slower than I would like,
but I really need rebase -i to be robust. To that end, I not only review
and re-review my patches frequently, I also use a cross-validation
technique inspired by my original ll-merge validation as well as
GitHub's Scientist library: I taught rebase -i to run every interactive
rebase twice, once with the original shell script's code, and once with
the builtin rebase--helper, and then to verify that the end result is as
similar as can be expected (the commit dates will differ most of the
time, of course).

It is a bit tedious, of course, because I have to resolve every merge
conflict twice, I have to reword everything twice (identically!), and I
have to wait longer for the rebase to finish. It is worth it, though,
because I really need rebase -i to be robust, as it is the center piece
of almost all of my workflows.

I organized the patch series into a thicket of branches, to make it
easier to review them; In addition to this here patch series, I plan to
submit 11 separate, partially interdependent series, resubmit another
one, and I already submitted a couple of patches earlier that were
integrated or replaced by superior solutions (thanks, Peff!). Skipping
the temporary patches (e.g. for cross-validation), that leaves me with
99 patches to submit in total (sing with me: "99 patches of code to
submit, 99 patches of code, ...").

I was curious just how much these patches could accelerate rebase -i, so
I disabled the cross-validation temprarily and let Travis measure the
performance improvements via the t/perf test that was already merged to
`master`. Look for "3404.2" in this build's logs:
https://travis-ci.org/git/git/builds/138277774

It looks like a 3x speedup on Linux, a 4x speedup on MacOSX and my local
measurements suggest a >5x speed-up on Windows.


Johannes Schindelin (5):
  log-tree: respect diffopt's configured output file stream
  line-log: respect diffopt's configured output file stream
  graph: respect the diffopt.file setting
  shortlog: support outputting to streams other than stdout
  format-patch: avoid freopen()

 builtin/log.c      | 71 +++++++++++++++++++++++++++---------------------------
 builtin/shortlog.c | 13 ++++++----
 graph.c            | 30 +++++++++++++----------
 line-log.c         | 34 +++++++++++++-------------
 log-tree.c         | 65 +++++++++++++++++++++++++------------------------
 shortlog.h         |  1 +
 6 files changed, 111 insertions(+), 103 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/diffopt.file-v1
-- 
2.9.0.118.gce770ba.dirty

base-commit: 05219a1276341e72d8082d76b7f5ed394b7437a4
