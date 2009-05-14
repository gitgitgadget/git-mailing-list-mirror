From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] read_directory(): infrastructure for pathname
 character set conversion
Date: Thu, 14 May 2009 14:23:37 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905141413080.3343@localhost.localdomain>
References: <alpine.LFD.2.01.0905141341470.3343@localhost.localdomain> <alpine.LFD.2.01.0905141342520.3343@localhost.localdomain> <alpine.LFD.2.01.0905141346440.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 23:23:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4iP7-0006AM-EW
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 23:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbZENVXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 17:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbZENVXj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 17:23:39 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39111 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752863AbZENVXj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 17:23:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4ELNbJ1001984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 May 2009 14:23:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4ELNbR6022569;
	Thu, 14 May 2009 14:23:37 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0905141346440.3343@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.962 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119226>



On Thu, 14 May 2009, Linus Torvalds wrote:

> In particular, this allows:
> 
>  - the filesystem path component separator to be set to something
>    different than the normal UNIX '/' character.

I forgot to mention that this also now allows really having a different 
prefix. The old code had "path" and "base", and without really reading the 
code you might think that you could have a different base for the two, but 
immediately when it recursed, it would re-set the path and base to be the 
same thing, so you could never really have two different address spaces.

The new code very much intentionally keeps the two apart, and the 
_intention_ is that on platforms like Windows, you should not just be able 
to use other path component separators like '\', it should also be 
possible to use an absolute base (which, if I recall correctly, is the 
only way to handle things like long path-names. But maybe I'm wrong - I 
really don't know the crazy native Windows API's).

IOW, the _intention_ is that you could literally pass in something like

	"c:\Source\git\myrepo"

as the "path", and with an empty "base", it would then be possible to 
basically traverse the tree with the filesystem operations building up a 
"path" like

	c:\Source\git\myrepo\subdir\myfile.txt

while "base" would track it, but become "subdir/myfile.txt".

In fact, my intention was that the pathname could easily be in some crazy 
UTF16LE format (ie not a real "string" at all), but I might need to pass 
the "pathlen" around as a parameter if we need to handle strings that 
contain embedded NUL characters. That's an easy thing to do if required, 
though.

Now, it's possible that nobody wants to do that kind of crazy windows 
stuff, because even windows people are perfectly fine using regular utf-8. 
I really dunno. My point is more that this is meant to be very flexible 
basic infrastructure and that we _could_ do things like that.

		Linus
