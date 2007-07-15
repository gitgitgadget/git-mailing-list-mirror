From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 11:14:30 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707151110520.20061@woody.linux-foundation.org>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com> 
 <7vodiehko7.fsf@assigned-by-dhcp.cox.net>  <e5bfff550707141346q2eba4ab8ka1c85e8b5a2c1b1d@mail.gmail.com>
  <20070715093529.GD2568@steel.home>  <e5bfff550707150306t3196f723ia3071ac301fb3f24@mail.gmail.com>
  <20070715104858.GG2568@steel.home>  <e5bfff550707150432v780d8361yba2fc729504d5b73@mail.gmail.com>
 <e5bfff550707150529l7e9bdd9fu253d38f99d4d2ed7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 20:14:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA8cI-0005Sx-FF
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 20:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbXGOSOl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 14:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754512AbXGOSOl
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 14:14:41 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58908 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754288AbXGOSOk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2007 14:14:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6FIEaPj003309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 15 Jul 2007 11:14:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6FIEU5E005417;
	Sun, 15 Jul 2007 11:14:31 -0700
In-Reply-To: <e5bfff550707150529l7e9bdd9fu253d38f99d4d2ed7@mail.gmail.com>
X-Spam-Status: No, hits=-4.612 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52574>



On Sun, 15 Jul 2007, Marco Costalba wrote:
>
> To further push for git patch, please check this from current linux tree:
> 
> git log --parents --pretty=raw -z -r -p c4201214
> 
> As you can see the diff contains a '\0' value (actually removed by the patch).

So arguably maybe we should have turned that patch into a binary patch, 
but then it would have been really hard to read, and GNU patch and friends 
couldn't have read it.

So I think a better option would be:

> qgit of course fails, as any tool based on parsing '\0' delimiting
> character records. If the size of the patch was explicitly given
> instead no fail will occur.

You have an alternate fix, namely to only look at the NUL character at 
newline boundaries. Also, when it comes to "git log", you actually know 
even more: each commit begins with "commit".

A patch will always be nicely line-oriented, and will never have a NULL at 
the *beginning* of a line.

So you could actually make the parsing really strict, and look for the 
sequence

	'\n\0commit '

and that's a very trustworthy delimeter.

But yes, you can have NUL-characters in the middle of patches.

		Linus
