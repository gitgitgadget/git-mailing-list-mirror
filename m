From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 11:56:56 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
References: <20070730180710.GA64467@nowhere>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Craig Boston <craig@olyun.gank.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 20:57:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFaR2-0005ah-H3
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 20:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966519AbXG3S5g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 14:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966502AbXG3S5g
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 14:57:36 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59326 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966247AbXG3S5g (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 14:57:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6UIv1co018164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Jul 2007 11:57:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6UIuujA025108;
	Mon, 30 Jul 2007 11:56:56 -0700
In-Reply-To: <20070730180710.GA64467@nowhere>
X-Spam-Status: No, hits=-2.729 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54249>



On Mon, 30 Jul 2007, Craig Boston wrote:
> 
> So far the main snag I've found is that AFAIK there's no equivalent to
> "svk import" to load a big tree (~37000 files) into a branch and commit
> the changes.  Here's the procedure I've come up with:
> 
> cd /path/to/git/repo
> git checkout vendor_branch_X
> git rm -r .
> cp -R /path/to/cvs/checkout_X/* ./
> git add .
> git commit -m"Import yyyymmdd snapshot"

Ouch.

What you want to do should fit git very well, but doing it that way is 
quite expensive.

Might I suggest just doing the .git thing *directly* in the CVS checkout 
instead?

It should literally be as easy as doing something like

	cd /path/to/cvs/checkout_X
	export GIT_DIR=/path/to/git/repo
	git add .
	git commit -m"Import yyyymmdd snapshot"

and you never copy anything around, and git will just notice on its own 
what CVS has changed.

You'd have to make sure that you have the CVS directories ignored, of 
course, and if you don't want to change the CVS directory at all (which is 
a good idea!) you'd need to do that by using the "ignore" file in your 
GIT_DIR, and just having the CVS entry there, instead of adding a
".gitignore" file to the working tree and checking it in.

The first time you do this it will be expensive, since it will re-compute 
all the SHA1's in the .git/index file, but afterwards, it will be able to 
use the index file to speed up operation, which is what is going to make 
this all *much* cheaper than removing the old files and copying all the 
files around anew.

(You can just force the re-indexing by doing a "git status" once, ie do

	cd /path/to/cvs/checkout_X
	export GIT_DIR=/path/to/git/repo
	git status

which will do it for you, and now all the subsequent snapshot generation 
should be trivial and very fast).

The above is totally untested, of course, but I think that's the easiest 
way to do things like this. In general, it should be *trivial* to do 
snapshots with git using just about _any_ legacy SCM, exactly because you 
can keep the whole git setup away from the legacy SCM directories with 
that "GIT_DIR=.." thing. 

(Of course, you could just move the .git directory into the CVS checkout 
too - and then CVS will just ignore it. But it may be a good idea to just 
keep them explicitly separate).

			Linus
