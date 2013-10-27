From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes:
 line
Date: Sun, 27 Oct 2013 02:37:08 -0400
Message-ID: <20131027063708.GC12361@thunk.org>
References: <20131024122255.GI9378@mwanda>
 <20131024122512.GB9534@mwanda>
 <20131026181709.GB10488@kroah.com>
 <20131027013402.GA7146@leaf>
 <526CA7D4.1070904@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Oct 27 07:37:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaJyy-0005Bd-Q0
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 07:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190Ab3J0GhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 02:37:21 -0400
Received: from imap.thunk.org ([74.207.234.97]:51250 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993Ab3J0GhT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 02:37:19 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1VaJyI-0003WF-PT; Sun, 27 Oct 2013 06:37:10 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id DEED7580704; Sun, 27 Oct 2013 02:37:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=thunk.org; s=mail;
	t=1382855828; bh=k9dZycE5A0FP079X7at9y7rC84nfuOa8bJSOzKn6Rts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVbQ57oFLBYr2QtAhtQxYrC+dQ3dn6KEjs0IGPDwAPBAHh3vu22JVarOWKDAxFuK2
	 zqqtxhI7DAyCqtvlZkwyKmDbiK5ZwFFacrwkzxjnElwIJKzsUz68LWHg2g23NwfXgD
	 oXn/2qia+LrEYI4yh0YGj5g8sPoRAEPn/luu9fhk=
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>, Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <526CA7D4.1070904@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236778>

One of the uses of the Fixes commit line is so that when we fix a
security bug that has been in mainline for a while, it can be tricky
to determine whether it should be backported in to the various stable
branches.  For example, let's suppose the security bug (or any bug,
but one of the contexts where this came up was for security fixes) was
introduced in 3.5, and backported into the 3.2.x kernel series, but
couldn't be applied into the 3.2.0 kernel series.  The security fix
was introduced in 3.12, and so it would be obvious that it should be
backported to the 3.10 kernel series, but it might not be so obvious
that it would also be required for the 3.2.x long-term stable series.

So the inclusion of the Fixes: line provides this critical bit of
information.  It's also useful not just for the long-term stable tree
maintainers, but the maintainers of distro kernels would also find it
to be very useful.

> I see that there a consistency check that the --fixes argument is a
> valid commit.  But is there/should there be a check that it is an
> ancestor of the commit being created?  Is there/should there be a check
> that both of these facts remain true if the the commit containing it is
> rebased, cherry-picked, etc?
> 
> In workflows that make more use of cherry-picking, it could be that the
> original buggy commit was cherry-picked to a different branch.  In this
> case the user would probably want to cherry-pick the fixing commit to
> the other branch, too.  But then the commit that it would be fixing
> would have a different SHA-1 than it did on the original branch.  A
> check that the "Fixes:" line refers to an ancestor of the current commit
> could warn against such errors.  (In some cases it might be possible to
> use cherry-pick's "-x" lines to figure out how to rewrite the "Fixes:"
> line, but I doubt that would work often enough to be worthwhile.)

I believe that in the discussions we had, it was assumed that the
Fixes: line would reference the commit in the mainline kernel tree.
i.e., it would always reference the commit which introduced the bug in
3.5, even if the commit-id after the buggy commit was backported to
3.2.x would obviously be different.  Presumably the distro kernel
maintainer would be able to find the commit in Linus's tree and then
try to find the corresponding commit in the distro kernel git tree,
probably by doing string searches over "git log".

We could actually do a much more elegant job if we did have the
concept of commit identity (i.e., ChangeID's) baked into git.  That
way, there would be a constant ChangeID that would remain constant not
only across revisions of a patch under development, but also when the
commit is cherry picked into stable branches.  If we had that, then
instead of doing string searches on git log output, we could imagine a
web and/or command line interface where given a ChangeID, it would
tell you which branches or which tags contained the same semantic
patch.

Of course, as soon as you do that, then if the multiple commits get
squashed together, you might need to have to support multiple
ChangeID's associated with one commit, at which point it becomes
incompatible with Gerrit's use of this feature.

So we could add all sorts of complexity, but it's not obvious to me
that it's worth it.

> First of all, let me show my ignorance.  How formalized is the use of
> metadata lines at the end of a commit message?  I don't remember seeing
> documentation about such lines in general (as opposed to documentation
> about particular types of lines).  Is the format defined well enough
> that tools that don't know about a particular line could nonetheless
> preserve it correctly?  Is there/should there be a standard recommended
> order of metadata lines?  (For example, should "Fixes:" lines always
> appear before "Signed-off-by" lines, or vice versa?)  If so, is it
> documented somewhere and preserved by tools when such lines are
> added/modified?  Should there be support for querying such lines?

Internally inside Google, we have tools that will assist in forward
porting local changes from a 3.x based kernel to a 3.y kernel, to make
sure that all local changes are properly accounted for and none are
accidentally dropped during the rebase operation.  So we have various
new metadata lines that we add internally, for example:

Upstream-3.x-SHA1: <commit-id>
	for commits in newer kernels that have been backported
Origin-3.x-SHA1: <commit-id>
	to indicate the commit-id of a patch that was forward ported
	as part of a rebase operation from 3.x to 3.9
Upstream-Dropped-3.x-SHA1: <commit-id>
	As part of an empty commit to indicate that a patch that was
	originally in our tree, has since been pushed upstream, so we
	can drop it as part of the rebase to the 3.y kernel.

etc.

Other projects have various metadata lines to reference a bug-tracker
id number; folks may have seen commits with various metadata id's in
public git repositories such as:

	Google-Bug-Id: 12345
	BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=62261
	Addresses-Debian-Bug: #698879

These are clearly much less standardized, and are probably used more
for human consumption than for any kind of automated tooling.  They
are out there, though, so it indicates that there definitely is a need
for such things.

I'm not entirely convinced that it's worth it to try to formalize this
more than what we already have, but perhaps there's some killer new
feature, such as better gitweb / Gerrit / Bugzilla integration, that
could be added if this stuff was more formalized.

Cheers,

					- Ted
