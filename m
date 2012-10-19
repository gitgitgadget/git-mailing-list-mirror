From: "Lauri Alanko" <la@iki.fi>
Subject: A design for distributed submodules
Date: Fri, 19 Oct 2012 03:31:58 +0300
Message-ID: <20121019033158.93403x1gcanyjo8u.lealanko@webmail.helsinki.fi>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi>
	<7vd30m2sbr.fsf@alter.siamese.dyndns.org>
	<20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi>
	<7vzk3p1xh3.fsf@alter.siamese.dyndns.org>
	<20121014131928.25943ezwa6fveyls.lealanko@webmail.helsinki.fi>
	<507ABDF3.4040106@web.de>
	<20121014182746.42895rwvalv4uoz6.lealanko@webmail.helsinki.fi>
	<507AE773.1010301@web.de> <7v4nlxylpm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; DelSp="Yes"; format="flowed"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 02:34:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TP0XX-0008Iz-3O
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 02:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab2JSAcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 20:32:09 -0400
Received: from smtp-rs1-vallila2.fe.helsinki.fi ([128.214.173.75]:54959 "EHLO
	smtp-rs1-vallila2.fe.helsinki.fi" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751282Ab2JSAcH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 20:32:07 -0400
Received: from webmail.helsinki.fi (webmail1-vallila2.fe.helsinki.fi [128.214.173.135])
	by smtp-rs1.it.helsinki.fi (8.14.4/8.14.4) with ESMTP id q9J0VwuN018887;
	Fri, 19 Oct 2012 03:31:59 +0300
Received: from eng-0609-2.hum.helsinki.fi (eng-0609-2.hum.helsinki.fi
	[128.214.63.230]) by webmail.helsinki.fi (Horde Framework) with HTTP; Fri,
	19 Oct 2012 03:31:58 +0300
In-Reply-To: <7v4nlxylpm.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208033>


I think I finally agree that it's best to develop submodules further
rather than introduce a new tool for the functionality I require. Here
are some explicit proposals for submodules so we can at least establish
agreement on what should be done. These are in order of decreasing
importance (to me).


* Upstreamless submodules

If there is no 'url' key defined for a submodule in .gitconfig, there is
no "authoritative upstream" for it. When a recursive
fetch/pull/clone/push is performed on a remote superproject, its
upstreamless submodules are also fetched/pulled/cloned/pushed directly
from/to the submodule repositories under the superproject .git/modules.
If this is the first time that remote's submodules are accessed, that
remote is initialized for the local submodules: the submodule of the
remote superproject becomes a remote of the local submodule, and is
given the same name as the remote of the superproject.

So, suppose we have a superproject with .gitmodules:

[submodule "sub"]
	path = sub

which is hosted at repositories at URL1 and URL2. Then we do:

git clone --recursive URL1 super
cd super
git remote add other URL2
git fetch --recursive URL2

Now .git/modules/sub/config has:

[remote "origin"]
	url = URL1/.git/modules/sub
[remote "other"]
	url = URL2/.git/modules/sub

So the effect is similar to just setting the submodule's url as
".git/modules/sub", except that:

  - it hides the implementation detail of the exact location of the
    submodule repository from the publicly visible configuration file

  - it also works with bare remotes (where the actual remote submodule
    location would be URL/modules/sub)

  - it allows multiple simultaneous superproject remotes (where
    git-submodule currently always resolves relative urls against
    branch.$branch.remote with no option to fetch from a different
    remote).


* Submodule discovery across all refs

This is what Jens already mentioned. If we fetch multiple refs of a
remote superproject, we also need to fetch _all_ of the submodules
referenced by _any_ of the refs, not just the ones in the currently
active branch. Finding the complete list of submodules probably has to
be implemented by reading .gitmodules in all of the (updated) refs,
which is a bit ugly, but not too bad.


* Recording the active branch of a submodule

When a submodule is added, its active branch should be stored in
.gitmodules as submodule.$sub.branch. Then, when the submodule is
checked out, and the head of that branch is the same as the commit in
the gitlink (i.e. the superproject tree is "current"), then that branch
is set as the active branch in the checked-out submodule working tree.
Otherwise, a detached head is used.


* Multiple working trees for a submodule

A superproject may have multiple paths for the same submodule,
presumably for different commits. This is for cases where the
superproject is a snapshot of a developer's directory hierarchy, and the
developer is simultaneously working on multiple branches of a submodule
and it is convenient to have separate working trees for each of them.

This is a bit hard to express with the current .gitconfig format, since
paths are attributes of repository ids instead of vice versa. I'd
introduce an alternative section format where you can say:

[mount "path1"]
   module = sub
   branch = master

[mount "path2"]
   module = sub
   branch = topic

Implementing this is a bit intricate, since we need to use the
git-new-workdir method to create multiple working directories that share
the same refs, config, and object store, but have separate HEAD and
index. I think this is a problem with the repository layout: the
non-workdir-specific bits should all be in a single directory so that a
single symlink would be enough.


Obviously, I'm willing to implement the above functionalities since I
need them. However, I think I'm going to work in Dulwich (which doesn't
currently have any submodule support): a Python API is currently more
important to me than a command-line tool, and the git.git codebase
doesn't look like a very attractive place to contribute anyway. No
offense, it's just not to my tastes.

So the main reason I'd like to reach some tentative agreement about the
details of the proposal is to ensure that _once_ someone finally
implements this kind of functionality in git.git, it will use the same
configuration format and same conventions, so that it will be compatible
with my code. The compatibility between different tools is after all the
main reason for doing this stuff as an extension to submodules instead
of something completely different.


Lauri
