Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD23F20179
	for <e@80x24.org>; Mon, 20 Jun 2016 10:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbcFTK6l (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 06:58:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:64543 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754563AbcFTK6f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 06:58:35 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lu3J4-1bLvPy1VpO-011P6h; Mon, 20 Jun 2016 12:58:24
 +0200
Date:	Mon, 20 Jun 2016 12:55:02 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/7] Let log-tree and friends respect diffopt's `file`
 field
In-Reply-To: <cover.1466244194.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1466420060.git.johannes.schindelin@gmx.de>
References: <cover.1466244194.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:55sIRCVxml4yCzBqoRuwFh6fr0u8K384RrBW537pJDWiyQGXJhP
 +Us1OpLnh3XN+Ev8hzLtSWO/09uJaxNi3ufWNbr31uw4JMd5IuP+sOqNfI+sIvu9b77B38g
 3Gp+n4fwR3pdV7uQ1s+pGkDkTV00Dp9fj4Tm76HjKZ2PHPBLMPPqkPQ1xsZoCzNFotZlsL3
 CJCuNwMvtRQf+7Wa0FTnw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:zS4cMjcUb20=:hMCE+nuuNQFZja3Dhw/Rp/
 +H9T5MCjHxVNmWpcY1n6Rpmhxi/3FDl8ouqW8/cgSfhnSQxqEW73wohXfiljqlkDTKQPu3nSt
 YksmDVyM6cUo878sDJlmLe9LPlncC02fk5XT7djY1LzLskYH9+a/9ENB6vIlW2cRKbLg1oiug
 Pi6BfoYYMWcaqq+rcqRXs98ODgOoMyNFroOOOu7cno2iG2++wztTfCoZp2lTirsJyM9gUItWn
 1w4rISwlKkKMmcTSEDOky0Lc/mTH+rtqYPW3NSms/62tc+uG3r5D5rDjO+flyAzalh89O4p3M
 0atVt9BTbhFIsSuVLqAqsqRjVEwbfEXtckYXUpphtbcEEiR6VLCJ65jnVNqD/ZR2XolfTanpw
 RJT46sDy/+Bwim9g/Uq/zRZtMZJ7i/PGPcRhMNCnHBc1mna1I1SX81d+nO4eDQIOSmy8dpyf4
 KugyjXCWmg6QezjCR3FdBVFGGzikjOWmWyOGQqRD8heq4jB8L7v9O7DpsZkAO8I3GqWrCnwbY
 fCPqzXWue+xFwlJ+iCqKf/vvXoDJnVV3wNJ7qxNtD3FKtL79WiPLKITEtfGsvi8K8jh3J3sCF
 bpw9a0fAxSCljl3jRlApmyNmjCK9tXq/TnTOe7fNaUnGa0CMYwhmO4/LUABjTdCT+EUPZD3L7
 1JWGhLFKC0pmRp4jjRBAuggJLAFhYAH8SVZYhMXLw6WJMFDPu1bD5IrdKRSDkqycfZOghn6f7
 YMF6j9Djnc8u6OJw8bVC+5NWeBavtLF6LsPFre1/spJ5NZjQ53lKbzfS1/vHaf/FZP6qsBYVl
 Gov1p7C
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


Johannes Schindelin (7):
  log-tree: respect diffopt's configured output file stream
  line-log: respect diffopt's configured output file stream
  graph: respect the diffopt.file setting
  shortlog: support outputting to streams other than stdout
  format-patch: explicitly switch off color when writing to files
  format-patch: avoid freopen()
  format-patch: use stdout directly

 builtin/log.c      | 71 +++++++++++++++++++++++++++---------------------------
 builtin/shortlog.c | 13 ++++++----
 graph.c            | 30 +++++++++++++----------
 line-log.c         | 34 +++++++++++++-------------
 log-tree.c         | 65 +++++++++++++++++++++++++------------------------
 shortlog.h         |  1 +
 6 files changed, 111 insertions(+), 103 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/diffopt.file-v2
-- 
2.9.0.119.g370c5a9

base-commit: 05219a1276341e72d8082d76b7f5ed394b7437a4
