From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Problems with new location of submodule's GIT_DIR
Date: Fri, 17 Aug 2012 18:40:04 +0200
Message-ID: <502E73E4.9080601@web.de>
References: <1345217299.7952.83.camel@athena.dnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Daniel Milde <daniel@milde.cz>
X-From: git-owner@vger.kernel.org Fri Aug 17 18:40:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Pas-0003wt-0j
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 18:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758488Ab2HQQkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 12:40:13 -0400
Received: from mout.web.de ([212.227.17.12]:60923 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758479Ab2HQQkL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 12:40:11 -0400
Received: from [192.168.178.41] ([91.3.156.248]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MAvVk-1SsTxU00wO-00AJZC; Fri, 17 Aug 2012 18:40:08
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <1345217299.7952.83.camel@athena.dnet>
X-Provags-ID: V02:K0:bLNCo6bjBxLrpcy0z2e2GqibeFykzg29QKTlNf5dhtN
 uxYT+5bhAa6+Y0KLoMM4i6GAXm7HA7/+7J/t+k/GMSux8tAIye
 geakC1ihEZURC+1ajBpwKjH2gUT/kw3rD+2bAutGprRG+WA6Ie
 GWwCnlv1aOFe2JNtHF94z15PTiJmte1R+2UDPVH6FR1ya/AMk0
 P6djgGWtzFisWQ5tr+akQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203621>

Am 17.08.2012 17:28, schrieb Daniel Milde:
> Hi all,
> I have encountered some difficulties with the new location of the
> metainformation directory (GIT_DIR) of submodules.
> 
> The change of location happened in 1.7.8:
> 
>  * When populating a new submodule directory with "git submodule init",
>    the $GIT_DIR metainformation directory for submodules is created
> inside
>    $GIT_DIR/modules/<name>/ directory of the superproject and referenced
>    via the gitfile mechanism. This is to make it possible to switch
>    between commits in the superproject that has and does not have the
>    submodule in the tree without re-cloning.
> 
> Which problems it causes:
> 
> 1) You cannot move submodule easily (change the path to submodule). You
> can either remove the submodule and then add it again to different path,
> or move the submodule directory and then edit path in its .git, change
> path in superproject's .git/modules dir and in .git/config. This is
> quite difficult in comparisson with previous behaviour when you can just
> move the submodule and then stash changes.

Unfortunately that is currently the case. Plans are to have something
like a "git submodule mv", which will do all the magic and make moving
submodules easy again.

> 2) This change introduced many difficulties on Windows platform, because
> there is limitation to path length and the way how paths are now
> composed leads to strange errors when project with submodules is in
> user's dir. 

Hmm, this sounds more like the problems we had with "c:" and "/c",
which are fixed in current git. What version are you using?

> 3) Submodules became dependent on superproject. This is quite bad if you
> are using submodules a lot (e.g. versioning the whole working space),
> because you cannot move or copy them out of the superproject now.

Okay, that use case is new to me. What is the intention when you move a
submodule out of the work tree? Couldn't you just as easily clone the
upstream repo again at the new place?

> I honestly don't know why this change was introduced because I have
> never seen git removing any submodule while walking through the history.
> I have seen only the message saying that directory is not empty and so
> git will not remove it. Or is there another reason why this change was
> added to git?

But that is just the same as when a submodules appears and you check
out a commit before the submodule was added. It should be removed but
currently isn't, which we can change in a future git version now the
git directory lives in a safe place. Other reasons are:

*) Converting a directory tree into a submodules (or the other way
   round) is currently virtually impossible to handle. But that'll
   work just fine in the near future, which will make a lot of users
   happy.

*) It is easy to accidentally throw away the submodules history and
   unpushed changes when removing it from the work tree (e.g. because
   you don't work on that part of the tree anymore), which should
   only contain tracked content and not repository data like it did.

So we did that change to make submodule handling easier and to be able
to support valid use cases which we couldn't. Sorry for the hassle,
but we believe it is worth it in the long run.
