From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] checkout: indicate when a detached head is checked out
 for a branch
Date: Fri, 18 Jul 2014 15:27:50 +0200
Message-ID: <53C920D6.80104@drmicha.warpmail.net>
References: <35dbe7e3f3e4566d775bea19d816adc44db8ed5c.1405676303.git.git@drmicha.warpmail.net> <CACsJy8CG17tzWWO27Pv2c+CjDyYiYATzgBSFfMBaugYgQfZQ5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 15:28:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X88Cp-0006Ga-1L
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 15:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935133AbaGRN2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 09:28:06 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47926 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932093AbaGRN2D (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2014 09:28:03 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7B3092187B;
	Fri, 18 Jul 2014 09:28:02 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 18 Jul 2014 09:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=qGHwpjtkpU3mhlftSBEmbd
	hn7Zc=; b=lR46U2BghIUVnltQZ2MQigOMLjjV1dnrIJCtYq/qOukxFPO6aK9RKi
	2rNilwvA40mNcxDsl/CCpCiMlmyAZj4D5ENi6mENgWUAUYujt/PgPtBIBCsG1i4J
	8WjjkXsQrhKUD/pRmh7scYa5aI7zVnLzyqnwqtlwBqrKc9P2SFMfw=
X-Sasl-enc: StcJgMWV4J2roGYghGgmTLEwHSyFmvYkdxDYRcIm2oN4 1405690081
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A0DC6680156;
	Fri, 18 Jul 2014 09:28:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8CG17tzWWO27Pv2c+CjDyYiYATzgBSFfMBaugYgQfZQ5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253818>

Duy Nguyen venit, vidit, dixit 18.07.2014 12:58:
> On Fri, Jul 18, 2014 at 4:50 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> I really like the new --to feature and will convert all my "new workdir"
>> checkouts to that. But that detached checkout is so easy to miss - in fact
>> I noticed it only when I compared "new-workdir" to "checkout --to" for a
>> test repo with one branch, to see what a converter would need to do.
>>
>> I'm even wondering whether we should do this DWIMmery at all,
> 
> This is what this series needs, user's opinions (bad or good). The
> other option is abort the checkout immediately. I think I made detach
> behavior default is because it's more work (and needs to be proven
> feasible). How about a config key that lets user decide what to do
> here, abort or detach. We may change the default behavior too if
> people think the current one is not good.

Uh, config bloat :)

I think DWIMmery is OK if it's made clear to the user what happened, and
it is somewhat expected/probably intended behavior.

Do we have a precedent where a detached head is produced when a branch
checkout is requested, or something similar? I think checking out remote
tracking branches is somehow in that same boat.

>> given how "dangerous" a detached head is for those who are not aware of it
>> before gc kicks in.
> 
> Wait, what danger are we talking about? I thought gc pays attention to
> detached heads as well..

As long as HEAD points to it, of course.

I think detached head is one of the killer features of git, in both
senses of the meaning...

Don't we DWIM (or suggest) "git checkout origin/master" to "git checkout
--track origin/master" which creates master with upstream origin/master?

Maybe I'm mixing things up, but I think we try to produce detached heads
only on special requests. New users get confused by them, some don't
understand the (well crafted) message you get when you switch away from
them, and while you can recover them from HEAD's reflog, they are gone
with the next gc unless they remain checked out (or get referenced).

I think I've just convinced myself that we shouldn't DWIm to a detached
head, and rather tell the user how to produce one if she really intended
to: "git checkout --detach..." That one seems to be broken by multiple
workdir setup (in the sense of producing an unnecessary hint).

Michael
