From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Tue, 11 Oct 2005 13:56:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510111346220.14597@g5.osdl.org>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home>
 <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net> <20051008064555.GA3831@steel.home>
 <7vachks7aq.fsf@assigned-by-dhcp.cox.net> <20051008133032.GA32079@localhost>
 <7v64s7svya.fsf@assigned-by-dhcp.cox.net> <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
 <87mzlgh8xa.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
 <87ek6s0w34.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
 <87slv7zvqj.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Tue Oct 11 23:02:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPRBp-0004TQ-2j
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 22:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVJKU5Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 16:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVJKU5X
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 16:57:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750766AbVJKU5W (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 16:57:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9BKuH4s001660
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Oct 2005 13:56:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9BKuCg3027082;
	Tue, 11 Oct 2005 13:56:14 -0700
To: Paul Eggert <eggert@CS.UCLA.EDU>
In-Reply-To: <87slv7zvqj.fsf@penguin.cs.ucla.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.123 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9986>



On Tue, 11 Oct 2005, Paul Eggert wrote:
> 
> Yes, quite true.  But we don't have to come up with something that's
> perfect in all cases, just something that's good enough to handle
> cases that we expect will be common in practice, in a world where
> UTF-8 is the preferred encoding for non-ASCII characters.

The thing is, I can almost guarantee you that any quoting in the high 
characters is going to be _worse_ than no quoting at all.

Exactly because quoting as UTF-8 is the wrong thing when it isn't actually 
UTF-8, and quoting as non-UTF-8 is the wrong thing when it _is_.

Not quoting at all, on the other hand, is unambigious. If you have a 
mailer that corrupts your text stream (which-ever type it is), then it's 
clearly the mailers problem. The _mailer_ at least has a chance in hell to 
know what character set it is getting mailed as.

The other alternative is to quote _everything_ non-ASCII. That's 
definitely reliable, but it's also unquestionably ugly as hell, especially 
in the long run.

Yes, there are some complex quoting approaches you can do, which quote 
things "correctly" (ie at a byte stream level) _and_ keep it valid UTF-8 
at the same time.

For example, you can read it as a UTF-8 stream, but then quote things at a 
byte level (ie if you quote one "character", you quote _all_ bytes in that 
character). And you quote if:

 - the UTF-8 _character_ is in the 0x80-0x9f control range
 - any _raw_byte_ is in the 0x80-0x9f range (it might not be UTF-8)
 - any _raw_byte_ is 0xfe-0xff (illegal UTF-8 character)
 - misformed UTF-8 (non-shortest sequence, or just generally invalid 
   sequences with missing or wrong high bits)

but quite frankly, that's a pretty painful thing to write. The upside is 
that it's easy to decode: you can _unquote_ it just as a byte stream.

			Linus
