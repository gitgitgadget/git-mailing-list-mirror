From: Jeff King <peff@peff.net>
Subject: Re: Newbie / git / gitosis question
Date: Wed, 26 Aug 2009 11:56:01 -0400
Message-ID: <20090826155601.GB32741@coredump.intra.peff.net>
References: <26ae428a0908260227k7ac6aeden9a4eae7ee95d4d45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Wed Aug 26 17:56:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgKr7-0006Ka-Fa
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 17:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbZHZP4C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 11:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbZHZP4C
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 11:56:02 -0400
Received: from peff.net ([208.65.91.99]:51626 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbZHZP4A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 11:56:00 -0400
Received: (qmail 23457 invoked by uid 107); 26 Aug 2009 15:56:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 26 Aug 2009 11:56:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Aug 2009 11:56:01 -0400
Content-Disposition: inline
In-Reply-To: <26ae428a0908260227k7ac6aeden9a4eae7ee95d4d45@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127104>

On Wed, Aug 26, 2009 at 10:27:30AM +0100, Howard Miller wrote:

> I've been working away at Gitosis and it's mostly fair enough but
> there's one bit that's unclear to me...
> 
> git push origin master:refs/heads/master
> 
> Would somebody kindly explain (or point to docs) what
> refs/heads/master means? How is this different from just 'git push
> origin master' or even 'git push origin master:master'?

I'll try to explain.

Refs are pointers to commits. In other words, you can think of
"refs/heads/master" as a key pointing to a SHA-1 commit id. The long-ish
name divides up the namespace for refs.

There are a few special refs that live outside of the refs/ hierarchy,
like HEAD, FETCH_HEAD, MERGE_HEAD, ORIG_HEAD, etc. Normal refs are
generally under refs/.

The refs/heads/ hierarchy is for branches (they are the "head" of a line
of development). The refs/tags hierarchy is for tags. The refs/remotes
hierarchy is where we store our local idea of where remote repositories'
branches point.

Pushing (and fetching) take a "refspec": two refs, a source and
destination, separated by a colon. So "git push foo:bar" means "look up
my local ref 'foo' and update or create the remote ref 'bar' with the
same commit".

Every ref has a "full name" that is much longer than what we often
see. We can generally abbreviate because one of the following applies:

  1. We are specifying a name to look up, and there is a set of lookup
     rules. For example, the name "master" will be considered as a tag,
     and then as a branch, and then as a remote branch.

     The lookup rules are described in "git help rev-parse" under the
     section "Specifying Revisions".

  2. We are using a name in a context that expects a particular type.
     For example, "git branch foo" knows that "foo" is a new branch
     name, and so will create the ref as refs/heads/foo. Similarly "git
     tag foo" will create refs/tags/foo.

  3. We can infer the type from the other half of a refspec. For
     example, given a local branch "master" and a tag "v1.0" (and
     neither currently existing on the remote side), we can do:

       git push origin master:master v1.0:v1.0

     and we know that the "master" we create on the remote will be a
     branch, because the local "master" is a branch, and similarly the
     "v1.0" we create on the remote will be a tag because the local
     "v1.0" is a tag.

And finally, "git push" knows a shorthand for refspecs: a refspec
without a colon is treated as having the same string on both sides. So
"master" is really a shortcut for "master:master".

Knowing all of that, let's look at your examples:

  A. git push origin master

     This is really a syntactic shortcut for "git push origin
     master:master".

  B. git push origin master:master

     The left-hand side of the refspec is looked up locally. In this
     case, it is probably going to be "refs/heads/master". The right-hand
     side is looked up on the remote. If it exists (i.e., you are
     updating your branch), it is probably "refs/heads/master".

     If it doesn't exist on the remote (i.e., you are pushing a new
     branch), then we can infer from the prefix of the left-hand side
     that the right-hand side should also be a branch (i.e., under
     "refs/heads/").

     So assuming "master" is a branch, this is really equivalent to:

       git push origin refs/heads/master:refs/heads/master

  C. git push origin master:refs/heads/master

     If you understood the explanation for (B) above, you will know that
     this is again basically the same thing. :)

     However, note that in (B), if the branch is being created on the
     remote, we rely on the "refspec inference" rule described earlier.
     This behavior was adopted in git in v1.5.5.2 (commit f8aae120,
     2008-04-23). So you may still see examples that pre-date this
     feature and recommend using the full ref-name, which should no
     longer be necessary.

Hope that helps. Let me know if you need clarification on any of the
above.

-Peff
