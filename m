From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase -i: avoid --cherry-pick when rebasing to a
 direct ancestor
Date: Sun, 21 Feb 2010 02:46:06 -0500
Message-ID: <20100221074605.GD2840@coredump.intra.peff.net>
References: <dfb660301002191324i7aeca7f5x990501bbca1475a9@mail.gmail.com>
 <201002200102.15777.trast@student.ethz.ch>
 <20100220072728.GA12168@coredump.intra.peff.net>
 <201002201438.29635.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Laine Walker-Avina <lwalkera@pasco.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 21 09:30:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj6WG-0007rT-9V
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 08:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab0BUHqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 02:46:09 -0500
Received: from peff.net ([208.65.91.99]:38122 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106Ab0BUHqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 02:46:08 -0500
Received: (qmail 8347 invoked by uid 107); 21 Feb 2010 07:46:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 21 Feb 2010 02:46:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Feb 2010 02:46:06 -0500
Content-Disposition: inline
In-Reply-To: <201002201438.29635.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140601>

On Sat, Feb 20, 2010 at 02:38:29PM +0100, Thomas Rast wrote:

> BTW, here's a weird data point:
> 
> $ ls -l a b
> -rw-r--r-- 1 thomas users 3300765 2010-02-20 12:48 a
> -rw-r--r-- 1 thomas users 3253762 2010-02-20 12:48 b
> $ time diff -u a b | wc -l
> 54530
> 
> real    0m0.644s
> user    0m0.562s
> sys     0m0.044s
> $ time git diff --no-index a b >/dev/null
> 
> real    0m22.848s
> user    0m21.956s
> sys     0m0.137s
> $ time git diff --no-index --patience a b >/dev/null
> 
> real    0m19.508s
> user    0m18.673s
> sys     0m0.273s

I was able to reproduce here. According to 'perf', git spends 70% of its
time in xdl_split, which says:

/*
 * See "An O(ND) Difference Algorithm and its Variations", by Eugene Myers.
 * Basically considers a "box" (off1, off2, lim1, lim2) and scan from both
 * the forward diagonal starting from (off1, off2) and the backward diagonal
 * starting from (lim1, lim2). If the K values on the same diagonal crosses
 * returns the furthest point of reach. We might end up having to expensive
 * cases using this algorithm is full, so a little bit of heuristic is needed
 * to cut the search and to return a suboptimal point.
 */

GNU diff also seems to use the same basic Myers algorithm, but says:

   The basic algorithm is described in:
   "An O(ND) Difference Algorithm and its Variations", Eugene Myers,
   Algorithmica Vol. 1 No. 2, 1986, pp. 251-266;
   see especially section 4.2, which describes the variation used below.

   The basic algorithm was independently discovered as described in:
   "Algorithms for Approximate String Matching", E. Ukkonen,
   Information and Control Vol. 64, 1985, pp. 100-118.

   Unless the 'find_minimal' flag is set, this code uses the TOO_EXPENSIVE
   heuristic, by Paul Eggert, to limit the cost to O(N**1.5 log N)
   at the price of producing suboptimal output for large inputs with
   many differences.

So it may be that TOO_EXPENSIVE heuristic. I don't know enough about the
diff code (git's or otherwise) to say how difficult it would be to adapt
GNU diff's tricks.

-Peff
