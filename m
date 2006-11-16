X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [DRAFT] Branching and merging with git
Date: Thu, 16 Nov 2006 15:47:19 -0800
Message-ID: <7vslgj2bug.fsf@assigned-by-dhcp.cox.net>
References: <20061116221701.4499.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 23:47:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061116221701.4499.qmail@science.horizon.com>
	(linux@horizon.com's message of "16 Nov 2006 17:17:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31639>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkqxC-0002pk-Pm for gcvg-git@gmane.org; Fri, 17 Nov
 2006 00:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424597AbWKPXrV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 18:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424601AbWKPXrV
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 18:47:21 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:43214 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1424597AbWKPXrU
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 18:47:20 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116234720.JGII9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 18:47:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nbnS1V00L1kojtg0000000; Thu, 16 Nov 2006
 18:47:26 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

linux@horizon.com writes:

> I know it took me a while to get used to playing with branches, and I
> still get nervous when doing something creative.  So I've been trying
> to get more comfortable, and wrote the following to document what I've
> learned.
>
> It's a first draft - I just finished writing it, so there are probably
> some glaring errors - but I thought it might be of interest anyway.

This is a greatest write-up I've seen for the past several
months.  I find it very balanced to point out the quirks people
would find difficult and explain why things are so by including
historical notes in appropriate places when needed.  Definitely
Documentation/ material when copyediting is done.

I have finished only the first half because it's not my git day
today, but so far...

> * Naming revisions
>...
> Second, you can refer to a head or tag name.  Git looks in the
> following places, in order, for a head:
> 	1) .git
> 	2) .git/refs
> 	3) .git/refs/heads
> 	4) .git/refs/tags

You might want to check this with the array in sha1_name.c::get_sha1_basic().
I think tags comes earlier than heads.

> 2) Revert changes to a small number of files.
>
> 	git checkout [<revision>] [--] <paths>
>    will copy the version of the <paths> from the index to the working
>    directory.  If a <revision> is given, the index for those paths will
>    be updated from the given revision before copying from the index to
>    the working tree.
>
>    Unlike the version with no <paths> specified, this does NOT update
>    HEAD, even if <paths> is ".".

It's great that you talk correctly about the latest feature-fix
that is queued for maint but not yet pushed out.

> 2) By path name.  This is a feature which appears to be unique to git.
>    If you give git-rev-list (or git-log, or gitk, or qgit) a list of
>    pathname prefixes, it will list only commits which touch those
>    paths. So "git log drivers/scsi include/scsi" will list only
>    commits which alters a file whose name begins with drivers/scsi
>    or include/scsi.
>
>    (If there's any possible ambiguity between a path name and a commit
>    name, git-rev-list will refuse to proceed.  You can resolve it by
>    including "--" on the command line.  Everything before that is a
>    commit name; everything after is a path.)
>
>    This filter is in addition to the ancestry filter.  It's also rather
>    clever about omitting unnecessary detail.  In particular, if there's
>    a side branch which does touch drivers/scsi, then the entire branch,
>    and the merge at the end, will be removed from the log.

"If there's a side branch which does NOT touch the paths..." I think.

> * Alternate branch naming
>
> The original git scheme mixes tracking branches with all the other heads.
> This requires that you remember which branches are tracking branches and
> which aren't.  Hopefully, you remember what all your branches are for,
> but if you track a lot of remote repositories, you might not remember
> what every remote branch is for and what you called it locally.

I think you wanted to mention .git/refs/remotes hierarchy and
separate-remote here, but haven't elaborated yet...

> * Remote tags
>
> TODO: Figure out how remote tags work, under what circumstances
> they are fetched, and what git does if there are conflicts.

refs/tags namespace is not policed at all by git and is treated
as a global namespace, controlled mostly by social convention
that your "upstream" (or central distribution point) supplies
tags for people who use it to synchronize to share.  Also, since
there is no guarantee that tags point at commits (v2.6.11-tree
tag is a pointer to a tree object, for example), there is no
farst-forward check performed for them.

The rule we use to autofollow tags currently is:

When you use shorthand fetch (or pull), we find tags that do not
exist locally, and if the object they point at are already found
in the repository then we fetch them automatically.  So for
example, if you are only tracking my 'maint' and not 'master'
nor 'next', and if you have tags up to v1.4.3.2, your "git fetch
origin" would update your copy of 'maint' and bring the commits
reachable from the tip of my 'maint'.  After that it notices
that v1.4.3.3, v1.4.3.4, v1.4.3.5 tags are in my repository but
missing from yours. It also notices that now you have
v1.4.3.3^{}, v1.4.3.4^{} and v1.4.3.5^{} in your repository, so
it issues another round of "git fetch" internally to fetch these
three tags.  At the same time it would also notice that I have
v1.4.4 tag that you do not have, but v1.4.4^0 commit is not
something you would get by fetching 'maint', so it would not
fetch it automatically.
