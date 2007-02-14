From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 07:51:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702140745110.3604@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
 <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
 <7v8xf1uxme.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702132127330.3604@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702141208020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D31C0E.2040206@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 16:51:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHMPc-0003vD-Dh
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 16:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbXBNPvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 10:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbXBNPvM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 10:51:12 -0500
Received: from smtp.osdl.org ([65.172.181.24]:32993 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932333AbXBNPvL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 10:51:11 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1EFp1hB006086
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 07:51:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1EFp0JH001603;
	Wed, 14 Feb 2007 07:51:01 -0800
In-Reply-To: <45D31C0E.2040206@verizon.net>
X-Spam-Status: No, hits=-0.413 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39658>



On Wed, 14 Feb 2007, Mark Levedahl wrote:
> 
> To recap, we have the following various suggestions to determine textness:
> 
> 1) ratio of ascii to non-ascii characters, possibly weighting some chars more
> than others
> 2) line length
> 3) existence of a null (\0)
> 4) file name globbing
> 5) roundtrip ( lf(crlf(file) ) == file

Actually, my patch already had one that you didn't mention: 
 6) CR never shows up alone.

So the patch I sent out basicallyhad the following rules:
 - no more than ~10% of all characters being other than regular printable 
   ASCII (where any control character except for newline/cr/tab was deemed 
   nonprintable)
 - any "lonely" CR automatically means it's binary, and I would refuse 
   to convert that to a LF (the test in the code is that CRLF count must 
   match CR count)

but the "roundtrip" rule is much too strict (it's actually perfectly 
possible for an editor to add CRLF characters only to new _lines_, leaving 
old lines with just LF - or the other way around. In fact, the editor I 
use under Linux does exactly that in reverse - if I add new lines, it will 
add those without CR, but will leave old lines with CRLF alone).

I think that to help asian languages (or strange text-files in utf8 or 
Latin1 too, for that matter: test-files with _just_ special characters), I 
should probably make the rule be that only the 0-31 range is special.

			Linus
