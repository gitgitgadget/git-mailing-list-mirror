From: Eric Wong <normalperson@yhbt.net>
Subject: Re: using git-svn with --no-metadata
Date: Sat, 21 Aug 2010 18:37:11 +0000
Message-ID: <20100821183711.GA14986@dcvr.yhbt.net>
References: <E1OmnCj-0001Z7-2U@smtp.tt-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vadim Zeitlin <vz-git@zeitlins.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 20:37:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmswV-0003oo-8r
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 20:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866Ab0HUShO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 14:37:14 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34963 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768Ab0HUShN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 14:37:13 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA471F514;
	Sat, 21 Aug 2010 18:37:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <E1OmnCj-0001Z7-2U@smtp.tt-solutions.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154150>

Vadim Zeitlin <vz-git@zeitlins.org> wrote:
>  Hello,
> 
>  First of all, let me use this opportunity to thank you for writing
> git-svn, it's the best thing since, well, probably git itself! Second,
> I'm sorry to bother you directly but I simply couldn't find any mailing
> list for git-svn and I wasn't sure if this was appropriate for the git
> mailing list itself. If I was wrong about not posting this there, please
> feel free to redirect/reply to git list if you prefer to discuss it there
> (I'd appreciate if you could still cc me in this case though).

Hello Vadim, you're welcome!

git-svn has always used the git mailing list.  Feel free to Cc
maintainers of particular subsections even when posting to the mailing
list, too.  The mailing list gets a lot of traffic, so we always
Cc folks who are relevant to the discussion.

>  Now to my question: I thought it would be a good idea to import an svn
> repository with --no-metadata option as I hoped that this would avoid the
> rewriting of commits which happen when git topic branches are checked in
> into svn with "git svn dcommit". The documentation (for my 1.7.1 version)
> did say that:

dcommit would have to rewrite commits anyways, since we sync the
usernames and commit times from SVN.  You can't avoid rewriting commits
unless you use "git svn set-tree" (on the other hand, set-tree can be
unfriendly to other SVN users).

> 	If you lose your .git/svn/git-svn/.rev_db file, git svn will not be
> 	able to rebuild it and you won't be able to fetch again, either.

> but I understood it as meaning that I wouldn't be able to fetch again if
> the file was lost (the file name appears to be wrong BTW, since the switch
> to rev_map from rev_db some time ago) and thought that it was ok as long as
> I took care to backup the .git/svn contents regularly. Apparently I was
> wrong as "git svn fetch" doesn't work even immediately after the import and
> looking at the code I see that working_head_info() only ever uses
> git-svn-id: lines in the commit messages and never rev_{db,map} files.
> 
>  So -- finally -- the questions are:
> 
> 1. Is this indeed the case, i.e. is importing from svn really impossible
>    with --no-metadata even if no files are lost? If so, I think it would
>    be nice to make the property description in the man page more clear.

rev_map (and rev_db before it) are designed for mapping SVN revision
numbers into git SHA1 identifiers.  rev_db used a simple but
space-inefficient offset lookup based on the SVN revision number.
rev_map uses a binary search also based on the SVN revision number.

> 2. Is it possible to implement getting the working head info from the
>    cached revision mappings instead of extracting it from the comments?
>    If so, would it be worth looking into doing this or is it something
>    that is doomed to fail anyhow?

It's possible to do a reverse mapping inefficiently (O(n)) by scanning
the values of the SHA1 commits.  You can add a hash database on disk,
too.  I don't think either is worth the effort in maintenance, though.
Nowadays git-filter-branch is in mainline git, and I recommend
using that for projects ready to drop SVN/git-svn entirely for git.

I'll update the docs accordingly.

-- 
Eric Wong
