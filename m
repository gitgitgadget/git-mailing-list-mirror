From: "David Jeske" <jeske@willowmail.com>
Subject: policy and mechanism for less-connected clients
Date: Wed, 25 Jun 2008 00:36:03 -0000
Message-ID: <12376.6951416203$1214355120@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 02:51:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBJEm-00047N-SU
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 02:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbYFYAud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 20:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbYFYAud
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 20:50:33 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60311 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752424AbYFYAud (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 20:50:33 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jun 2008 20:50:32 EDT
Received: (qmail 23555 invoked by uid 90); 25 Jun 2008 00:43:44 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Wed, 25 Jun 2008 00:36:03 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86193>

I'd like to hear feedback and ideas about a different mechanism than is being
used with git-pull or git-push.

The purpose of this mechanism is to host a distributed source repository in a
world where most most developer contributors are behind firewalls and do not
have access to, or do not want to configure a unix server, ftp, or ssh to
possibly contribute to a project. The model of allowing less-authoritative
developers to make their changes available for more-authoritative users to pull
is accepted as superior. However, no users are assumed to be authoritative over
each-other, or an entire tree, and many users should have authority only to
supply new deltas to their own branches. The ability to handle emailed patches
is an asset, but is deemed too manual for this need.

I believe git's design is strong; that many of the mechanisms are already
built; that new mechanisms to build this can be simple; and that with such
mechanisms, many more developers would have access to git's decentralized
development style. Further, it would address drawbacks in today's git relative
to public central version control systems, making this system closer to a 'best
of both worlds'.

design assumptions:

- all developers are firewalled and can not be "pulled" from directly.
- there can be one or more well-connected servers which all users can access.
- .. but which they cannot have ssh, ftp, or other dangerous access to
- .. and whose protocol should be layered on http(s)
- there is a shared namespace for branches, and tags
- .. users are not-trusted to change the branches or tags of other users
- .. only certain users are trusted to change the shared origin branches
- .. also allow directory ACLS on shared branch commits
- all their DAGs should be in a single repository for space efficiency
- users generally want to follow well-named branches
- .. will be free to follow any branch, and pull changes from any branch

I would like to make it easy for users to:

(a) safely "share" every DAG, branch, and tag data in their repository to a
well-connected server, into an established namespace, while only changing
branches and tags in their namespace. This will allow all users to see the
changes of other users, without needing direct access to their trees (which are
inaccessible behind firewalls). [1]

(b) fetch selected DAG, branch, and tag data of others to their tree, to see
the changes of others (whether merged with head or not) while disconnected or
remote.

(c) grant and enforce permission for certain users to submit _merges only_ onto
certain sub-portions of the "well-named branches"

There are many many benefits of git's mechanisms for this topology, and I
expect you know them so I'll skip them. I see the following challenges from the
current git implementation. Please tell me where I'm mistaken.. this is all
AFAIK, some from tests, some from docs.

(1) A server will need to support the required permissions and isolation
enforcement. Namely, permissions for portions of the branch/tag namespace,
assurance that DAGs are valid, and directory permissions.

(2) a "share" client command will need to be implemented which transmits-up
local changes to only my DAGs, branches, and tags without affecting the shared
origin namespace pointers on the server. It will share all these changes
regardless of what the user's "active" branch is. Local branches might be
mapped to a branch on the server such as origin/users/(username)/(branchname).
Branches which are supposed to stay local might be named "local/branch", and be
ignored by the "share". [1]

(3) a mechanism for controlling permissions (possibly based on checking out and
editing a special subtree, ala cvs)

(4) A mechanism to be sure "share" does not cause users who have permission to
inadvertently move the origin/master branch pointer, even if they are working
on their local master branch. For example, their changes would be named by
origin/users/(username)/master. This is necessary because "share"  is the only
way for the firewalled user to make their changes available to others. As a
result, it is imperative that this be separate from a decision to promote their
changes onto the shared origin branch. Currently git-push implies both of these
together. git-share would be to git-push what git-fetch is git-pull. git-push
would continue to be used to tell the system you wish to promote your change to
origin/master. [2]


[1] - "share" permissions can be considered two ways. In the strictly client
server model, the server will only allow the client to change branch pointers
that it owns in the namespace. However, if clients establish their own PGP-keys
or other hash-identity keys with the server, then branch changes may be signed
by clients, and propagate between clients in any direction and order, until
they fully propagate. It's not clear if this additional complexity is worth it.

[2] - it might be reasonable to build a mechanism to allow a local "intent to
promote" preceed a git-share, in which case git-share could safetly
fast-forward the head. However, it's unclear what benefit this has over
git-fetch.
