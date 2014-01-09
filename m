From: "W. Trevor King" <wking@tremily.us>
Subject: [RFC v3 0/4] Preferred local submodule branches
Date: Wed,  8 Jan 2014 22:17:51 -0800
Message-ID: <cover.1389247320.git.wking@tremily.us>
References: <20140108040627.GD29954@odin.tremily.us>
Cc: Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 09 07:18:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W18x8-0005a6-Ax
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 07:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbaAIGSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 01:18:47 -0500
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:43074
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751066AbaAIGSU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jan 2014 01:18:20 -0500
Received: from omta05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id BiJJ1n0040vyq2s53iJJV4; Thu, 09 Jan 2014 06:18:18 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta05.westchester.pa.mail.comcast.net with comcast
	id BiJH1n001152l3L3RiJHJ3; Thu, 09 Jan 2014 06:18:18 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 183D3EB6881; Wed,  8 Jan 2014 22:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389248294; bh=Ns5hevFc1KMYqKVOSoFoylZwVEeg8yBk+v154oYZd5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UFLobjKNbc1L6HIqXeZXV3KY6LMHq19569/FXkUAbgwrOEtaOFnHhZh+nQb4U+pCk
	 mMAVZ7MrVs34DOve0FlQ6RbE40JpgtWjB+A7IDe1+iS8LBKZKtAV6IbVY3kQZoBCRg
	 nT/bNG760ykiMje//HtmUGsRBHNmQcUjgOfbAWM8=
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <20140108040627.GD29954@odin.tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389248298;
	bh=mnRYEIJ1l7kxxhtd1gfk9JXd+4J3v4HcB4yDkr28tDU=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id;
	b=VhiD0EP6SJtfraNcNwFidcCiBBNPtI4/UmjZUHQC8AjYCMonQo1DLB6Y7yM+9SCrc
	 545brIVEVSyBssU+2sTJx1VjCRTwk6YicYcmnCdJKt17N2jLZHlmQJa0WLw/14/YwR
	 scIVmbOwdScmNbjkA8kzp0IRP6o0ridXVBhodMXKI4GI67AKsd9Cr6G21HTMvuXaqh
	 p0BoDo2NK9vOPW+uGAwVodVZR95JLwMVMR1Fm1WemxJzhT1WhWy8aocIzLGVVqoX6J
	 QocDmkifjN84NUYQHbU3ggdGTo8sp+6mDnZ2fUBLqTr7Fdhqmb0WipK5qxfgVGr/cg
	 AKpcQNNNlaJPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240248>

From: "W. Trevor King" <wking@tremily.us>

In another branch of the submodule thread Francesco kicked off, I
mentioned that we could store the preferred local submodule branch on
a per-superbranch level if we used the
.git/modules/<submodule-name>/config for local overrides [1].  Here's
a patch series that greatly extends my v2 "submodule: Respect
requested branch on all clones" series [2] to also support automatic,
recursive submodule checkouts, as I outlined here [3].  After this
series, I can get through:

  # create the subproject
  mkdir subproject &&
  (
    cd subproject &&
    git init &&
    echo 'Hello, world' > README &&
    git add README &&
    git commit -m 'Subproject v1'
  ) &&
  # create the superproject
  mkdir superproject
  (
    cd superproject &&
    git init &&
    git submodule add ../subproject submod &&
    git config -f .gitmodules submodule.submod.update merge &&
    git commit -am 'Superproject v1' &&
    ( # 'submodule update' doesn't look in .gitmodules (yet [4]) for a
      # default update mode.  Copy submodule.submod.update over to
      # .git/config
      git submodule init
    )
  ) &&
  # start a feature branch on the superproject
  (
    cd superproject &&
    #git checkout -b my-feature --recurse-submodules &&
    ( # 'git submodule checkout --recurse-submodules' doesn't exist yet, so...
      git checkout -b my-feature &&
      git submodule checkout -b --gitmodules
    ) &&
    (
      cd submod &&
      echo 'Add the subproject side of this feature' > my-feature &&
      git add my-feature &&
      git commit -m 'Add my feature to the subproject'
    ) &&
    echo 'Add the superproject side of this feature' > my-feature &&
    git add my-feature &&
    git commit -am 'Add the feature to the superproject'
  ) &&
  # meanwhile, the subproject has been advancing
  (
    cd subproject &&
    echo 'Goodbye, world' >> README &&
    git commit -am 'Subproject v2'
  ) &&
  # we need to get that critical advance into the superproject quick!
  (
    cd superproject &&
    # update the master branch
    #git checkout --recurse-submodules master
    ( # 'git checkout --recurse-submodules' doesn't exist yet [5,6].
      # Even with that patch, 'git checkout' won't respect
      # submodule.<name>.local-branch without further work.
      git checkout master &&
      git submodule checkout
    ) &&
    git submodule update --remote &&
    git commit -am 'Catch submod up with Subproject v2' &&
    # update the my-feature branch
    #git checkout --recurse-submodules my-feature &&
    ( # 'git checkout --recurse-submodules' doesn't exist yet [5,6].
      git checkout my-feature &&
      git submodule checkout
    ) &&
    git submodule update --remote &&
    git commit -am 'Catch submod up with Subproject v2' &&
    # what does the history look like?
    (
      cd submod &&
      git --no-pager log --graph --date-order --oneline --decorate --all
      # *   16d9e3e (HEAD, my-feature) Merge commit 'f5e134d5747ee4a206e96d8c017f92f5b29a07f3' into my-feature
      # |\  
      # | * f5e134d (origin/master, origin/HEAD, master) Subproject v2
      # * | 0a1cd07 Add my feature to the subproject
      # |/  
      # * c2d32ba Subproject v1
    ) &&
    printf 'master: ' &&
    git ls-tree master submod &&
    # master: 160000 commit f5e134d5747ee4a206e96d8c017f92f5b29a07f3  submod
    printf 'my-feature: ' &&
    git ls-tree my-feature submod
    # my-feature: 160000 commit 16d9e3ea2fb57e7a166587203abdb328f90895d1  submod
  )
  git --version
  # git version 1.8.5.2.237.g01c62c6

I think the first three patches are fairly solid.  The last one gets
through the above script, but I'd need a more thorough test suite
before I trusted it.  I tried to be detailed in the commit messages,
but of course, we'd want some user-facing documentation if we actually
merged something like this series.  I'm sending it to the list mostly
to explain my current views and re-focus debate [1].

[1]: http://article.gmane.org/gmane.comp.version-control.git/240240
[2]: http://article.gmane.org/gmane.comp.version-control.git/239967
[3]: http://article.gmane.org/gmane.comp.version-control.git/240192
[4]: http://article.gmane.org/gmane.comp.version-control.git/239246
[5]: http://thread.gmane.org/gmane.comp.version-control.git/239695
[6]: http://article.gmane.org/gmane.comp.version-control.git/240117

Cheers,
Trevor

W. Trevor King (4):
  submodule: Add helpers for configurable local branches
  submodule: Teach 'update' to preserve local branches
  submodule: Teach 'add' about a configurable local-branch
  submodule: Add a new 'checkout' command

 git-submodule.sh | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 138 insertions(+), 14 deletions(-)

-- 
1.8.5.2.237.g01c62c6
