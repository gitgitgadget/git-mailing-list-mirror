From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Fri, 02 Sep 2011 09:42:49 +0200
Message-ID: <4E6088F9.5070102@drmicha.warpmail.net>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org> <20110902000039.GB9339@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 09:42:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzOOv-0008K4-3n
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 09:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab1IBHmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 03:42:52 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:40762 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752937Ab1IBHmv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2011 03:42:51 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 39A5220BDE;
	Fri,  2 Sep 2011 03:42:51 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 02 Sep 2011 03:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=k0QY956KuJS8ndPijGU5ZM
	S3Jsw=; b=K3IBB2QA/R6nbHcsMsk248TZRa9E2WyriH697kmy50Ku53WGd0xVXI
	+oEwGW40owxPUmXt78Loefvvl1r1UCQzwt2Na5RsF556SJxIOvuJxaxbm53yr6JD
	xPI7GXHrPTSt7ADK25kOePUBV5wK3qJ7fuQ1asWNjg1yfvwIPG2nI=
X-Sasl-enc: 2xXDxP447Y8NH54BzmslZ8a58BhdoXGS+dzj1wnQTjmU 1314949370
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8977CA81C85;
	Fri,  2 Sep 2011 03:42:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <20110902000039.GB9339@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180602>

Jeff King venit, vidit, dixit 02.09.2011 02:00:
> On Thu, Sep 01, 2011 at 11:25:31AM -0700, Junio C Hamano wrote:
> 
>> Suggested reading:
>>
>>   http://git-blame.blogspot.com/2011/08/how-to-inject-malicious-commit-to-git.html
>>
>> I am wondering if we are better off applying something along the lines of
>> this patch, so that with the default configuration, users can notice if
>> their upstream unexpectedly rewound their branches.
> 
> Hmm. This feels like it's subtly changing the meaning of
> refs/remotes/$remote/*.
> 
> Right now, I think of it as a local cache for whatever the remote side
> has. In other words, a way of separating the network-fetching parts of
> the workflow from the local parts. And in that sense, it is perfectly
> reasonable to overwrite with what the other side has, whether they
> rewind or not, because we are just representing what they have. And
> since we keep a reflog, it's not as if the previous state is lost to us
> locally.
> 
> But with this change, we are making a policy judgement about what to
> fetch. And as you noticed, it means that users need to start telling git
> about their policy (e.g., mentioning in the refspecs that pu can rewind)
> in order to keep fetch working.
> 
> So I consider that a downside, because it's extra work for the user[1].
> What are the upsides?
> 
> Is this about preventing workflow-related mistakes where people
> accidentally merge in rebased commits, creating annoying shadow
> histories?
> 
> Is it about preventing malicious rewinds from infecting downstream
> repositories?
> 
> If the former, then I suspect we need to give more guidance to the user
> than saying "reject, non-fast-forward". What then? Should they "fetch
> -f"?  Or "pull --rebase" (actually, how do they even fetch the branch
> now for such a pull --rebase)? Or talk out-of-band to the repo owner?
> 
> If the latter, then I think we should be specific about the attack
> scenarios, and what happens with and without this config. And if it's a
> security precaution, what cases doesn't it cover (e.g., initial clone is
> still vulnerable, as is a one-off pull. As are are malicious insertion
> attacks that don't involve rewinding).
> 
> And then we can weigh the upsides and the downsides.
> 
> -Peff
> 
> [1] What I really don't like is that cloning git.git is no longer:
> 
>       git clone git://git.kernel.org/pub/scm/git/git.git
> 
>     which is a minimal as it can be, but becomes:
> 
>       git clone git://git.kernel.org/pub/scm/git/git.git
>       cd git
>       git config --add remote.origin.fetch +refs/heads/pu:refs/remotes/origin/pu
> 
>     It's not that my fingers are too tired to do all that typing, but
>     rather that the first set of instructions is very easy to explain,
>     and the second one is full of magic and head-scratching about why
>     git isn't handling this magic itself.
> 
>     It would be considerably nicer if the server had some way of saying
>     "I expect this branch to be rewound". Which has been discussed off
>     and on over the years, as I recall.

Hmm, that sounds like the often requested feature to have part of the
config distributed by "clone" as well, possibly after displaying it and
getting user confirmation.

Michael
