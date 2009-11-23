From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: how to suppress progress percentage in git-push
Date: Mon, 23 Nov 2009 11:56:43 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911231043310.2059@xanadu.home>
References: <20091122145352.GA3941@debian.b2j>
 <20091123145959.GA13138@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 23 18:06:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCcMf-0003iq-Jy
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 18:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbZKWRGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 12:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752672AbZKWRGD
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 12:06:03 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10877 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbZKWRGB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 12:06:01 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KTK00F0BN2JYCD0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Nov 2009 11:56:44 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091123145959.GA13138@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133509>

On Mon, 23 Nov 2009, Jeff King wrote:

> On Sun, Nov 22, 2009 at 10:53:53PM +0800, bill lam wrote:
> 
> > I set crontab to push to another computer for backup. It sent
> > confirmation email after finished.  It looked like
> > 
> > Counting objects: 1
> > Counting objects: 9, done.
> > Delta compression using up to 2 threads.
> > Compressing objects:  20% (1/5)
> > Compressing objects:  40% (2/5)
> > Compressing objects:  60% (3/5)
> > Compressing objects:  80% (4/5)
> > Compressing objects: 100% (5/5)
> > Compressing objects: 100% (5/5), done.
> > Writing objects:  20% (1/5)
> > Writing objects:  40% (2/5)
> > Writing objects:  60% (3/5)
> > Writing objects:  80% (4/5)
> > Writing objects: 100% (5/5)
> > Writing objects: 100% (5/5), 549 bytes, done.
> > Total 5 (delta 3), reused 0 (delta 0)
> > 
> > Often the list of progress % can be a page long.  I want output but
> > not those percentage progress status.  Will that be possible?
> 
> Hmm. There seems to be a bug. pack-objects is supposed to see that
> stderr is not a tty and suppress the progress messages. But it doesn't,
> because send-pack gives it the --all-progress flag, which
> unconditionally tells it to display progress, when the desired impact is
> actually to just make the progress more verbose.

Not exactly.

First, the progress variable is initialized with the result of isatty(2) 
by default.  The --progress argument is there to override that since 
pack-objects is often executed on the sending end of a fetch operation 
where stderr is not a terminal.

Then, during the pack-objects process, there are 3 phases: counting 
objects, compressing objects, and writing objects.  However in the fetch 
case we prefer to let the receiving end (index-pack or unpack-objects) 
take care of the progress display during the third phase.  This is why 
by default pack-objects doesn't display any "writing objects" progress 
when the generated pack is sent to stdout.  The --all-progress argument 
is there to override that, namely for a push.  The fact that 
--all-progress implies --progress is a bad side effect which wouldn't 
need to exist, but I don't think this is the cause of the issue here.

> We need to do one of:
> 
>   1. make --all-progress imply "if we are using progress, then make it
>      more verbose. Otherwise, ignore."
> 
>   2. fix all callers to check isatty(2) before unconditionally passing
>      the option

None of the above would fix the issue as this only affects progress 
display for phase #3.  You'd still get progress display for the counting 
phase and the compressing phase.

That doesn't mean it is OK for send-pack to unconditionally use 
--all-progress though, although it does provide the -q argument to 
pack-objects when push -q is used which inhibits any progress display 
already.


Nicolas
