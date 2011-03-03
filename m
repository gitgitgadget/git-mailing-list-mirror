From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git blame-tree
Date: Thu, 3 Mar 2011 10:36:48 -0500
Message-ID: <20110303153647.GE1074@sigill.intra.peff.net>
References: <20110302164031.GA18233@sigill.intra.peff.net>
 <20110302171653.GA18957@sigill.intra.peff.net>
 <7vbp1tcr25.fsf@alter.siamese.dyndns.org>
 <20110302210434.GB20400@sigill.intra.peff.net>
 <7v39n5az15.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 16:36:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvAaI-0005gm-G7
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 16:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758373Ab1CCPgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 10:36:53 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49585 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758345Ab1CCPgw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 10:36:52 -0500
Received: (qmail 27948 invoked by uid 111); 3 Mar 2011 15:36:49 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 03 Mar 2011 15:36:49 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Mar 2011 10:36:48 -0500
Content-Disposition: inline
In-Reply-To: <7v39n5az15.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168397>

On Wed, Mar 02, 2011 at 03:22:14PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > With sensible semantics, we can turn off --no-merges and still get good
> > results. And anybody who cares for something different can use
> > --no-merges themselves. Though I expect the opposite to be the case; I
> > can imagine somebody wanting --first-parent to blame files only to
> > merges.  I'll have to make sure that works properly in my re-roll.
> 
> I still do not understand why anybody would even want to say --no-merges.

Originally, because my merge semantics were crap. But what I was saying
here was "if, for whatever reason, somebody decided that --no-merges,
they can still do it". So I don't know why. My point was we can safely
drop the automatic no-merges as junk.

> > I was thinking something like:
> >
> >   git blame-tree dir branch1 branch2
> >
> > where branch2 is actually _ahead_ of branch1. We take the file list from
> > branch1, but may blame commits on branch2. It's probably a little bit of
> > a crazy thing to ask for, though.
> 
> To be compatible with all the git commands, the order of parameters should
> be revs first and then pathspec, i.e. "git blame-tree branch1 branch2 dir".
> But that is a tangent.

Yeah, agreed (for some reason when I wrote the original patch, I had the
brain-dead idea that I was matching blame. But obviously that is not the
case).

> Again, the same "what does that mean" applies.

Assuming we switched it, we have:

  git blame-tree branch1 branch2 -- dir

And no, I don't know what that means. My question was what should we do
with it? I think your answer is "complain if rev.pending.nr != 1", and
that sounds sensible to me.

One other possible answer is to take the union of the trees of each
revision listed on the command line. Then you could do something like
"git blame-tree --all -- path", and see all files in all trees. But I
don't really see how that is a particularly useful output, so I'd just
as soon disallow it for now.

> But that doesn't change my question.  Why are you taking a single
> directory and doing "ls-tree $endpoint $that_directory" to populate the
> set of paths to find who touched them last, instead of using the args as
> regular pathspecs and running "ls-tree $endpoint -- net include/net" to
> populate the set?

Because my initial attempt was bolted onto ls-tree before I realized
that what I really wanted was blame-tree, and this historical crap
survived from an earlier iteration. I think what you are suggesting is
much better.

> As I said already, it does not make any sense to have more than one
> endpoint to begin with when you are asking "what is the last one that
> touched things", and that also applies to the regular blame, which I think
> already has a logic to make sure you have only one positive commit in the
> starting rev list.

Yeah, agreed.

> > ... When net/subdir/foo.c changes, we do care, we just say
> > "net/subdir" changed.
> 
> I think you would want diff-tree with or without -r then.  I suspect
> people may want to pass --recursive to this command.

Yeah, I am coming to that conclusion the more I think about it.

> ... which may probably be helped by limiting the recursion of that diff
> with pathspec, but I realize that you are not by default running recursive
> diff, so...

Yes, I definitely didn't want recursion. But clearly that is an obvious
option for people to want, and we should support it. So the code needs
to be structured to handle both cases.

Partially I was blinded in my initial effort by trying to make it as
fast and simple as possible for one specific case. But I think we can
get good performance results using the more traditional traversal and
diff machinery, and have a lot more options, too. My rewrite will be
based around that.

Thanks for the comments.

-Peff
