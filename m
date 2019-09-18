Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661151F463
	for <e@80x24.org>; Wed, 18 Sep 2019 15:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfIRPOJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 11:14:09 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:59101 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfIRPOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 11:14:09 -0400
X-Originating-IP: 1.186.12.28
Received: from localhost (unknown [1.186.12.28])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 29B4BC001D;
        Wed, 18 Sep 2019 15:14:05 +0000 (UTC)
Date:   Wed, 18 Sep 2019 20:44:04 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: missing some patches from git?
Message-ID: <20190918151404.rqjohdderwxfqtdm@yadavpratyush.com>
References: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
 <20190918092721.GA76617@archbookpro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918092721.GA76617@archbookpro.localdomain>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/09/19 02:27AM, Denton Liu wrote:
> On Wed, Sep 18, 2019 at 09:02:37AM +0200, Birger Skogeng Pedersen wrote:
> > Hi Pratyush,
> > 
> > 
> > I was comparing your git-gui repo[1] with the source code of
> > git/git-gui[2]. There seems to be a couple of things missing.
> > 
> > For example, I created a patch back in March 2018[3]. Junio pulled it
> > so the changes are really there in git/git-gui/git-gui.sh (see this[4]
> > line). This was while there was no git-gui maintainer. I guess the
> > change never got merged to git-gui, but directly to git.
> > 
> > Not sure what you should to about it, I just wanted to let you know.

This is something I've been aware of, but I have followed the strategy 
of ignoring the problem till someone complains. Well, that someone has 
now complained.

I'm not particularly comfortable with cross-tree/sub-tree merges, so 
I've been dreading doing this for a while. Guess now its time to get my 
hands dirty.

> > 
> > [1] https://github.com/prati0100/git-gui
> > [2] https://github.com/gitster/git/tree/master/git-gui
> > [3] https://public-inbox.org/git/20180302100148.23899-1-birgersp@gmail.com/
> > [4] https://github.com/gitster/git/blob/master/git-gui/git-gui.sh#L3885
> > 
> > 
> > Birger
> 
> As an exercise in writing throwaway scripts, I created this monstrosity.
> If you're interested in merging all of the git-gui branches that came
> from mainline back into git-gui's master, perhaps we could do something
> like this:

Ah! Thanks a lot for this. This reduces some of the work I've been 
dreading.

> 
> 	#!/bin/sh
> 
> 	branches=
> 	# note that all instances of "master" refer to git.git's "master"
> 	# also, 5ab7227 is the latest commit in Pat's git-gui repo
> 	for c in $(git rev-list --children master 5ab7227 | grep ^5ab7227 | cut -d' ' -f2-)
> 	do 
> 		merge_commit=$(git rev-list $c..master --ancestry-path --merges | tail -n1)
> 		branch_name=$(git show -s --format=%s $merge_commit | sed -e "s/Merge branch '\\([^']*\\)' of .*/\\1/")
> 
> 		#echo $branch_name: $(git rev-parse $merge_commit^2)
> 		git branch -f "$branch_name" $merge_commit^2
> 		branches="$branches $branch_name"
> 	done
> 	# this also assumes git-gui's master is checked out
> 	git merge $branches

Assuming I have git.git cloned in ../git (relative to git-gui.git), I 
ran:

  git pull -Xsubtree=git-gui ../git $branches

instead of:

  git merge $branches

because git-gui's tree doesn't have those commits and branches yet, so 
we can't merge straight away. This seems to have worked, but I thought 
I'd mention it in case it would cause some subtle problems.

> This script should resurrect all of the branches that were based on
> 5ab7227 from mainline's master. Then (assuming you have git-gui's
> master checked out), it should do a big octopus merge to bring all of
> the changes in.
> 
> We end up with the following branches being merged:
> 
> 	js/msgfmt-on-windows: 492595cfc70f97cd99d4c460db1ba01b73dab932

This branch is already in git-gui (with the exception of one commit. 
More on that below).

> 	tz/fsf-address-update: 63100874c1653dd6a137f74143eda322550eabc7
> 	jn/reproducible-build: 474642b4a47c74a1f277955d7387d1886546fa01
> 	ls/no-double-utf8-author-name: 331450f18a7fd298ddd6b85cc5e8ed9dba09f9da
> 	js/misc-git-gui-stuff: 76756d67061076c046973bff2089ad49f5dc2eb6
> 	bb/ssh-key-files: 6a47fa0efa342daa53c6386538fda313420351a5
> 	bp/bind-kp-enter: 146a6f1097f451c6b6d332916a515b7ce8c07e9a
> 	cb/ttk-style: f50d5055bf9bb2aa35e629d31943334afc4a9f10
> 	py/call-do-quit-before-exit: 5440eb0ea2651c45a0e46f2335ecbb8d1f42c584
> 
> Then perhaps you could do a request-pull and development could continue
> on your fork?
> 
> Not sure if this is even desirable but here's the script just in case it
> ends up useful. I had fun writing it.

Just to pick your brain: in what case would this not be desirable?
 
> Also note that we end up missing two commits that made changes to
> git-gui/ under mainline git (not directly to the git-gui repo): 
> 
> 	* 7560f547e6 (treewide: correct several "up-to-date" to "up to date", 2017-08-23)
> 	* 00ddc9d13c (Fix build with core.autocrlf=true, 2017-05-09)

One more commit that is missing: 492595cfc7 (git-gui (MinGW): make use of MSys2's msgfmt, 2017-07-25)

This commit is comes from the merge of js/msgfmt-on-windows, which has 
all the commits from the merge 5ab7227 (Merge remote-tracking branch 'philoakley/dup-gui', 2017-03-18)
in git-gui.

While merging js/msgfmt-on-windows should get this commit into git-gui, 
I'd rather have it separate,

> 
> Hope any of this is useful to anyone,

It is very useful. Thanks :)

-- 
Regards,
Pratyush Yadav
