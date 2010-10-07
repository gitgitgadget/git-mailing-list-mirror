From: Junio C Hamano <gitster@pobox.com>
Subject: Re: format-patch on permission change gives empty patch
Date: Wed, 06 Oct 2010 21:40:05 -0700
Message-ID: <7vocb6y5sq.fsf@alter.siamese.dyndns.org>
References: <20101006.173714.245380201.davem@davemloft.net>
 <20101006.174008.70175671.davem@davemloft.net>
 <7vtykyy70w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Miller <davem@davemloft.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 06:40:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3iHX-0006WB-6d
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 06:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073Ab0JGEkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 00:40:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab0JGEkN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 00:40:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39628DC947;
	Thu,  7 Oct 2010 00:40:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AFCo6G0bB5sAigIw47GzSP7o/wU=; b=VkY/mi
	UNcxzskjAf28CFJNGXKORJg+/ThFIQ+kgQr0rn+WzKZ+Vd1zchwdcqtwprNwXiHq
	EODTGQgB15tAgu0cb/GzcbHGc4Fkrq/y59Hm18vMTxlg/GxuyUsOc189H/OK1H8W
	ux/EHcS1qOplLbwaMeS01hJU40Di6V95YnUcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PMG6VBUdwoODzJEaSmSxWdMPOPV1Gdnx
	WtaXKZGxyJP0b3ZcyECAZso1csiu82jXRCO5hp+tiSuxb/VKO4xSdieOineL5Jqc
	UNlAn9ZdQp8XGC6DR4ZWxmhieMhvePqSDVjmvUaZvwdYlvwXCaL7I04ZVWTMnfcj
	ElvY3UxWrA8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CDC8DC946;
	Thu,  7 Oct 2010 00:40:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 127B8DC945; Thu,  7 Oct
 2010 00:40:07 -0400 (EDT)
In-Reply-To: <7vtykyy70w.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 06 Oct 2010 21\:13\:35 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F817CC1C-D1CC-11DF-A70C-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158366>

Junio C Hamano <gitster@pobox.com> writes:

> David Miller <davem@davemloft.net> writes:
>
>> From: David Miller <davem@davemloft.net>
>> Date: Wed, 06 Oct 2010 17:37:14 -0700 (PDT)
>>
>>> 
>>> When I ask git to format-patch a commit that is just a file
>>> permission change, it ends up generating an empty file, not
>>> even the commit message is included.
>>
>> Ok it turns out that the commit in question was a NOP since the file
>> permissions didn't change.
>>
>> But even if the patch is truly empty, format-patch should still give
>> me the commit message shouldn't it?
>
> Probably; we have strongly encouraged people not to commit no-op, so I
> guess nobody stumbled upon this corner case.
>
> Perhaps something like this?

Actually, I have a feeling that this is not merely a corner case we didn't
care about.

A half-good news is that format-patch already takes --always command line
option to generate a message out of an empty commit, but because it cannot
be applied with "am", it is rather pointless.

BUT.

The weatherbaloon patch is probably a bad idea.  "git rebase", especially
when rebasing a side branch imported from some foreign SCM, would rather
badly break with this patch, because its "format-patch | am" pipeline
depends on format-patch to skip a no-op commit.  Otherwise, "am" will
complain about a patchless message.  So in a sense, the current behaviour
is internally consistent and deliberately so.

I have a mixed feeling about where to go next.

 (1) Treat "rebase" as a way to reproduce a reasonable history; the
     current behaviour to drop empty commits is consistent with this view,
     as a history with an empty commit is _not_ entirely reasonable.

 (2) Treat "rebase" as a way to reproduce history faithfully, even an
     unreasonable one.  We could teach "--allow-empty" to "am", and
     rewrite the pipeline as "format-patch --always | am --allow-empty" to
     implement it.

I think I would eventually end up doing the latter, but not tonight.
