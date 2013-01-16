From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-remote: distinguish between default and configured
 URLs
Date: Wed, 16 Jan 2013 13:45:36 +0100
Message-ID: <50F6A0F0.70800@drmicha.warpmail.net>
References: <7v4nii5tp2.fsf@alter.siamese.dyndns.org> <a5bf3511b3ecf4e9243d550d11ab977f95ecea30.1358331096.git.git@drmicha.warpmail.net> <20130116104222.GA15125@farnsworth.metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 16 13:46:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvSNm-0002P3-MK
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 13:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757359Ab3APMpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 07:45:39 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56851 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754354Ab3APMph (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 07:45:37 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 506E220532;
	Wed, 16 Jan 2013 07:45:37 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 16 Jan 2013 07:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=4iEiyUq+6T1OaApe+GZbaf
	d5bwY=; b=KG/q3XClKk/hw2IR7VFu6iZPiIJ0oJECTYg15W6KWfiQJAWGkLNiYy
	pVra7BegrQzMyDqGgHxPbappdTOdPf9zcL3qRoiqFwaIkYB15po+t6p7CyZppZVk
	3oCuonYKh2YKovvO6lrgh7eY3MQN0VpV19HVaKfgCkUEqobg46r6g=
X-Sasl-enc: SGQ75FXenEnGdaBET0JSwKqqJBErgHCDrsKz9gPHr03i 1358340336
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id D8EB948247A;
	Wed, 16 Jan 2013 07:45:35 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <20130116104222.GA15125@farnsworth.metanate.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213750>

John Keeping venit, vidit, dixit 16.01.2013 11:42:
> On Wed, Jan 16, 2013 at 11:14:48AM +0100, Michael J Gruber wrote:
>> The current output of "git remote -v" does not distinguish between
>> explicitly configured push URLs and those coming from fetch lines.
>>
>> Revise the output so so that URLs are distinguished by their labels:
>>
>> (fetch): fetch config used for fetching only
>> (fetch/push): fetch config used for fetching and pushing
>> (fetch fallback/push): fetch config used for pushing only
>> (fetch fallback): fetch config which is unused
>> (push): push config used for pushing
> 
> How does this interact with url.<base>.pushInsteadOf?
> 
> I have a global rule to convert git:// URLs to ssh:// for pushing:
> 
>     [url "git@example.com:"]
>         pushInsteadOf = git://example.com/
> 
> With only a URL configured for a remote (no pushURL), I get (with Git
> 1.8.1):
> 
>     origin git://example.com/repository.git (fetch)
>     origin git@example.com:repository.git (push)
> 
> From the original discussion in this thread, I think that if I did
> "git remote set-url --add --push <url>" it would replace my current push
> URL, and the change to "(fetch/push)" doesn't help in this case.
> 
> Should there be special handling for pushInsteadOf here?
> 
> 
> John

Thanks for pointing out this case.

The new code would still list this as two separate URLs because they
really are; whether they come from two config entries or from one being
subject to two different insteadof expansions is completely opaque to
builtin/remote.c, unless remote.c learns to stick that additional info
into struct remote somehow.

In short, the separate listing is correct, but in this case there's no
improvement in readability.

We could still say that (push)InsteadOf is a power feature and we want
to help the "normal" case, but it's a bit half-assed. In the end we
might even have to keep track of insteadof-expansions and display those
also (i.e. "expanded from...")?

Michael
