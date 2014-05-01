From: Jeff King <peff@peff.net>
Subject: Re: [RFD] use approxidate for "git commit --date=xyz"?
Date: Thu, 1 May 2014 18:06:39 -0400
Message-ID: <20140501220639.GD14441@sigill.intra.peff.net>
References: <CA+55aFx=LizEyS6hq=av_qwRZuu_q3xPSXO-Jr4CAfXqaAuUtA@mail.gmail.com>
 <xmqq1tweec1o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 00:06:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfz7v-0006FB-R1
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 00:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbaEAWGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 18:06:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:43145 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751887AbaEAWGm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 18:06:42 -0400
Received: (qmail 18537 invoked by uid 102); 1 May 2014 22:06:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 May 2014 17:06:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2014 18:06:39 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tweec1o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247887>

On Wed, Apr 30, 2014 at 02:34:59PM -0700, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > I just got a comment saying that
> >
> >     git commit --amend --date=now
> >
> > doesn't work. I replied that you can use
> >
> >    --date="$(date)"
> 
> Offhand without double-checking the actual codepath I do not have
> objection against approxidate-careful.

This has come up a few times on the list, but nobody ever produced a
patch. To quote myself[1]:

> I think the original rationale was that it's OK for us to allow some
> sloppiness when _viewing_ commits, since you will generally notice the
> problem. But when making commits, it's better to be careful, since you
> may be setting the sha1 in stone.
> 
> These days we have two tools that could help:
> 
>   1. approxidate_careful will do a regular approxidate, but keep track
>   of whether we found anything even remotely useful. That doesn't mean
>   you can't still get unexpected results, but at least some truly
>   useless cases return errors.
> 
>   2. For commits with a different author and committer, we mention the
>   author name in the post-commit summary. We could do the same with a
>   timestamp that was given (i.e., mentioning it in a standard format)
>   to give the user another opportunity to double-check what we parsed.

I think it would make sense if we followed both of those points.

Should we also loosen $GIT_AUTHOR_DATE? I'd prefer not to, as that is
not typically fed by the users themselves, but rather by scripts, and
being robust there may be more valuable.

> But why does the workflow need --date=now in the first place?
> Wouldn't --reset-author do what you want better?  What is the
> situation where you want to say that this patch has been changed
> significantly enough from the original to label it with the current
> timestamp without taking the authorship?

In some of the instances on the list, the user simply didn't know that
--reset-author would do the trick. And I do think it's slightly
unintuitive.

However, the original rationale for "--date" was to back-date
commits[2], so even though there is an equivalent for "--date=now", it
might be nice to support "--date=2.days.ago".

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/168596

[2] http://article.gmane.org/gmane.comp.version-control.git/134406
