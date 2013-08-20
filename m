From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-config and large integers
Date: Tue, 20 Aug 2013 16:41:30 -0700
Message-ID: <xmqqhaekudzp.fsf@gitster.dls.corp.google.com>
References: <20130820223953.GA3429@sigill.intra.peff.net>
	<xmqqli3wufmc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 21 01:41:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBvYR-0005hX-Oq
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 01:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab3HTXlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 19:41:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53127 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379Ab3HTXlf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 19:41:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50AF33A47A;
	Tue, 20 Aug 2013 23:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Auuk7ZszBjiPDZkN16h+pXvCeuE=; b=hQyImQ
	YR1/DVfd/+R+4vanxKImg3LrommjbLF7OaIcyUThFgrbUMFmw1fq7eISCM6XufW8
	ITqEAyPqN/c/jwwIIc4b/v0I0kDsLvLV/HUhtYuzSc0vaH/Eyp4Gjkp31Sh5Jxc6
	NCABHFPVNlX4yBQsfhql29aVonchnNmhDhCkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FyZtAexGOynmEJTPMdCjsgn2e+vxGep7
	QXiTGf14dIyyiDoqauTVJHsSYtDANeB0d9fxzmiV5h71+ty7Y4DKrvw5xV1RmZD/
	mMsQHaMmoeraNOvm7OyofYqxTRClXN2OpLAxooxOQGsxFGF7TZ34RawXyHiePcNd
	ymCdee2zryk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 433EA3A478;
	Tue, 20 Aug 2013 23:41:34 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CBE73A476;
	Tue, 20 Aug 2013 23:41:33 +0000 (UTC)
In-Reply-To: <xmqqli3wufmc.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 20 Aug 2013 16:06:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0BC151EC-09F2-11E3-8336-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232669>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I was playing with a hook for file size limits that wanted to store the
>> limit in git-config. It turns out we don't do a very good job of big
>> integers:
>>
>>   $ git config foo.size 2g
>>   $ git config --int foo.size
>>   -2147483648
>>
>> Oops. After this series, we properly notice the error:
>>
>>   $ git config --int foo.size
>>   fatal: bad config value for 'foo.size' in .git/config
>>
>> and even better, provide a way to access large values:
>>
>>   $ git config --ulong foo.size
>>   2147483648
>
> I may be missing something, but why do we even need a new option for
> the command that is known to always produce textual output?
>
> As you said "Oops", the first example that shows a string of digits
> prefixed by a minus sign for input "2g" is buggy, and I think it is
> perfectly reasonable to fix it to show a stringified representation
> of 2*1024*1024*1024 when asked for "--int".
>
> What am I missing???

If this applied on the writing side, I would understand it very
much, i.e.

	$ git config --int32 foo.size 2g
        fatal: "2g" is too large to be read as "int32".

and as a complement it may make sense as a warning mechanism to also
error out when existing value does not fit on the "platform" int, so
your 

>>   $ git config --int foo.size
>>   fatal: bad config value for 'foo.size' in .git/config

might make sense (even though I'd suggest being more explicit than
"bad value" in this case---"the value specified will not fit when
used in a variable of type int on this platform").  When .git/config
is shared on two different boxes (think: NFS), the size of "int"
might be different between them, so the logic to produce such a
warning may have to explicitly check against int32_t, not platform
int and say "will not fit in 'int' on some machines".

I dunno.


	
