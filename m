From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Cloning into an existing, non-empty directory?
Date: Fri, 22 Apr 2011 13:21:42 +0200
Message-ID: <BANLkTikY7c7rP+yv5vt2vxw5nu84k_H=Xw@mail.gmail.com>
References: <BANLkTi=VwiqN99AMEJb6jb1uFya2Hipibw@mail.gmail.com> <20110421220327.GA3396@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 13:22:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDER8-00069t-EL
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 13:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951Ab1DVLWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2011 07:22:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43030 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab1DVLWD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2011 07:22:03 -0400
Received: by iwn34 with SMTP id 34so411180iwn.19
        for <git@vger.kernel.org>; Fri, 22 Apr 2011 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=aX+Ln29DU7PQCX55hu+pl+GdiMdlg/AVcYHnbgkR0Ac=;
        b=IJLFzspcRbLTOGSvzVP3KNismqCCSqPS6CWwhuU5spvvq6P60kwtmMBfXHkDU+vduv
         WLq+qI1G9rCzoDBnuTQxTlHfwMGMv9830K7bwfIpH/86OW6lVJShsIIJVBOQqgiPrwPS
         XuL4fB4gq+0SGwXQ9avIbqxAahY3g+nQN6B+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xgvo3N5qQ1ntZPv2T2ib3kcp1ytMZ4HAUfhq5SC+GMpejnZwXdMWzTy7NJ5DW+g+dY
         mQfFNvnQNkNGiTqL6ZLh+nSjxGxPH2fvotxHYspiCm8zQZq1COl5LY9pAd26W01U2SqO
         wGHJiR9mpm7xtcerBA2KVnzN87ctlSbAPNq1o=
Received: by 10.231.210.148 with SMTP id gk20mr756176ibb.110.1303471322311;
 Fri, 22 Apr 2011 04:22:02 -0700 (PDT)
Received: by 10.231.92.16 with HTTP; Fri, 22 Apr 2011 04:21:42 -0700 (PDT)
In-Reply-To: <20110421220327.GA3396@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171934>

On Fri, Apr 22, 2011 at 00:03, Jonathan Nieder <jrnieder@gmail.com> wrote:

> Have you tried something like the following?

I didn't. Thanks a lot for your feedback.

My tentative script, which is pretty ham-fisted, takes care of most
(all?) possible errors, feedback on it is very welcome.

Two issues remain, though:

1) git merge does not seem to understand either of those parameters.
This means that I have to pull, not merge, which introduces a race
condition into my safety checks. Which leads me to

2) running `git pull` as suggested results in:

fatal: /usr/lib/git-core/git-pull cannot be used without a working tree.

which can be worked around by using --work-tree and --git-dir . Not
ideal, but workeable if I accept the race condition.




#!/bin/sh
set -x

[[ $# -lt 2 ]] && echo "not enough arguments" && exit 1
[[ $# -eq 2 ]] && GIT_WORK_TREE="$HOME/killme/fgit/target-default"
[[ $# -eq 3 ]] && GIT_WORK_TREE="$3"
[[ $# -gt 3 ]] && echo "too many arguments" && exit 2

GIT_REMOTE="$1"
GIT_DIR="$2"
export GIT_REMOTE GIT_DIR GIT_WORK_TREE
mkdir -p $GIT_WORK_TREE
cd $GIT_WORK_TREE ||
  (echo "$(basename $0): fatal: could not enter $GIT_WORK_TREE" &&
   exit 20) || exit 20
git init
git remote add origin $GIT_REMOTE
git config branch.master.remote origin
git config branch.master.merge  refs/heads/master
git fetch
for i in $(git ls-tree -r origin/master | awk '{print $4}'); do
	[[ -e $i ]] &&
	  echo "$(basename $0): error: $i exists." &&
	  CONFLICT=1;
done

[[ -n $CONFLICT ]] &&
  echo "$(basename $0): Will stop after fetching and not try to merge!\n" &&
  exit 3

git --work-tree="$GIT_WORK_TREE" --git-dir="$GIT_DIR" pull
#git --work-tree="$GIT_WORK_TREE" --git-dir="$GIT_DIR" merge


As usual, any and all feedback appreciated,
thanks,
Richard
