From: Jeff King <peff@peff.net>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Wed, 9 Feb 2011 18:46:21 -0500
Message-ID: <20110209234621.GA12575@sigill.intra.peff.net>
References: <20110206051333.GA3458@sigill.intra.peff.net>
 <4D4EF7E4.7050303@hartwork.org>
 <vpq1v3kopn3.fsf@bauges.imag.fr>
 <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
 <20110207055314.GA5511@sigill.intra.peff.net>
 <7vhbcguytf.fsf@alter.siamese.dyndns.org>
 <20110207195035.GA13461@sigill.intra.peff.net>
 <20110208100518.GA9505@neumann>
 <20110209210312.GB2083@sigill.intra.peff.net>
 <7vipwsomq8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 00:46:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnJk2-00018l-DU
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 00:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021Ab1BIXq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 18:46:29 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60992 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754261Ab1BIXq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 18:46:29 -0500
Received: (qmail 13515 invoked by uid 111); 9 Feb 2011 23:46:26 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 09 Feb 2011 23:46:26 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Feb 2011 18:46:21 -0500
Content-Disposition: inline
In-Reply-To: <7vipwsomq8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166457>

On Wed, Feb 09, 2011 at 02:40:47PM -0800, Junio C Hamano wrote:

> > The most compelling I have seen is "you tend to notice accidental
> > full-tree sooner than accidental relative behavior". Which you mentioned
> > in your email.
> 
> Hmph.  You earlier mentioned "oops, I just pushed this commit and it turns
> out that I screwed up "git add" five minutes ago and it only had half of
> the files I intended" problem, but "oops, I just pushed this commit and it
> turns out that I screwed up "git add" five minutes ago and it had more
> changes than I intended" problem would be equally annoying, and I don't
> think one is inherently more likely to be noticed than the other; IOW, it
> is not compelling, but is just an arbitrary and a biased observation, no?

Yeah, thinking on it more, it is not so much that you notice sooner[1],
as the behavior may be less destructive when you do notice. That is,
accidentally adding too much has put things into the object db.
Accidentally not adding enough means your changes are susceptible to
"git reset --hard" or other destructive actions.

[1] I seem to remember this argument about noticing sooner coming up in
previous discussions, and so I was taking it for granted. But thinking
on it, I can't really come up with a solid reason why one might notice
errors sooner in full tree rather than relative behavior.

> Can somebody volunteer to come up with a comprehensive list of operations
> that will change their behaviour when we switch to "full-tree without
> pathspec" semantics?  We mentioned "grep" and "add -u" already.

I went through the whole list of "git help -a" and considered each
command. Quite a few don't take pathspecs, or would be very odd to be
not full-tree (e.g., read-tree reads the whole tree, not just some
subset based on where you are in the project. Anything else would be
kind of insane). I omitted those. If you don't see something in this
list, it's either because I thought it was irrelevant, or I just missed
it going through the list; feel free to mention more.

I think everything which takes a pathspec takes it relative to the
current directory. So we are really just considering the behavior when
_no_ pathspecs are provided.

The current behavior is:

  add:    error (and suggest "git add .")
  add -u: relative
  add -A: relative
  add -i: full-tree
  add -p: full-tree
  archive: relative
  checkout: full-tree (e.g., "git checkout -f")[1]
  checkout-index: n/a (only checks out arguments)
  clean: relative
  commit -a: full-tree[2]
  diff: full-tree
  diff-files: full-tree
  grep: relative
  ls-files: relative
  ls-tree: relative[3]
  status: shows full-tree, relative by default, absolute
          with status.relativePaths
  reset --hard: full-tree[4]
  log/show/etc: full-tree[5]
  blame: error[6]

Notes:

[1] checkout being full-tree without pathspecs is mostly due to "git
    checkout" meaning "switch to this branch" and not "checkout some part of
    the index". So naturally it is a full-tree operation.

[2] The inconsistency in "git commit -a" versus "git add -u" is to me
    one of the worst, as I think it is a useful mental model to think of
    "commit -a" as "add -u; commit".

[3] I can understand ls-files being relative, though I don't agree with
    it. But ls-tree looking at a relative subset of the tree is just
    insane (you were the one who pointed this out to me last time this
    subject came up, too).

[4] I think reset --hard is just a tree operation, since it is "set HEAD
    to this ref, check it out into the index, _and_ reset the worktree
    to match". So obviously it should be full-tree. But I think a common
    mental model, especially when resetting to HEAD implicitly, is that
    it is about "reset my working tree to the HEAD state". So I included
    it in this list.

[5] Revision traversal is not about the worktree at all, so it has
    always been about the full project. I don't think there's any
    argument there, but I put it in the list as a contrast to ls-tree,
    to which the same argument should apply.

[6] Blame obviously does nothing without a path right now. In theory it
    could eventually grow whole-directory blame. In that case, I would
    expect it to be full-tree (and "git blame ." would do what you
    want).

Assuming we move from relative to full-tree, I think the possible things
to move are:

  add -u/-A
  archive
  grep
  clean
  ls-files/ls-tree

I don't think it's worth moving ls-files/ls-tree. They're plumbing that
people don't use frequently. So the cost of moving them is high (because
we are breaking something meant to be scriptable) and the benefit is low
(because users don't type them a lot).

Obviously add and grep are the two that people have talked about. The
archive behavior surprised me, and I would think it should be full-tree
by default. But it is sort of plumbing-ish, in that people have probably
scripted around and people _don't_ tend to create archives a lot. So it
may fall into the same category as ls-files/ls-tree.

That leaves clean. I would say from a consistency standpoint that it
should go full-tree to match the other commands. But it is one of the
most destructive commands, and making it full-tree makes it easier to
accidentally delete, instead of accidentally fail to delete. So that
makes me hesitate to switch it to full-tree behavior (though a "clean
reflog" would be a pretty cool feature in general).

So depending on your view of the above, it may just be "add -u/-A" and
"grep" that are worth switching.

-Peff
