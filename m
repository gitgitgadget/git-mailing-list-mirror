From: Jeff King <peff@peff.net>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Thu, 22 Sep 2011 16:58:56 -0400
Message-ID: <20110922205856.GA8563@sigill.intra.peff.net>
References: <4E7A3BDE.3040301@alum.mit.edu>
 <7vy5xh1whq.fsf@alter.siamese.dyndns.org>
 <4E7AF1AE.5030005@alum.mit.edu>
 <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com>
 <20110922171340.GA2934@sigill.intra.peff.net>
 <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 22:59:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6qMK-00066L-IQ
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 22:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab1IVU66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 16:58:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40986
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753908Ab1IVU66 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 16:58:58 -0400
Received: (qmail 11100 invoked by uid 107); 22 Sep 2011 21:03:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Sep 2011 17:03:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2011 16:58:56 -0400
Content-Disposition: inline
In-Reply-To: <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181918>

On Thu, Sep 22, 2011 at 02:41:42PM -0400, Jay Soffian wrote:

> attr.c says:
> 
>   a. built-in attributes
>   b. $(prefix)/etc/gitattributes unless GIT_ATTR_NOSYSTEM is set
>   c. core.attributesfile
>   d. per-directory .gitattributes
>   e. $GIT_DIR/info/attributes
> 
> The mechanics of (d) are established by git_attr_direction:
> 
>   GIT_ATTR_CHECKIN: working-copy, then index
>   GIT_ATTR_CHECKOUT: index, then working-copy
>   GIT_ATTR_INDEX: index-only

Thanks for hunting it down. I had been thinking that "attributes from
tree" would come either before or after (d) above, but the concept
really fits better into the second list (i.e., they're per-directory
attributes, it's just a matter of which set of directories).

> Where GIT_ATTR_CHECKIN is the default direction and GIT_ATTR_CHECKOUT
> is used while checking-out files from the index. (GIT_ATTR_INDEX is
> used only by git-archive.)

Hrm. But git archive works correctly in a bare repo with no index at
all. It looks like we just populate an in-core index and feed that to
git_attr_set_direction. Which is a bit suboptimal for something like
diff, which might not need to look at all parts of the tree (I guess it
is similarly suboptimal for archive with pathspecs).

But still, those are just performance considerations. We could use the
same trick for diff/log in a bare repo. I guess we'd end up refreshing
the index from each commit in a multi-commit log, which might be
noticeably slow.

> Consistent with that, when comparing two commits (diff-tree), I think
> you look at the .gitattributes in the second commit.

That makes some sense to me. As Junio pointed out, there is a catch with
"diff -R". In that case, I would still think you would use the "second"
commit, even though we're reversing the diff. So:

  git diff A B

would not be exactly equivalent to:

  git diff -R B A

in that the second would use attributes from "A" instead of "B".

However, I think this is skirting around a somewhat larger issue, which
is that gitattributes are sometimes about "this is what the file is like
at the current state of history", and sometimes about "this is what this
file is like throughout history".

For example, imagine I've got a repository of binary files. At some
point, I decide to use gitattributes to configure a textconv filter. In
my non-bare repo, when I do "git log" I get nice textconv'd diffs going
back through all of history. But if I push to a bare repo and try to do
a "git log" there, my attributes are ignored. So in this case, I like
that the working tree's attributes are applied retroactively, and I'd
like the bare repo to do the same.

Now consider a different example. I have a repo with a script "foo" that
contains perl code, and I add .gitattributes marking it as such (for
func headers, or maybe I have a magic external diff, or whatever[1]).
Later, I decide that I hate perl and rewrite it in python, updating
gitattributes. Now I _don't_ want the retroactive behavior. When I do a
"git log -p", I want to see the old commits with the perl script shown
using the perl attribute, not the python. But what the heck would it
mean to diff a recent python commit against an old perl one?

Even though we think of the diff attributes as "here's how you diff",
they are really "here are some annotations about the end points". So for
something like a textconv, you care about the attributes of _both_
sides of a diff, applying the attributes of the "from" tree to the paths
in that tree. Something like funcname is harder. I guess you'd probably
want to use the attributes from the "from" tree, since it is about
reporting context from the "from" side.

So the semantics really end up depending on the particular attribute.
Something like "-delta" exists more outside the history or the state of
a particular commit.

So I think doing it "right" would be a lot more complicated than just
reading the commits from a particular tree. I think it would mean adding
more context to all attribute lookups, and having each caller decide how
the results should be used.

However, retroactively applying attributes from the working tree, even
though it is sometimes wrong (e.g., we get the perl/python thing wrong
_now_ if you have a working tree), is often convenient in practice
(because otherwise you end up duplicating your per-directory
gitattributes in your info/attributes file), and rarely is it actually
wrong (because changing the type of a file without changing its path
isn't all that common).

So if the status quo with working trees (i.e., retroactively applying
the current gitattributes to past commits) is good enough, perhaps the
bare-repository solution should be modeled the same way? In other words,
should "git log -p" in a bare repo be looking for attributes not in the
commits being diffed, but rather in HEAD[2]?

That at least would make it consistent with the non-bare behavior. And
then if we want to move forward with making particular attributes more
aware of their context, we can do it in _both_ the bare and non-bare
cases.

-Peff

[1] The perl/python thing is probably not a huge deal, as funcnames are
    the most likely thing to configure. But you can imagine it would be
    much worse if some binary file changes formats, and you were using
    textconv. Or something with word-diff, perhaps.

[2] You can almost do this with:

      git show HEAD:.gitattributes >info/attributes
      git show commit-you-care-about
      rm info/attributes

    except that it won't handle any per-directory attributes files from
    subdirectories. So I think you'd want a "--attributes-from=HEAD"
    diff option or something similar.
