From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Tue, 11 Oct 2005 11:37:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home>
 <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net> <20051008064555.GA3831@steel.home>
 <7vachks7aq.fsf@assigned-by-dhcp.cox.net> <20051008133032.GA32079@localhost>
 <7v64s7svya.fsf@assigned-by-dhcp.cox.net> <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
 <87mzlgh8xa.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
 <87ek6s0w34.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-149975580-1129055866=:14597"
Cc: Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Tue Oct 11 20:39:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPP0q-0003Cv-4m
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 20:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVJKSiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 14:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVJKSiE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 14:38:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932278AbVJKSiB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 14:38:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9BIbm4s027718
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Oct 2005 11:37:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9BIbkiV020863;
	Tue, 11 Oct 2005 11:37:47 -0700
To: Paul Eggert <eggert@CS.UCLA.EDU>
In-Reply-To: <87ek6s0w34.fsf@penguin.cs.ucla.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.123 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9978>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-149975580-1129055866=:14597
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 11 Oct 2005, Paul Eggert wrote:
>
> For example, the simplest approach is to say a byte is funny if it is 
> space, backslash, quote, an ASCII control character, or is non-ASCII.  
> But this will cause perfectly-reasonable UTF-8 file names to be 
> presented in git format using unreadable strings like "a\293\203\257b" 
> or whatever.

I think the simplest question to ask is "what are we protecting against?"

There's only two characters that are _really_ special diff itself: \n and 
\t. The former is obvious, the latter just because the regular gnu diff 
format puts a tab between the name and the date (and if you _knew_ the 
date was always there you could just work backwards, but since not all 
diffs even put a date, \t ends up being special in practice).

So what else would you want to protect against? I hope not 8-bit 
cleanness: if some stupid protocol still isn't 8-bit clean, it should be 
fixed.

And \0 is already impossible, at least on sane systems.

So arguably you don't need to quote anything else than \n and \t (and that 
obviously means you have to quote \ itself). That means that any filename 
always shows "sanely" in its own byte locale, and everything is readable, 
regardless of whether it's UTF-8 or just plain byte-encoded Latin1, or 
anything else.

So I don't think you should quote invalid UTF-8: it's invalid UTF-8 
whether ítis quoted or not.

		Linus

PS. There _is_ something you may want to quote, namely the standard CSI 
terminal escapes. Not because they wouldn't pass through, but because some 
people might just "cat" a patch. This is debatable. Now, they are in all 
in the range 0x00-0x1f and 0x80-0x9f, and since UTF-8 encoding is supposed 
to happen before it (but you don't know how many get that right), if you 
want to quote those characters, you need to do so _both_ for the "raw" 
format and for the UTF-8 format.

Now, the UTF-8 format for that high range is actually the same character, 
except preceded by a 0xc2 (I think), so the simplest thing is to do 
quoting _purely_ on a byte-stream level (ignore any UTF-8 stuff), and 
screw the fact that you end up with a non-UTF-8 sequence (character 0x0080 
is UTF-8 sequence 0xC2 0x80, and would be quoted as 0xC2 + "\200", which 
is no longer valid in UTF-8).

It gets quite nasty. For any UTF-8 quoting scheme you come up with, I'll 
point out something that it does wrong or looks horrible for a Latin1 
filename ;)
--21872808-149975580-1129055866=:14597--
