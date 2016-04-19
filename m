From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 2/2] git-p4: fix Git LFS pointer parsing
Date: Tue, 19 Apr 2016 14:04:01 -0700
Message-ID: <xmqqh9exz4xq.fsf@gitster.mtv.corp.google.com>
References: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com>
	<1461096530-82448-3-git-send-email-larsxschneider@gmail.com>
	<xmqqtwixz6i4.fsf@gitster.mtv.corp.google.com>
	<A6FD8E93-63E8-49EE-838D-2AF3FD3910D4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org, sschuberth@gmail.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 23:04:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ascof-0005ii-Br
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 23:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954AbcDSVEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 17:04:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932937AbcDSVEF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 17:04:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 162E6144FE;
	Tue, 19 Apr 2016 17:04:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sthKzG8Hak2mN+VeqWjiDA0fV4Y=; b=iX07JT
	aFCfY5HA9zyTf3vYLwbosBCcbyJQqv+71iG5dTv0g1HDuFNkhS/18o7NSfgTd4SY
	CtzoYoZiHkZ9sW2SIwlH6OYQffQe3RSkz4tQ+p2W/mcLkHLu9x0ItXm+SjJbVhZL
	waj1qIhfHQpF5FY/skHRlF9h/kOma2teeVwAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vAnquAJWy5wlSYvMPgs/xs88pZ95+Muz
	FToqn3C2ifLsmc7I1ol0EShyqkX9cRncsfB5pdeRVGzCEni3IlvdpFZ+VemSHnbM
	fCtuCLW57AZN/MFKUwVfk9ps7LIVEHQ9FWrXMNnWgs4YX3bCsey99UBqQeb2BS/t
	o6/lhAR9C3Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 08EB8144FD;
	Tue, 19 Apr 2016 17:04:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 78AD6144FA;
	Tue, 19 Apr 2016 17:04:02 -0400 (EDT)
In-Reply-To: <A6FD8E93-63E8-49EE-838D-2AF3FD3910D4@gmail.com> (Lars
	Schneider's message of "Tue, 19 Apr 2016 22:54:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3E71DD6C-0672-11E6-939A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291926>

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 19 Apr 2016, at 22:30, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> larsxschneider@gmail.com writes:
>> 
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>> 
>>> Git LFS 1.2.0 removed a line from the output of the 'git lfs pointer'
>>> command [1] which broke the parsing of this output. Adjust the parser
>>> to the new output and add minimum Git LFS version to the docs.
>> 
>> Hmph, adjust to operate with both, or drop the support for the old
>> one?

> I dropped the support for the older version to keep the code as
> simple as possible (plus it would be cumbersome to test with an
> outdated Git LFS version). Since it is probably a niche feature I
> thought that might be acceptable.

It is bad enough that clients need to be adjusted at all in the
first place, but I would have found it very troubling if the
problematic change to LFS thing were made in such a way that it
makes backward compatible adjustment on the client code impossible.

But it seems that you could read their output and strip a line that
begins with a known substring to make it compatible with both?

"git P4" itself may be niche and using it with the LFS thing may
even be more so, but in Git land, traditionally we take the backward
compatibility seriously.  If it is not too much work, I'd prefer to
see this done the right way.

Thanks.
