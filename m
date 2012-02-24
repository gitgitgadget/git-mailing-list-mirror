From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Fri, 24 Feb 2012 12:03:39 -0800
Message-ID: <7vsji0xalg.fsf@alter.siamese.dyndns.org>
References: <4F46036F.3040406@gmail.com>
 <20120223102426.GB2912@sigill.intra.peff.net> <4F462E61.4020203@gmail.com>
 <m34nuhelnf.fsf@localhost.localdomain> <4F4643BB.8090001@gmail.com>
 <20120223193451.GB30132@sigill.intra.peff.net>
 <7vy5rt2u0c.fsf@alter.siamese.dyndns.org> <4F475689.4040203@gmail.com>
 <20120224095253.GC11846@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nikolaj Shurkaev <snnicky@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 24 21:03:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S11Mq-0000cE-JR
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757618Ab2BXUDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 15:03:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755999Ab2BXUDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:03:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 080336153;
	Fri, 24 Feb 2012 15:03:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=yTTJgIECWOrWxr0H9vqLctL1qls=; b=VbLev2RCMr67DAaP2kRm
	/cq2zolYOlAdpD61WHrTnO6nrQRQ0/ehwpjefw+BvJhxDZUaTvjRE9mLMWB05Tiz
	C6tc7YytFTlRdWpBRvj6c/eDS1W3BRgs9pUv0MLsLFNIdeVQAGnk8NTNPUTwReM3
	3ab+b2UhIkzl9R5fcBF5Udc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=miFstEzQITRO40kceX/t7+4lsodsOxpC+OFau87Uvh5uW1
	wgu76joo29XvP1QGCczHE2+3O5bVQV1kqVfDgfKozu6xd0vqqIfwlukZizxT+H7S
	ZIFhlkkrV2Hn1fiUD0x1ec7dzo9AdCPVFf8WWjoIkcVjcPlEBNLbq6z2KvPrQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2CEB6152;
	Fri, 24 Feb 2012 15:03:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5670B6150; Fri, 24 Feb 2012
 15:03:40 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A53DDCFE-5F22-11E1-8198-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191459>

Jeff King <peff@peff.net> writes:

>> DESCRIPTION
>> -----------
>> @@ -219,6 +220,12 @@ you can use `--suffix=-patch` to get
>> `0001-description-of-my-change-patch`.
>> range are always formatted as creation patches, independently
>> of this flag.
>> 
>> +[\--] <path>...::
>> + Put in patches only those modifications that affect specified files
>> + and folders. It's important to understand that log message of the
>> + commit may become inappropriate because some parts of patch may be
>> + cut off.
>> +
>
> I think that text looks OK. But to my mind, it is not that format-patch
> accepts a path parameter, but rather that it takes arbitrary log-like
> arguments.

The above text is not telling the entire truth, though.

When the command is run with the "--full-diff" option, seleted commits
will be shown in full.  This is useful for example when you want to pick
commits that add a new "frotz" driver, which obviously needs to include
"drivers/frotz/" subdirectory, without missing necessary changes to the
Makefiles in the higher level (e.g. "drivers/Makefile"), e.g.

	git format-patch --full-diff v1.0..v1.1 -- drivers/frotz

In such a case, "some parts may be cut off" does not make the log message
inappropriate.

On the other hand, people often do not use the resulting history of taking
partial patches (i.e. without --full-diff) and feeding them to "am" as-is.
The operation is used merely to give them a starting point for working on
(possibly) an unrelated topic, and the history is further tweaked with
"rebase -i" or even "commit --amend".  It is not "inappropriate" that the
log says more than what the patch does in such a use case.  What the log
says is irrelevant.

> I don't know how well tested every option is, though, so maybe it's not
> a good idea to encourage the use of random options.

I obviously agree and also suspect that the real question is not "how well
tested" but "if it makes sense".

I am reasonably sure that over time the options and features that make
sense in the context of producing something that is useful with "am" have
been already made to work well, but I also am fairly certain that the
coverage of the code to explicitly reject options that do not make sense
in that context would be spotty at best.  For example, did we carefully
design and implement how format-patch should behave when "-z" is given,
or does the code happen to do whatever it happens to do?  If the latter,
did we consider rejecting "-z" when given from the command line and
implement such safety?
