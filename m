From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Odd .gitignore behaviour
Date: Thu, 15 Nov 2007 10:56:27 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711151044150.2786@woody.linux-foundation.org>
References: <80ir431xny.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 19:57:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isjtb-0003mT-DY
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 19:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763762AbXKOS4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 13:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761068AbXKOS4l
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 13:56:41 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59906 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760758AbXKOS4k (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 13:56:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAFIuSSP025866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Nov 2007 10:56:31 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAFIuRa5010090;
	Thu, 15 Nov 2007 10:56:28 -0800
In-Reply-To: <80ir431xny.fsf@tiny.isode.net>
X-Spam-Status: No, hits=-1.809 required=5 tests=AWL,BAYES_00,SUBJECT_FUZZY_TION
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65150>



On Thu, 15 Nov 2007, Bruce Stephens wrote:
> 
> So surely sub1/sub2/foo ought to be included again?  Or is the first
> line in sub1/.gitignore not "a previous pattern" in this sense?

Yes.

The negated patterns have to show up *before* the patterns that they 
override, because the first pattern that matches is the one that is used.

> If I move the "foo" pattern up a level, creating a .gitignore in base
> just containing "foo", then sub1/sub2/foo is still regarded as
> ignored, even though it surely matches the negating pattern
> sub1/.gitignore, and that should be of higher precedence than the
> pattern in base/.gitignore?

The priority between nested .gitignore files should be that inner files 
have higher priority than outer files (since the inner ones "know more", 
and the outer ones are "generic").

So what you describe sounds wrong.

But my quick test didn't actually support the behaviour you see. In this 
situation:

	[torvalds@woody git-test]$ cat .gitignore
	a*
	[torvalds@woody git-test]$ cat subdir/.gitignore
	!a-ok
	[torvalds@woody git-test]$ find *
	all-files
	subdir
	subdir/a-ok
	[torvalds@woody git-test]$ git ls-files -o --exclude-per-directory=.gitignore
	.gitignore
	subdir/.gitignore
	subdir/a-ok

ie we *do* show "showdir/a-ok" (but we don't show "all-files") because 
a-ok is explicitly marked to be not ignored by a higher-priority rule.

Side note: "git status" uses the "--directory" flag, so it will not even 
recurse into unknown directories, and will instead apply the gitignore 
rules to the directory names, so you get:

	[torvalds@woody git-test]$ git ls-files -o --exclude-per-directory=.gitignore --directory
	.gitignore
	subdir/

which doesn't show "a-ok", but that's for a totally unrelated reason and 
has nothing to do with .gitignore!

		Linus
