From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 18:29:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com> 
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org> 
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home> 
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 02:31:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSkF5-00028b-Kx
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 02:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbXCRBaI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 21:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753020AbXCRBaI
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 21:30:08 -0400
Received: from smtp.osdl.org ([65.172.181.24]:51887 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976AbXCRBaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 21:30:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2I1TdcD017552
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Mar 2007 18:29:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2I1TcO7013435;
	Sat, 17 Mar 2007 17:29:39 -0800
In-Reply-To: <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
X-Spam-Status: No, hits=-0.978 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42464>



On Sat, 17 Mar 2007, Morten Welinder wrote:
>
> >         samples  %        app name                 symbol name
> >         41527    15.6550  git                      strlen
> 
> Almost 16% in strlen?  Ugh!
> 
> That's a lot of strings, or perhaps very long strings.  Or a profiling bug.

It's likely real, and the problem is likely lots of small strings.

Each git tree entry is:

	"<octal mode> name\0" <20-byte sha1>

so you do have a *lot* of strlen() calls when doing any tree parsing. And 
for some inexplicable reason, glibc thinks strings are long on average, so 
it has a fancy algorithm to do 8 bytes at a time and tries to do things 
aligned etc.

The size of strlen() on x86-64 with glibc is 232 bytes. I'm not kidding.

			Linus
