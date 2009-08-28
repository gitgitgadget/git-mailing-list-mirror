From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 13:28:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
References: <4A97193A.8090502@facebook.com>
 <20090828060538.GA22416@coredump.intra.peff.net>
 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
 <20090828150212.GA6013@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>,
	David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:29:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh5GD-000640-JV
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 19:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbZH1R3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 13:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbZH1R3B
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 13:29:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37823 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbZH1R3B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 13:29:01 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KP300GEJKJMZ770@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 28 Aug 2009 13:28:34 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090828150212.GA6013@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127316>

On Fri, 28 Aug 2009, Jeff King wrote:

> On Fri, Aug 28, 2009 at 09:58:27AM +0200, Alex Riesen wrote:
> 
> > > I couldn't find any tests related to relative date processing, so it
> > > would be really nice to have some. But I'm not sure of the best way to
> > > do it without dealing with race conditions. Annoyingly, show_date calls
> > > gettimeofday at a pretty low level, so there isn't a way of
> > > instrumenting it short of LD_PRELOAD trickery (which is probably not
> > > very portable).
> > 
> > Maybe better prepare the _test_ so that it uses current time and time
> > arithmetics then put yet another cludge in operational code? Especially
> > when we already have a greate number of GIT_ environment variables,
> > documented nowhere, with effects not immediately obvious:
> 
> But that's the point: you can't do that without a race condition. Your
> test gets a sense of the current time, then runs git, which checks the
> current time again. How many seconds elapsed between the two checks?
> 
> I guess it is good enough for testing large time spans, but I was hoping
> for a comprehensive time test.

I agree with your concern.  This is why I created the --index-version 
switch to pack-objects.

However I was hoping for a current time trickery solution that could 
live in test-date.c instead of interfering with the main code in such a 
way.

Did a quick test to override the library version:

diff --git a/test-date.c b/test-date.c
index 62e8f23..0bcd0c9 100644
--- a/test-date.c
+++ b/test-date.c
@@ -1,5 +1,10 @@
 #include "cache.h"
 
+int gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int i;

Result:

$ ./test-date now
now -> bad -> Wed Dec 31 19:00:00 1969
now -> Tue Jan 22 10:48:24 10199

So this seems to work.  ;-)


Nicolas
