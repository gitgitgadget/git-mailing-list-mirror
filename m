From: Jeff King <peff@peff.net>
Subject: Re: git 2.2.x: Unexpected, overstrict file permissions after "git
 update-server-info"
Date: Tue, 6 Jan 2015 14:37:42 -0500
Message-ID: <20150106193742.GA28440@peff.net>
References: <20150105210724.032e9718@x230>
 <20150106034702.GA11503@peff.net>
 <xmqqd26sql0v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Sokolovsky <paul.sokolovsky@linaro.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:38:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Zwt-0003To-3a
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 20:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756463AbbAFThq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 14:37:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:59636 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756299AbbAFThp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 14:37:45 -0500
Received: (qmail 12519 invoked by uid 102); 6 Jan 2015 19:37:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jan 2015 13:37:45 -0600
Received: (qmail 12850 invoked by uid 107); 6 Jan 2015 19:38:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jan 2015 14:38:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jan 2015 14:37:42 -0500
Content-Disposition: inline
In-Reply-To: <xmqqd26sql0v.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262094>

On Tue, Jan 06, 2015 at 02:08:16AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, I didn't consider the mode impact of using mkstemp. That is
> > definitely a regression that should be fixed. Though of course if you
> > really do want 0644, you should set your umask to 0022. :)
> > ...
> > If you haven't set core.sharedrepository, then adjust_shared_perm is a
> > noop. But you shouldn't have to do that. Git should just respect your
> > umask in this case.
> 
> Thanks for a nicely done patch series, but I am not sure if I agree
> with the analysis and its conclusion.
> 
> If adjust_shared_perm is a no-op, how do we ensure that other files
> that need to be served by a dumb HTTP server are readable by it?  Is
> it because we just happen not to use mkstemp() to create them (and
> also is it because the pushers do not have umask 007 or stronger to
> prevent files from being read by the HTTP server user)?

I think there are two things at play here.

One is that we accidentally tightened the permissions on the info/*
files, and that is a regression that should be fixed regardless. So the
patch series is doing the right thing, even if the commit message is up
for debate. And I think you agree with that, from what you've written.

As for "should it work", I would tend to say yes. As long as "work" is
"respect your umask". Git has no reason to do anything other than "0666
& umask"[1] when creating new files. The umask is the traditional way to
configure the permissions on files you create, and git should follow it,
unless it happens to know a particular file is sensitive (and I cannot
really think of any that are, aside from a few related to credential
storage).

So if you do not have "0004" in your umask, everything git creates should
be world-readable, and other users should be able to access it.

Grepping around, there are a few other calls to mkstemp (and not
mkstemp_mode). But they are all for true temporary files (which will be
read by subprocesses of the current process), and not files which we
expect to live on in the repo. So I think we are mostly following that
rule already.

There are a couple spots where we use 0600 explicitly, for no good
reason (e.g., some BISECT_* files, which I guess might be left in the
filesystem for later processes to read).

[1] We actually use 0444 for object and packfile creation, but I think
    that still follows the same line of reasoning.

> Is our goal here to give the users this statement?
> 
>     For shared repository served by dumb HTTP and written by users
>     who are different from the user that runs the HTTP server, you
>     need to do nothing special.

No, I don't think so. We should follow the umask, and in most cases that
will just work for serving by another user (and if it _doesn't_, then
perhaps it is because the user with the draconian umask _wanted_ to
prevent other people, including the http user, from reading it).

And as you noted, if you want to override that umask, we already have
core.sharedrepository.

So maybe my commit message overstated things. And it should just say "we
should be respecting the umask, because setting a permissive umask is
enough to make dumb http work, and we broke that".

> It feels to me that the old set-up were "working" by accident, not
> by design (I may be mistaken--so correct me if that were the case).

I do not think it was consciously designed as part of git, but rather
that general good taste and fitting in with Unix traditions made it
work. We follow the umask, and the umask is typically enough to make it
work.

> And if that is the case, I do not think it is a good idea to try to
> hide the broken configuration under the rug longer.  "As long as
> everybody writes world-readable files, you do not have to do
> anything" will break when the next person with 0xx7 umask setting
> pushes, no?

Yes, but it will be the fault of the person with the 0xx7 umask. ;)

-Peff
