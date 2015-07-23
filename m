From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] receive-pack: crash when checking with non-exist HEAD
Date: Wed, 22 Jul 2015 22:58:18 -0700
Message-ID: <20150723055817.GA26794@peff.net>
References: <CANYiYbE3Vy_gtFMKTMw1wHLDhU758nXaJnKaNy6WMNRz0fjUnw@mail.gmail.com>
 <xmqqr3o0q6k7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 07:58:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZI9WU-0004g5-9C
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 07:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbbGWF6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 01:58:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:33935 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750702AbbGWF6V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 01:58:21 -0400
Received: (qmail 4120 invoked by uid 102); 23 Jul 2015 05:58:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jul 2015 00:58:21 -0500
Received: (qmail 9510 invoked by uid 107); 23 Jul 2015 05:58:25 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jul 2015 01:58:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jul 2015 22:58:18 -0700
Content-Disposition: inline
In-Reply-To: <xmqqr3o0q6k7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274479>

On Wed, Jul 22, 2015 at 01:30:00PM -0700, Junio C Hamano wrote:

> I see a similar "if head_name is NULL, don't bother." check in
> is_ref_checked_out() so in that sense this is a correct fix to the
> immediate problem.  That check came from 986e8239 (receive-pack:
> detect push to current branch of non-bare repo, 2008-11-08).

Yeah, I think this patch makes sense for the same reason as the check in
986e8239: if our HEAD ref does not point to a branch, we cannot possibly
be trying to delete it.

I do think the check is a little racy, though I'm not sure it is easy to
fix. E.g., imagine one client pushes to create refs/heads/master just as
somebody else is trying to delete it. I don't think this is much
different than the case where somebody redirects HEAD to
refs/heads/master as we are trying to delete it, though. The checks are
inherently racy because they are not done under locks (you would need to
lock both HEAD and refs/heads/master in that case). It's probably not a
big deal in practice.

> This is a tangent, but if HEAD points at an unborn branch that
> cannot be created, wouldn't all other things break?  
> 
> For example, in order to "git commit" from such a state to create
> the root commit on that branch, existing unrelated branches whose
> names collide with the branch must be removed, which would mean one
> of two things, either (1) you end up losing many unrelated work, or
> (2) the command refuses to work, not letting you to record the
> commit.  Neither is satisfactory, but we seem to choose (2), which
> is at least the safer of the two:
> 
>     $ git checkout master
>     $ git checkout --orphan master/1
>     $ git commit -m foo
>     fatal: cannot lock ref 'HEAD': 'refs/heads/master' exists;
>     cannot create 'refs/heads/master/1'

Yeah, that seems sensible. I think the "way out" for the user here would
presumably be:

  git symbolic-ref HEAD refs/heads/something-else

though of course they could also rename the other ref.

> We may want to avoid putting us in such a situation in the first
> place.  Giving "checkout --orphan" an extra check might be a simple
> small thing we can do, i.e.
> 
>     $ git checkout master
>     $ git checkout --orphan master/1
>     fatal: 'master' branch exists, cannot create 'master/1'
> 
> But I suspect it would not protect us from different avenues that
> can cause this kind of thing; e.g. to prevent this:
> 
>     $ git branch -D next
>     $ git checkout --orphan next/1
>     $ git fetch origin master:refs/heads/next
> 
> creation of a ref "refs/heads/next" here must notice HEAD points
> at "refs/heads/next/1" (that does not yet exist) and do something
> intelligent about it.

Right. You'd have to teach the is_refname_available() check to always
check what HEAD points to, and consider it as "taken", even if the ref
itself doesn't exist. But what about other symbolic refs? The
"refs/remotes/origin/HEAD" symref may point to
"refs/remotes/origin/master" even though "refs/remotes/origin/master/1"
exists. I doubt that will cause real problems in practice, but it points
out that special cases like "the value of HEAD is magic and reserved"
will later end up being insufficient as the code is extended.

I think I'd be willing to simply punt on the whole thing as being too
rare to come up in practice.

-Peff
