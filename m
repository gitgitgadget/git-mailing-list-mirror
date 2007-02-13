From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 12:32:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702131225070.3604@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702131816.27705.litvinov2004@gmail.com> <eqt40c$5ov$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 21:32:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH4K9-00022G-12
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 21:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbXBMUcV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 15:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbXBMUcV
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 15:32:21 -0500
Received: from smtp.osdl.org ([65.172.181.24]:51988 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbXBMUcU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 15:32:20 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1DKWFhB003226
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Feb 2007 12:32:15 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1DKWEQn008566;
	Tue, 13 Feb 2007 12:32:15 -0800
In-Reply-To: <eqt40c$5ov$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.423 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39583>



On Tue, 13 Feb 2007, Mark Levedahl wrote:
> 
> A proper win32 port will accept any of \n, \r\n as valid line endings (add
> \r to support Mac pre-OSX if anyone cares, I still occasionally see such
> files), treat any of them as semantically equal, and enforce the user's
> chosen style (\n or \r\n) on output.

The patch I sent out does that, except right now the "autocrlf" flag is 
just a pure boolean.

I could easily make it take a ternary value:
 - off (normal UNIX semantics - never change anything)
 - on (turn CRLF->LF on input, turn LF->CRLF on output)
 - input-only (turn CRLF->LF on input, leave LF alone on output)

that would be just a couple of extra lines (almost all of them in the 
config file parsing logic).

[ The "output-only" case is obviously possible, but insane. It would turn 
  a LF-only file into CRLF on output, and then not turn it back on input, 
  so doing any "git commit -a" would basically turn every single lines 
  into CRLF, which you do NOT want. 

  So hopefully that explains the three - not four - cases ]

And the patch already leaves files that the user doesn't touch alone (ie 
if you check something out with CRLF turned off, and then turn it on in 
the config, nobody will care - the checked-out copy will have LF-only even 
if explicitly re-checking it out would turn it into CRLF, but that's fine.

It would be interesting to hear if the patch works for the MinGW people in 
particular. People using git with a Cygnus environment are probably used 
to try to keep files with just LF, since they are really trying to do a 
UNIX environment on top of Windows. But I suspect that WinGW people are 
more likely to use native Windows tools for things, and then perhaps just 
a smattering of UNIXy tools..

			Linus
