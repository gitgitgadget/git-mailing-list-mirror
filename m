From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [BUG] Fail to add a module in a subdirectory if module is already
 cloned
Date: Tue, 24 Jan 2012 22:10:55 +0100
Message-ID: <4F1F1E5F.2030509@web.de>
References: <jfmvpp$4v7$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jehan Bing <jehan@orb.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 22:11:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpne2-0001HY-5C
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 22:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757465Ab2AXVLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 16:11:05 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:44250 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755844Ab2AXVLE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 16:11:04 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate04.web.de (Postfix) with ESMTP id 07635712C616
	for <git@vger.kernel.org>; Tue, 24 Jan 2012 22:11:02 +0100 (CET)
Received: from [192.168.178.43] ([91.3.157.14]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0Lw1CH-1ShdJQ2FJt-018FiJ; Tue, 24 Jan 2012 22:11:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <jfmvpp$4v7$1@dough.gmane.org>
X-Provags-ID: V02:K0:zUtrjWjSJAu7YifnPpqSMN93HPdf5FrekFZk2o8aZaf
 4HMZ+iKKb+Rvm4YkkeQoert9GW92CotZlcn7pCyW7rqSYOaUpL
 clTn0bzWBC52RByt7iajeIcsjeLBhT9f1HD2cRqmPt5ztDZxwC
 OGOwidWw3VMxPyE1UHu55xBgukUjyWho6KMqfZLCoADZyrJi9S
 vUOWcraTzAtdoMFMrc1hw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189069>

Am 24.01.2012 20:11, schrieb Jehan Bing:
> I'm getting an error if I try to add a module in a subdirectory and that module is already cloned.
> Here are the steps to reproduce (git 1.7.8.3):
> 
> git init module
> cd module
> echo foo > foo
> git add foo
> git commit -m "init"
> cd ..
> git init super
> cd super
> echo foo > foo
> git add foo
> git commit -m "init"
> git branch b1
> git branch b2
> git checkout b1
> git submodule add ../module lib/module
> git commit -m "module"
> git checkout b2
> rm -rf lib
> git submodule add ../module lib/module
> 
> The last command returns:
>     fatal: Not a git repository: ../.git/modules/lib/module
>     Unable to checkout submodule 'lib/module'
> 
> The file lib/modules/.git contains:
>     gitdir: ../.git/modules/lib/module
> (missing an additional "../")
> 
> In branch b1, after adding the module, the file contained the full path:
>     gitdir: /[...]/super/.git/modules/lib/module
> Or contains the correct relative path after checking out b1 later:
>     gitdir: ../../.git/modules/lib/module

Thanks for your detailed report, I can reproduce that on current master.

The reason for this bug seems to be that in module_clonse() the name is
not properly initialized for added submodules (it gets set to the path
later), so the correct amount of leading "../"s for the git directory
is not computed properly. The attached diff fixes that for me, I will
send a patch as soon as I have extended a test case for this breakage.

diff --git a/git-submodule.sh b/git-submodule.sh
index 3adab93..9bb2e13 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -131,6 +131,7 @@ module_clone()
        gitdir=
        gitdir_base=
        name=$(module_name "$path" 2>/dev/null)
+       test -n "$name" || name="$path"
        base_path=$(dirname "$path")

        gitdir=$(git rev-parse --git-dir)
