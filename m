From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git full diff output issues..
Date: Thu, 26 May 2005 13:33:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505261316250.2307@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505261223240.2307@ppc970.osdl.org>
 <Pine.LNX.4.60.0505262036500.16829@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 22:32:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbOzb-0002Ws-8J
	for gcvg-git@gmane.org; Thu, 26 May 2005 22:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVEZUb6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 16:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVEZUb6
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 16:31:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:23240 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261722AbVEZUbj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 16:31:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4QKVOjA032684
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 26 May 2005 13:31:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4QKVL7q011551;
	Thu, 26 May 2005 13:31:23 -0700
To: Anton Altaparmakov <aia21@cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0505262036500.16829@hermes-1.csi.cam.ac.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 26 May 2005, Anton Altaparmakov wrote:
> 
> Given that git already has the metadata lines in the diff ("old mode", 
> "deleted file mode", etc) why not simply add another metadata line "name" 
> and what follows that is the name until an end of line character (or a NUL 
> if you want file names with embedded new lines).  You can then only emit 
> the "name" metadata line when no actual diff is present and hence the name 
> is uncertain.

Yes, that would work. 

However, I ended up just validating the name parsing by making sure that 
when I parse the "git --diff" line, I only take the name if I can see it 
being the same for both the old and the new. IOW, if I see

	diff --git a/hi b/hello

then I won't take it, but if I see

	diff --git hi there/I am/being difficult   oopsie dir/I am/being difficult

then I get "I am/being difficult" by virtue of checking the two names 
against each other.

This means, btw, that the "git --diff" format must _not_ do

	diff --git a/file /dev/null
	deleted file mode 100644

because in that case I don't trust the filename enough. Of course, this
all only happens when deleting empty files, if the file had any contents,
then I will see the unambiguos filename on the '---' line, and again be
happy.

IOW, git-apply is being pretty anal about things, but it looks like that
works out well.

			Linus
