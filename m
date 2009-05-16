From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/3] Introduce 'convert_path_to_git()'
Date: Sat, 16 May 2009 10:27:33 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905161008190.3301@localhost.localdomain>
References: <alpine.LFD.2.01.0905141341470.3343@localhost.localdomain> <alpine.LFD.2.01.0905141342520.3343@localhost.localdomain> <alpine.LFD.2.01.0905141346440.3343@localhost.localdomain> <alpine.LFD.2.01.0905151156090.3343@localhost.localdomain>
 <7vy6sxpn2q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 16 19:28:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5NgJ-000609-0w
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 19:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbZEPR2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 13:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbZEPR2J
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 13:28:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40173 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752047AbZEPR2I (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 May 2009 13:28:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4GHRYp9004965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 16 May 2009 10:27:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4GHRXal022554;
	Sat, 16 May 2009 10:27:34 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vy6sxpn2q.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.964 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119367>



On Fri, 15 May 2009, Junio C Hamano wrote:
> 
> "Ugly" is not quite the word I am looking for.  "My gut feels that there
> has to be a way to write this more cleanly, but I am frustrated that I
> cannot come up with one" might be the word...

Well, we can certainly make it even more interesting, and more prone to 
work even when the word-size grows.

	#define MAX_SHIFT (8*sizeof(unsigned long))
	#define SHIFT_BITS(x,y)  ((x) << ((y) & (MAX_SHIFT-1)))

	#define EXPAND(x,bits) ((x) | SHIFT_BITS(x,bits))
	#define EXPAND2(x,bits) EXPAND(EXPAND(x,bits),bits*2)
	#define EXPAND4(x,bits) EXPAND2(EXPAND2(x,bits),bits*4)
	
	#define MASK80 EXPAND4(0x80808080ul,32)

and now it should work up to 256 bits without warnings or undefined 
behavior (shifting by the word-size or more is not well-specified, which 
is why it has the "MAX_SHIFT/SHIFT_BIT" magic)

Untested, of course. But it seems to work on 32-bit and 64-bit cases. I 
can only hope that it works for 128-bit and 256-bit cases too.

And yes, it depends on "sizeof(unsigned long)" being a power of two. We 
could avoid that dependency by turning the "& (MAX_SHIFT-1)" into a ?: 
operation that actually compares with the value, and then it would work 
for a 6-byte "unsigned long" too.

It fundamentally does depend on 8-bit bytes, of course, but so does the 
whole algorithm, so that's not much of a dependency.

IOW, I'm not claiming it's "truly portable". Just reasonably so.

			Linus
