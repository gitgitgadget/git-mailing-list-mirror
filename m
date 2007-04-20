From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFR] gitattributes(5) documentation
Date: Thu, 19 Apr 2007 18:45:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704191835290.9964@woody.linux-foundation.org>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net> <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
 <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
 <7vslav4yv6.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 03:45:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeiBs-00073o-TL
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 03:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbXDTBpN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 21:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbXDTBpN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 21:45:13 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:46441 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751581AbXDTBpM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2007 21:45:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3K1j5gD024705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Apr 2007 18:45:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3K1j1Xv004468;
	Thu, 19 Apr 2007 18:45:03 -0700
In-Reply-To: <7vslav4yv6.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.538 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45054>


Great. And reading the documentation, something struck me: wonderful docs 
about crlf, but it became clear that either the docs are wrong, or the 
behaviour is less than optimal: you cannot specify "crlf=input" any way?

So I would sugegst that
 - if crlf is set, we still honor the value of "core.autocrlf", we just 
   don't care about the *content*.

Maybe that's what the code is doing (I thought it did, but I'm too lazy to 
check), but the docs don't say that:

On Thu, 19 Apr 2007, Junio C Hamano wrote:
> 
> Set::
> 	A path to which the `crlf` attribute is set is converted
> 	to have CRLF line endings in the working tree upon
> 	checkout, and converted back to strip CRLF line endings
> 	to LF line endings upon checkin.

This documented behaviour is non-optimal for a few reasons:
 - it makes it impossible to say "this is text", and have it work on UNIX 
   platforms ;)
 - it makes it impossible to have "autocrlf=input", and then correct one 
   single file that was incorrectly guessed to be binary, and have that 
   file behave like other files.

So I _think_ the right rules are:

 - unspecified: use autocrlf *and* content detection logic
 - unset: never do crlf<->lf ("binary")
 - set: use autocrlf without content detection logic ("text")

with possibly an added rule:

 - set to value: "true" or "input" force that particular setting 
   *regardless* of autocrlf, ie we'd always get CRLF even on UNIX.

Hmm?

			Linus
