From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: cleaner/better zlib sources?
Date: Thu, 15 Mar 2007 19:06:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703151906050.4998@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151807010.4998@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 03:11:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS1uo-0002J9-48
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 03:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbXCPCLF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 22:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbXCPCLF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 22:11:05 -0400
Received: from x35.xmailserver.org ([64.71.152.41]:48023 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbXCPCLD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 22:11:03 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S21C648> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Thu, 15 Mar 2007 22:11:00 -0400
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <Pine.LNX.4.64.0703151807010.4998@alien.or.mcafeemobile.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42315>

On Thu, 15 Mar 2007, Davide Libenzi wrote:

> On Thu, 15 Mar 2007, Linus Torvalds wrote:
> 
> > 
> > I looked at git profiles yesterday, and some of them are pretty scary. We 
> > spend about 50% of the time under some loads in just zlib uncompression, 
> > and when I actually looked closer at the zlib sources I can kind of 
> > understand why. That thing is horrid.
> > 
> > The sad part is that it looks like it should be quite possible to make 
> > zlib simply just perform better. The profiles seem to say that a lot of 
> > the cost is literally in the "inflate()" state machine code (and by that I 
> > mean *not* the code itself, but literally in the indirect jump generated 
> > by the case-statement).
> > 
> > Now, on any high-performance CPU, doing state-machines by having
> > 
> > 	for (;;)
> > 		switch (data->state) {
> > 			...
> > 			data->state = NEW_STATE;
> > 			continue;
> > 		}
> > 
> > (which is what zlib seems to be doing) is just about the worst possible 
> > way to code things.
> 
> A quick hack would be to just define:
> 
> #define SWITCH_LBL(n) \
> 	case n: \
> 	lbl_##n:
> 
> #define STATE_CHANGE(s) \
> 	state->mode = s; \
> 	goto lbl_##s;
> 
> Then replace all the "state->mode = STATE; break;" into STATE_CHANGE(STATE);
> I'm giving it a try as we speak ...

I get about 5-6% boost with it AFAICS ...



- Davide
