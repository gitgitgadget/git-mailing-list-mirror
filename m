From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] git-remote: distinguish between default and configured
 URLs
Date: Wed, 16 Jan 2013 13:04:25 +0000
Message-ID: <20130116130425.GB15125@farnsworth.metanate.com>
References: <7v4nii5tp2.fsf@alter.siamese.dyndns.org>
 <a5bf3511b3ecf4e9243d550d11ab977f95ecea30.1358331096.git.git@drmicha.warpmail.net>
 <20130116104222.GA15125@farnsworth.metanate.com>
 <50F6A0F0.70800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 14:04:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvSfh-0005BV-E4
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 14:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027Ab3APNE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 08:04:29 -0500
Received: from dougal.metanate.com ([90.155.101.14]:55421 "EHLO metanate.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753381Ab3APNE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 08:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com; s=stronger;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=pHHNnPhCH7z7WUR+12kqES7PxwAwOyZgRmMsVGzBXKg=;
	b=VACJxq07UiX1+8ew1Hivp4mj1Nu4wnpAOuxNAyK72pXo17MGQharv8XnUmXQIbxcsYUjtTAVoaRzg0UzvvDvUflRfDMe4sLv4AhLr5E0X2TZ4ZXdtHlu0MbZZek5vzlbH4CfwBB/XTdk7eKJeyD8viCtGZ2Qze0G9A7wcm/73qJhwCXiuHKAeTS7glwBYelwqT3ohYbOhzzbz+ttW8azFM9/HJ9ohpz+FIxhYCCUf4VDomtiKpm1VHnTwpARJP63J+iGQguxlpb1TzeQcNALBpr1Qro8+sNO2w/vVxn9G4YIMTh0LWk5PuShWd1mifWblu5LCMVg4oDC7oJdRYRqPg==;
Received: from brian.metanate.com ([192.168.88.1] helo=farnsworth.metanate.com)
	by shrek.metanate.com with esmtps (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <john@keeping.me.uk>)
	id 1TvSfJ-0002Vs-Hm; Wed, 16 Jan 2013 13:04:25 +0000
Content-Disposition: inline
In-Reply-To: <50F6A0F0.70800@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213751>

On Wed, Jan 16, 2013 at 01:45:36PM +0100, Michael J Gruber wrote:
> John Keeping venit, vidit, dixit 16.01.2013 11:42:
>> On Wed, Jan 16, 2013 at 11:14:48AM +0100, Michael J Gruber wrote:
>>> The current output of "git remote -v" does not distinguish between
>>> explicitly configured push URLs and those coming from fetch lines.
>>>
>>> Revise the output so so that URLs are distinguished by their labels:
>>>
>>> (fetch): fetch config used for fetching only
>>> (fetch/push): fetch config used for fetching and pushing
>>> (fetch fallback/push): fetch config used for pushing only
>>> (fetch fallback): fetch config which is unused
>>> (push): push config used for pushing
>> 
>> How does this interact with url.<base>.pushInsteadOf?
>> 
>> I have a global rule to convert git:// URLs to ssh:// for pushing:
>> 
>>     [url "git@example.com:"]
>>         pushInsteadOf = git://example.com/
>> 
>> With only a URL configured for a remote (no pushURL), I get (with Git
>> 1.8.1):
>> 
>>     origin git://example.com/repository.git (fetch)
>>     origin git@example.com:repository.git (push)
>> 
>> From the original discussion in this thread, I think that if I did
>> "git remote set-url --add --push <url>" it would replace my current push
>> URL, and the change to "(fetch/push)" doesn't help in this case.
>> 
>> Should there be special handling for pushInsteadOf here?
> 
> Thanks for pointing out this case.
> 
> The new code would still list this as two separate URLs because they
> really are; whether they come from two config entries or from one being
> subject to two different insteadof expansions is completely opaque to
> builtin/remote.c, unless remote.c learns to stick that additional info
> into struct remote somehow.

OK.  I like the new format, I was just wondering if it was a simple
enhancement to indicate a pushInsteadOf URL specially as well.

> In short, the separate listing is correct, but in this case there's no
> improvement in readability.
> 
> We could still say that (push)InsteadOf is a power feature and we want
> to help the "normal" case, but it's a bit half-assed. In the end we
> might even have to keep track of insteadof-expansions and display those
> also (i.e. "expanded from...")?

Given that it's not a trivial enhancement, I'd accept the argument that
someone who has configured pushInsteadOf can be expected to understand
the underlying git-config semantics of "git remote set-url".


John
