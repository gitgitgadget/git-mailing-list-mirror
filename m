From: Jeff King <peff@peff.net>
Subject: Re: Git log follow question
Date: Wed, 26 May 2010 01:58:23 -0400
Message-ID: <20100526055823.GA30409@coredump.intra.peff.net>
References: <006d01caf300$703e96a0$50bbc3e0$@burgmann.anu.edu.au>
 <20100514043704.GC6075@coredump.intra.peff.net>
 <alpine.LFD.2.00.1005140730030.3711@i5.linux-foundation.org>
 <20100525093140.GA32460@coredump.intra.peff.net>
 <alpine.LFD.2.00.1005251141580.3689@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Albert Krawczyk <albert@burgmann.anu.edu.au>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 26 07:58:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9dP-0001kQ-L0
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769Ab0EZF61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 01:58:27 -0400
Received: from peff.net ([208.65.91.99]:58894 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443Ab0EZF60 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 01:58:26 -0400
Received: (qmail 30328 invoked by uid 107); 26 May 2010 05:58:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 26 May 2010 01:58:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 May 2010 01:58:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005251141580.3689@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147747>

On Tue, May 25, 2010 at 11:49:25AM -0700, Linus Torvalds wrote:

> On Tue, 25 May 2010, Jeff King wrote:
> > 
> > Thanks for the input. I took a look at it myself and it is a bit more
> > complex than just turning on pruning. I have a prototype --follow that
> > handles arbitrary pathspecs instead of single files; instead of
> > replacing the single-file pathspec, it just widens the pathspec as it
> > traverses history.
> 
> Doing it "right" is actually a _lot_ more complex than that.

Did you mean doing history rewriting right is more complex than that, or
did you mean that handling multiple follow pathspecs is more complex
than pathspec-widening (where "handling multiple pathspecs" means making
"--follow subdir" work about as well as "--follow file", but not
actually doing real history rewriting)?

If the former, I agree.

If the latter, I am not sure it is any worse than the single-file follow
case.

For example, consider this history:

  echo content >file && git add . && git commit -m base
  git mv file new && git commit -m moved
  sleep 1 ;# to ensure timestamp difference
  git checkout -b other HEAD^
  echo changes >>file && git commit -a -m changes
  git merge master

We'll traverse in this order:

  merge
  changes (to file)
  moved (from file to new)
  base (create file)

If I do "git log --follow new" with the current master, I will see only
"moved" and "base". I don't see "changes" because it operates on "file",
not "new". But if we reverse the order in which the two branches'
commits were made, then we will parse "moved" first, and we _will_ see
"changes", because we've updated our pathspec. So it matters when we
traverse the rename.

For "base" and everything prior to it, in general we will already have
traversed the rename because we try to do things in date order. But in
the face of clock skew, it is possible to follow the ancestry down
before hitting a rename on another branch.

So my point is that even with the current --follow, there are already
corner cases where traversal order matters. Which is maybe the point you
were trying to make, too, but I was unclear from your example if you
meant that the problem was _worse_ with simple expansion of pathspecs
(i.e., not actually turning on revs->prune) than the current --follow.

-Peff
