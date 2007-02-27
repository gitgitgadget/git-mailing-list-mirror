From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: RFC: Patch editing
Date: Tue, 27 Feb 2007 02:14:55 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702270205540.6485@iabervon.org>
References: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 08:15:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLwYS-0004on-Uv
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 08:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbXB0HPA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 02:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbXB0HPA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 02:15:00 -0500
Received: from iabervon.org ([66.92.72.58]:1185 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbXB0HO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 02:14:59 -0500
Received: (qmail 8098 invoked by uid 1000); 27 Feb 2007 02:14:55 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2007 02:14:55 -0500
In-Reply-To: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40698>

On Sun, 25 Feb 2007, Johannes Schindelin wrote:

> Hi list,
> 
> while I was hacking on another issue, I realized just how often I would 
> like to stash away a fix which is unrelated (but often triggered) by the 
> theme of the current topic branch. Or I fix an earlier commit, which is 
> not the tip of the branch, so I cannot --amend it.
> 
> My common practice is to commit it nevertheless, and sort the topic 
> branches out later, by cherry-picking my way through the commits.
> 
> This is a tedious and error-prone procedure, and I often wished I knew how 
> to use StGIT. But then, StGIT is overkill for me: on some machines I work 
> on, there is no Python installed, I do not really need to have a history 
> on the order and version of patches, and I do not need to preserve author 
> and committer information *1*.
> 
> Therefore, I wrote this extremely simple script to sort out the order of 
> commits, and possibly merging some. The script lets you edit the commit 
> list upon start (reordering it, or removing commits), and then works on 
> that list.

For much the same reason, I wrote a script that entirely ignores the 
intermediate commits in a throw-away head, and lets you trim down the diff 
between the mainline and your head, and arrange it into a new patch 
series. Never got around to making it particularly nice, but it might be a 
good starting point for someone who wants to make something useable. (In 
its current state, you need some external tool that you're comfortable 
editing diffs with, and it doesn't do anything with any commit messages 
you may have written)

	-Daniel
*This .sig left intentionally blank*

#!/bin/sh

if [ "$1" != "" ]
then
  git-symbolic-ref REFINE_HEAD refs/heads/$1
fi

if [ -f .git/refine-patch ]
then
  if ! git-apply --index .git/refine-patch
  then
    exit 1
  fi
  rm .git/refine-patch
  echo "Applied selected changes; verify and commit"
  exit 0
fi

if git-status > /dev/null
then
  echo "Uncommitted changes; verify and commit"
  exit 0
fi

git-diff -M HEAD REFINE_HEAD > .git/refine-patch
if [ -s .git/refine-patch ]
then
  $EDITOR .git/refine-patch
else
  echo "All done"
  rm .git/refine-patch
fi
