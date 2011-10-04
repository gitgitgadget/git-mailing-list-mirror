From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git ksshaskpass to play nice with https and kwallet
Date: Tue, 04 Oct 2011 14:12:02 +0200
Message-ID: <4E8AF812.5090906@drmicha.warpmail.net>
References: <4E8ADDCF.6090406@drmicha.warpmail.net> <20111004105008.GA11789@sigill.intra.peff.net> <4E8AEDBD.4070404@drmicha.warpmail.net> <20111004113713.GA19171@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 14:12:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB3r4-00042t-2t
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 14:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108Ab1JDMMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 08:12:07 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53985 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932078Ab1JDMMG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 08:12:06 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D990324F91;
	Tue,  4 Oct 2011 08:12:04 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 04 Oct 2011 08:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=XotGH6hqInYauZYmEI4MAh
	VBi6o=; b=qMBJPW21cCGnP8nvS2GNx9J7wZhOzyHAhLHx0CvqGl2MKzMUt306ef
	6o73ARC7l6g/VSTJH+3bgMkAxiYFIyPB5WkHXDPdQC0JGpeafZe0XCtakkCdirUW
	6ePxsPlq075vGG+uz/T6x5TxWFu3R3HSpoFAJshb9XbKcMkQ8M1jM=
X-Sasl-enc: uH4jnck3on64Xh9A1usFukOgdXuzUc845wCPdmYgM3sE 1317730324
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 07CC3821177;
	Tue,  4 Oct 2011 08:12:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <20111004113713.GA19171@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182765>

Jeff King venit, vidit, dixit 04.10.2011 13:37:
> On Tue, Oct 04, 2011 at 01:27:57PM +0200, Michael J Gruber wrote:
> 
>> Still, ksshaskpass's trying to guess a unique key from the prompt text
>> seems quite hackish to me. But many people will have a Git without
>> credential-helpers, and a KDE default setup, so hope my post helps
>> someone besides myself.
> 
> Hmm. I don't think that pre-credential-helper git actually puts the
> hostname in the prompt, though. It just says "Username:". So your trick
> wouldn't work then, would it?
> 
>> Note that git-credentials-askpass would have a fair chance of doing
>> better: credential_askpass() knows the username and could pass it to
>> credential_ask_one(), e.g. by amending the description field, or setting
>> the first field to "Password for user %(user)". Do you think that would
>> be worth deviating from the default behavior (i.e. compared to no helper)?
> 
> I think that git should do that by default. v1.7.7 (and earlier) does:
> 
>   $ git push https://example.com/foo.git
>   Username:
>   Password:
> 
> With my patches in 'next', it does:
> 
>   $ git push https://example.com/foo.git
>   Username for 'example.com':
>   Password for 'example.com':
>

Sheesh. I'm too used to using next(+) to even think of that! You're
completely right: My trick only works with next's additions.

> But it would probably be better to say:
> 
>   $ git push https://example.com/foo.git
>   Username for 'example.com':
>   Password for 'user@example.com':

Yes, exactly. credential_askpass() knows what it needs for that.

> The latter is especially useful if you have put a username in your
> ~/.gitconfig, in which case you get:

I'm actually wondering why git can't infer the user from

https://user@host.com

with last week's next, at least.
> 
>   $ git push https://example.com/foo.git
>   Password for 'user@example.com':
> 
> which is a nice reminder. And it would happen to work with your askpass
> magic (I also wonder if it should mention the protocol and the repo, but
> most of the time that isn't relevant, and it does make the prompt harder
> to read).

With the above, I can probably do without any magic: 'example.com' would
be the wallet key for the username (if I let the wallet store it) and
'user@example.com' the key for the password, whether the username comes
from the wallet or from the config. (Again, why not from the URL?)

Michael
