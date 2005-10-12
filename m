From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Wed, 12 Oct 2005 07:59:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510120749230.14597@g5.osdl.org>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home>
 <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net> <20051008064555.GA3831@steel.home>
 <7vachks7aq.fsf@assigned-by-dhcp.cox.net> <20051008133032.GA32079@localhost>
 <7v64s7svya.fsf@assigned-by-dhcp.cox.net> <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
 <87mzlgh8xa.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
 <87ek6s0w34.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
 <87slv7zvqj.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111346220.14597@g5.osdl.org>
 <877jcjmdmq.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1215390309-1129129195=:14597"
Cc: Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 17:01:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPi5r-0007Us-UV
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 17:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVJLPAa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 11:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVJLPAa
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 11:00:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15840 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964803AbVJLPA3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2005 11:00:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9CF014s010313
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Oct 2005 08:00:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9CExtIB031694;
	Wed, 12 Oct 2005 07:59:57 -0700
To: Paul Eggert <eggert@CS.UCLA.EDU>
In-Reply-To: <877jcjmdmq.fsf@penguin.cs.ucla.edu>
X-Spam-Status: No, hits=2 required=5 tests=OSDL_HIGH_ASCII_6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10033>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1215390309-1129129195=:14597
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 11 Oct 2005, Paul Eggert wrote:
> 
> >  - any _raw_byte_ is in the 0x80-0x9f range (it might not be UTF-8)
> 
> Why quote the raw bytes?  Is this for terminal escapes on older xterm
> (or xterm-like) implementations that don't understand UTF-8?

It's not about "understanding" UTF-8.

Even a perfectly modern xterm may simply not be in UTF-8 mode: if it 
wasn't in an UTF-8 locale, then it won't do UTF-8 decoding.

> If so, I'm not sure I'd bother, as it would introduce a lot of annoying
> quoting with perfectly reasonable UTF-8, and (if we assume the world
> is moving to UTF-8) it addresses a problem that is going away.

UTF-8 is only _now_ getting really widespread, and I think it's because 
RedHat bit the bullet and made UTF-8 the default locale a few years ago.

These things take _decades_.

I don't know if you realize it, but it's only within the last couple of 
years that the old 7-bit "finnish ASCII" went away. Finnish and Swedish 
have three extra characters: åäö (latin1) and Ã¥Ã¤Ã¶ (utf-8). But only
within the last few years has the really _old_ ASCII representation really 
gone away so much that I don't see it at all (the characters '{' '}' and 
'|' were taken over, so that if you had a Finnish ASCII font, programming 
in C was really funky - but it was common enough that I could do it 
without thinking much about it ;)

So lots of people still use the byte-wide encodings. Whether really old 
ASCII only or some special locale-dependent one (of which latin1 and the 
"win-latin1" thing are obviously the most common by far). And in that 
locale, it's not the UTF-8 control characters that matter, it's the _byte_ 
control characters that do.

So if you want to support any other locale than UTF-8, you need to escape 
them. Assuming you want to escape control characters at all, of course (I 
still think it's perfectly fine to just let the raw mess through and 
depend on escaping at higher levels)

			Linus
--21872808-1215390309-1129129195=:14597--
