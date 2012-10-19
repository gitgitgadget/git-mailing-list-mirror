From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: A design for distributed submodules
Date: Fri, 19 Oct 2012 22:09:35 +0200
Message-ID: <5081B37F.3010204@web.de>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi> <7vd30m2sbr.fsf@alter.siamese.dyndns.org> <20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi> <7vzk3p1xh3.fsf@alter.siamese.dyndns.org> <20121014131928.25943ezwa6fveyls.lealanko@webmail.helsinki.fi> <507ABDF3.4040106@web.de> <20121014182746.42895rwvalv4uoz6.lealanko@webmail.helsinki.fi> <507AE773.1010301@web.de> <7v4nlxylpm.fsf@alter.siamese.dyndns.org> <20121019033158.93403x1gcanyjo8u.lealanko@webmail.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lauri Alanko <la@iki.fi>
X-From: git-owner@vger.kernel.org Fri Oct 19 22:10:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPItK-00010L-Kl
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 22:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758467Ab2JSUJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 16:09:47 -0400
Received: from mout.web.de ([212.227.17.11]:55123 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755086Ab2JSUJr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 16:09:47 -0400
Received: from [192.168.178.41] ([91.3.183.102]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MLPRu-1TPqqm23Kk-0005OU; Fri, 19 Oct 2012 22:09:38
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121019033158.93403x1gcanyjo8u.lealanko@webmail.helsinki.fi>
X-Provags-ID: V02:K0:Zm2gKCd1LHHjHwFL53wlCmxB6YCxacpOO6AVy80IWSJ
 19zH4aL/F7psuSr6o+pHOBQN+nW2eyTNG2b3h5sfC60FnSTX7O
 W89tzgH63Xwdx+7ijE5af2/eXlIFOTVEBRt1N17jrqdWTi7i/6
 Ecamqqo7DnfGydIEsHxjAeJ6YgW1UiLA1E6mcIh70XRauUwN2m
 p6fKgOZ/+Xbzo59SV5tiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208057>

Am 19.10.2012 02:31, schrieb Lauri Alanko:
> I think I finally agree that it's best to develop submodules further
> rather than introduce a new tool for the functionality I require. Here
> are some explicit proposals for submodules so we can at least establish
> agreement on what should be done. These are in order of decreasing
> importance (to me).

Good to hear that!

> * Upstreamless submodules
> 
> If there is no 'url' key defined for a submodule in .gitconfig, there is
> no "authoritative upstream" for it. When a recursive
> fetch/pull/clone/push is performed on a remote superproject, its
> upstreamless submodules are also fetched/pulled/cloned/pushed directly
> from/to the submodule repositories under the superproject .git/modules.
> If this is the first time that remote's submodules are accessed, that
> remote is initialized for the local submodules: the submodule of the
> remote superproject becomes a remote of the local submodule, and is
> given the same name as the remote of the superproject.
> 
> So, suppose we have a superproject with .gitmodules:
> 
> [submodule "sub"]
>     path = sub
> 
> which is hosted at repositories at URL1 and URL2. Then we do:
> 
> git clone --recursive URL1 super
> cd super
> git remote add other URL2
> git fetch --recursive URL2
> 
> Now .git/modules/sub/config has:
> 
> [remote "origin"]
>     url = URL1/.git/modules/sub
> [remote "other"]
>     url = URL2/.git/modules/sub

So you want to automatically propagate the new superproject remote
"other" into the submodules?

> So the effect is similar to just setting the submodule's url as
> ".git/modules/sub", except that:
> 
>  - it hides the implementation detail of the exact location of the
>    submodule repository from the publicly visible configuration file
> 
>  - it also works with bare remotes (where the actual remote submodule
>    location would be URL/modules/sub)
> 
>  - it allows multiple simultaneous superproject remotes (where
>    git-submodule currently always resolves relative urls against
>    branch.$branch.remote with no option to fetch from a different
>    remote).

Maybe it's too late on a Friday evening in my timezone, but currently
I can't wrap my mind around what you have in mind here ... will try
again later.

> * Submodule discovery across all refs
> 
> This is what Jens already mentioned. If we fetch multiple refs of a
> remote superproject, we also need to fetch _all_ of the submodules
> referenced by _any_ of the refs, not just the ones in the currently
> active branch.

That is how things already work now (and it is done in an optimized
way because we only do a fetch in a submodule when the referenced
commit isn't already present locally). But the current limitation
is that only populated submodules are updated (we do a "git fetch"
inside the submodules work tree), so e.g. currently we can't follow
renames. We should also do a fetch for submodules which aren't
checked out but whose repo is found in .git/modules/<name>.

> Finding the complete list of submodules probably has to
> be implemented by reading .gitmodules in all of the (updated) refs,
> which is a bit ugly, but not too bad.

Yes, this will be necessary to get the correct path -> name mapping
for submodules which aren't found in the work tree (e.g. because
they are renamed). (I will also need to peek into another commit's
.gitmodules file to make the recursive checkout work for appearing
submodules for the same reason)

> * Recording the active branch of a submodule
> 
> When a submodule is added, its active branch should be stored in
> .gitmodules as submodule.$sub.branch. Then, when the submodule is
> checked out, and the head of that branch is the same as the commit in
> the gitlink (i.e. the superproject tree is "current"), then that branch
> is set as the active branch in the checked-out submodule working tree.
> Otherwise, a detached head is used.

We had some discussions about a "floating" submodule model where the
submodules follow the tip of a branch configured in .gitmodules. That
looked similar to what you have in mind, except that the tip of that
branch is always used.

> * Multiple working trees for a submodule
> 
> A superproject may have multiple paths for the same submodule,
> presumably for different commits. This is for cases where the
> superproject is a snapshot of a developer's directory hierarchy, and the
> developer is simultaneously working on multiple branches of a submodule
> and it is convenient to have separate working trees for each of them.
> 
> This is a bit hard to express with the current .gitconfig format, since
> paths are attributes of repository ids instead of vice versa. I'd
> introduce an alternative section format where you can say:
> 
> [mount "path1"]
>   module = sub
>   branch = master
> 
> [mount "path2"]
>   module = sub
>   branch = topic
> 
> Implementing this is a bit intricate, since we need to use the
> git-new-workdir method to create multiple working directories that share
> the same refs, config, and object store, but have separate HEAD and
> index. I think this is a problem with the repository layout: the
> non-workdir-specific bits should all be in a single directory so that a
> single symlink would be enough.

I'm not sure how good that'll work. E.g. what happens if the user
configures the URL of "path1" to something else? It looks to me like
having the same repo copied under different .git/modules/<name> would
be a more robust approach, even though it wastes some disk space.

> Obviously, I'm willing to implement the above functionalities since I
> need them. However, I think I'm going to work in Dulwich (which doesn't
> currently have any submodule support): a Python API is currently more
> important to me than a command-line tool, and the git.git codebase
> doesn't look like a very attractive place to contribute anyway. No
> offense, it's just not to my tastes.
> 
> So the main reason I'd like to reach some tentative agreement about the
> details of the proposal is to ensure that _once_ someone finally
> implements this kind of functionality in git.git, it will use the same
> configuration format and same conventions, so that it will be compatible
> with my code. The compatibility between different tools is after all the
> main reason for doing this stuff as an extension to submodules instead
> of something completely different.

Fair enough. But I fear unless we code the same functionality in both
worlds at about the same time the assumption that it will be done in
the future in the git core in the same way you expect may fail.

Having said that: I expect to implement peeking into another commit's
.gitmodules to read the config next after I finished the rm and mv for
submodules (and intend to use it for doing a fetch first), so maybe we
can start with that?
