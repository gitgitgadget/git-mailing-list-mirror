From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 00:11:23 -0400
Message-ID: <20120522041123.GA9972@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
 <20120521174525.GA22643@sigill.intra.peff.net>
 <20120521221417.GA22664@sigill.intra.peff.net>
 <20120521235219.GA5589@sigill.intra.peff.net>
 <4FBB0F21.5080608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 22 06:11:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWgRX-0000Xo-AG
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 06:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815Ab2EVEL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 00:11:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51410
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733Ab2EVEL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 00:11:26 -0400
Received: (qmail 11877 invoked by uid 107); 22 May 2012 04:11:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 00:11:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 00:11:23 -0400
Content-Disposition: inline
In-Reply-To: <4FBB0F21.5080608@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198166>

On Tue, May 22, 2012 at 05:59:29AM +0200, Michael Haggerty wrote:

> >Try doing "git fetch . refs/*:refs/*" in a repository with a large
> >number of refs (e.g., 400K). With git v1.7.10, this takes about 9.5s on
> >my machine. But using the version of git in "next" takes about 16.5s.
> >Bisection points to your 432ad41 (refs: store references hierarchically,
> >2012-04-10). Perf shows sort_ref_dir and msort_with_tmp as hot spots.
> 
> I'm looking into this.
> 
> For your test, were the 400k references all in one "directory", or
> were they sharded somehow?

Sharded. This was the rails network repo, so it basically looks like
this:

  refs/remotes/XXXXXXX/heads/master
  refs/remotes/XXXXXXX/tags/v1.0
  refs/remotes/XXXXXXX/tags/v1.1
  ...
  refs/remotes/XXXXXXX/tags/v3.5
  refs/remotes/YYYYYYY/heads/master
  refs/remotes/YYYYYYY/tags/v1.0
  refs/remotes/YYYYYYY/tags/v1.1
  ...

Basically the same 90 or so refs you would have in a normal repository
(a branch or two, and a bunch of tags), repeated over and over under
numbered remote hierarchies (i.e., each remote is basically a copy of
the refs from somebody's fork of the repo).

I can provide you with the exact repo if you want, but it is about 100M.

Interestingly, I don't seem to get nearly as much slow-down in my "fake"
many-refs repo, which has all 100K entries directly in refs/heads.

-Peff
