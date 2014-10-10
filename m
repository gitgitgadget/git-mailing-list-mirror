From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] test-lib.sh: support -x option for shell-tracing
Date: Fri, 10 Oct 2014 02:21:56 -0400
Message-ID: <20141010062156.GA17481@peff.net>
References: <20141010060636.GA15057@peff.net>
 <20141010061355.GC15277@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 08:22:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcTaX-0002YB-5u
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 08:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbaJJGV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 02:21:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:57089 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751174AbaJJGV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 02:21:58 -0400
Received: (qmail 28770 invoked by uid 102); 10 Oct 2014 06:21:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 01:21:58 -0500
Received: (qmail 30744 invoked by uid 107); 10 Oct 2014 06:21:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 02:21:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Oct 2014 02:21:56 -0400
Content-Disposition: inline
In-Reply-To: <20141010061355.GC15277@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 10, 2014 at 02:13:55AM -0400, Jeff King wrote:

> Having finally figured out how to drop the "set +x" from the output, I
> have noticed that I kind of liked the "test_eval_ret=$?" part of the
> trace (which is now gone, too), because it pretty explicitly tells you
> that the last traced command failed. But now that it has been silenced,
> there's no reason we couldn't add back in our own output to make it more
> clear.

Like:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a60ec75..81ceb23 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -237,7 +237,11 @@ do
 		shift ;;
 	-x)
 		test_eval_start_='set -x'
-		test_eval_end_='set +x'
+		test_eval_end_='
+			set +x
+			test "$test_eval_ret_" = 0 ||
+			  say_color error >&4 "last command exited with \$?=$?"
+		'
 		verbose=t
 		shift ;;
 	*)
@@ -543,7 +547,7 @@ test_eval_ () {
 	{
 		test_eval_inner_ "$@" </dev/null >&3 2>&4
 		test_eval_ret_=$?
-		$test_eval_end_
+		eval "$test_eval_end_"
 	} 2>/dev/null
 	return $test_eval_ret_
 }

I think we can probably do away with this excessive use of eval, and
just keep a boolean flag for "is -x in effect" and check it inside
test_eval_. Originally I was trying to keep the number of executed
commands down, because everything until the "set +x" ran (including
checks for an "is -x in effect" flag) was shown to the user. But since
that is no longer the case, we can be less stingy with the conditionals.

-Peff
