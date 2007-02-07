From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 18:50:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702061832020.8424@woody.linux-foundation.org>
References: <20070206023111.GB9222@spearce.org> <200702060928.54440.andyparkins@gmail.com>
 <Pine.LNX.4.64.0702060836180.8424@woody.linux-foundation.org>
 <20070206164441.GA4949@spearce.org> <200702070117.l171HGxr023213@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Wed Feb 07 03:50:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEct9-0003iY-3W
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 03:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbXBGCuV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 21:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965636AbXBGCuV
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 21:50:21 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60163 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965632AbXBGCuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 21:50:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l172o8mA018053
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Feb 2007 18:50:08 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l172o76C004704;
	Tue, 6 Feb 2007 18:50:07 -0800
In-Reply-To: <200702070117.l171HGxr023213@laptop13.inf.utfsm.cl>
X-Spam-Status: No, hits=-0.458 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.112__
X-MIMEDefang-Filter: osdl$Revision: 1.174 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38885>



On Tue, 6 Feb 2007, Horst H. von Brand wrote:
>
> Shawn O. Pearce <spearce@spearce.org> wrote:
> 
> [...]
> 
> > What about this language?
> > 
> > 	The time of the change is specified by `<time>` as the number of
> > 	seconds since the UNIX epoc (midnight, Jan 1, 1970, UTC) and is
> > 	written in base-10 notation using US-ASCII digits.  The committer's
> > 	timezone is specified by `<tz>` as a positive or negative offset
> > 	from UTC.  For example EST (which is typically 5 hours behind GMT)
> > 	would be expressed in `<tz>` by ``-0500'' while GMT is ``+0000''.
> 
> That is /not/ a timezone! Maybe an offset from UTC.

Btw, one thing that might be a good idea to document very clearly:

 - in the native git format, the offset from UTC has *nothing* to do with 
   the actual time itself. The time in native git is always in UTC, and 
   the offset from UTC does not change "time" - it's purely there to tell 
   in which timezone the event happened.

   So 12345678 +0000 and 12345678 -0700 are *exactly*the*same*date*, 
   except event one happened in UTC, and the other happened in UTC-7.

 - in rfc2822 format, the offset from UTC actually *changes* the date. The 
   date "Oct 12, 2006 20:00:00" will be two _different_ times when you say 
   it is in PST or in UTC.

And yes, for all I know we might get this wrong inside git too. It's easy 
to get confused, because they really do mean different things.

For an example of this, do

	make test-date

in git (which parses the argument using the "exact date" and "approxidate" 
versions respectively, and the exact date parsing will give the internal 
git representation on the first line in the middle column), and then:

	./test-date "1234567890 -0800"
	./test-date "1234567890 +0000"

and then try

	./test-date "Fri Feb 13 15:31:30 2009 PST"
	./test-date "Fri Feb 13 15:31:30 2009 UTC"

and notice how the first two (numeric) dates that differ in UTC offset 
will still return the exact same seconds since the epoch:

	1234567890 -0800
	1234567890 +0000

but the second example (with a rfc2822-like date), will show how the 
seconds-since-epoch changes, and gives:

	1234567890 -0800
	1234539090 +0000

respectively for those two dates.

Logical? It actually is, but you have to understand how git represents 
date to see the logic. To git, the "timezone" is really totally 
irrelevant. It doesn't really affect the "date" at all. At most, it 
affects how you _print_ the date, and you can tell what timezone the 
computer was set to when the commit was made.

And yes, I would not be at all surprised if we had some bug here where we 
got it wrong occasionally.

		Linus
