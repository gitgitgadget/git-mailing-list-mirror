From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: how to squash two commits into only one
Date: Wed, 30 Mar 2011 21:22:21 +0200
Message-ID: <4D9382ED.4090806@dirk.my1.cc>
References: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com> <AANLkTi=7TNjLVrcJVppiULBnDdKCM_vqwhn1JqoW+DQo@mail.gmail.com> <AANLkTimsN40twLwOWXsQqbv0SVN7T9rEHSUpcVum8aFR@mail.gmail.com> <AANLkTikX5YvMrooVi-7e-YDrCP_7QHqL6wR=1bY1cZ2L@mail.gmail.com> <5A9D499C-26AC-401E-B21A-1F8E03FBAC4B@gmail.com> <AANLkTinjbXzdfkxVRPPSXJj6Z0mMrikzdi2V8N5YAGR-@mail.gmail.com> <7v1v1psrvr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Joshua Juran <jjuran@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Lynn Lin <lynn.xin.lin@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 21:22:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q50yQ-0000sV-Ue
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 21:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720Ab1C3TW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 15:22:29 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:45700 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169Ab1C3TW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 15:22:28 -0400
Received: from [84.176.47.197] (helo=[192.168.2.100])
	by smtprelay02.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Q50yF-0002Iq-58; Wed, 30 Mar 2011 21:22:23 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <7v1v1psrvr.fsf@alter.siamese.dyndns.org>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170410>

Am 29.03.2011 20:28 schrieb Junio C Hamano:
> Nguyen Thai Ngoc Duy<pclouds@gmail.com>  writes:
>
>>> Actually, that should be: `git reset --soft HEAD^; git commit --amend`.
>>
>> "git rebase --root" does not seem a bad idea though.
>
> The lack of this did't annoy me enough (one woudln't have to deal with
> root commits too often) so I wouldn't bother implementing it myself, but
> "git rebase --root" especially with "-i" would be a nice addition.
>
> i.e. well written and explained patches welcome.

Lynn, this won't help you right now, but perhaps in the future:
When I create a new repo, the first thing I do is creating an
empty commit, like so:

git init my_repo
cd my_repo
git commit --allow-empty -m "Initial commit (empty)"

This creates an empty root commit which is helpful not only
in your case.

Another way to solve your problem would be to prepend that empty
root commit to your repo afterwards. It's a bit weird, but it
works -- at least if you don't have branches (except for
"master").

git checkout --orphan new_master  (1)
git rm -rf .                      (2)
git commit --allow-empty -m "Initial commit (empty)" (3)
git rebase new_master master      (4)
git branch -d new_master          (5)

(1) creates a new branch 'new_master' which is totally independent
     of any other branch in the repo, thus the option's name. But it
     silently does a "git add .", i.e. it stages all files that were
     checked out before issuing the command. See 'checkout' docs
     for details.
(2) removes all the files staged in (1), so that you have a new
     starting point which is really clean.
(3) creates the empty root commit on 'new_master'
(4) replays all changes of 'master' to 'new_master'. 'new_master'
     then has three commits: the root commit and the two commits from
     'master'
(5) removes the 'new_master' which is no longer needed.

And NOW you can do your 'rebase -i <root_commit>' to squash your
actual commits.

If you have more than one branch you would have to repeat step (4) with
the other branches.

HTH,
Dirk
