From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: False positive from orphaned_commit_warning() ?
Date: Wed, 25 Jul 2012 16:43:38 -0400
Message-ID: <CAPBPrnugVm0RS5+Ljgg2E-AJygYsOSRjZW0Z=o9Mavs-SxTBog@mail.gmail.com>
References: <20120725185343.GA6937@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:43:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su8Qs-0006ub-SM
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 22:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329Ab2GYUnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 16:43:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41278 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2GYUnj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 16:43:39 -0400
Received: by eaak13 with SMTP id k13so49096eaa.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HnHTi63n/AVzz4brvdkDwd46GzP2jbR3lkFGUjcpAVY=;
        b=GD7WcL8wrupvOatilN4PlIfoBy1WHzc51qaTEuacLjyY886ZHhhuJTIjWYdDdbWJpP
         gXwC2SGWuEne7bPCWaauRuEo563qNLpvHf7F/N3CthIvbAUfKUu0hV3CeYPyP1jJGNHr
         QcC0uR3pxBz2ymmmnRc67UQWBR3TMTuAA9GIlZ/Jh2/5759v6oFDO0DAkKtpPaw8+Vez
         /rHaTtHXuQZgXdiNlr8ap/QYKvkgFkOEHFUu46vv+CIpGBqQM4VK9c/AhFY7Fq+HQlUs
         pLqWkMlJn1d7Piwe2nx5EGkRm6wEtd6xi7POMvKeqFxTd4t+fPIUE9U0MnkphA6s6oLx
         SknA==
Received: by 10.14.184.133 with SMTP id s5mr1384709eem.31.1343249018560; Wed,
 25 Jul 2012 13:43:38 -0700 (PDT)
Received: by 10.14.201.4 with HTTP; Wed, 25 Jul 2012 13:43:38 -0700 (PDT)
In-Reply-To: <20120725185343.GA6937@windriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202193>

On Wed, Jul 25, 2012 at 2:53 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> Has anyone else noticed false positives coming from the
> orphan check?  It is warning me about commits that are
> clearly on master.  Here is an example, where I checkout
> master~2 and then switch back to master.  It somehow thinks
> that master~2 is orphaned, when master~2 is by definition
> in the commit chain leading to master.

I've been able to reproduce this with the following simplified recipe,
although I still don't know what is causing the failure (I'm not very
familiar with the code)

git init test
cd test
#make 3 commits
touch a && git add a && git commit -m a
touch b && git add b && git commit -m b
touch c && git add c && git commit -m c

#clone it
cd ..
git clone test test2
cd test2
git checkout master~2
git checkout master
#Warning: you are leaving 1 commit behind, not connected to
#any of your branches


I can't figure out what's going wrong here, but the clone is
important; it doesn't fail without it. It appears to have something to
do with the fact that the cloned repository has a remote, as:
#in test2
git remote rm origin
git checkout master~2
git checkout master

Does not throw the warning, but it's not just the presence of
origin/master that triggers it, as:

cd ../test
git remote add origin ../test2
git fetch origin
git checkout master~2
git checkout master

Does not trigger it either.

Confused,
-- 
-Dan
