From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] start_command(), if .in/.out > 0, closes file descriptors, not the callers
Date: Sun, 17 Feb 2008 02:42:52 -0500
Message-ID: <20080217074252.GO24004@spearce.org>
References: <7v1w7dhnov.fsf@gitster.siamese.dyndns.org> <1203183399-4813-1-git-send-email-johannes.sixt@telecom.at> <1203183399-4813-2-git-send-email-johannes.sixt@telecom.at> <7vmyq07bqe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 08:43:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQeBP-000548-6Z
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 08:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbYBQHm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 02:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbYBQHm5
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 02:42:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48466 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbYBQHm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 02:42:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JQeAm-0006yk-Ex; Sun, 17 Feb 2008 02:42:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5486E20FBAE; Sun, 17 Feb 2008 02:42:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vmyq07bqe.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74098>

Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> 
> These two patches make the calling convention more uniform and
> it feels like a good clean-up of the semantics.
...
> > diff --git a/run-command.h b/run-command.h
> > index e9c84d0..0e67472 100644
> > --- a/run-command.h
> > +++ b/run-command.h
> > @@ -14,6 +14,23 @@ enum {
> >  struct child_process {
> >  	const char **argv;
> >  	pid_t pid;
> > +	/*
> > +	 * Using .in, .out, .err:
> > +	 * - Specify 0 to inherit stdin, stdout, stderr from parent.
> 
> Wouldn't this be better if 0, 1, or 2 specify inheriting
> these respectively?
> 
> I am confused...

Using 0 to inherit stdin/stdout/stderr makes it easy for callers
of run_command() to setup something like this:

	struct child_process p;
	memset(&p, 0, sizeof(p));
	p.git_cmd = 1;
	p.argv = args;
	run_command(&p);

and have the child inherit stdin/stdout/stderr automatically,
much as a fork() automatically inherits those into the child
process.

So I agree with keeping 0 for inheriting, rather than needing to set
"p.in = 0; p.out = 1; p.err = 2".  We don't always need (or want)
the redirection service.

I think its OK (although maybe somewhat crazy) for the caller to
set "p.in = 1" and thus ask start_command() to close(1) before
it returns.

What happens if the parent has already closed fds 1 and 2 but then
opens a network socket somewhere and wants that socket to be stdin
of the child?  Its at fd 1.  But the parent doesn't want to track
that fd either, she wants it to go into the child and only the child.
So it seems reasonable to make this the "give away" case, and that's
what it always had been.

Of course the same argument can be said for fd 0; if the parent does
close(0) before some other open/socket/pipe call then its obviously
possible for the parent to get a fd that it wants the child to take
over and close.

We're basically assuming that the parent will always keep its
own stdin open if it will be spawning children.  We all know what
happens when we assume (we double close file descriptors) but I
think its a reasonable safe assumption to be making.
 
-- 
Shawn.
