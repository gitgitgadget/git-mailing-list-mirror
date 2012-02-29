From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] am -3: allow nonstandard -p<num> option
Date: Wed, 29 Feb 2012 02:27:42 -0500
Message-ID: <20120229072742.GA11896@sigill.intra.peff.net>
References: <1330471495-12013-1-git-send-email-gitster@pobox.com>
 <1330471495-12013-2-git-send-email-gitster@pobox.com>
 <20120229025842.GA3585@sigill.intra.peff.net>
 <7vvcmqwbto.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 08:27:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2dx1-0002Or-Bw
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 08:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030801Ab2B2H1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 02:27:46 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60953
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030751Ab2B2H1p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 02:27:45 -0500
Received: (qmail 19762 invoked by uid 107); 29 Feb 2012 07:27:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Feb 2012 02:27:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Feb 2012 02:27:42 -0500
Content-Disposition: inline
In-Reply-To: <7vvcmqwbto.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191812>

On Tue, Feb 28, 2012 at 07:36:03PM -0800, Junio C Hamano wrote:

> > $git_apply_opt can have other stuff in it, too (from my cursory reading,
> > it looks like --whitespace, --directory, --exclude, -C, --reject,
> > --ignore-whitespace, and --ignore-space-change).  Those options are now
> > passed, too.
> >
> > Naively, I don't think it should be a problem. Many of them will do
> > nothing (because the patch _should_ apply cleanly to the blobs it
> > mentions). Some seem like an obvious improvement (e.g., "--directory"
> > should be just as necessary as "-p", I would think). For something like
> > "--whitespace=error", I would think we would have errored out already
> > when we first tried to apply the patch. Or maybe not. I didn't test.
> 
> An honest answer is that I didn't think deeply if they matter ;-).

I figured. But once in a while it is good to hold you to the same
standard that we do of other contributors. :)

> Certainly we would want to honor the original settings for whitespace
> errors by propagating the option, so that we would reject or adjust when
> synthesizing the fake ancestor tree the same way as we deal with them when
> apply the patch for real.

I did a quick test, and yes, your patch is an improvement for the other
options, too. Though it's still not perfect. My test was:

  # make a repo with a simple file
  git init -q repo && cd repo &&
  perl -le 'print for(1..10)' >foo && git add foo && git commit -qm base &&

  # now make a whitespace-damaged patch
  sed -i 's/3/trailing whitespace  /' foo && git commit -qam ws &&
  git format-patch -1 --stdout >patch &&
  git reset -q --hard HEAD^ &&

  # now make a change that needs a 3-way merge
  sed -i 's/5/conflicting context/' foo && git commit -qam conflict &&

  # and then apply our patch with 3-way fallback, erroring out on
  # whitespace
  git am --whitespace=error -3 patch

which does indeed apply the patch with the wrong whitespace settings.
With your patch, it correctly refuses to apply. Though the output is:

  Applying: ws
  /home/peff/foo/am/repo/.git/rebase-apply/patch:13: trailing whitespace.
  trailing whitespace  
  fatal: 1 line adds whitespace errors.
  Repository lacks necessary blobs to fall back on 3-way merge.
  Cannot fall back to three-way merge.
  Patch failed at 0001 ws

which is misleading. We do not lack the necessary blobs, but rather
git-apply failed for a different reason. However, git-apply doesn't
differentiate the situations by exit code, so git-am is left to guess.

So I think the unintended side effects of your patch are likely to be a
good thing and fix bugs. Possibly the commit message should explain
that, but as it is already in next, I'm content to leave this thread in
the list archive as a footnote.

We could assign a special exit code to git-apply to allow git-am to
produce a better error message. I don't know if it's worth the effort.

-Peff
