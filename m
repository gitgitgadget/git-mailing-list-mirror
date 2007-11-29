From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: problem with git detecting proper renames
Date: Thu, 29 Nov 2007 09:44:28 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711290934260.8458@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 18:45:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxnRW-0001JM-UQ
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 18:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159AbXK2Rof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 12:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756234AbXK2Rof
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 12:44:35 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37991 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755113AbXK2Roe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2007 12:44:34 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lATHiTsB004224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2007 09:44:30 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lATHiSXF031788;
	Thu, 29 Nov 2007 09:44:29 -0800
In-Reply-To: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net>
X-Spam-Status: No, hits=-2.727 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66548>



On Thu, 29 Nov 2007, Kumar Gala wrote:
> 
> I did some git-mv and got the following:
> 
> the problem is git seems confused about what file was associated with its
> source.

Well, I wouldn't say "confused". It found multiple identical options for 
the source, and picked the first one (where "first one" may not be obvious 
to a human, it can depend on an internal hash order).

But if you have the resultant git tree somewhere public (or just send me 
the exact "git mv" and revision to recreate), I'll happily give it a look, 
to see if we can improve our heuristics to be closer to what a human would 
expect.

For example, in this case, it looks  like there were two totally identical 
"init.S" files that got renamed with the same identical content to two new 
names. YOU seem to expect that it would stay as two renames, but from a 
content angle, since the two sources were identical, it's a totally 
arbitrary choice whether it's a "copy one source to two destinations and 
delete the other source" or whether it's two cases of "move one source to 
another destination" (and the latter case also has the issue of which way 
to move it).

(You also had two identical Makefile's with the exact same issue).

So git doesn't care about how you did the rename, it only cares about the 
end result, and the exact same way that it will detect a rename if you 
implement it as a "copy file" and then a later "delete old file", it will 
also potentially go the other way, or just decide that identical contents 
moved in different ways.

But we can certainly tweak the heuristics. For example, if we find 
multiple identical renames, right now we just pick one fairly at random, 
and have no logic to prefer independent renames over "multiple copies and 
a delete". But this code is actually fairly simple, and with a good 
example I can easily add heurstics (for example, it probably *is* better 
to consider it to be two renames, just because the resulting diff will be 
smaller - since a "delete" diff is much larger than a rename diff).

		Linus
