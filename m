From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Mon, 6 Jan 2014 17:02:03 +0100
Message-ID: <20140106160202.GE27265@t2784.greatnet.de>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <20140105194850.GA2994@book.hvoigt.net>
 <20140105212458.GG3156@odin.tremily.us>
 <20140105225733.GB4660@book.hvoigt.net>
 <20140105233943.GJ3156@odin.tremily.us>
 <20140106003314.GL3156@odin.tremily.us>
 <20140106011255.GM3156@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Jan 06 17:02:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Cd3-0002wg-SP
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 17:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbaAFQCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 11:02:09 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:33562 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752AbaAFQCH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 11:02:07 -0500
Received: from [83.133.105.219] (helo=t2784.greatnet.de)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1W0Ccu-0008G5-85; Mon, 06 Jan 2014 17:02:04 +0100
Content-Disposition: inline
In-Reply-To: <20140106011255.GM3156@odin.tremily.us>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240021>

On Sun, Jan 05, 2014 at 05:12:56PM -0800, W. Trevor King wrote:
> On Sun, Jan 05, 2014 at 04:33:14PM -0800, W. Trevor King wrote:
> > The only people who would need *automatic* rebase recovery would be
> > superproject devs update-cloning the subproject.  That's a small
> > enough cross-section that I don't think it deserves the ambiguity of
> > gitlink-to-reference.  In that case, all you really need is a way to
> > force a recovery gitlink (i.e. add a 'commit' object to the tree by
> > hand).
> 
> Actually, you recovering by hand is a lot easier.  Setup a
> rebased-away gitlink target:
> 
>   mkdir subproject &&
>   (
>     cd subproject &&
>     git init
>     echo 'Subproject' > README &&
>     git add README &&
>     git commit -m 'Subproject v1' &&
>     echo 'Changes' >> README &&
>     git commit -am 'Subproject v2'
>   ) &&
>   mkdir superproject &&
>   (
>     cd superproject &&
>     git init
>     git submodule add ../subproject &&
>     git commit -m 'Superproject v1'
>   ) &&
>   (
>     cd subproject &&
>     git reset --hard HEAD^ &&
>     git reflog expire --expire=now --all &&
>     git gc --aggressive --prune=now
>   )
> 
> Then a recursive clone of the superproject dies:
> 
>   $ git clone --recursive superproject super2
>   Cloning into 'super2'...
>   done.
>   Submodule 'subproject' (/tmp/x/subproject) registered for path 'subproject'
>   Cloning into 'subproject'...
>   done.
>   fatal: reference is not a tree: f589144d16282d1a80d17a9032c6f1d332e38dd0
>   Unable to checkout 'f589144d16282d1a80d17a9032c6f1d332e38dd0' in submodule path 'subproject'
> 
> But you still have the submodule checkout (up until the $sha1 setup):
> 
>   $ cd super2
>   $ git diff
>   diff --git a/subproject b/subproject
>   index f589144..82d4553 160000
>   --- a/subproject
>   +++ b/subproject
>   @@ -1 +1 @@
>   -Subproject commit f589144d16282d1a80d17a9032c6f1d332e38dd0
>   +Subproject commit 82d4553fe437ae014f22bbc87a082c6d19e5d9f9-dirty
> 
> And you can automatically update to match the upstream remote:
> 
>   $ git submodule update --remote --force
>   Submodule path 'subproject': checked out '82d4553fe437ae014f22bbc87a082c6d19e5d9f9'
>   $ git diff
>   diff --git a/subproject b/subproject
>   index f589144..82d4553 160000
>   --- a/subproject
>   +++ b/subproject
>   @@ -1 +1 @@
>   -Subproject commit f589144d16282d1a80d17a9032c6f1d332e38dd0
>   +Subproject commit 82d4553fe437ae014f22bbc87a082c6d19e5d9f9
> 
> When explicitly updating to the superproject or subproject's
> (--remote) new tip is so easy, I don't see a need for floating the
> gitlinks themselves.

I agree. If we were to support this more easily we could add a
configuration option so you can omit the --remote (i.e.:
submodule.<name>.remote=true, as I also suggested in the other email).

That way the developer checking out a branch in flight does not even
need to know whether (and which) submodules sha1s are still in flight
and temporarily set this configuration in the branches .gitmodules file.

Maybe that could actually be the attach operation Francesco is
suggesting:

	git submodule attach [--pull] <submodule path> <branchname>

will attach the specified submodule to a branch. That means it changes
the .gitmodule file accordingly and stages it. With the --pull switch
one can specify whether a local branch tracking the remote branch should
be automatically created. Names and the command format are just a
suggestion here.

That way we can support the

	fork superproject needing submodule changes and send submodule
	changes upstream first.

workflow. What do you think?

Cheers Heiko
