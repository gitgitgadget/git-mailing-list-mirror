From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleaner/better zlib sources?
Date: Thu, 15 Mar 2007 18:46:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 02:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS1Wg-0005cK-GO
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 02:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbXCPBqf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 21:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbXCPBqf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 21:46:35 -0400
Received: from smtp.osdl.org ([65.172.181.24]:48707 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225AbXCPBqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 21:46:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2G1kIcD000816
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Mar 2007 18:46:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2G1kHj2032267;
	Thu, 15 Mar 2007 17:46:17 -0800
In-Reply-To: <45F9EED5.3070706@garzik.org>
X-Spam-Status: No, hits=-0.379 required=5 tests=AWL,HOT_NASTY
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42313>



On Thu, 15 Mar 2007, Jeff Garzik wrote:
> 
> ISTR there are a bunch of state transitions per byte, which would make sense
> that it shows up on profiles.

Yeah. I only looked at the kernel sources (which include a cleaned-up 
older version of zlib), but they seemed to match the disassembly that I 
saw when doing the instruction-level profiling.

The code *sometimes* falls through from one state to another, ie there's a 
case where zlib does:

	...
        case DICTID:
            NEEDBITS(32);
            strm->adler = state->check = REVERSE(hold);
            INITBITS();
            state->mode = DICT;
        case DICT:
	...

which will obviously generate fine code. There's a few other examples of 
that, *BUT* most of the stuff is just horrid, like

        case HEAD:
            if (state->wrap == 0) {
                state->mode = TYPEDO;
                break;
            }

where the "break" (which simply breaks out of the case-statement, and thus 
just loops back to it:

    for (;;)
        switch (state->mode) {

thing is nasty nasty nasty).

A trivial thing to do is to just replace such

	state->mode = xxx;
	break;

with

	state->mode = xxx;
	goto xxx_mode;

and all of that complicated run-time code *just*goes*away* and is replaced 
by a relative no-op (ie an unconditional direct jump).

Some of them are slightly more complex, like

	state->mode = hold & 0x200 ? DICTID : TYPE;
	INITBITS();
	break;

which would need to be rewritten as

	old_hold = hold;
	INITBITS();
	if (old_hold & 0x200) {
		state->mode = DICTID;
		goto dictid_mode;
	}
	state->mode = TYPE;
	goto dictid_mode;

but while that looks more complicated on a source code level it's a *lot* 
easier for a CPU to actually execute.

Same obvious performance problems go for

	case STORED:
	   ...
        case COPY:
            copy = state->length;
            if (copy) {
		...
		state->length -= copy;
		break;
	    }
	    Tracev((stderr, "inflate:       stored end\n"));
	    state->mode = TYPE;
	    break;

notice how when you get to the COPY state it will actually have nicely 
fallen through from STORED (one of the places where it does that), but 
then it will go through the expensive indirect jump not just once, but at 
least *TWICE* just to get to the TYPE thing, because you'll first have to 
re-enter COPY with a count of zero to get to the place where it sets TYPE, 
and then does the indirect jump immediately again!

In other words, the code is *incredibly* badly written from a performance 
angle.

Yeah, a perfect compiler could do this all for us even with unchanged zlib 
source code, but (a) gcc isn't perfect and (b) I don't really think 
anything else is either, although if things like this happen as part of 
gzip in SpecInt, I wouldn't be surprised by compilers doing things like 
this just to look good ;)

Especially with something like git, where we know that most of the time we 
have the full input buffer (so inflate() generally won't be called in the 
"middle" of a inflate event), we probably have a very well-defined start 
state too, so we'd actually predict perfectlyon the *first* indirect jump 
if we just never did any more of them.

> I could have sworn that either Matt Mackall or Ben LaHaise had cleaned up the
> existing zlib so much that it was practically a new implementation.  I'm not
> aware of any open source implementations independent of zlib (except maybe
> that C++ behemoth, 7zip).

I looked at the latest release (1.2.3), so either Matt/Ben hasn't been 
merged, or this wasn't part of the thing they looked at.

			Linus
