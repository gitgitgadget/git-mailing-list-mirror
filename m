X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Locked down (but still shared) repositories
Date: Thu, 7 Dec 2006 06:35:39 -0500
Message-ID: <20061207113539.GA10781@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 11:36:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33570>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsHXq-0008Og-Br for gcvg-git@gmane.org; Thu, 07 Dec
 2006 12:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032076AbWLGLfo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 06:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032077AbWLGLfo
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 06:35:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37825 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1032076AbWLGLfn (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 06:35:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsHXO-0007KD-LX for git@vger.kernel.org; Thu, 07 Dec 2006 06:35:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 90DD320FB6E; Thu,  7 Dec 2006 06:35:39 -0500 (EST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I have a number of repositories that I want to share across a number
of users on the same UNIX system.

For various auditing reasons the repositories need to be tightly
controlled.  That is the following cannot be permitted:

  * delete or overwrite a loose object;
  * delete or overwrite a pack file;
  * delete or overwrite a ref, except see below;
  * change the config;
  * change the description;
  * change HEAD;

The only changes that are permissible can be made through
git-receive-pack, which limits the user to only the following:

 * upload (possibly new) objects;
 * create/update/force-update a ref;
 * delete a ref;

And the latter two are controlled by a very strict update hook.
The update hook checks the ref name and real user id against
an ACL file (info/allowed-users) and checks to see if the user
can perform the requested operation against that ref, with four
operations being recognized:

  * A == the ref is being created;
  * U == the ref is being fast-forwarded;
  * R == the ref is being rewound/reset;
  * D == the ref is being deleted;

The update hook also requires that all lines returned by:

  git-rev-list --pretty=raw $3 --not --all | egrep ^committer

correspond to a name/email address combination registered in another
table for the real user id (info/allowed-committers).  Which means
we can actually trust the committer field of all commits which
are referenced by refs, as the UNIX system authenticated them.
The tagger field is also checked for every tag, but its slightly
more involved than the simple line above as it peels back the tag
layers as needed.  :)

So the update hook is update-hook-example.txt, but suffering from
extreme paranoia and has been put on steriods.  I'm considering
sending it in for Documentation/howto, or contrib.


Which brings me to the following problem:

I can't create the repository with --shared, as the UNIX users
all have normal shell access to the system.  (/bin/rm would work
wonders to let a user violate a number of the items above.)

I also cannot create secondary git-only UNIX accounts for each user,
using git-shell in the git-only account.  (For example "spearce"
and "spearce-git", with the latter using git-shell and being in a
group which does have repository access, while the former doesn't.)

The workaround that I have come up with is the following:

The repositories are all owned by a single user, and were created
without --shared, so only the owner can modify the repository.
The repositories are however readable by a specific group, and
all permitted users of that repository are members of that group.
So they can read the repository files directory, which works very
well with objects/info/alternates.  :-)

git-receive-pack on this system is owned by the same repository
owner, and is also marked setuid.  Consequently when a user pushes
into a repository the effective uid is that of the repository owner,
objects can be written, refs can be changed, the update hook runs
setuid, and it enforces everything.


The problem now is what happens when users try to use Git
as a distributed tool and push changes between their own two
repositories?  Even if the two specific users can agree on using
--shared (because maybe they actually read the Git manual and want
to use that feature), git-receive-pack runs setuid as the blessed
repository user.  Any update hook installed within one of these
'user private' repositories is untrusted, but will be running with
enough permissions to run /bin/rm and destroy data.  See above
about how I can't have that...

So I've patched git-receive-pack to refuse to run if its running
setuid and the hook's owner isn't the effective uid, or the hook
is group/world writable.  This seems to close the last hole, but
it also makes hooks/update and hooks/post-update useless in user
private repositories on this system.


I'm sending this to try and solicit better ideas from the mailing
list.  We have a lot of UNIX guru types, and a lot of Git guru types,
and they are all smarter than I...  ;-)

-- 
