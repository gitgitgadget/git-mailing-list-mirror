From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-diff-index -C problem
Date: Mon, 18 Jun 2007 02:26:41 -0400
Message-ID: <20070618062641.GK18491@spearce.org>
References: <69b0c0350706172248l6343e4c6yfd36ced8230a11ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Govind Salinas <govindsalinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 08:26:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0AhK-0004hJ-PI
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 08:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbXFRG0p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 02:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754890AbXFRG0p
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 02:26:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55369 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbXFRG0o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 02:26:44 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I0AhG-0006UC-AZ; Mon, 18 Jun 2007 02:26:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7248420FBAE; Mon, 18 Jun 2007 02:26:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <69b0c0350706172248l6343e4c6yfd36ced8230a11ef@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50382>

Govind Salinas <govindsalinas@gmail.com> wrote:
> I am writing a porcelain for git and I have been playing with
> git-diff-index. I noticed that if i copy a file and git-add the copy
> it shows the file added, as i expect...
> 
> But then if i then say git-add on the original file, i expect that -C
> would check that file to see if it was copied, it does not.  If i
> touch the file, then git detects the copy, so git-add is not forcing
> git to consider the file modified.

Oddly enough if you add --find-copies-harder Git does actually
find the copy then, without needing to make the file stat-dirty
in the index.

  $ rm -rf foo;mkdir foo;cd foo;git init
  Initialized empty Git repository in .git/

  $ echo hello >a;git add a; git commit -m a
  Created initial commit 9d2537b: a
   1 files changed, 1 insertions(+), 0 deletions(-)
   create mode 100644 a

  $ cp a b;git add b
  $ git diff-index --abbrev HEAD
  :000000 100644 0000000... ce01362... A  b
  $ git diff-index --abbrev -C HEAD
  :000000 100644 0000000... ce01362... A  b
  $ git diff-index --abbrev -C --find-copies-harder HEAD
  :100644 100644 ce01362... ce01362... C100       a       b

  $ touch a
  $ git diff-index --abbrev -C HEAD
  :100644 100644 ce01362... 0000000... M  a
  :100644 100644 ce01362... ce01362... C100       a       b

I *think* the reason this happens is because -C means to find a copy
among the other modified files.  Because "a" was not modified (unless
it is stat-dirty or otherwise modified) then "b" is not a copy of it.

The --find-copies-harder makes us also look at the unmodified files,
and there we find the copy.

Indeed, the documentation says exactly that:

  --find-copies-harder::
      For performance reasons, by default, `-C` option finds copies only
      if the original file of the copy was modified in the same
      changeset.  This flag makes the command
      inspect unmodified files as candidates for the source of
      copy.  This is a very expensive operation for large
      projects, so use it with caution.  Giving more than one
      `-C` option has the same effect.

So what you are seeing is actually as designed, and documented.

-- 
Shawn.
