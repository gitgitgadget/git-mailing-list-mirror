From: Jeff King <peff@peff.net>
Subject: Re: help reverting a merge
Date: Mon, 30 Nov 2009 03:13:15 -0500
Message-ID: <20091130081315.GA587@coredump.intra.peff.net>
References: <dd18b0c30911291524q7ea7e9c7v980340ddf7269519@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Justin Mattock <justinmattock@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 09:13:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF1Nq-0005T6-1n
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 09:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbZK3INI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 03:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbZK3INI
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 03:13:08 -0500
Received: from peff.net ([208.65.91.99]:34390 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429AbZK3INH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 03:13:07 -0500
Received: (qmail 10687 invoked by uid 107); 30 Nov 2009 08:17:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 30 Nov 2009 03:17:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Nov 2009 03:13:15 -0500
Content-Disposition: inline
In-Reply-To: <dd18b0c30911291524q7ea7e9c7v980340ddf7269519@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134079>

On Sun, Nov 29, 2009 at 03:24:09PM -0800, Justin Mattock wrote:

> I've done a bisect on a problem with the kernel,
> and am a bit confused on what to do. i.g. the
> results are showing this:
> a03fdb7612874834d6847107198712d18b5242c7 is the first bad commit
>
> [...]
> 
> how do I find out the commits in this merge to automatically
> revert to find the problem that's causing this bug?

There is some discussion here:

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#bisect-merges

Basically neither merged branch was buggy on its own, but together they
have a bug.  You can try rebasing the two sides of the merge into a
linear history, and then bisecting on that:

  # order doesn't matter here, but rebasing 12e0933 on top makes more
  # sense since it has many fewer commits between it and the merge-base
  # (and you'll need to fix up conflicts manually, so the smaller the
  # rebase the better)
  git checkout 12e0933
  git rebase 202c467

  # to be safe, confirm that the rebase result shows your bug;
  # we know that 202c467 doesn't have the bug, or we would not have
  # bisected to the merge commit before
  test test test
  git bisect start
  git bisect bad HEAD
  git bisect good 202c467

which should give you the specific commit on the side branch where the
breakage occurred.

This has been discussed as a technique before, and I have a feeling in
the back of my mind that maybe there was talk of having git-bisect help
with this case, but I don't think anything ever came of it. Christian
(cc'd) would probably know more.

-Peff
