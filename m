From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git checkout under 1.7.6 does not properly list untracked files
 and aborts
Date: Wed, 21 Sep 2011 10:28:59 +0200
Message-ID: <4E79A04B.7080607@drmicha.warpmail.net>
References: <4E6A7167.6070408@workspacewhiz.com> <4E779BA4.8070109@workspacewhiz.com> <4E78ACE2.60306@drmicha.warpmail.net> <4E78DACF.3030200@workspacewhiz.com> <4E7996AA.4040909@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Sep 21 10:29:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6IB7-0008SS-Ef
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 10:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088Ab1IUI3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 04:29:06 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36558 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751897Ab1IUI3D (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 04:29:03 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway2.nyi.mail.srv.osa (Postfix) with ESMTP id BDF8529E45;
	Wed, 21 Sep 2011 04:29:02 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 21 Sep 2011 04:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=gAogPcFOZ/9xB9x/p+mQ98
	QECL4=; b=nGFHA5oQfiLtsU1sdHrtWBJr99P9XQwanHPJU+QEjTZfUWlC57/GXA
	rQQ5+ny0Bn1zbU6og01lVcD3lwFQKDx4DmijdfY6RJQRO3hHIYuUOqnYzFxmQqeu
	crhfvoYnVfy0PXVCzDhFv2oJ4UwtG2pQyMQhai1YwgK9LsbRhJbJE=
X-Sasl-enc: g+9f44E8vLbNVOlz3/fYS0l4s2gNUfpvHKCfknZlUPu/ 1316593742
Received: from localhost.localdomain (p548594C9.dip0.t-ipconnect.de [84.133.148.201])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 00D647C06E7;
	Wed, 21 Sep 2011 04:29:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <4E7996AA.4040909@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181826>

Michael J Gruber venit, vidit, dixit 21.09.2011 09:47:

> Interesting. So, it is related to sparse, it seems, and there is also a
> mistake in the documentation (which contradicts itself, btw). With your
> script, since all files are requested to be checked out ('*'), none
> should have skip-worktree set, and the result should be the same as with
> my version. But I get this:
> 
> Initialized empty Git repository in /tmp/t/utest/.git/
> [master (root-commit) 5929c8b] a
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 a
> [master 60ad69e] b
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 b
> tracked
> Switched to branch 'side'
> cat: b: No such file or directory
> untracked
> untracked
> 
> That is probably the same output as for you. The final "git checkout
> master" errored out without doing anything and without message. I'll
> send a few cleanups now, and do some bisecting and thinking later;
> though there are people whose sparse-knowledge is way less sparse than
> mine ;)

So, I bisected it. The first bad commit is

9037026 (unpack-trees: fix sparse checkout's "unable to match
directories", 2010-11-27)

although the real culprit may be its predecessor

2431afb (unpack-trees: move all skip-worktree checks back to
unpack_trees(), 2010-11-27)

which does not compile:

    CC unpack-trees.o
unpack-trees.c: In function 'mark_new_skip_worktree':
unpack-trees.c:852:75: error: 'o' undeclared (first use in this function)
unpack-trees.c:852:75: note: each undeclared identifier is reported only
once for each function it appears in
make: *** [unpack-trees.o] Error 1

So, this problem was introduced after v1.7.3.2. Given the extent of
those two commits, I can't help further (but your proposed fix may be fine).

Duy, sorry for prodding you again. My bisect script was (based on
Joshua's, based on mine):

#!/bin/sh
GIT_EXEC_DIR=~/src/git
PATH=$GIT_EXEC_DIR:$PATH
export GIT_EXEC_DIR
d=/tmp/t/utest
rm -Rf $d || exit 1
mkdir $d || exit 1
cd $d || exit 1
git init
git config core.sparseCheckout true
echo *>.git/info/sparse-checkout
echo tracked>a
git add a
git commit -m a a
git branch side
echo tracked>b
git add b
git commit -m b
git checkout side
echo untracked>b
git checkout master 2>&1 | grep "would be"

Hope this helps.

Michael
