From: Steven Grimm <koreth@midwinter.com>
Subject: Pushing to a non-bare repository
Date: Fri, 02 Feb 2007 19:01:28 -0800
Message-ID: <45C3FB08.1020805@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 04:01:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDB9a-0005UP-Cm
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 04:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946265AbXBCDBW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 22:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946301AbXBCDBW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 22:01:22 -0500
Received: from tater.midwinter.com ([216.32.86.90]:43914 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1946265AbXBCDBV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 22:01:21 -0500
Received: (qmail 26221 invoked from network); 3 Feb 2007 03:01:20 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=E/lnME2k02jgZsgdbCZFK+Ja7zZ4weGnaxEXxnuZ6daJP7KwceAeFAR4eO088/vv  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 3 Feb 2007 03:01:20 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38547>

This keeps coming up as I introduce people to git. In previous 
discussions, the conclusion often seems to be that users don't really 
know what they want the semantics to be. So here's what I want. I think 
it's actually not that complicated to get something that'll be far more 
useful than what we have today.

1. If the target repo has a branch other than the target branch checked 
out, allow the push and don't touch the working copy. (By "allow the 
push" here I mean proceed with the existing push behavior, which might 
still error out if, e.g., the target branch has commits that aren't in 
the local repo yet.)

2. If the target repo has the target branch checked out and the working 
copy equals its head, allow the push and reset the working copy to the 
newly created head. Basically this is equivalent to a simple 
fast-forward pull in the other direction.

3. If the target repo has the target branch checked out and there are 
uncommitted edits, block the push and return an error indicating the 
target repo is being edited and can't be pushed to until the edits are 
undone or committed.

That's it. No merging of local edits in the target, just the same 
semantics as a push to a bare repo (in case 1) or a fast-forward 
operation with no merging (case 2). Would it be even nicer to have some 
automatic merge magic in case 3? Maybe, but cases 1 and 2 are still very 
useful without it.

In particular, those two cases would completely cover the two situations 
where I most often want to push to a checked-out parent: a common 
integration area that we can browse manually or point a Web server or a 
compiler at as a source directory, and (more important to me) a 
bidirectional sync mechanism between my laptop and my server, where I 
want to commit my changes then send them to the other side to continue 
working. Right now git requires me to set up a dummy parent repository 
that both my laptop and my server repositories are clones of, and I have 
to run an extra "pull" after each push to get the changes where I want 
them. No purpose is served by that parent repository except to satisfy 
git's requirement that a push target has to be bare.

Another place where the current situation is a bit weak is when I want 
to clone someone's repo to help them fix a bug. If I clone it onto my 
laptop, I end up having to email diffs back; our corporate network 
doesn't allow us to make TCP connections to our laptops, only from our 
laptops, so it is impossible for the other person to log onto the server 
and pull from my clone. If I could push back to a topic branch in the 
other person's repo, they could merge my change into their working copy 
at their leisure.

Is this actually more complicated than the above? What am I missing?

-Steve
