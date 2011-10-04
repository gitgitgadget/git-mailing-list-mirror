From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git ksshaskpass to play nice with https and kwallet
Date: Tue, 04 Oct 2011 13:27:57 +0200
Message-ID: <4E8AEDBD.4070404@drmicha.warpmail.net>
References: <4E8ADDCF.6090406@drmicha.warpmail.net> <20111004105008.GA11789@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 13:28:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB3AM-0006AK-Er
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 13:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756469Ab1JDL2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 07:28:01 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:55461 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755398Ab1JDL2A (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 07:28:00 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BA8192AEF1;
	Tue,  4 Oct 2011 07:27:59 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 04 Oct 2011 07:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=LMbngZOM3oh0JiYcev7DKU
	6D3f8=; b=HoxniFuZDU9CXgAhdprI9Vo0oIh53yhlYPQN8JLzf5Sx4IfauSZ0Je
	vJs40tiWAPzXGXkggTUvZ+0dV6RVy5mQJmChRk2kTqfqhRvo91AecbzN1nOr2yMQ
	bsjJO7ukM7/9hNgkXxWRVhZsi+iV2ciB1ZQBbp7e6go6KOoUkCNog=
X-Sasl-enc: P1IGKQ6Ks8oXNA1Yl38ykHDDIlH1O1nWWkUKq4MbnLue 1317727679
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 412FA820FA1;
	Tue,  4 Oct 2011 07:27:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <20111004105008.GA11789@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182762>

Jeff King venit, vidit, dixit 04.10.2011 12:50:
> On Tue, Oct 04, 2011 at 12:19:59PM +0200, Michael J Gruber wrote:
> 
>> But Git calls the askpass helper with a command line like
>> /usr/bin/ksshaskpass Username for 'bitbucket.org':
>> and once again with
>> /usr/bin/ksshaskpass Password for 'bitbucket.org':
>> So far so good.
>>
>> But when asked to store the credentials in the KDE wallet, ksshaskpass
>> tries (too) hard to guess a good key from that line. And for both
>> invocations, it comes up with the same key (the URL), so that when the
>> password info is needed, the username info from the wallet is returned.
>> Authentication fails.
>> Far from good.
> 
> Neat. I didn't know ksshaskpass would do that. I wondered for a minute
> if all of the credential helper stuff could have gone through the
> askpass interface. But I don't think so.

Don't worry ;)

> One problem is that the askpass interface only lets us ask for one thing
> at a time. So even with your clever hack, it will end up storing two
> separate keys: Username@host and Password@host. But it has no idea
> they're connected. So if you store "user1 / pass1", then try to push to
> "user2@host", we would silently use the password for user1.
> 
> On top of that, there isn't much contextual information. I guess they
> assumed the guessing would be used for "ssh". But it means that a stored
> ssh password could potentially be used for git, and vice versa. I guess
> you could get around that by making the host field longer and more
> descriptive (i.e., a full url).

I think it's really meant for ssh keys only, where the keyid identifies
the key uniquely.

Still, ksshaskpass's trying to guess a unique key from the prompt text
seems quite hackish to me. But many people will have a Git without
credential-helpers, and a KDE default setup, so hope my post helps
someone besides myself.

Note that git-credentials-askpass would have a fair chance of doing
better: credential_askpass() knows the username and could pass it to
credential_ask_one(), e.g. by amending the description field, or setting
the first field to "Password for user %(user)". Do you think that would
be worth deviating from the default behavior (i.e. compared to no helper)?

Cheers,
Michael
