From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Questions about repo and git submodule
Date: Tue, 23 Dec 2008 07:29:51 -0800
Message-ID: <20081223152951.GB27865@spearce.org>
References: <856bfe0e0812230601m1765b483pe62c7902849e9cea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: Emily Ren <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 16:31:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF9E7-000303-5w
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 16:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbYLWP3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 10:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbYLWP3x
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 10:29:53 -0500
Received: from george.spearce.org ([209.20.77.23]:35981 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbYLWP3w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 10:29:52 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9522938200; Tue, 23 Dec 2008 15:29:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <856bfe0e0812230601m1765b483pe62c7902849e9cea@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103829>

Emily Ren <lingyan.ren@gmail.com> wrote:
> 
> I have some questions about android repo and git submodule.
> 
> I created a repo repository with below commands:
> 1.  repo init -u git://android.git.kernel.org/platform/manifest.git
> 2.  repo initialized in /android
> 
> 1. The android dir is not a git repository,

Correct, it is not a git repository.  The repo tool does not use
git submodules.  The top level of a repo client has a ".repo/"
directory with metadata, not a ".git/" directory.  The table of
contents (the subprojects) is stored in XML files under ".repo/".

<aside>
I actually fought against the XML format for repo's manifest, but
others felt it was suitable.  And then walked away from the project
after Android open-sourced its code tree.  Leaving me to maintain it.
I see a file format simplification in the future for repo.
</aside>

> if other people clone my
> android code, how does it work?

Sadly this isn't supported correctly.  You can't initialize one
repo client from another, even though you can git clone one git
repository from any other.  Its a bug in repo's design.  The data
under ".repo/projects/" isn't laid out correctly to permit reuse
of one repo client to initialize another.

Its something I keep meaning to fix, but its going to take some
real effort.

In the mean time, there is a "--mirror" flag to repo init
which can be used to clone everything into bare repositories.
Those bare repositories can be published for others to repo init
from, though you need to customize the manifest.git:default.xml
so that the embedded URL refers back to your server and not
android.git.kernel.org.  Yet another thing I want to fix.

> 2. I want to make android dir to be a git repository, is it workable
> that I create submodule for each subdirectory in another directory? Is
> there a script for it?

You might be able to do something like this:

	cd /android
	git init
	repo forall -c 'cd /android && git submodule add `pwd`'

Also, you might want to consider asking questions related to repo
on the repo-discuss@googlegroups.com mailing list.  There's a lot
more repo users there than on the git mailing list, and they have
started to come up with their own "tips n tricks".

-- 
Shawn.
