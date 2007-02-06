From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 09:20:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702060913220.8424@woody.linux-foundation.org>
References: <20070206023111.GB9222@spearce.org> <Pine.LNX.4.64.0702052248070.19212@xanadu.home>
 <20070206054808.GA10508@spearce.org> <Pine.LNX.4.64.0702060829310.8424@woody.linux-foundation.org>
 <20070206165630.GB4949@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 18:21:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEU04-0005jg-3i
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 18:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbXBFRU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 12:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbXBFRU6
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 12:20:58 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41438 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267AbXBFRU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 12:20:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l16HKfmA030493
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Feb 2007 09:20:41 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l16HKeqg023316;
	Tue, 6 Feb 2007 09:20:41 -0800
In-Reply-To: <20070206165630.GB4949@spearce.org>
X-Spam-Status: No, hits=-0.422 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.112__
X-MIMEDefang-Filter: osdl$Revision: 1.174 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38861>



On Tue, 6 Feb 2007, Shawn O. Pearce wrote:
> 
> If the source is only supplying RFC2822 date format and is reliable
> in its formatting of such, having gfi parse that rather than
> the frontend is probably more reliable.  (Git already has a well
> tested date parsing routine.)

I'm not so worried about the git date parsing routines (which are fairly 
solid) as about the fact that absolutely *tons* of people get rfc2822 
wrong.

And we'd never even see it, because gits date-parsing routines are very 
forgiving, and allow pretty much anything (and no, I'm not talking about 
approxidate(), which really *does* allow anything, I'm talking about the 
"strict" date parser). 

They allow pretty much any half-way valid date, exactly because people 
don't do rfc2822 right anyway (and because they are also meant to work 
even if you write the date by hand, like "12:34 2005-06-07").

And *particularly* when it comes to timezones, it just guesses. The whole 
daylight savings time thing is just too hard. And if no timezone exists, 
it will just take the current one, so things may *seem* like they work, 
but then two different people importing the *same* archive in two 
different locations will actually get different results!

THAT'S A BAD THING!

It's much better to specify the date so exactly that you simply cannot get 
different results with the same input.

Sure, you can still mess up the program that actually generates the data 
for gfi, and have bugs like that *there*, but at least they'd have to 
think a bit about it.

And the TZ problem is actually less likely if you have a strict TZ format. 
For example, when importing from CVS, the natural thing to do is to just 
always set TZ to +0000. Which gets you something reliable, and it won't 
depend on who did the import.

But hey, especially if it's a flag, and especially if it's *documented* 
that the date parsing will depend on the current timezone etc, then maybe 
it's all ok. It's certainly convenient to be able to give the date in any 
format. It's just very easy to get bugs when you allow any random crud..

		Linus
