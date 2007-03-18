From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 19:20:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
 <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172136440.18328@xanadu.home>
 <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172200060.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 03:21:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSl16-00011g-0m
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 03:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbXCRCVB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 22:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbXCRCVB
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 22:21:01 -0400
Received: from smtp.osdl.org ([65.172.181.24]:52691 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752915AbXCRCVA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 22:21:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2I2KgcD018710
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Mar 2007 19:20:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2I2Kf3E014111;
	Sat, 17 Mar 2007 18:20:42 -0800
In-Reply-To: <alpine.LFD.0.83.0703172200060.18328@xanadu.home>
X-Spam-Status: No, hits=-0.977 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42470>



On Sat, 17 Mar 2007, Nicolas Pitre wrote:
> 
> Well... in my opinion it is the _current_ tree walker that is quite ugly 
> and complex.  It is always messier to parse strings than fixed width 
> binary fields.

Sure. On the other hand, text is what made things easy to do initially, 
and you're missing one *BIG* clue: you cannot remote the support without 
losing compatibility with all traditional object formats.

So you have no choice. You need to support the text representation. As a 
result, *your* code will now be way more ugly and messy.

The thing is, parsing some little text may sound expensive, but if the 
expense is in finding the end of the string, we're doing really well.

In other words: the data structures are both simple and straightforward, 
and the only reason strlen() shows up at all is:

 - we pass strings around as just C strings, even when we know their 
   lengths. Prime example: look at tree-diff.c. And when you look at it, 
   realize that *for*every*single*strlen* in that file except for the very 
   last one (which is only used once per process for setup) we actually 
   know the string length from before, but we (well, *I*) decided that it 
   wasn't worth passing down as a parameter all the time.

 - the simple parsing of the tree itself (which really isn't that 
   expensive - the real expense is bringing the data into the CPU cache, 
   but that's something we'd need to do *anyway*).

So I seriously suspect that you could get the strlen() overhead down from 
that 16% pretty easily, but you'd have to pass the length of the "base" 
string along all the time (and in the tree_entry cases you'd replace the 
"strlen()" calls with a call to something like

	static inline int tree_entry_len(const char *name, const unsigned char *sha1)
	{
		return (char *)sha1 - (char *)name - 1;
	}

which will do it for you).

But what you're ignoring here is that "16%" may sound like a huge deal, 
but it's 16% of somethng that takes 1 second, and that other SCM's cannot 
do AT ALL.

		Linus
