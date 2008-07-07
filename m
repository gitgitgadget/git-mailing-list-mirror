From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: git-svn sucks when it should not
Date: Mon, 7 Jul 2008 02:00:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807070135450.7342@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 07 02:01:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFeAO-0005Rv-DK
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 02:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757206AbYGGAAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 20:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757204AbYGGAAR
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 20:00:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:32906 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757198AbYGGAAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 20:00:16 -0400
Received: (qmail invoked by alias); 07 Jul 2008 00:00:14 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp059) with SMTP; 07 Jul 2008 02:00:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194kLdkReB4UH6JfrZ+FAHNv3gJCE4kBzdJaageEy
	cxDB0UgHSaMqmV
X-X-Sender: user@eeepc-johanness
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87567>

Hi Eric,

I have the pleasure of needing to work with a subversion project where 
parts of the webserver are password restricted.

In particular, I cannot access the parent directory, and one of 
the branches is protected, too.

Maybe you remember me describing that problem on IRC a few weeks ago: yes, 
it is still persistent.

Now, I thought that I know my way around Perl, at least a little bit, but 
while git-svn barfed on the repository, I... uhm, well, you probably get 
the idea.

The funny part is this: when I say "git svn clone $URL/trunk", or the same 
with the absolute paths to the single tags, instead of "git svn clone -s 
$URL", git-svn does the correct thing.  It works, importing the stuff as 
"git-svn".

So I tried to just edit out by hand the branches section, so that the 
password-protected branch would not be a problem.

The result was surprising: git svn fetch exited with success, but it 
did... absolutely nothing.

After a lot of frustrating hours, which were not at all helped by 
brilliant variable names such as "r" and "gsv", I now know this: the log 
contains paths that do not have a prefix "trunk", but "<dir>/trunk", 
where "<dir>" is the last directory of the URL.

Changing git-svn's URL to the parent of <dir> is a no-go, since that is -- 
as I mentioned above -- password protected.

Yes, in a perfect world I could just force the admin to change that, but 
no, this is not a perfect world, so do not even try to suggest that if 
you want to help.

Changing the fetch line to "<dir>/trunk:refs/remotes/trunk" does not work 
either, since git-svn cleverly checks $URL/<dir>/<dir>/trunk/.

I then tried to hack match_globs() and match_paths() to add that extra 
prefix to the patterns, so that that extra prefix + trunk would be 
matched and edited out.  This happened to work out alright.

But I tried for several hours to get in a proper solution which does not 
throw up on the tags, and I have to conclude that this piece of code is 
not hackable by anybody else but you.

So I stand defeated by your program.  Thank you.

My ugly, ugly workaround that is however easy, easy, is a shell script 
that uses curl to find out what refs are new, and clones each ref 
individually, then pushes all the results together into one repository.

Should not have been _that_ hard,
Dscho
