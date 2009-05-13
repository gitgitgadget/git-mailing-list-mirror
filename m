From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 10:46:53 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905131036040.3343@localhost.localdomain>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512151403.GS30527@spearce.org> <20090512161638.GB29566@coredump.intra.peff.net> <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain>
 <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 13 19:49:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Ia0-0005sL-PJ
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 19:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759438AbZEMRtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 13:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755991AbZEMRtJ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 13:49:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56694 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754906AbZEMRtI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 13:49:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4DHkrZE028357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2009 10:47:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4DHkrBV020529;
	Wed, 13 May 2009 10:46:53 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.464 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119078>



On Wed, 13 May 2009, Linus Torvalds wrote:
>
> Of course, it probably makes sense to have a whole "git_readdir()" that 
> does this thing in general.

Actually, the more I think about that, the less true I think it is.

It _sounds_ like a nice simplification ("just do it once in readdir, and 
forget about it everywhere else"), but it's in fact a stupid thing to do.

Why?

If we _ever_ want to fix this in the general case, then the code that does 
the readdir() will actually have to remember both the "raw filesystem" 
form _and_ the "cleaned-up utf-8 form".

Why? Because when we do readdir(), we'll also do 'lstat()' on the end 
result to check the types, and opendir() in case it's a directory and we 
then want to do things recursively etc. And that happens to work on OS X 
(because we can use our "fixed" filename for lstat too), but it does not 
work in the general case.

And you can say "well, just do the stat inside the wrapped readdir()", but 
that doesn't work _either_, since

 - we don't want to do the lstat() if it's unnecessary. Even if we don't 
   have "de->d_type" information, we can often avoid the need for it, if 
   we can tell that the name isn't interestign (due to being ignored).

   Avoiding the lstat is a huge performance issue for cold-cache cases. 
   It's basically a seek.

   So we really want to do the lstat() later, which implies that the 
   caller needs to know _both_ the original "real" filesystem name _and_ 
   the converted one.

 - it doesn't handle the opendir() case anyway - so the end result is that 
   a real implementation will _always_ need to carry around both the 
   "filesystem view" filename _and_ the "what we've converted it into".

Now, the point of the patch I sent out was that for the specific case of 
OS X, which does UTF-8 conversions (wrong) but also is happy to get our 
properly normalized name, we don't care. So my patch is "correct" for that 
special case - and so would a plain readdir() wrapper be.

But my patch is _also_ correct for the case where a readdir() wrapper 
would do the wrong thing. My patch doesn't _handle_ it (since it doesn't 
change the code to pass both "filesystem view" and "cleaned-up view" 
pathnames), but the patch I sent out also doesn't make it any harder to do 
right.

In contrast, doing a readdir() wrapper makes it much harder to do right 
later, because it's just doing the conversion at the wrong level (you 
could make that "wrapper" return both the original and the fixed 
filename, but at that point the wrapper doesn't really help - you might 
as well just have the "convert" function, and it would be a hell of a lot 
more obvious what is really going on).

So I take it back. A readdir() wrapper is not a good idea. It gets us a 
tiny bit of the way, but it would actually take us a step back from the 
"real" solution.

			Linus
