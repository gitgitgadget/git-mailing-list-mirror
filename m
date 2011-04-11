From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: gitattributes - clean filter invoked on pull?
Date: Mon, 11 Apr 2011 12:00:45 +0200
Message-ID: <4DA2D14D.6010707@viscovery.net>
References: <20110411084229.GW5146@genesis.frugalware.org> <20110411091919.GE28959@kytes> <20110411093114.GY5146@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	timar74@gmail.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 12:01:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Dvi-0000di-MY
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 12:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab1DKKAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 06:00:51 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56265 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752835Ab1DKKAv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 06:00:51 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q9DvK-00030O-RQ; Mon, 11 Apr 2011 12:00:47 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 55ADE1660F;
	Mon, 11 Apr 2011 12:00:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110411093114.GY5146@genesis.frugalware.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171323>

Am 4/11/2011 11:31, schrieb Miklos Vajna:
> On Mon, Apr 11, 2011 at 02:49:21PM +0530, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>>> Is this a bug? I don't exactly understand why this would be necessary.
>>
>> From config.txt:
>> - 'clean' is "The command which is used to convert the content of a
>> worktree file to a blob upon checkin".
>> - 'smudge' is "The command which is used to convert the content of a
>> blob object to a worktree file upon checkout."
>>
>> According to the documentation, 'smudge' is *supposed* to be invoked
>> on a clone/ pull, since it involves a checkout.  I don't see how you
>> can avoid running these filters on every checkin/ checkout unless you
>> cache the result somewhere.
> 
> That's not a problem - the issue I pointed out is that the 'clean' one
> is invoked on pull/clone, and it takes time if it's applied to several
> files.

The invocation is only needed when files are marked as "racily clean",
because in this case git has to check whether the worktree contents are
what is recorded in the index or not. This can happen a lot when you have
a fast machine where many worktree files and the index itself can be
written within the same (wall clock) second. You example is so short that
it triggers this case almost reliably.

When git pull merges the fetched commit, it has to determine whether there
are no changes in any of the files that are to be updated by the merge. If
one such file is marked as racily clean, the worktree contents must be
inspected, which in turn means that the clean filter has to be used.

If you insert before the final 'git pull':

sleep 1
git reset
sleep 1

you will notice that some clean filter calls happen before the 'git pull'
because git 'git reset' rectifies the racily-clean entry.

This just explains what you observed. I haven't thought about how you
should change your workflow to avoid this behavior. My guess is that the
extra clean filters called by 'git pull' don't actually happen that
frequently during normal interactive work that touches the index.

Perhaps you are also bitten by a regression in 'git status', which does
not correct the racily-clean entries even though it should (fixed in git
1.7.4.4.), and therefore the clean filter is run more often than necessary.

> 
> 'smudge' is just a 'cat', I don't care about it. :)

Then you can just remove it from the config and save a fork(). You don't
have to configure both clean and smudge filters.

-- Hannes
