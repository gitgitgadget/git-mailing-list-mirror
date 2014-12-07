From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH/RFC v2] Squashed changes for multiple worktrees vs.
 submodules
Date: Sun, 7 Dec 2014 08:42:30 +0200
Message-ID: <20141207064230.GA9782@wheezy.local>
References: <1417390076-2953-1-git-send-email-max@max630.net>
 <547E24E4.7050100@web.de>
 <20141202221611.GB9128@wheezy.local>
 <5480BEB9.8070109@web.de>
 <CAF7_NFQzPDF+7NS2VwopK8Oei=9NzWEAGM5fko-St5KvvmLa9A@mail.gmail.com>
 <5482FF40.3040204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 07 07:48:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxVdw-0001gA-QU
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 07:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbaLGGnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2014 01:43:04 -0500
Received: from p3plsmtpa09-04.prod.phx3.secureserver.net ([173.201.193.233]:51331
	"EHLO p3plsmtpa09-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750721AbaLGGnC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2014 01:43:02 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-04.prod.phx3.secureserver.net with 
	id QWiS1p0055B68XE01WizzX; Sat, 06 Dec 2014 23:43:01 -0700
Content-Disposition: inline
In-Reply-To: <5482FF40.3040204@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260972>

On Sat, Dec 06, 2014 at 02:06:08PM +0100, Jens Lehmann wrote:
> Am 05.12.2014 um 07:32 schrieb Max Kirillov:
>> Currently I'm estimating approach when submodules which have .git
>> file or directory inside are updated, and those which do not have it are not.
>> I have added a config variable submodule.updateIgnoringConfigUrl (because
>> usually the submodule.<name>.url is what turns on the update). It looks working,
>> maybe I even add setting the variable when chackout --to is used.

> But it's not only submodule.<name>.url, the list goes on with
> update, fetch & ignore and then there are the global options
> like diff.submodule, diff.ignoreSubmodules and some more.

I believe that parameters are important for some use, but I
know several tesns of git users who have no idea bout them,
and I myself only learned about them while working on this.

To have some a submodule not initialized in some sorktree is
what I really need. I was sure before it is managed by
having the submodule checked out. Probably I just did not
run `submodule update` in the worktree where did not use
submodules, but I cannot rely on it.  I see now from
211b7f19c7 that adding parameter for all updates will break
the initalization. Maybe it would be better to have a
runtime argument: `git submodule update --ignore-config-url`

> Thanks to you and Duy for discussing this with me! I'd sum it
> up like this:
> 
> *) Multiple worktrees are meant to couple separate worktrees
>    with a single repository to avoid having to push and fetch
>    each time to sync refs and also to not having to sync
>    settings manually (with the benefit of some disk space
>    savings). That's a cool feature and explains why a branch
>    should be protected against being modified in different
>    worktrees.

I should notify that I am not the author of the feature,
maybe Duy have some other vision.

>    The first level submodule settings are shared between the
>    multiple worktrees; submodule objects, settings and refs
>    aren't (because the .git/modules directory isn't shared).
> 
>    Looks like that would work with just what we have now, no?

Yes, very much like what I proposed in $gmane/258173, but I
need to have something about preventing checkout. And I
should review what I've done since that, maybe there are
more things to fix.

> *) I'd love to see a solution for sharing the object database
>    between otherwise unrelated clones of the same project (so
>    that fetching in one clone updates the objects in the common
>    dir and gc cannot throw anything away used by one of the
>    clones). But I'd expect a bare repository as the common one
>    where we put the worktrees refs into their own namespaces.

There is a GIT_NAMESPACE already, maybe it should be just
extended to work with all commands?

btw, have you tried alternates? It does reduce the number of
objects you need to keep very strongly. You can put in the
alternate store only released branches which are guaranteed
to be not force-updated, to avoid issues with missing
objects, and it still helps. For example, the full git
repository takes about 70mb, and if I put master to
alternate store, the rest takes 7mb, and even if I clone all
original repository, debian repository and msysgit
repository, thay all take 15mb. It's without worktree, which
takes 27mb :)

-- 
Max
