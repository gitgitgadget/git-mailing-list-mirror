From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 13:42:47 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211334540.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de>  <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>  <478F99E7.1050503@web.de>  <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>  <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> 
 <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>  <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>  <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>  <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> 
 <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org> <46a038f90801211306g3dd9a167wb74d06e444b18b93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:43:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH4Qf-00086o-F9
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbYAUVnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753677AbYAUVnL
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:43:11 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54660 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752859AbYAUVnJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 16:43:09 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LLglga027485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 13:42:48 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LLgl1r021391;
	Mon, 21 Jan 2008 13:42:47 -0800
In-Reply-To: <46a038f90801211306g3dd9a167wb74d06e444b18b93@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71349>



On Tue, 22 Jan 2008, Martin Langhoff wrote:
> 
> (slightly offtopic) are you praising UTF-8 as storage format (for disk
> and network) or in general? UTF-8-aware string ops like counting
> characters seem to me a horrendous thing at the ASM level.

I'm praising UTF-8 (without normalization) as a wonderful format where you 
can do 99.9% of everything without ever caring about all the expensive 
stuff.

But in order to do that, you really need to avoid normalization, and you 
also need to accept mis-formed UTF-8 strings (because even if it is real 
UTF-8, the string may actually be just a fragment of some larger string).

Once you do that (and _only_ if you do that), then UTF-8 is actually a 
wonderful thing. You can consider it to be a traditional "everything is a 
stream of bytes", and everything that only cares about a stream of byte 
will work wonderfully well.

And then, the (actually relatively few) things that want to do things like 
show things on the screen, or check for equivalence, or worry about width 
of the characters, *those* can still do so. 

So the beauty of UTF-8 is that you can switch between thinking of it like 
just a binary blob and thinking of it like text, and everythign works 
(including the traditional C null-termination).

And yes, that was obviously the explicit design goal. It's a good thing.

> More on topic, I suspect Kevin's experience is more on end-user apps,
> where input sanitization and even canonicalisation are common
> practice.

Sure. And I'm not arguing against them. Knowing the rules for combining 
characters is really important for input and output. 

> At least in Moodle we store *exactly*  what the user POSTed and
> cleanup^Wcorrupt it when displaying it, so that if it does happen that
> the cleanup was buggy, we never corrupted the data.

Absolutely. It's what the kernel does, and I think that's what perl does 
too for their "strings". It works really well. It also allows you to 
handle binary data (ie data that *really* isn't text) with shared routines 
etc etc.

And that's the beauty of non-normalized (and possibly badly formed) UTF-8.

		Linus
