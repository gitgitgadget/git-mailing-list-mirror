From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2 19/24] Added the class AddRuleListFactory.
Date: Mon, 12 May 2008 21:29:09 -0400
Message-ID: <20080513012909.GG29038@spearce.org>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-20-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Tue May 13 03:30:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvjLB-0006Oi-TB
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 03:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbYEMB3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 21:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756354AbYEMB3N
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 21:29:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50257 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904AbYEMB3N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 21:29:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JvjK8-0003vm-6O; Mon, 12 May 2008 21:29:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D39F120FBAE; Mon, 12 May 2008 21:29:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1210623222-24908-20-git-send-email-florianskarten@web.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81978>

Florian Koeberle <florianskarten@web.de> wrote:
> +class AddRuleListFactory {
> +	/*
> +	 * The add command of git 1.5.2.5 behaves a little bit stange: "git add
> +	 * a/\*z" adds the file "a/b/xyz" but "git add a/x\*" does not.
> +	 * 
> +	 * The first is parsed as pattern "*z" for whole directory tree "a". The
> +	 * second is parsed as an path.
> +	 * 
> +	 */

Its not strange.  C Git expands each file path to its _full_ path
and stores that into a buffer, then runs fnmatch() for each pattern
on the buffer.  If fnmatch() succeeds the path is added to the index.

In the case above we are running a match of "a/\*.z" against
"a/b/xyz" and that passes.  Or we run "a/x\*" on "a/b/xyz" and it
fails as the sequence of characters "a/x" does not appear in the
string "a/b".

You are running into this odd corner case because you are not
treating the pattern passed as something that matches against the
entire path.  This is one reason why TreeFilter's use the entire
path when they process an entry for inclusion or exclusion, and why
TreeWalk has each AbstractTreeIterator append the current entry name
onto the end of the current path buffer, so we can always examine
the full path from the root of the repository/working directory.

Trying to avoid the full path in classes like ComplexFilePattern
is why you are running into this corner case here, and must now do
extra contortions to somewhat match the behavior of C Git.

At this point I think most of the rules package is overcomplicated
and overoptimized, and yet doesn't actually quite match the behavior
of C Git.

-- 
Shawn.
