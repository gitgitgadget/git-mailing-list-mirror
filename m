From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 21:36:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702132127330.3604@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
 <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
 <7v8xf1uxme.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 06:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHCot-0005Vi-W8
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 06:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbXBNFgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 00:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbXBNFgf
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 00:36:35 -0500
Received: from smtp.osdl.org ([65.172.181.24]:42155 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbXBNFge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 00:36:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1E5aMhB019407
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Feb 2007 21:36:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1E5aLeo022521;
	Tue, 13 Feb 2007 21:36:21 -0800
In-Reply-To: <7v8xf1uxme.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.415 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39618>



On Tue, 13 Feb 2007, Junio C Hamano wrote:
> 
> It might be safe for some definition of safe, but it is very
> Asian unfriendly.
> 
> I'd probably suggest replacing it with what GNU diff uses, which
> we stolen and implemented in diff.c::mmfile_is_binary().

Well, the thing is, mmfile_is_binary() doesn't really have a big downside 
if it's wrong one way or the other.

In contrast CR->CRLF conversion, if wrong, actually corrupts binary files. 
So I felt it was better to be really safe than sorry. It's *much* better 
to miss some CRLF translation than to do too much of it.

That said, I'm sure it could be improved a lot. In particular, characters 
in the range 0x00 - 0x1f are clearly "more binary" than the 0x7f+ range, 
with the obvious exceptions (tab, cr, lf).

0x00 - which is the only one mmfile_is_binart() uses - is arguably the 
"most binary" one, of course, but it might be interesting to give 
different weights to the whole range.. In particular, especially for small 
files, the fact that there is no 0x00 byte in no way indicates that it's 
not "binary".

This whole issue is obviously one reason I'd like to involve the filename 
itself, and make it use a ".gitattributes" file - exactly because that 
allows you to be much more aggressive and more precise.

(0x00 may be one of the more _common_ characters in many binary files, 
which makes it a good character to search for too, so I don't really have 
any hugely strong opinions here. After all, the whole heuristic is off by 
default anyway, so it's "really safe" ;^)

			Linus
