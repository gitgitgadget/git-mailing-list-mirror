From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule helper list: Respect correct path prefix
Date: Wed, 24 Feb 2016 13:38:04 -0800
Message-ID: <xmqqpovlssar.fsf@gitster.mtv.corp.google.com>
References: <1456348502-4529-1-git-send-email-sbeller@google.com>
	<xmqqy4a9st2v.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbbKnips12CU6KZX39rAZ_O-pYy20nsSGCCf+1w5LzgxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Caleb Jorden <cjorden@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 22:38:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYh8U-0003Te-GN
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 22:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757553AbcBXViJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 16:38:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755100AbcBXViH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 16:38:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8DE946F8A;
	Wed, 24 Feb 2016 16:38:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sq784MGyf5/rNccu8O+xZXVWhMI=; b=PcLL8W
	RmHWXQgihKomuRgeeNk7NGDA0nA6XjJYpWb/huJ4JaJ1+0/t92QX1aXZ5URu/osl
	boR9XMkzezb8A4iywEXNjiKscXXAZRwx7qJv7fOFiiBZUGdk0Q6rh/z7BbBCeYeo
	YGbfaWSu4IQ92QOfPYSzMRwqJLqXxH5OSj2JA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bAxjuFcmVZbCEoQF9+vMbPq8iea+qlRo
	OB0JREUHyxy9hfDyk9Ylm5KRGLTg0SMHn9Amzt1K0qyPgAr5DlZAQn+JSIrS44nx
	yWo4AQJuZl2I9BWu1tqkVPMTIXuu7XHGxlVWvq79yJ2pJyi/PdiVJIDBRqYEFAdx
	9g3IxwHsGaA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF4AE46F89;
	Wed, 24 Feb 2016 16:38:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5275646F85;
	Wed, 24 Feb 2016 16:38:05 -0500 (EST)
In-Reply-To: <CAGZ79kbbKnips12CU6KZX39rAZ_O-pYy20nsSGCCf+1w5LzgxA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 24 Feb 2016 13:32:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E35AD4D2-DB3E-11E5-AB02-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287234>

Stefan Beller <sbeller@google.com> writes:

> On Wed, Feb 24, 2016 at 1:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> This is a regression introduced by 74703a1e4d (submodule: rewrite
>>> `module_list` shell function in C, 2015-09-02).
>>>
>>> Add a test to ensure we list the right submodule when giving a specific
>>> path spec.
>>>
>>> Reported-By: Caleb Jorden <cjorden@gmail.com>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>>
>>>  I developed this on top of current origin/master, though I can backport it
>>>  to 2.7 as well if desired.
>>>
>>>  I do not remember the cause why we started to ignore a common prefix.
>>
>> The code you are removing with this patch is probably an
>> optimization you copied from builtin/ls-files.c.  When the
>> optimization is used, the original also limits the list of paths to
>> those that match the prefix by calling prune_cache(), but perhaps
>> you didn't have a corresponding code in your copy?
>
> I think that is a good explanation. So do we want to add the pruning
> or use this patch to fixup the regression and wait until someone complains
> about the speed penalty due to no optimization?

As I do not know offhand if the optimization, especially the pruning
part, applies to the context of this code the same way ls-files does
things (which treats the index read into core as a throw-away data),
we shouldn't even attempt to salvage the faulty half-optimization
until we understand what it involves to make it work.  So "disable
broken optimization and make simple way work correctly" is the good
first step, especially for a fix that is meant to go to 2.7.x
series.

We must first be sure that removing the faulty half-optimization is
the only thing we need to fix this breakage, though ;-)

Thanks.
