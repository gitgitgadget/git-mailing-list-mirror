From: Paul Eggert <eggert@CS.UCLA.EDU>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Tue, 11 Oct 2005 23:51:41 -0700
Message-ID: <877jcjmdmq.fsf@penguin.cs.ucla.edu>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 08:53:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPaTr-0002ai-VO
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 08:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVJLGwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 02:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVJLGwt
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 02:52:49 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:59309 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S932368AbVJLGws (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2005 02:52:48 -0400
Received: from penguin.cs.ucla.edu (Penguin.CS.UCLA.EDU [131.179.64.200])
	by kiwi.cs.ucla.edu (8.11.7p1+Sun/8.11.7/UCLACS-5.2) with ESMTP id j9C6pf406118;
	Tue, 11 Oct 2005 23:51:42 -0700 (PDT)
Received: from eggert by penguin.cs.ucla.edu with local (Exim 4.50)
	id 1EPaSj-0002LE-7w; Tue, 11 Oct 2005 23:51:41 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510111346220.14597@g5.osdl.org> (Linus
 Torvalds's message of "Tue, 11 Oct 2005 13:56:12 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10011>

Linus Torvalds <torvalds@osdl.org> writes:

> you can read it as a UTF-8 stream, but then quote things at a byte
> level (ie if you quote one "character", you quote _all_ bytes in
> that character).

Yes, that's what I had in mind.

> And you quote if:
>
>  - the UTF-8 _character_ is in the 0x80-0x9f control range

Yes.  Or more generally, if it's any UTF-8 control character.

>  - any _raw_byte_ is in the 0x80-0x9f range (it might not be UTF-8)

Why quote the raw bytes?  Is this for terminal escapes on older xterm
(or xterm-like) implementations that don't understand UTF-8?  If so,
I'm not sure I'd bother, as it would introduce a lot of annoying
quoting with perfectly reasonable UTF-8, and (if we assume the world
is moving to UTF-8) it addresses a problem that is going away.

>  - any _raw_byte_ is 0xfe-0xff (illegal UTF-8 character)
>  - misformed UTF-8 (non-shortest sequence, or just generally invalid 
>    sequences with missing or wrong high bits)

Yes, that makes sense.

> quite frankly, that's a pretty painful thing to write.

It's not trivially short, yes.  But it shouldn't be that hard.

Also, I guess we don't have to write it, at least not at first.  As
long as we specify something like the C quoted-string format mentioned
earlier, we can encode into that format using a naive algorithm (e.g.,
quote any non-ASCII byte or ASCII control character), and beautify the
encoding method later.

> The upside is that it's easy to decode: you can _unquote_ it just as
> a byte stream.

Yes, that's the idea.

Also, the interchange format is the most important thing.  We have to
decode anything that is in the format, and we must encode into the
format.  Encoding prettily is nice, but not necessary.
