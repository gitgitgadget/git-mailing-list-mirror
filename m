From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: configuring cherry-pick to always use -x?
Date: Tue, 15 Feb 2011 09:58:03 +0100
Message-ID: <4D5A401B.1050103@drmicha.warpmail.net>
References: <4D596435.9020605@gmail.com> <AANLkTimi=d0qbO3_-BEnPEJ+iy9B=_fksF7TiBE7HorC@mail.gmail.com> <4D59A39C.9090402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 10:01:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpGmZ-0004j8-Jq
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 10:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969Ab1BOJBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 04:01:09 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57588 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751769Ab1BOJBI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 04:01:08 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 57BA920A3C;
	Tue, 15 Feb 2011 04:01:08 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 15 Feb 2011 04:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=UWXa747YVkY2NXhF9Zjk0x0L7jA=; b=J1H8LLASxra/FAopq5+ndTY5lytftu9mSqtzKm8imrbf5K4IvgkqizC1rVRViOUjmzpAPROgQUdHUDLGD5iCcrV9wa/ny/id42dl/aKMR3Xm/5uGmGlzpdEkgy9JQNjDIV7jg4aQYwSwH145o8lbu8BFv2jN+qZKW733auzagSI=
X-Sasl-enc: KaH/vqa3jfbKtfVWFAL9OGGjS9huUMPDFuozO3IDXH7x 1297760468
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 894C8400D93;
	Tue, 15 Feb 2011 04:01:07 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <4D59A39C.9090402@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166829>

Adam Monsen venit, vidit, dixit 14.02.2011 22:50:
> Junio C Hamano wrote:
>> could you please justify in what workflow it would make sense to use
>> -x most of the time?
> 
> Sure. Summary: two long-lived publicly visible branches.
> 
> Details:
> Mifos is what I'm usually working on lately. We have branches "master"
> and "f-release" both present in our public git repository called "head"
> (hosted at sf.net). master is the bleeding edge of development,
> f-release is a release maintenance branch recently created off the tip
> of master. I expect both to live on forever (even though commits to
> f-release will eventually cease).
> 
> Right after f-release was cut, we merged f-release to master every day
> or so to make sure bugfixes for f-release were also propagated to future
> releases. After a while, merging resulted in too many conflicts and we
> started cherry picking instead.
> 
> This process is described generally at
> http://mifosforge.jira.com/wiki/display/MIFOS/Release+Branch+Merging+Policy

I don't quite understand how cherry picks could conflict less then
merges if the release branch contains fixes only. Also, I don't think
the advice to use "merge+revert" is a good one. All of this indicates a
suboptimal use of branches. My impression is that "f-release" actually
mixes release engineering and maintenance. Two possible remedies:

- Separate release engineering from maintenance and merge only the
latter to master

- If you do want them on the same branch "f-release", you probably know
beforehand which commits you don't want on master. You can fake-merge
these ("merge -Xours") to master and merge the others, which is somewhat
ugly but still better than cherry-picking everything. In some sense this
is "manual rerere" whose results are shared (pushed) easily.(*)

Michael

(*) If that is cryptic, I mean something like:

git checkout master
git merge f-release
#be happy if it succeeds, identify problematic commit X if not; decide
whether X belongs on master; if yes resolve, if not reset and:
git merge X^
git merge -Xours X
#back to start
