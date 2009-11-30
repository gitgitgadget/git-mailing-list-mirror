From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Mon, 30 Nov 2009 16:59:18 +0100
Message-ID: <4B13EBD6.5060608@drmicha.warpmail.net>
References: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brlink@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 30 17:00:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF8g0-0006Tn-P9
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 17:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbZK3QAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 11:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbZK3QAY
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 11:00:24 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:34710 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752149AbZK3QAX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 11:00:23 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2C280C5AF0;
	Mon, 30 Nov 2009 11:00:30 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 30 Nov 2009 11:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5Xxu9eeJzinuyPxDdGQ+Js5YEW8=; b=g41WZtlG90HIEv4IoLiJ2MbSbdz4JrFGi4yL8FNdSE6In3l+LYrU/a+XDkGS/TS5qTOhwTSmkEH9fk990mbrs5c8hUJknOVZ2BsvD9zvEdT3Kp/wai/ztL4K/29B4jl3qSQ+OTpa3ZroX2hRHxLMBltwMGDF+2MzK6OUwDm/BIs=
X-Sasl-enc: D6rI7xf76krEU2WXKyoiDzg5585x1H1q5/V+5bYC/t+D 1259596829
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 856851C98;
	Mon, 30 Nov 2009 11:00:29 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <cover.1259524136.git.brlink@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134116>

Bernhard R. Link venit, vidit, dixit 30.11.2009 15:43:
[...]

Ok, I couldn't resist looking at your examples. Actually, before
anything else: Thanking for describing *what* you want to achieve, not
only how.

> Example 1:
> 
> Let's assume you maintain such a regularily-rebased branch that you
> want to be able to publish (or pull from other repositories for example
> on your laptop):
> 
> o=m=o=o=master
>    \
>     a=b=c=d=e=feature
> 
> with this patch you can do "git rebase -eqt master" and get:
> 
>               a'=b'=c'=d'=e'=feature'=eqt
>              /                       /
> o=m=o=o=master--------              /
>    \                  \            /
>     a=b=c=d=e=feature--merge-------
> 

git checkout -b featureprime feature
git rebase master
git merge feature # should be trivial
git branch -M featureprime feature

> i.e: the new feature branch has both histories:
>   - "feature'" where everything is cleanly rebased and in a form where
>                format-patch is suitable to send it upstream
>   - "merge" which is both a descendant from feature (so one can see what
>     changed since that time and can just pull when one had had cloned feature)
> 
> Example 2:
> 
> Let's assume you have a feature branch like
> 
> o=master
>    \
>     a=b=c=d=e=f
> 
> Assume you just commited "f" which fixes a bug introduced by "b".
> Now you of course do not want to send it that way upstream (as it will
> make reviewing harder, may force people bisecting to skip some versions
> every time they hit this region and so on), so you want to
> bisect -i and squash "f" into "b".
> 
> o=master
>    \
>     a=b+f=c'=d'=e'
> 
> But if you had already cloned at state "d" to your laptop (or made a backup
> of that branch at some server, or published it for use of some collegues)
> it will not be a fast-forward, so you have to be very carefull to not
> accidentially lose a commit that is already there.
> 
> So with this patches you can do "git rebase -i --eqt" and squash f into b
> and get:
> 
> o=master
>    \
>     a=b=c=d=e=f---
>      \            \
>       b+f=c'=d'=e'=eqt
> 
> which means that you can just pull from your laptop and get the new head
> as fast-forward, but still have a proper history ready for submitting.

If that side branch is named "feature":
git checkout -b fixup feature
git rebase -i a # squash f into b; creates b+f c# d' e'
git merge feature # should be trivial
git branch -M fixup feature

You can also go crazy with rebase --onto here, or use cherry-pick
repeatedly.

Note that I always use a temporary branch for rewriting, before renaming
it to the proper branch name. I haven't checked, but I assume the
"first-parents" are the way you want them (you want log --first-parent
--no-merges to show the rewritten commits, right?); otherwise you would
have to do the merges the other way round.

Cheers,
Michael
