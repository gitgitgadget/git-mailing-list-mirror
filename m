From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Wed, 12 Oct 2005 14:24:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510121411550.15297@g5.osdl.org>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home>
 <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net> <20051008064555.GA3831@steel.home>
 <7vachks7aq.fsf@assigned-by-dhcp.cox.net> <20051008133032.GA32079@localhost>
 <7v64s7svya.fsf@assigned-by-dhcp.cox.net> <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
 <87mzlgh8xa.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
 <87ek6s0w34.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
 <87slv7zvqj.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111346220.14597@g5.osdl.org>
 <877jcjmdmq.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510120749230.14597@g5.osdl.org>
 <87vf02qy79.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 23:27:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPo5q-0006FN-VX
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 23:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVJLVY4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 17:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVJLVY4
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 17:24:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932389AbVJLVYz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2005 17:24:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9CLOW4s030144
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Oct 2005 14:24:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9CLOVMf017966;
	Wed, 12 Oct 2005 14:24:31 -0700
To: Paul Eggert <eggert@CS.UCLA.EDU>
In-Reply-To: <87vf02qy79.fsf@penguin.cs.ucla.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10051>



On Wed, 12 Oct 2005, Paul Eggert wrote:
> 
> Worse, when I used Emacs to copy your text into another file -- the
> sort of thing that is likely to be done with an emailed patch -- the
> file contained the UTF-8 encoding of the gibberish, rather than the
> original bytes of your message.

Btw, this is an example of where locale-based character translations just 
fundamentally suck.

cut-and-paste quote naturally tries to translate between the source 
and destination locales, but it fundamentally cannot work. The only thing 
that ever works is bit-for-bit copying.

Any program that tries to do locale conversion is always going to be a bug 
waiting to happen.

If GNU emacs does locale translations rather than just do a binary 
transfer of the data, then that's a sign that GNU emavs is being really 
stupid. If the data was UTF-8 to begin with, then a binary copy is also 
going to be UTF-8. And if it wasn't UTF-8, then a binary copy is the only 
thing that is sensible.

And this is the thing that makes UTF-8 so wonderful: exactly the fact that 
it makes bit-for-bit copying an acceptable policy again, and locales 
become a non-issue. In a truly UTF-8 world, you should _never_ convert 
anything at all (and that includes mis-formed UTF-8).

Any non-binary file saving or transfer approach where characters have 
"meaning" is always mistake. It's why DOS/Windows "binary" vs "text" files 
was wrong. It's why font-encoding locales are wrong (Mixed text with two 
types? Yet another metadata quoting scheme? No thank you! It's also why 
UCS-16 and UCS-32 were total disasters: they had "context" in their 
encoding).

Say "yes" to binary transfer. Because text transfers are broken.

			Linus
