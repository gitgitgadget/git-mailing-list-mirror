From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/6] convert object type handling from a string to a
 number
Date: Tue, 27 Feb 2007 08:24:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702270816350.12485@woody.linux-foundation.org>
References: <11725197603476-git-send-email-nico@cam.org>
 <1172519760216-git-send-email-nico@cam.org> <11725197613482-git-send-email-nico@cam.org>
 <11725197622423-git-send-email-nico@cam.org> <11725197633144-git-send-email-nico@cam.org>
 <11725197632516-git-send-email-nico@cam.org> <7vejobhor2.fsf@assigned-by-dhcp.cox.net>
 <alpine.LRH.0.82.0702270856360.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 17:25:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM58M-0007Ms-Iu
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 17:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbXB0QYm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 11:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbXB0QYm
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 11:24:42 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39114 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbXB0QYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 11:24:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1RGOEhB008721
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 08:24:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1RGODvL021373;
	Tue, 27 Feb 2007 08:24:13 -0800
In-Reply-To: <alpine.LRH.0.82.0702270856360.29426@xanadu.home>
X-Spam-Status: No, hits=-0.936 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40758>



On Tue, 27 Feb 2007, Nicolas Pitre wrote:
> > 
> > I am wondering if "enum object_type" and signed comparison here
> > are compatible.
> 
> Enums are signed as far as I know.

No they are not.

"enums" are traditionally "int", but it's not a requirement, and the 
technical C requirement is that they be "an integral size sufficiently 
large to hold all the possible values".

In other words, with a small set of values, it's entirely possible that 
the integral type in question be "unsigned char", for example.

It so happens that gcc will never *by*default* pick such a type for the 
particular set of values you have. By default (to match traditions) gcc 
will always pick "int" (or, thanks to a gcc extension, a bigger type if 
the values require it), but if you pass it "-fshort-enums" it will pick a 
smaller type. 

And yes, it will actually pick "unsigned char", I think. Try it to be 
sure.

So to be portable, and to be safe, you really should make the error values 
part of the enum, ie you should add a

	OBJ_ERROR = -1,

if you want to make sure that the enum really can hold a negative number!

(In fact, on some embedded platforms, "-fshort-enums" is actually on by 
default - in order to keep data structures smaller)

		Linus
