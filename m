From: Paul Eggert <eggert@CS.UCLA.EDU>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Thu, 13 Oct 2005 17:16:57 -0700
Message-ID: <87irw1q7eu.fsf@penguin.cs.ucla.edu>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net>
	<20051007232909.GB8893@steel.home>
	<7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
	<20051008064555.GA3831@steel.home>
	<7vachks7aq.fsf@assigned-by-dhcp.cox.net>
	<20051008133032.GA32079@localhost>
	<7v64s7svya.fsf@assigned-by-dhcp.cox.net>
	<7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
	<87mzlgh8xa.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
	<87ek6s0w34.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
	<87slv7zvqj.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510111346220.14597@g5.osdl.org>
	<877jcjmdmq.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510120749230.14597@g5.osdl.org>
	<87vf02qy79.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510121411550.15297@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 02:19:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQDGz-0007CV-TH
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 02:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbVJNARv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 20:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVJNARv
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 20:17:51 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:2973 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S932569AbVJNARu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 20:17:50 -0400
Received: from penguin.cs.ucla.edu (Penguin.CS.UCLA.EDU [131.179.64.200])
	by kiwi.cs.ucla.edu (8.11.7p1+Sun/8.11.7/UCLACS-5.2) with ESMTP id j9E0Gv423711;
	Thu, 13 Oct 2005 17:16:57 -0700 (PDT)
Received: from eggert by penguin.cs.ucla.edu with local (Exim 4.50)
	id 1EQDFp-00087k-7i; Thu, 13 Oct 2005 17:16:57 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510121411550.15297@g5.osdl.org> (Linus
 Torvalds's message of "Wed, 12 Oct 2005 14:24:31 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10094>

Linus Torvalds <torvalds@osdl.org> writes:

> So I repeat: 
>  - escape as little as possible
>  - make the _viewer_ decide how to view it.

Under my most recent proposal, the only bytes one must escape are ",
\, and LF.  Doesn't that satisfy these two main criteria?


> If GNU emacs does locale translations rather than just do a binary
> transfer of the data, then that's a sign that GNU emacs is being
> really stupid.

Perhaps so, but it has a lot of company.  I have even worse problems
with Mozilla Thunderbird.  And as we observed, Pine also has problems
sending properly-formatted email containing arbitrary binary data.

I suspect the vast majority of email clients will screw up in
relatively common cases involving unusual characters in file names.
Using attachments avoids many of the problems, but lots of patches are
emailed inline and I'd rather not force people to use attachments to
send diffs.


> I find that email is very robust - it's basically 8-bit clean. No 
> character encoding, no crap. Just a byte stream. It really _is_ the most 
> reliable format.

Hmm.  To test that theory, I just now sent plain-text email to myself,
containing a carriage-return (CR) byte in the middle of a line.

The CR byte was transliterated into a LF.  Ooops.

This was the very first (and only) test I tried, which isn't a good
sign for reliability.  If you're curious, I tracked the problem down
to Exim, a popular mail transfer agent that is running on my personal
Debian GNU/Linux (stable) box.  As to why Exim munges email, please see
<http://www.exim.org/exim-html-4.40/doc/html/spec_44.html#SECT44.1>.
(And I didn't know about the Exim glitch before trying my test.
I'm normally a Sendmail man myself.)

More generally, I suspect inline patches with weird bytes will suffer
greatly from encoding and recoding by mail agents.


> What matters is not what it looks like, but what it _saves_ as. If
> you save the email message, it should come out as the same reliable
> 8-bit byte stream

Unfortunately this isn't true for Emacs, and I suspect other mailers
will have similar problems.  For example, with Emacs I can easily save
either the exact byte-for-byte message body that my mail transfer
agent gave me; or I can have Emacs decode the message into its
constituent characters, reencode the result as UTF-8, and put that
into a file.  In neither case, though, am I saving the original byte
stream that you presented to your mail user agent.  Even if I save the
byte-for-byte message body, it is often in quoted-printable format so
I'll have to decode strings like "=EF" to recover the original bytes.
This is doable, yes, but it's inconvenient in practice, at least with
the mail user agents I'm familiar with.  And even if I do it, I don't
necessarily have the same byte stream you gave your mail user agent; I
merely have the byte stream that your MUA gave to your MTA, and these
may not be the same thing (they certainly aren't always the same thing
with Emacs).


The simplest fix for git may be to say "Don't use inline patches; use
attachments if you must email anything with strange characters in it."
That's fine.  But I prefer a format that also allows GNU diff, if it
chooses, to generate output that resists common inline-email botches.
