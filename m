From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Cannot clone redirecting stdout
Date: Fri, 11 Sep 2009 18:47:32 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909111820450.28290@iabervon.org>
References: <fc8ab2ad0909101533l135c8003m80091cb40ec93f16@mail.gmail.com> <20090911102329.GA13044@sigill.intra.peff.net> <20090911135110.GA30860@coredump.intra.peff.net> <9e0f31700909110846h54959ae6u466ceda40799ba37@mail.gmail.com> <20090911160510.GA10848@coredump.intra.peff.net>
 <20090911162013.GA10939@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Johan_S=F8rensen?= <johan@johansorensen.com>,
	Aloisio <aloisiojr@gmail.com>, git@vger.kernel.org,
	support@gitorious.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 00:47:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmEu9-0006ye-0Z
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 00:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634AbZIKWrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 18:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753345AbZIKWrb
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 18:47:31 -0400
Received: from iabervon.org ([66.92.72.58]:42256 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbZIKWrb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 18:47:31 -0400
Received: (qmail 19208 invoked by uid 1000); 11 Sep 2009 22:47:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Sep 2009 22:47:32 -0000
In-Reply-To: <20090911162013.GA10939@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128228>

On Fri, 11 Sep 2009, Jeff King wrote:

> On Fri, Sep 11, 2009 at 12:05:10PM -0400, Jeff King wrote:
> 
> > Ah. I have a theory. If I do a clone of git://gitorious.org/qt/qt.git,
> > the counting/compressing stages take a long time (I timed it at 1m40
> > before it actually sends any data). And looking at upload-pack.c, we
> > leave the 30-second alarm set while creating the pack. Meaning we die 30
> > seconds into creating the pack.
> > 
> > When progress is being displayed, however, the progress timer actually
> > uses SIGALRM, as well. So we are constantly resetting the timer and it
> > never goes off.
> 
> Hmm. Actually, this is not quite right. It looks like we call out to
> pack-objects as an external program, so there is no conflict with the
> signal. And we do proxy the output of pack-objects, which will keep our
> timer resetting every time we see a chunk of output. But pack-objects
> produces no output during the deltification phase, unless progress is
> turned on.  So we still hit our timeout in upload-pack during that
> phase.
> 
> So our options are:
> 
>   1. Turn off the timer during deltification, which could mean that it
>      would potentially go forever. But it's not controlled by the user.
>      I think the 'timeout' feature is really about the client just
>      opening the connection and sitting.
> 
>   2. Keep progress on during deltification, but just throw it away
>      instead of relaying it if no-progress is in effect.
> 
>   3. Accept that hitting the timeout during deltification _should_ cause
>      it to die. In that case, then the case with progress is wrong, and
>      we should stop resetting the timer just because we got some
>      progress output from pack-objects. But this may be redefining the
>      intent of --timeout. I don't know what the original intent was, or
>      what users of the feature are expecting.

You don't remember October 2005? HPA introduced it in 960decc, which has a 
pretty good explanation: we doesn't want to get DoS'd if clients just send 
SYNs. So it's supposed to time out only if we spend that long waiting 
for a protocol item from the client.

	-Daniel
*This .sig left intentionally blank*
