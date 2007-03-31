From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Packing large repositories
Date: Sat, 31 Mar 2007 14:56:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703311450030.6730@woody.linux-foundation.org>
References: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com>
 <Pine.LNX.4.64.0703280943450.6730@woody.linux-foundation.org>
 <20070330062324.GU13247@spearce.org> <alpine.LFD.0.83.0703300851270.3041@xanadu.home>
 <78639417-ACDB-484F-85BB-EC0AF694949A@adacore.com>
 <Pine.LNX.4.64.0703311033290.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703311408560.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dana How <danahow@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 23:56:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXlYn-0003uN-Iu
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 23:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbXCaV4a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 17:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbXCaV4a
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 17:56:30 -0400
Received: from smtp.osdl.org ([65.172.181.24]:37722 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573AbXCaV43 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 17:56:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2VLuBod020492
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 31 Mar 2007 14:56:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2VLu9sJ030800;
	Sat, 31 Mar 2007 14:56:10 -0700
In-Reply-To: <Pine.LNX.4.64.0703311408560.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.965 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43574>



On Sat, 31 Mar 2007, Linus Torvalds wrote:
> 
> Ok, here's a slightly updated patch that does a few more iterations..

Don't use this. There's something wrong with it, and unlike the first 
patch, it doesn't even pass all tests.

I think it's because I decided to try to use rounding in the newton thing 
(which got things closer), but I suspect that rounding is broken - I think 
it can round to "outside" the valid range. I didn't notice that with the 
eclipse performance testing, probably because when you have enough objects 
you'll never see it, but with smaller packs, being off-by-one means that 
you can easily fall off the map ;)

So I'd like to re-iterate the note I had in that email:

> Not really meant to be applied, but it was interesting to play with 
> this. NOTE! I don't think the math is really strictly correct (ie the 
> scaling inside the loop), but it's "close enough" to not matter, and this 
> really was meant to be an request-for-discussion.

IOW, it's very much a RFD patch. I suspect it is trivial to fix, but I 
also suspect that unless somebody else decides that this is interesting, 
I'll just leave the patch behind. None of the loads I tested really seemed 
to be very sensitive to object lookup performance - the binary search 
simply seems ot be "good enough", and usually the costs are in generating 
patches ("git blame") or just diffing trees ("git log <pathspec>"), and 
the object lookup doesn't seem to be critical enough to worry about.

If somebody can point to a load where we spend a noticeable amount of time 
on doing index lookups, that would obviously change my opinion, but in the 
meantime, I think this is better considered a case of "we _could_ do 
something like this if it's ever an issue.."

		Linus
