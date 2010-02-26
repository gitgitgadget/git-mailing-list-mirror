From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH 2/3] Different views on a repository
Date: Fri, 26 Feb 2010 01:45:33 +0100
Organization: SUSE Labs
Message-ID: <201002260145.33960.agruen@suse.de>
References: <cover.1267029680.git.agruen@suse.de> <201002251535.03334.agruen@suse.de> <7vljeh9qcx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 01:45:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkoKt-0000p5-OL
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 01:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934776Ab0BZApj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 19:45:39 -0500
Received: from cantor2.suse.de ([195.135.220.15]:50638 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934749Ab0BZApi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 19:45:38 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 5A7828672B;
	Fri, 26 Feb 2010 01:45:37 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.12-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7vljeh9qcx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141086>

On Thursday 25 February 2010 18:28:46 Junio C Hamano wrote:
> Andreas Gruenbacher <agruen@suse.de> writes:
> > No, it's a server side thing.
> 
> If it were a server side thing, then I would expect no change to
> send/receive pack.
>
> Instead your clients will access distinct URL as if they are different
> repositories.
> 
>     git clone git://example.com/pub/scm/git/A
>     git push example.com:/pub/scm/git/B master
>     git pull http://example.com/pub/scm/git/C
>
> They should not have to care that the server is cheating to save disk
> space, and they should be able to access your server with Git v1.6.0.
> 
> Instead, the server side would:
> 
>  - have separate repositories, A, B and C, as normal repositories;
> 
>  - these repositories share their object stores by having their
>    .git/objects pointing at a shared location via a symlink;
> 
>  - on the server side, gc/prune/fsck will have to be updated so that when
>    the object store of a repository (say A) is shared with something else,
>    they will consider refs in other repositories (B and C) also as the
>    root of traversal.

I was proposing to change receive-pack and upload-pack, both of which are 
running on the server; there was no mention of send-pack.  What I've proposed 
is not a complete solution, but it should suffice to show the idea.

Your alternative proposal would also solve my problem, in a different way.  
With either approach, what looks like separate repositories A, B, and C to 
clients looks like one repository to gc/prune/fsck.

> So if this were a server side solution, I would expect the series would
> add:
> 
>  - a way to set up a shared object store;
> 
>  - a way to maintain a list of backlinks to repositories that share an
>    object store;
> 
>  - a way to create a new repository that shares the object store
>    (e.g. create a symlink to the shared store instead of having its own
>    .git/objects/, and add itself to the list of backlinks for the shared
>    object store);
> 
>  - a way to retire an existing such repository (rm -rf and remove itself
>    from the list of backlinks);
> 
>  - update gc/prune/fsck to honor such a list of backlinks.
> 
> This would help a "forks" setup commonly seen at places like repo.or.cz
> and github.com among others.

Yes. I'm don't know how big a problem this is for those kinds of hosters; in 
our case, it is a big problem.

> One thing that is missing from the above handwaving outline that your
> "different views" offers is a "consolidated view", a pseudo-repository
> that allows you to see refs from individual real (from the client's and
> project participant's point of view) repositories as if they are in
> individual subhierarchies of the ref namespace.

I have been talking about a repository and different subsets or views of that 
repository; you call the former a consolidated view and the latter a 
repository.  Those are really just two sides of the same coin.

> I however suspect that you didn't want such a view in the first place if
> there weren't issues around reachability.  In other words, I suspect that
> you invented it merely as one possible solution to the reachability issue,
> and it was not your goal to have such a consolidated view by itself.

I'm actually not sure.  The "consolidated view" as you put it may be useful 
all by itself; it would be a proper, self sufficient git repository -- a 
really nice property.  it may be too painful to maintain this view though.

When sharing objects across repositories, the worst-case scenario is that 
something goes wrong with the backlinks.  You will eventually lose objects, 
but it may take a while until it happens and until you notice, with a lot of 
damage.  That's nasty.

A combination of the two approaches would be to "link forward" instead of 
"linking back", so that the consolidated view would maintain itself, with a 
server repo setup like this:

	/repos/ABC:
		objects
		refs/tags/A/
		refs/tags/B/
		refs/heads/A/
		refs/heads/B/

	/repos/A:
		refs/tags -> /repos/ABC/refs/tags/A/
		refs/heads -> /repos/ABC/refs/heads/A/
		objects -> /repos/ABC/objects/

	/repos/B:
		refs/tags -> /repos/ABC/refs/tags/B/
		refs/heads -> /repos/ABC/refs/heads/B/
		objects -> /repos/ABC/objects/

This could be made safe by not doing garbage collection if objects is a 
symlink instead of a directory.  (The ABC repo could be garbage collected as 
usual.)  Am I overlooking anything why this can't work?


Thanks,
Andreas
