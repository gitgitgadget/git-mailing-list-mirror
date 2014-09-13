From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-new-workdir submodules interact poorly with core.worktree
Date: Sat, 13 Sep 2014 13:25:31 +0200
Message-ID: <541429AB.8030202@web.de>
References: <1410527113-sup-9003@sabre>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Edward Z. Yang" <ezyang@mit.edu>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 13 13:25:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSlSU-0003uv-T2
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 13:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbaIMLZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 07:25:35 -0400
Received: from mout.web.de ([212.227.17.11]:50599 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbaIMLZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 07:25:34 -0400
Received: from [192.168.178.41] ([79.193.66.205]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Llna8-1Y26Cy0Rjk-00ZQ70; Sat, 13 Sep 2014 13:25:32
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <1410527113-sup-9003@sabre>
X-Provags-ID: V03:K0:9HeXDAaO5xEh6tWydXpL9TSksFgqnphAvPpaFIg2ARRtDxOF/el
 XtxpzEAWsujKMVNbr8TTl2/Jnf5tiggoozSXOD2lMyDO7b9aV/nNevlWzzr/yy2G7oZOqi/
 jvJxGFUIznL1x8Tc+y8P6tBw/sWkvVjJEPTFn1ePFS6Dv0XT3+ValvUuHyM0KClgMwAeaNQ
 rhG3Dui+jmNWjR//svT5Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256965>

Am 12.09.2014 um 15:58 schrieb Edward Z. Yang:
> tl;dr You can't git-new-workdir checkouts which use core.worktree.  This
> is unfortunate because 'git submodule init' uses core.worktree by
> default, which means you can't recursively git-new-workdir without a
> hack.
>
> In the beginning, the Developer created the remote Git repository and
> the submodule.
>
>      mkdir -p remote/sub
>      (cd remote/sub && git init && touch a && git add a && git commit -m "sub init")
>      mkdir remote/top
>      cd remote/top
>      git init
>      git submodule add ../sub
>      git commit -m "top init"
>      cd ../..
>
> And the Developer said, "Let there be a local clone and submodule", and
> lo, there was a local clone and submodule:
>
>      git clone remote/top top
>      (cd top && git submodule init && git submodule update)
>
> the Developer blessed the working copy, and said "Be fruitful and
> increase in number with git-new-workdir":
>
>      git-new-workdir top worktop
>
> Unfortunately, this workdir didn't have the submodules initialized.
>
>      $ ls worktop/sub/
>      $
>
> Now, the Developer could have run:
>
>      $ (cd worktop && git submodule init && git submodule update)
>
> but the resulting submodule would not have been shared with the original
> submodule, in the same way that git-new-workdir shared the Git metadata.
>
> The Developer sought to create the submodule in its own likeness, but it
> did not work:
>
>      $ rmdir worktop/sub && git-new-workdir top/sub worktop/sub
>      fatal: Could not chdir to '../../../sub': No such file or directory
>
> What was the Developer's fall from grace?  A glance at the config of
> the original and new submodule shed light on the matter:
>
>      $ cat top/sub/.git
>      gitdir: ../.git/modules/sub
>      $ cat top/.git/modules/sub/config
>      [core]
>              repositoryformatversion = 0
>              filemode = true
>              bare = false
>              logallrefupdates = true
>              worktree = ../../../sub
>      $ cat worktop/sub/.git/config
>      [core]
>              repositoryformatversion = 0
>              filemode = true
>              bare = false
>              logallrefupdates = true
>              worktree = ../../../sub
>
> git-new-workdir sought to reuse the config of top/sub/.git, but this
> configuration had core.worktree set.  For the original checkout,
> this worked fine, since its location was .git/modules/sub; but for the
> new workdir, this relative path was nonsense.
>
> I do not think there is really a way to make this work with
> core.worktree.  Our saving grace, however, is there is a hack that can
> make this work: we just need to use the
> pre-501770e1bb5d132ae4f79aa96715f07f6b84e1f6 style of cloning
> submodules:
>
>      git clone remote/top oktop
>      git clone remote/sub oktop/sub
>      (cd oktop && git submodule init && git submodule update)
>
> Now recursive git-new-workdir will work.

Thanks for the report and a nice summary.

> What's the upshot?  I propose two new features:
>
> 1. A flag for git submodule update which reverts to the old behavior
> of making a seperate .git directory rather than collecting them together
> in the top-level .git/modules

That would play bad with the upcoming recursive submodule update
(which needs .git/modules to safely remove a submodule work tree),
so I wouldn't want to do that step backwards.

> 2. Teach git-new-workdir to complain if core.worktree is set in the
> source config, and how to recursively copy submodules.

I'd prefer pursuing this approach.
