From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: strange git delays
Date: Thu, 20 Mar 2008 14:53:33 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803201441270.3020@woody.linux-foundation.org>
References: <1206019968.27619.26.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: James Utter <james.utter@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 22:54:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcSiJ-0007gZ-63
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 22:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448AbYCTVxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 17:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757440AbYCTVxg
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 17:53:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53767 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757439AbYCTVxf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2008 17:53:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2KLrY4W027889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Mar 2008 14:53:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2KLrX1Y025943;
	Thu, 20 Mar 2008 14:53:33 -0700
In-Reply-To: <1206019968.27619.26.camel@localhost>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.266 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77687>



On Fri, 21 Mar 2008, James Utter wrote:
>
> james@timesink:~/testgit$ time git commit --message "initial commit"
> Created initial commit 4f4b3a3: initial commit
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 hello
> 
> real	0m10.008s
> user	0m0.000s
> sys	0m0.008s

Ok, that is almost exactly 10 seconds longer than it should take.

And I can almost guarantee that it's something like a problem looking up 
your hostname or perhaps user identity - I would guess you have some name 
service problem.

Do an

	strace -tT git commit --message "initial commit"

on that git commit to make sure, but I would almost bet that it's when git 
does tget "getpwuid()" thing to get your name from the gecos fields, and 
you have some setup problem with nscd o similar.

It might just go away if you set up your user name and email manually, ie 
try doing

	git config --global user.name "James Utter"
	git config --global user.email james.utter@gmail.com

and see if that makes the delay go away. It probably tries to look up your 
login info from some non-existent NIS setup, and then times out after ten 
seconds and picks the data from your /etc/passwd file instead.

(There can be other things that do similar things - misconfigured name 
servers etc can cause delay etc. So maybe I'm wrogn on blaming nscd, but 
it would be my first guess).

		Linus
