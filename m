From: Andreas Krey <a.krey@gmx.de>
Subject: Re: 'Failed to create .git/index.lock'
Date: Mon, 15 Feb 2016 22:34:36 +0100
Message-ID: <20160215213436.GB16220@inner.h.apk.li>
References: <20160209075829.GA12331@inner.h.apk.li> <5B9871D2-395D-4F0C-94FB-278832FCFD76@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:34:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQn8-0004EE-CF
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbcBOVen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:34:43 -0500
Received: from continuum.iocl.org ([217.140.74.2]:43585 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbcBOVem (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:34:42 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id u1FLYaL29522;
	Mon, 15 Feb 2016 22:34:36 +0100
Content-Disposition: inline
In-Reply-To: <5B9871D2-395D-4F0C-94FB-278832FCFD76@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286245>

On Mon, 15 Feb 2016 18:06:33 +0000, Lars Schneider wrote:
> Hi Andreas,
> 
> I am looking into a similar issue with SourceTree on Windows right now. However, in my case it only happens when I switch branches.

Semi-bingo. That is actually a difference between the workspace this
happens in and the others. This one works on many branches; the others
clone anew for each new branch.

I investigated the Git commands that SourceTree triggers and it looks like it is doing something like this:

> (1) Run checkout command
> git.exe --no-pager -c color.branch=false -c color.diff=false -c color.status=false -c diff.mnemonicprefix=false -c core.quotepath=false checkout MY-BRANCH
> 
> (2) Run rev-parse command 
> git.exe --no-pager -c color.branch=false -c color.diff=false -c color.status=false -c diff.mnemonicprefix=false -c core.quotepath=false rev-parse HEAD^1
> 
> My assumption is that SourceTree triggers these two commands in parallel and sometimes (2) locks the repo first which makes (1) fail.

That would be partly a bug in SourceTree to do so.

> Does your Git process run on Windows, too?

No. RHEL7 Linux.

> Is there a possibility that you issue Git commands in parallel?

I don't think so, except for background GC (which isn't quite background -
one phase seems to still run foregrounded).

> I also have read that certain anti virus software can trigger these errors on Windows.

That is an ugly problem indeed.

> I looked through the Git code found that increasing "core.packedrefstimeout" [1] might help in some cases that trigger this error [2] but not in others [3]. In my case this seems to help. Maybe it's worth a try for you, too?

I may need to look into that. Because sometimes the lock causes my
automatic process to fail but the lock file isn't there anymore when
I get to cleanup. But sometimes it keeps existing.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
