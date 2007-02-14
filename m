From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 08:53:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702140847020.3604@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
  <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org> 
 <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
 <45D335C3.E28D28E0@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 17:53:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNNl-0005fF-AL
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbXBNQxW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbXBNQxW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:53:22 -0500
Received: from smtp.osdl.org ([65.172.181.24]:35202 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932391AbXBNQxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:53:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1EGrFhB008070
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 08:53:15 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1EGrExh003123;
	Wed, 14 Feb 2007 08:53:14 -0800
In-Reply-To: <45D335C3.E28D28E0@eudaptics.com>
X-Spam-Status: No, hits=-0.409 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39680>



On Wed, 14 Feb 2007, Johannes Sixt wrote:
>
> Thanks a lot, busy beaver! I gave this a quick spin with a few
> interesting operations: merges and rebase. Merges leave the merge
> results with only LFs behind.

Yes. Merge uses "git-cat-file" (well, it historically did, now that it's 
built-in it still does the equivalent operation).

I already talked about how git-cat-file was special ;)

> Rebasing seems to work as expected (working files have CRLFs), except 
> when merges are needed.

Well, it always "merges", but yes, you mean three-way data merges. The 
normal SHA1-direct merges will just use the normal git-read-tree thing 
which is the same as checkout.

> Doesn't git-unpack-file also need to call into the converter?

See earlier discussions. git-cat-file (and git-unpack-file, which is just 
a version of it, really) don't have the original filename, so we'll need 
to extend on it some way in order to support file attributes even in 
theory. So before we do that, I'd hate to do any format conversion there.

Yes, yes, right now it ignores the filename *anyway*, but the point is, 
right now that's a "small implementation detail". I would NOT want to do 
this if I couldn't know the filename at all!

The merge algorithms actually obviously *do* know the filename fo the 
things that they are going to merge, so the filename information does 
exists. It's just not passed on far enough.

Finally, one comment: if you use "autocrlf = input" (my second patch), all 
of this works even now, since the default is to just leave things as 
LF-only anyway. In fact, even with "autocrlf = on", nothing should really 
*break* except for silly editors that actuall *require* CRLF.

IOW, it's more important to do the CRLF->LF conversion than it is to do 
the LF->CRLF one ;)

		Linus
