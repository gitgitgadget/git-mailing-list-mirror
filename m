From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Fwd: [FORCEDETH]: Fix reversing the MAC address on suspend.]
Date: Wed, 9 Jan 2008 19:47:01 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801091934160.3148@woody.linux-foundation.org>
References: <1199902258.2978.93.camel@pmac.infradead.org> <20080109.154431.128118336.davem@davemloft.net> <alpine.LFD.1.00.0801091620450.3148@woody.linux-foundation.org> <20080109.164149.264906319.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: dwmw2@infradead.org, B.Steinbrink@gmx.de,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 04:47:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCoOa-0003IK-Bh
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 04:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbYAJDr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 22:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754288AbYAJDr2
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 22:47:28 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48026 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753154AbYAJDr1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jan 2008 22:47:27 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0A3l2FT020420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 Jan 2008 19:47:03 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0A3l111003426;
	Wed, 9 Jan 2008 19:47:01 -0800
In-Reply-To: <20080109.164149.264906319.davem@davemloft.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.223 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70039>



On Wed, 9 Jan 2008, David Miller wrote:
> 
> > How do you generate those MSG_FILE/PATCH_FILE things? Using 
> > "git-mailinfo"? Do you by any chance give it the "-n" flag to make it 
> > *not* do the conversion to UTF8?
> 
> I create them by hand in my editor.

Ok. Apparently you get them in latin1, and save them as such.

If you can make your editor/mail setup (I assume it's Gnu "bovine 
excrement" Emacs, since you say that you use your editor for email) use 
utf8 natively for saving any results, then all your problems should go 
away.

That said, I suspect we could make git-commit just do the same thing that 
git-am already does, namely if it's not given an explicit character set 
for the input/output _and_ it's supposed to be in utf8, it could do the 
"guess_charset()" thing on a per-line basis.

It's not perfect, but the reason git-am does that (through "git mailinfo") 
is exactly the fact that it's very easy indeed to have mixed messages with 
some parts in UTF-8 (the body, for example) and others *not* in utf-8 (eg 
have headers in Latin1).

Doing the "check each line one at a time, see if it is already in UTF-8, 
otherwise assume it's the traditional Latin1" is kind of hacky, but it's 
probably better than just acceping a non-utf8 commit message and writing 
random data.

For people who really want to use Latin1 (or any other non-utf8 model), we 
already have a way to get the current behaviour, by forcing something like

	[i18n]
		commitencoding = binary

but we seem to have ended up with UTF-8 being the default encoding, so we 
should probably just make sure that we do end up writing valid utf-8 
unless some other explicit commit encoding has been set up.

So I think it's really your own fault for basically giving a latin1 
message (and not using the tools that know how to convert emails correctly 
from *many* different encodings).

But I *also* think that git probably should at least have warned you (I 
think it does, if you use "git commit" rather than "git commit-tree), and 
preferably have refused to write an invalid encoding or just converted 
from what is the most common one (and even if I feel a bit bad about just 
saying "latin1 is the default non-utf8 encoding", I think it makes sense 
for historical reasons).

			Linus
