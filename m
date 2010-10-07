From: Stephen Bash <bash@genarts.com>
Subject: Re: Trac+Git: rev-list with pathspec performance?
Date: Thu, 7 Oct 2010 13:49:52 -0400 (EDT)
Message-ID: <2595121.446745.1286473792827.JavaMail.root@mail.hq.genarts.com>
References: <17750617.441668.1286378804923.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 19:50:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3ubn-0000lP-3L
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 19:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678Ab0JGRuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 13:50:03 -0400
Received: from hq.genarts.com ([173.9.65.1]:23968 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753664Ab0JGRuB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 13:50:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id A637F1E268D1;
	Thu,  7 Oct 2010 13:49:59 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZyBq1lrmc9l; Thu,  7 Oct 2010 13:49:52 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id D75CA1E2637D;
	Thu,  7 Oct 2010 13:49:52 -0400 (EDT)
In-Reply-To: <17750617.441668.1286378804923.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158416>

> > Note that there is proof of concept
> > "tree blame" (in Perl) which generates such 'last change to file'
> > information, I think faster than running 'git rev-list -1 <file>'
> > for
> > each file. Even better would be to encode used algorithm in C.
> >
> > http://thread.gmane.org/gmane.comp.version-control.git/150063/focus=150183
> 
> My early experiments with your script are good for speed, but for some
> reason I'm always getting the first commit for a file rather than the
> most recent. I'll do some experimenting to see if I can uncover the
> issue.

Following up, I had to add -r to the diff-tree command line when requesting a subdirectory to work around the problem (script always returned the first commit).

I'm curious if it's faster to get the SHA of the sub-tree and compare that before actually running diff-tree?  And for that matter, just run diff-tree on the sub-tree that we care about rather than a recursive sub-tree on the root?  These may be early optimizations, but they're ideas that occurred to me while debugging the code...

> > P.S. Alternate solution would be to simply get rid of SVN-inspired
> > view.  Git tracks history of a *project* as a whole, not set of
> > histories for individual files (like CVS).

After a lot of experimentation, this is basically what we did.  I modified the Trac templates to not list the last change SHA or log message in the directory view.  After all my testing, I just don't think there's a fast way to get this information from Git.  This blame-dir script is the fastest alternative I've tried (about 5x faster than rev-list'ing each file), but it's still ~30 seconds on my machine (which is faster than our web server), and IMHO that's too long to ask a user to wait for a page to load.

Thanks,
Stephen
