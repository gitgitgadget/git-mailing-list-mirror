From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] archimport improvements
Date: Sun, 13 Nov 2005 00:54:36 +1300
Message-ID: <46a038f90511120354n4584aedfhb1f2928ac41478ab@mail.gmail.com>
References: <20051112092336.GA16218@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 12 12:55:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eaty8-0000nb-37
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 12:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVKLLyh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 06:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVKLLyh
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 06:54:37 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:23471 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932329AbVKLLyh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 06:54:37 -0500
Received: by zproxy.gmail.com with SMTP id 40so790495nzk
        for <git@vger.kernel.org>; Sat, 12 Nov 2005 03:54:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d9FKpR9WxY0xBTm5bjZSTe1PfHyv0G0F8hcs6orNiUC3IJ+aXmnIVHfYE/sx+lRPy3gU7CXF6Aihc2hoao/zf0LeSmUfBBPTQGU6UUoAwyLT1GyJPgk4TJh/mLfy/VMlRPbCmaqT6dFUH9bcHEMkgwiPg/kLyVnscf/kNPk9qyQ=
Received: by 10.64.203.19 with SMTP id a19mr640099qbg;
        Sat, 12 Nov 2005 03:54:36 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Sat, 12 Nov 2005 03:54:36 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051112092336.GA16218@Muzzle>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11672>

Eric,


On 11/12/05, Eric Wong <normalperson@yhbt.net> wrote:
> I'm another Arch-user trying out git.  Unfortunately, I encountered
> several problems with git-archimport that I needed fixed before my
> development trees could be imported into git.

Welcome and good stuff! I'll give your patches a try when I sober up.
In the meantime, some notes after having read the patches a bit...

> Bug Fixes:
>
> * Support for '--branch'-less Arch version names.
>   Encoding '/' to '--' (as was previously done) is not 100% reversable
>   because the "--branch" portion of an fully-qualified Arch version name
>   is optional (though not many people or Arch-related tools know this).
>
> * I'm encoding the '/' in the fully-qualified name as ',' to not confuse
>   other porcelains, but leaving '/' in branch names may be alright
>   provided porcelains can support them.
>
> * Identify git branches as an Arch "archive,category<--branch>--version"
>   Anything less than that is ambiguous as far as history and patch
>   relationships go.

These bug/sanity fixes are _good_. As you mention, I wasn't aware that
patchnames could show up not having a --branch part. Tricky...

> * Renamed directories containing renamed/moved files inside didn't get
>   tracked properly.  The original code was inadequate for this, and
>   making it support all rename cases that Arch supports is too much
>   work.  Instead, I maintain full-blown Arch trees in the temp dir and
>   replay patches + rsync based on that.  Performance is slightly slower
>   than before, but accuracy is more important to me.
>
> * Permission (execute bit only because of git) tracking as a side effect
>   of the above.

Hmmm. I understand what you are doing, but I'm not sure we'd want to
replace the current code with this strategy.  Importing large trees
with hundreds (thousands) of commits is so slow it is just a no go.
Renames are described quite well in the 'commit log', and the current
code does handle file renames...

> * Tracking changes from branches that are only cherry-picked now works

Can you elaborate a bit more on this?

> * Pika-escaped filenames unhandled.  This seems fixed in the latest
>   git, but I fixed it more generally and removed the ShellQuote module
>   dependency along the way.

Yes, this got fixed recently. Your change here goes together with the
'tla get' + rsync strategy which I'm not sure about.

> * Don't die() when a merge-base can't be found.  Arch supports
>   merging between unrelated trees.

Fair enough. Does it result on a good graft in git?

> Usability enhancements:
>
> * Optionally detect merged branches and attempt to import their history,
>   too.  Use the -D <depth> option for this.  Specifying a <depth>
>   greater than 1 is usually not needed unless the tree you're tracking
>   has had history pruned.
>
> * Optionally attempt to auto-register unknown Arch archives from
>   mirrors.sourcecontrol.net to pull their history with the -a (boolean)
>   switch.  Not sure how useful users will find this.

Those two are interesting!

> * Removed -A <archive> usage (unnecessary in all cases) and made all
>   Arch calls and output parsing to be compatible with both tla (tested
>   1.3.3) and baz (1.4.2).  Default is still tla, but the ARCH_CLIENT
>   environment variable may be changed to baz.

That's excellent -- thanks!

> Current weaknesses:
>
> * (Present in the original code as well).
>   The code still assumes that dates in commit logs can be trusted, which is
>   fine in most cases, but a wayward branch can screw up git-archimport and
>   cause parents to be missed.

Fair enough. You mention an alternative strategy (tla ancestry) --
have you tried it at all?

cheers,


martin
