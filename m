From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] diff: add custom regular expressions for function
 names
Date: Thu, 5 Jul 2007 12:44:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707051227380.9789@racer.site>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
 <alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
 <7vejjnhpap.fsf@assigned-by-dhcp.cox.net> <7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 13:44:53 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6PlU-0002xW-BK
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 13:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbXGELom (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 07:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbXGELom
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 07:44:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:48471 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754671AbXGELol (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 07:44:41 -0400
Received: (qmail invoked by alias); 05 Jul 2007 11:44:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 05 Jul 2007 13:44:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195g6tDp2t5PzGsZqNpLgFmrA4rhMUk90AcslnsvF
	v6ReCxEPjjP8bY
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51669>

Hi,

On Wed, 4 Jul 2007, Junio C Hamano wrote:

> *NOTE IN BIG RED LETTERS*
> 
> I do not particularly like the way multiple regexps are used in
> Johannes's patch, but I left it as-is, as that part of the
> change is orthogonal from the support to use the gitattribute
> mechanism, and the primary reason I got involved in this topic
> is to give help around the latter area.

I do not like it particularly, either. Until two days ago, that POSIX 
regexps suck so much, in that they do not even have a look-ahead, let 
alone a negative look-ahead. _That_ is what I wanted.

Alas, that is the first valid argument I encounter that would speak _for_ 
pcre. It speaks volumes that _nobody_ pointed this out before, but all 
pcre fans put out bogus arguments.

> I think using multiple regexp is cute, but if we do that, it
> should allow people to pick from:
> 
> 	public class Beer
> 	{
> 		int special;
> 		public static void main(String args[])
>                 {
>                 	... modified part is here ...
> 
> with two regexp matches, say:
> 
> 	/^(public|private|protectd) class (.*)/ then
>         /^	+.* (\w*\(.*)$/
> 
> and define the hunk_header format as something like:
> 
> 	"\[1,2]::\[2,1]"
> 
> meaning, "pick the second capture group from the match data of
> the first regexp, followed by double-colon, and pick the first
> capture group from the match data of the second regexp", to
> result in "Beer::main(String args[])".  You should be able
> to pick "/package (\w+);/ then /^sub (\w+)/" in Perl code using
> the same idea.
> 
> I am not married to the syntax I used in the above examples,
> though.

Is that really necessary?

But yeah, it is possible. You'd have to have some state in the struct, and 
introduce yet another escape (probably in place of the first line of the 
regexp), similar to

	*[2,2]::[1,1]
	*keep-searching-after-match 1
	^	+.* (\w*\(.*)$
	^(public|private|protected) class (.*)

Of course, there _has_ to be a way to handle exceptions, such as in Perl, 
where you do not necessarily have a package, and thus do not want that 
silly "::" in front of the rest.

But frankly, I think this is too complicated. Maybe somebody more 
intelligent than me can actually come up with a sane syntax and 
implementation of this, but at some point I think it is Good Enough(tm). 
And IMHO it is already good enough matching just one line.

Ciao,
Dscho
