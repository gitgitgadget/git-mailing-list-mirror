From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] config: define and document exit codes
Date: Wed, 18 May 2011 20:49:10 +0200
Message-ID: <4DD414A6.2060807@drmicha.warpmail.net>
References: <20110517140725.GA17193@sigill.intra.peff.net> <6301052eb455e9088e50f78760e6ca1b9499564a.1305646709.git.git@drmicha.warpmail.net> <7vfwocc8z5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 20:49:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMlo8-0000c0-Pb
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 20:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933499Ab1ERStP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 14:49:15 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:60498 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933485Ab1ERStO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 14:49:14 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1D35E20C2B;
	Wed, 18 May 2011 14:49:14 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 18 May 2011 14:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=QaWgKrONTdr2dHIiJ7V2ac1VZPc=; b=jTz7Lfw7PtZcW8kFlebM0jt4b3yxd6Hsc7k+nXqSXbuPdf6I2ELIT4oVcx5oaRypBQyXBvHIqsUcXW4Xjqv0n5TlPJv76F3xD6HG/r1Lj3vGPEAnitjv+DaMrIW8uXCBIbt9TJ0PMq9jIg7ZHM1nYjn+2VTORGLW6JwX/p1WAY4=
X-Sasl-enc: EENlBbqN2+PlH6r5+uZCrHghQ5jLKJCp54aTI1pfmcqk 1305744553
Received: from localhost.localdomain (p54859040.dip0.t-ipconnect.de [84.133.144.64])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9AC344470EB;
	Wed, 18 May 2011 14:49:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7vfwocc8z5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173894>

Junio C Hamano venit, vidit, dixit 18.05.2011 17:41:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> +This command will fail (with exit code ret) if:
>> +
>> +. The config file is invalid (ret=3),
>> +. can not write to the config file (ret=4),
>> +. no section or name was provided (ret=2),
>> +. the section or key is invalid (ret=1),
>> +. you try to unset an option which does not exist (ret=5),
>> +. you try to unset/set an option for which multiple lines match (ret=5),
>> +. you try to use an invalid regexp (ret=6), or
>> +. you use '--global' option without $HOME being properly set (ret=128).
> 
> I wonder if you want to sort this in the order of return codes.

Well, if I wanted to... ;)

I don't mind resorting.

>> +/* git_config_parse_key() returns these negated: */
>> +#define CONFIG_INVALID_KEY 1
>> +#define CONFIG_NO_SECTION_OR_NAME 2
>> +/* git_config_set(), git_config_set_multivar() return the above or these: */
>> +#define CONFIG_NO_LOCK -1
>> +#define CONFIG_INVALID_FILE 3
>> +#define CONFIG_NO_WRITE 4
>> +#define CONFIG_NOTHING_SET 5
>> +#define CONFIG_INVALID_PATTERN 6
> 
> Symbols "CONFIG_FOO" looks too much like they are about the feature set
> chosen when compiling git, at least to me. But I do not think of a better
> naming scheme ("CONFIG_ERR_FOO" may be a slight improvement but not good
> enough improvement for the price we pay by having such long symbol names).

Well, we could do CONFIG_ENOLOCK and such. I didn't find a good sample
to follow. Thinking more about it, using CONFIG_ENOPARSE would be nice,
though I can't decide between 1, 2 or 3 for that...

> By the way, Are you still interested in "diff --stat-count" topic, or have
> you abandoned it?

Yes. I've reworked it a bit but there are three goals:

- count right
- determine the correct maximal file name length
- don't sacrifice efficiency

The middle one is problematic even before my patch (that first loop does
not drop all items that the latter one drops).

Maybe the third one is no real problem so that I could simply go through
the list twice.

Oh, and I've checked that fmt-merge-msg does this:

- output at most <count> items
- if there are more, output "..."

So, there's progress, though not visible yet.

Michael
