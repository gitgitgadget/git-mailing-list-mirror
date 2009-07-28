From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn fetches the same revision multiple times for non-trunk
	branches
Date: Tue, 28 Jul 2009 02:41:22 -0700
Message-ID: <20090728094122.GB25863@dcvr.yhbt.net>
References: <CEAA2460-501C-48C1-BC33-B92A68C2161B@gmail.com> <20090725105111.GB13534@dcvr.yhbt.net> <E9365F62-FD6F-4770-B177-9B8F0413C12C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Zeh <robert.a.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 11:41:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVjBe-0004oW-Nz
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 11:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbZG1JlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 05:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbZG1JlY
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 05:41:24 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42224 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbZG1JlY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 05:41:24 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 47F7D1F4EA;
	Tue, 28 Jul 2009 09:41:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <E9365F62-FD6F-4770-B177-9B8F0413C12C@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124228>

Robert Zeh <robert.a.zeh@gmail.com> wrote:
> So is the basic problem that the history of the branch is unknown and we 
> have to retrieve the history?

Yes, or rather it's not known that it's a branch/tag:

Say you have something like this:

  /trunk/client
  /trunk/server
  /trunk/design_docs_specs_and_whatnot
  /tags/client_1.0
  /tags/client_1.1
  /tags/server_1.0
  /tags/server_1.1

But you're tracking /trunk, /tags/*, /branches/* like you normally do,
all the developers usually work off /trunk anyways because /client
changes are tied to /server and they have both checked out and
they also need to read/update the docs common to the server and
client.

However, tags are deployed to separate machines and the docs don't need
to be; so they're tagged separately off their respective working
directories.

So when git svn sees /tags/client_1.0, it'll think that it was tagged
off /trunk and not /trunk/client.  But since you're tracking /trunk and
not /trunk/client, it can't find history in /trunk.  So it starts
tracking /trunk/client anew without taking /trunk into account.

So git svn will create a ref that looks like tags/client_1.0@REV.  What
git svn could (and if somebody found time to work on it) is to reuse
any/first tags/client_1.0@REV tags it finds.

And simply using the existing git history of /trunk to see the history
of /trunk/client is suboptimal, too, because /trunk/client could've
originally come from /client (an actual case I've encountered) before
/trunk existed.

Remember, unlike SVN, git doesn't track directory renames (or renames,
or directories at all) for that matter.  This is a huge fundamental
difference between the two systems and mapping between them was one of
the greatest difficulties I had with git svn.

The very first version of git svn was something that would only ever
dumbly track one directory (and it still supports that mode of
operation, just don't pass any options to init/clone).  So a git working
tree might have trunk, branches/*, tags/* all on the filesystem.  It's
a very big working tree in some cases, but it was the easiest to
implement because it didn't do anything smart.

-- 
Eric Wong
