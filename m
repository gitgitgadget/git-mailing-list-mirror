From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: svn to git, N-squared?
Date: Sun, 11 Jun 2006 21:02:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606112056440.5498@g5.osdl.org>
References: <9e4733910606111902l709c71ccyf45070d55112739e@mail.gmail.com> 
 <Pine.LNX.4.64.0606112028010.5498@g5.osdl.org>
 <9e4733910606112039p7aff60c7w7a074d0e35c7b0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 06:03:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpddu-0007O6-LT
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 06:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWFLECt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 00:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWFLECs
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 00:02:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20205 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750803AbWFLECs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 00:02:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5C42jgt017503
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Jun 2006 21:02:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5C42iNS008030;
	Sun, 11 Jun 2006 21:02:45 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606112039p7aff60c7w7a074d0e35c7b0f@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21687>



On Sun, 11 Jun 2006, Jon Smirl wrote:
> 
> I have it stopped and I am running the repack.
> There are 1.27M files in my .git directory

Yeah, that would do it. That's ~5000 files per object directory, so I 
assume that your directories are 200+kB in size, and for every new object 
added, you'll basically have to traverse the old directory fully in order 
to find an empty place for it (and without hashing, you'll traverse it 
_twice_ - first to look for it, then to look for the empty space).

Btw, after repacking, if it still has lots of lose objects, and you still 
have several directories that are huge (because there are pending objects 
for a commit that didn't happen yet when you ^Z'd the svnimport), you'll 
literally get better performance if you do something like

	for i in ??
	do
		cp -r $i $i.new
		rm -rf $i
		mv $i.new $i
	done

in your .git/objects/ directory (CAREFUL! Any script that does "rm -rf" 
should be double- and triple-checked for sanity! ;)

That should make sure that you don't still have huge directories.

(And yes, this is a real problem at least with ext3).

The git cvsimporter ends up repacking the archive every thousand commits. 
That's just a random number, but it's indicative of what we did there to 
handle large imports. I don't think anybody has done a large import using 
the git-svnimport before, so you're in new territory which explains some 
of the teething problems.

		Linus
