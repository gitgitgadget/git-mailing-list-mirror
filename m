From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT RFC] Changing patch@branch syntax
Date: Fri, 22 Jun 2007 22:00:37 +0200
Message-ID: <20070622200037.GE7730@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070515220310.GJ16903@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0705220527x5d4c3d0fw2d0d66b37aab3f97@mail.gmail.com> <20070522210020.GV19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070621230207.GD7730@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0706220859n2c2962ffy21464526a5ebd6cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 22:00:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1pJH-0002T3-Bs
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 22:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbXFVUAq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 16:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbXFVUAq
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 16:00:46 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:50048 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbXFVUAp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 16:00:45 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E508E5A21A;
	Fri, 22 Jun 2007 22:00:43 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 00E4F1F151; Fri, 22 Jun 2007 22:00:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0706220859n2c2962ffy21464526a5ebd6cd@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50708>

On Fri, Jun 22, 2007 at 04:59:05PM +0100, Catalin Marinas wrote:
> >So here is a new proposal, which I believe would address all current
> >issues, at the expense of changing stgit syntax.  The idea is to use a
> >single separator for all levels of Stackable objects, with an optional
> >"patch id" (eg. //top) at the end when meaningful.  Only names would
> >be possible to omit, separators would be mandatory to specify the
> >nesting level.  That gives a syntax of:
> >
> >        [patchset]([:stackable]+(//id)?)*
> 
> I don't think I can write a regexp for it but I don't like the
> mandatory ":" before the patch name (or stackable object). The main
> reason is that one usually works on a branch with patch names, there
> might be scripts+xargs involved and forcing the use of ":" would make
> it more complicated.

That's probably not much of a problem: patch lists could be generated
for script use with a flag similar to "series --showbranch".


> I also don't think we need to make this distinction in the names as
> different commands or options take different type of arguments:
> 
> stg show <patch>
> stg series --branch <stack>

Currently, "stg show HEAD" or any other git ref does work, except when
there are name clashes.

And since we're going to have all of patches, stacks, and pools in the
same "stackable" family, we're going to use them interchangeably in
more and more places.  But there are also places where we can use at
will stack names and generic git heads (eg. "stg branch X").

I'd rather having a single name-resolution mechanism, instead of one
for patches and one for branches.


> I'll try to express this with BNF (though I'm not an expert in this 
> notation):
> 
> <name> ::= "" | [^\w.-]+
> <attr> ::= top | top.old | bottom | bottom.old | log | ...
> <nameattr> ::= <name> | <name>//<attr>
> 
> <stackable> ::= <nameattr> | <stackable>:<stackable>
> 
> If empty name (""), the current object for the level is used.
> 
> The above <stackable> is more generic. A patchset might have other
> attributes or none at all (could have a "old" attribute if we decide
> to keep older versions of a stack for example).

Right, good idea.


> I would introduce a <repo> in front of all the above (for which we
> don't have any support)

Yes - URLs could do the work, with a '#' to use the stackable as URL
fragment.


> but this is somehow at a similar level to <pool> in case we don't
> use a hydra. Or the <pool> can also be a repository?

I think they are different enough: a pool/hydra typically has several
members applied, whereas a repo has only a current branch.



Now for technical details.  I have a prototype hydra mechanism that
demonstrates that we can create such a beast without having everything
breaking all around.  However, it does not use the model described in
this thread, but rather links to stacks which exist independantly - I
want to keep that as a possibility, by using some symlink-like
mechanism, but the current prototype will not live, although I may
experiment a bit more with it.  BTW, we should probably name the final
beast "pool" and not "hydra", so users have a better idea of how to
use it :)

However, the various refactorings and fixes I have done should be
quite ready for inclusion (modulo dispatching recent fixes down to the
relevant patch).  Here I need to know your plans for 0.13: if the
refactoring would go in, I just have to polish things as they are; if
you prefer to keep this for 0.14, I'll sink the bugfixes down my stack
so they can be in 0.13 at least.

Did you have time to look at the various refactorings at
http://repo.or.cz/w/stgit/ydirson.git ?

Best regards,
-- 
Yann
