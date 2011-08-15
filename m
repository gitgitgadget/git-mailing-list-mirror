From: Jeff King <peff@peff.net>
Subject: Re: "git apply --check" successes but git am says "does not match
 index"
Date: Mon, 15 Aug 2011 16:23:18 -0700
Message-ID: <20110815232318.GA4699@sigill.intra.peff.net>
References: <loom.20110814T113311-277@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Zemacsh <ruini.xue@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 01:23:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt6VD-0004AV-8r
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 01:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab1HOXXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 19:23:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33191
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205Ab1HOXXV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 19:23:21 -0400
Received: (qmail 30252 invoked by uid 107); 15 Aug 2011 23:24:00 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Aug 2011 19:24:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2011 16:23:18 -0700
Content-Disposition: inline
In-Reply-To: <loom.20110814T113311-277@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179395>

On Sun, Aug 14, 2011 at 09:36:30AM +0000, Zemacsh wrote:

> Before applying a mbox patch, "git apply --check" reports OK. Then, I run 'git 
> am', however, it complains "does not match index". Actually, both working tree 
> and index are clean. what might be the problem?
> 
> If I run "git am --abort" now, and re-turn "git am". To my surprise, everything 
> goes well.

Hmm. I don't think this has anything to do with the "apply --check". But
rather the problem is that "git am" doesn't ever refresh the index. For
example:

  git init repo &&
  cd repo &&
  echo one >file && git add . && git commit -m one &&
  echo two >file && git add . && git commit -m two &&
  git format-patch -1 --stdout >patch &&
  git reset --hard HEAD^ &&
  sleep 1 &&
  touch file &&
  git am patch

This fails with:

  Applying: two
  error: file: does not match index
  Patch failed at 0001 two

Running "git am --abort" resets the index, which freshens it, and then a
further "git am" works:

  $ git am --abort
  $ git am patch
  Applying: two

We should perhaps call "update-index --refresh" at the start to avoid
these sorts of false positives. Probably it should happen whenever we
"git am --continue", as well. But for efficiency reasons, not between
each patch.

I dunno. Do people want to call "git am" in a tight loop, where the
index refresh would be a problem? I would think they should instead feed
a whole mbox in one go.

-Peff
