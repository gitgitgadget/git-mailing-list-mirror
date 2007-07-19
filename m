From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 10:42:18 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707191032320.27353@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <Pine.LNX.4.64.0707160022560.14781@racer.site> <7vejj96igx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707190258550.14781@racer.site>
 <alpine.LFD.0.999.0707181949490.27353@woody.linux-foundation.org>
 <7vfy3l3rj0.fsf@assigned-by-dhcp.cox.net>
 <7vodi83fg7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 19:43:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBa28-0004RH-WB
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 19:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbXGSRnO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 13:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S940017AbXGSRnN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 13:43:13 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39117 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S939576AbXGSRnL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 13:43:11 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6JHgOEh005386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Jul 2007 10:42:25 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6JHgI9I013736;
	Thu, 19 Jul 2007 10:42:18 -0700
In-Reply-To: <7vodi83fg7.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.177 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53011>



On Thu, 19 Jul 2007, Junio C Hamano wrote:
> > ...
> > But the real problem of this approach of course is that this is
> > not reliable and can get a false match.  You can find your
> > beginning NUL in the SHA-1 part of one entry, and terminating
> > NUL later in the SHA-1 part of next entry, and you will never
> > notice.

[ I didn't react to this in your first email, because I thought you were 
  talking about your "use the rules for the ASCII part", and thought you 
  talked about how *that* was not reliable and can get a false match). But 
  it seems that you were actually talking about the NUL character test ]

Nope, wrong.

Why? Because there must always be a NUL *between* different SHA1's. 
There's *always* a NUL character that precedes a SHA1. So when you have 
two NUL characters (with no other NUL's between them), you *know* that 
they cannot be from two different SHA1's. If the first one was from an 
earlier SHA1, then the second one is *guaranteed* to be the one that 
happens *before* the next SHA1.

See?

You really have two, and only two cases:

 - NUL's that are within 20 bytes of each other: you don't know anything 
   about them. It might be that they are both within the *same* SHA1, or 
   the first one was the one that separated the ASCII part from the SHA1, 
   or the first one was a NUL in the previous SHA1 and the second one was 
   the NUL after the ASCII part.

   So two NUL's in the same 21-byte region are not reliable (ie less than 
   20 bytes in *between* them). They tell you nothing, and you must just 
   ignore them. 

 - NUL's that are more than 20 bytes apart: the second NUL is *guaranteed* 
   to be the start of the next SHA1.

   They cannot be part of the same "NUL + sha1", and thus the first NUL 
   *must* be from a previous SHA1 (or the NUL that preceded it). And that 
   means that the second NUL *must* be the NUL that precedes the next 
   SHA1.

So there is *no* ambiguity what-so-ever. It's not about guessing, and it's 
not about "luck". If you don't find two NUL bytes separated by more than 
20 bytes, you start the linear search.

> In other words, if you are really really *really* unlucky, not
> only you might end up being fooled by random byte sequences in
> SHA-1 part of the tree object, you would not even notice that
> you have to fall back on the linear search.

Wrong. Either you find a guanteed rigth place, or you ran out of the 
buffer and know you have to fall back on the linear search. 

No fooled.

> I've long time ago concluded that if we care about reliability
> (and we do very much), a bisectable tree without breaking
> backward compatibility is impossible.

No. You concluded incorrectly. I'm pretty damn sure the current tree 
format is perfectly fine. It's dense, it's nice and linear, and it's 
easily bisectable.

		Linus
