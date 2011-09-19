From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4014: remove Message-Id/timestamp before comparing
 patches
Date: Mon, 19 Sep 2011 15:15:45 -0400
Message-ID: <20110919191545.GD26115@sigill.intra.peff.net>
References: <6b2cb6ebec907342a02d56a36ddc58715efabc00.1316414731.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pang Yan Han <pangyanhan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Sep 19 21:15:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5jJq-0003L9-LF
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 21:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807Ab1ISTPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 15:15:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37533
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756511Ab1ISTPr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 15:15:47 -0400
Received: (qmail 8044 invoked by uid 107); 19 Sep 2011 19:20:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Sep 2011 15:20:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2011 15:15:45 -0400
Content-Disposition: inline
In-Reply-To: <6b2cb6ebec907342a02d56a36ddc58715efabc00.1316414731.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181693>

On Mon, Sep 19, 2011 at 08:45:43AM +0200, Thomas Rast wrote:

> The test introduced in 787570c (format-patch: ignore ui.color,
> 2011-09-13) has a race condition: if the two format-patch invocations
> do not ask for the current time in the same second, their Message-Id
> headers will disagree.
> 
> Normally this would be a pretty unlikely occurrence.  However, under
> valgrind format-patch runs so slowly that the race triggers every
> time, with a time difference of 2-3s on my hardware.
> 
> To avoid this problem, replace the contents of the Message-Id header
> with a dummy before comparing.

Hmph. I was confused at first reading this, because git format-patch
doesn't produce message-ids. Usually.

But it does if you turn on threading, which obviously requires it. And
earlier tests set format.thread without bothering to clean up after
themselves.

So perhaps this is a better solution:

-- >8 --
Subject: [PATCH] t4014: clean up format.thread config after each test

The threading tests turn on format.thread, but never clean
up after themselves, meaning that later tests will also have
format.thread set.

This is more annoying than most leftover config, too,
because not only does it impact the results of other tests,
but it does so non-deterministically. Threading requires the
generation of message-ids, which incorporate the current
time, meaning a slow-running test script may generate
different results from run to run.

Signed-off-by: Jeff King <peff@peff.net>
---
This uses the test_color helper I introduced recently in d960c47. This
should be OK, because ph/format-patch-no-color (which introduces the
problem) is built on top of jk/color-and-pager (which introduces
test_config).

There are several other places in the script that could use the same
cleanup, but I didn't bother as they are more complex (e.g., using
"--add" to build up multi-value header config) and don't actually cause
problems (because they're deterministic, and don't clutter the output in
a meaningful way)

 t/t4014-format-patch.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7e405d7..6797512 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -457,22 +457,22 @@ test_expect_success 'thread deep cover-letter in-reply-to' '
 '
 
 test_expect_success 'thread via config' '
-	git config format.thread true &&
+	test_config format.thread true &&
 	check_threading expect.thread master
 '
 
 test_expect_success 'thread deep via config' '
-	git config format.thread deep &&
+	test_config format.thread deep &&
 	check_threading expect.deep master
 '
 
 test_expect_success 'thread config + override' '
-	git config format.thread deep &&
+	test_config format.thread deep &&
 	check_threading expect.thread --thread master
 '
 
 test_expect_success 'thread config + --no-thread' '
-	git config format.thread deep &&
+	test_config format.thread deep &&
 	check_threading expect.no-threading --no-thread master
 '
 
-- 
1.7.7.rc1.3.gb95be
