From: Jeff King <peff@peff.net>
Subject: Re: Make GIT_USE_LOOKUP default?
Date: Mon, 18 Mar 2013 03:32:29 -0400
Message-ID: <20130318073229.GA5551@sigill.intra.peff.net>
References: <CACsJy8AihriCDfN=cz7FjdHzZAhnPPGML_w8yWcVVrmTQLZyjw@mail.gmail.com>
 <7vd2uxrdh7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ingo Molnar <mingo@elte.hu>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 08:33:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHUZ2-000209-8e
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 08:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358Ab3CRHcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 03:32:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55113 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116Ab3CRHcd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 03:32:33 -0400
Received: (qmail 13979 invoked by uid 107); 18 Mar 2013 07:34:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Mar 2013 03:34:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2013 03:32:29 -0400
Content-Disposition: inline
In-Reply-To: <7vd2uxrdh7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218396>

[+cc Ingo and Jonathan, as this revisits the "open-code hashcmp" thread
     referenced below]

On Sun, Mar 17, 2013 at 01:13:56PM -0700, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > This env comes from jc/sha1-lookup in 2008 (merge commit e9f9d4f), 5
> > years ago. I wonder if it's good enough to turn on by default and keep
> > improving from there, or is it still experimental?
> 
> The algorithm has been used in production in other codepaths like
> patch-ids and replace-object, so correctness-wise it should be fine
> to turn it on.  I think nobody has bothered to benchmark with and
> without the environment to see if it is really worth the complexity.
> 
> It may be a good idea to try doing so, now you have noticed it ;-).

The only benchmarking I could find in the list archive (besides the ones
in the commit itself, showing little change, but fewer page faults) is:

  http://article.gmane.org/gmane.comp.version-control.git/123832

which actually indicates that GIT_USE_LOOKUP is slower (despite having
fewer page faults).

By the way, looking at that made me think for a few minutes about
hashcmp, and I was surprised to find that we use an open-coded
comparison loop. That dates back to this thread by Ingo:

  http://article.gmane.org/gmane.comp.version-control.git/172286

I could not replicate his benchmarks at all. In fact, my measurements
showed a slight slowdown with 1a812f3 (hashcmp(): inline memcmp() by
hand to optimize, 2011-04-28).

Here are my best-of-five numbers for running "git rev-list --objects
--all >/dev/null" on linux-2.6.git:

  [current master, compiled with -O2]
  real    0m45.612s
  user    0m45.140s
  sys     0m0.300s

  [current master, compiled with -O3 for comparison]
  real    0m45.588s
  user    0m45.088s
  sys     0m0.312s

  [revert 1a812f3 (i.e., go back to memcmp), -O2]
  real    0m44.358s
  user    0m43.876s
  sys     0m0.316s

  [open-code first byte, fall back to memcmp, -O2]
  real    0m43.963s
  user    0m43.568s
  sys     0m0.284s

I wonder why we get such different numbers. Ingo said his tests are on a
Nehalem CPU, as are mine (mine is an i7-840QM). I wonder if we should be
wrapping the optimization in an #ifdef, but I'm not sure which flag we
should be checking.

Note that I didn't run all of my measurements using "git gc" as Ingo
did, which I think conflates a lot of unrelated performance issues (like
writing out a packfile). The interesting bits for hashcmp in "gc" are
the "Counting objects" phase of pack-objects, and "git prune"
determining reachability. Those are both basically the same as "rev-list
--objects --all".

I did do a quick check of `git gc`, though, and it showed results that
matched my rev-lists above (i.e., a very slight speedup by going back to
memcmp).

-Peff
