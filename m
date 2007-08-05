From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: way to automatically add untracked files?
Date: Sat, 4 Aug 2007 22:03:03 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708042157150.5037@woody.linux-foundation.org>
References: <873ayymzc1.fsf@catnip.gol.com>
 <fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 07:03:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHYH6-00058b-VL
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 07:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbXHEFDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 01:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbXHEFDa
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 01:03:30 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34575 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751756AbXHEFD3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 01:03:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l75539fU002250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 4 Aug 2007 22:03:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l755332n025740;
	Sat, 4 Aug 2007 22:03:03 -0700
In-Reply-To: <fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
X-Spam-Status: No, hits=-2.421 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_32
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54946>



On Sun, 5 Aug 2007, Miles Bader wrote:

> I previously wrote
> > One thing I often want to do is git-add all untracked files, and also 
> > automatically git-rm all "disappeared" files
> ...
> > One way to do this seems to be just "git add ."
> 
> Oh, also, "git add ." doesn't seem to do the right thing with 
> "dissapeared" files:  If I do:
> 
>     mv foo.cc bar.cc
>     git add .

Do "git status -a" to figure out the removed ones.

I actually think we should probably make "git add ." do it too, but it's 
not how we've done it historically ("git add ." really ends up just 
reading the working directory tree and addign all the files it sees: so by 
definition it doesn't do anything at all to files it does *not* see, ie 
the removed ones).

> Am I doing something wrong, or is this just missing functionality?

Well, it's just "behaviour". It's probably largely historical, in that 
"git add" used to be thought of as "adding new files", but obviously then 
it got extended to mean "stage old files for commit" too, but in that 
extension, the "remove old files" never came up.

But git certainly has the capability. "git commit -a" will notice all the 
files that went away and automatically remove them, so

	git add .
	git commit -a

will do what you want (except, as we found out last week, we've had a huge 
performance regression, so that's actually a really slow way to do it, and 
so it's actually faster to do

	git ls-files -o | git update-index --add --stdin
	git commit -a

instead (where the first one just adds the *new* files, and then obviously 
the "git commit -a" does the right thing for old files, whether deleted or 
modified)

		Linus
