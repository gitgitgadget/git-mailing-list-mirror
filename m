From: Jeff King <peff@peff.net>
Subject: [PATCH 0/8] more &&-chaining test fixups
Date: Wed, 25 Mar 2015 01:24:56 -0400
Message-ID: <20150325052456.GA19394@peff.net>
References: <20150320100429.GA17354@peff.net>
 <20150320101308.GQ12543@peff.net>
 <20150325012323.Horde.zCWvV1mF8OBE1PxYPuuEFg8@webmail.informatik.kit.edu>
 <20150325025635.GC15051@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 06:25:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YadoQ-0006xE-1c
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 06:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbbCYFZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 01:25:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:38151 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750863AbbCYFY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 01:24:59 -0400
Received: (qmail 17242 invoked by uid 102); 25 Mar 2015 05:24:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 00:24:59 -0500
Received: (qmail 11434 invoked by uid 107); 25 Mar 2015 05:25:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 01:25:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2015 01:24:56 -0400
Content-Disposition: inline
In-Reply-To: <20150325025635.GC15051@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266253>

Here's what I found looking for loops like:

  for i in a b c; do
     something_important $i || break
  done &&
  something_else

which presumably expect the chain to stop when something_important fails
for any loop element. The solutions are one of (depending on the
surrounding code):

  1. Switch the break to "return 1". The tests are all &&-chained, so
     the effect of a failed command is to exit the test immediately
     anyway. And we wrap our eval'd test snippets inside an extra layer
     of function call to explicitly allow early returns like this.

  2. Switch the break to "exit 1". Calling "return" from a subshell
     inside a function is a bit weird. It doesn't exit the function at
     all, but rather just the subshell (in both bash and dash). But if
     you are not in a function, calling "return" at all is an error in
     bash (subshell or no), and OK in dash (where it acts like "exit").
     POSIX explicitly marks the "outside of a function" behavior as
     unspecified, but I couldn't find anything about the subshell
     behavior.

     So I'm loathe to depend on it, even though it does seem to do what
     we want, as I do not want to even think what some more obscure
     shells might do with it. And especially because we know that "exit
     1" portably does what we want (the only downside is that you have
     to recognize which situation you are in and use "exit" versus
     "return").

  3. Unroll the loops. In some cases the result is actually shorter, and
     (IMHO) more readable.

These sites were all found with:

  git grep -E '(^|\|\|)[ 	]*break' t/t*.sh

(that's a space and a tab in the brackets).  There are some matches
there that I did not touch, because they were already fine.  E.g., t5302
and t7700 use loops to assign a value to a variable and break out early,
and then check the value of the variable.

That's just the tip of the iceberg, though. Searching for

  git grep 'for .* in '

yields hundreds of hits. Most of which are probably fine (quite a few
are outside &&-chains entirely). I focused on the ones that called
break, because that indicated to me that the author was trying to
address the &&-chain. Certainly anybody else is welcome to take a stab
at the rest, but I'm also happy to fix them up as we touch nearby code
and notice them.  Most of the loops are in setup code that we do not
expect to fail anyway, so examining them is a lot of work for a little
gain.

There were a few legitimate problems, though. I've ordered the patches
below by descending severity. These apply on top of jk/test-chain-lint.

  [1/8]: perf-lib: fix ignored exit code inside loop
  [2/8]: t0020: fix ignored exit code inside loops
  [3/8]: t3305: fix ignored exit code inside loop
  [4/8]: t7701: fix ignored exit code inside loop

    These four are actual bugs.

  [5/8]: t: fix some trivial cases of ignored exit codes in loops

    These ones are in setup code, and so would almost certainly never
    fail.

  [6/8]: t: simplify loop exit-code status variables
  [7/8]: t0020: use test_* helpers instead of hand-rolled messages
  [8/8]: t9001: drop save_confirm helper

    These last three are pure cleanup, no behavior changes. The last two
    are not even strictly related to the same topic, but I noticed them
    while in the area.

-Peff
