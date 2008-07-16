From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git submodules and commit
Date: Wed, 16 Jul 2008 13:35:24 +0200
Message-ID: <487DDCFC.9020007@viscovery.net>
References: <320075ff0807160331j30e8f832m4de3e3bbe9c26801@mail.gmail.com>	 <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com>	 <487DD1C7.3070701@viscovery.net> <320075ff0807160402s7429291ela288b42d99c1ec53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 13:36:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ5J7-0004TD-Pk
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 13:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbYGPLf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 07:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbYGPLf2
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 07:35:28 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:9267 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbYGPLf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 07:35:27 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KJ5I5-0000o6-2X; Wed, 16 Jul 2008 13:35:25 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BD9F56D9; Wed, 16 Jul 2008 13:35:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <320075ff0807160402s7429291ela288b42d99c1ec53@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88669>

Nigel Magnay schrieb:
> On Wed, Jul 16, 2008 at 11:47 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Nigel Magnay schrieb:
>>> For me, in some really high proportion of cases, I think I want 'git
>>> commit' to mean 'commit to any child repositories, any sibling
>>> repositories, and any parent repositories (updating the submodule sha1
>>> as appropriate). In other words, 'pretend like the whole thing is one
>>> big repo'.
>> And I think that this is the problem: If this way of commiting your
>> changes is *required* in the *majority* of cases, then you are IMO outside
>> the intended use-case of submodules. You are better served by really
>> making this one big repo.
>>
> 
> Hm - then my contention is that the scope of submodules needs to be
> expanded (or something needs to be built on top).
> 
> One-big-repo doesn't fly - > 75% of the code volume (the 'other'
> modules) are shared between multiple projects. In SVN these are just
> svn:externals (which has it's own imperfections).
> 
> I think it's a common usecase. You have 'shared' modules and
> 'project-specific' modules[*]. The 'shared' modules you hope don't
> change very much, but they are part of the overall project
> configuration - it's really nice that you can branch so easily in git,
> then get the module owner to merge those changes into the next release
> at their leisure. The superproject then represents the correct
> configuration of submodule trees to make a valid build.

Ah, is this your actual scenario? Just to make sure we are talking about
the same thing:

- You own superproject P.
- $Maintainer owns submodule S.
- You use S in P.
- You make changes to S that you would like $Maintainer to include in the
next release.
x You use in P your changes to S while $Maintainer has not yet released a
new version of S with your changes.
- Finally your changes arrive via the new release of S.

That *is* the intended use-case for submodules. But you have to play the
game by the rules:

- $Maintainer defines the official states of S.

- You must never commit an unofficial state of S in P.

The critical step in above list I marked with x:

- During the period where only *you* have the new changes to S, you must
*not* commit your submodule state to P. Instead, you write P in such a way
that it can work with both the old version of S and the upcoming release
that will have your changes[*]. This way you make sure that your consumers
of P always have a working version regardless of which version of S they use.

- After you have received the new release of S from $Maintainer, you
commit the new state of S in P. And if you are nice to your consumers of
P, then you *do not* remove the workaround from P just yet, so that you
don't force them to upgrade S. You will remove it later only if it becomes
a maintainance burden.

[*] If it is not possible to make P work with old and new versions, then
you have to work closely with the $Maintainer so that you never need
commit an unofficial state of S into P.

-- Hannes
