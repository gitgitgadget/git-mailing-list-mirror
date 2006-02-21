From: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Git cannot push to repository with too many tags/heads
Date: Tue, 21 Feb 2006 13:46:07 -0500
Message-ID: <1140547568.5509.21.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Stephen Tweedie <sct@redhat.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 19:46:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBcWg-0005mX-Vu
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 19:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWBUSqP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 13:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbWBUSqP
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 13:46:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23185 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932626AbWBUSqP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 13:46:15 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k1LIkEBf028859
	for <git@vger.kernel.org>; Tue, 21 Feb 2006 13:46:14 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k1LIk9126346;
	Tue, 21 Feb 2006 13:46:09 -0500
Received: from vpn83-173.boston.redhat.com (vpn83-173.boston.redhat.com [172.16.83.173])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id k1LIk9As028584;
	Tue, 21 Feb 2006 13:46:09 -0500
To: git mailing list <git@vger.kernel.org>
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16540>

Hi,

I'm using git's cvs import to track the Fedora kernel rpm repository,
and it has just passed a watermark that git cannot currently cope with.

The problem is the large number of branches and tags on this repository.
A tag for every build means that the number builds up rapidly, and
git-send-pack has an internal limit of 900 refs to query when building a
pack.

I hoped this wouldn't be a problem.  In theory, I should just be able to
push to a single refspec and avoid that limit entirely.  But no ---
unfortunately, git is determined to push out the objects for *every* ref
that matches between src and dst when building the pack, even if it's
not actually going to update the remote ref.  And in building the
git-rev-list argument list for that colossal update, it exceeds the
internal limit of 900 refs in exec_rev_list().

I think exec_rev_list() is doing the wrong thing here.  If I specify an
explicit refspec list for git-send-pack, then when send_pack() calls
match_refs(), we break out to match_explicit_refs() and set
dst->peer_ref only for the ref[s] which match the refspec.  send_pack()
then skips all other refs by doing a

		if (!ref->peer_ref)
			continue;

Unfortunately, exec_rev_list() is missing this, and it tries to ask
git-rev-list for the commit objects of *every* ref on the remote_refs
list, even if they have been explicitly excluded by match_refs() and
have no peer_ref.  So with this huge repository, I can't even push a
single refspec without bumping into the limit of 900 refs.

The immediate consequence to me is that I can't push to this particular
repository.  But if I'm following the code right, a consequence is that
git-send-pack is accidentally sending all objects for refs that the
remote end is prepared to receive, even if we've supplied a refspec
asking for only a subset of those refs to actually be updated.

I think we can fix this just by adding a test for ref->peer_ref to
exec_rev_list().  That seems to fix the immediate problem for me, at
least.  Patch to follow.

--Stephen
