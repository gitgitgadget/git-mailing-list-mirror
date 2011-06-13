From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] zlib: zlib can only process 4GB at a time
Date: Mon, 13 Jun 2011 04:56:56 -0700
Message-ID: <7vsjreq707.fsf@alter.siamese.dyndns.org>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com>
 <1307736948-16956-7-git-send-email-gitster@pobox.com>
 <BANLkTikmLDZj2qdkmF-kBUkB33o9EjtBpg@mail.gmail.com>
 <7v4o3uspiy.fsf@alter.siamese.dyndns.org>
 <BANLkTi=sT_LxRaJSM3Cj-QkSwqGan29K7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 13 13:57:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW5ld-0001fE-8C
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 13:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452Ab1FML5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 07:57:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab1FML5E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 07:57:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B53D24ACC;
	Mon, 13 Jun 2011 07:59:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ofJsfq1dgj36qi8+MatNLlBNH+o=; b=ggwszJ
	rqQnLDV8OyqWvuUB7lQPg8upx9s4gPM4MQrkGTIKwm06CRRvPOrwJXzsisBCj5Ji
	MLZ+4kAt0NVTzKpvZsSEEOcG78fbGyw9EOKFmuZ1lCOId6TbzT//KWiXPH38Mg+T
	2gYfe0R/5abCQS7o+p20HR2Orz5tlZpEEeUf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tGIDTmCq9BW386fyOjAsYXeM0XTWKMqy
	jVeoJ54AMI5sfNbUpvSUkOC2FGyEIrPFQt+C4nWJ2ej6LQebh5mvLiNAhRb2NUtn
	UJZHEX4vH/jUOwkJaRE5q+l4omNl5T5EVHBDTstuCYJrSecGRa4ZVtS5glmBV7C+
	UE/w2GB7XlU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 91DDC4ACB;
	Mon, 13 Jun 2011 07:59:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 98BEA4ACA; Mon, 13 Jun 2011
 07:59:08 -0400 (EDT)
In-Reply-To: <BANLkTi=sT_LxRaJSM3Cj-QkSwqGan29K7A@mail.gmail.com> (Erik
 Faye-Lund's message of "Mon, 13 Jun 2011 13:17:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D1A37EA-95B4-11E0-BF7F-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175699>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Sun, Jun 12, 2011 at 11:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>>> On Fri, Jun 10, 2011 at 10:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> The size of objects we read from the repository and data we try to put
>>>> into the repository are represented in "unsigned long", so that on larger
>>>> architectures we can handle objects that weigh more than 4GB.
>>>
>>> shouldn't this be "size_t" instead of "unsigned long"?
>>
>> No, this must be unsigned long as that is the internal type we use.

There are two unrelated issues you have to address if your "unsigned long"
is 32-bit and you want to handle more than 4GB data in git.

When git holds repository data in core, it always has represented it as a
pair of <pointer to the beginning of memory block that holds data, length>
where the length is "unsigned long" from day one.  See read_sha1_file() in
read-cache.c that appears in e83c516 (Initial revision of "git", the
information manager from hell, 2005-04-07). This limits you to 4GB if your
"unsigned long" is 32-bit.

The right type to use in order to enable more platforms to go beyond 4GB
might be to use uintmax_t, but the series you are commenting on however is
not about changing that.

We have another problem stemming from the way in which we incorrectly used
zlib API even on a platform where "unsigned long" is capable to express
size beyond 4GB. In many places, we set up the state object used by zlib
API (i.e. z_stream) to point at the "pointer to the beginning of memory
block" with its "next_in" field, and "length" with its "avail_in" field,
pass that object around in the callchain, and expect that by making
repeated call to zlib, "next_in" would eventually progress to the end of
the data we have in core while "avail_in" would fall to zero when all data
is processed. The "avail_in" field zlib API gives us however is uInt which
is 32-bit, so this expectation is incorrect. If you have 4G+32 bytes of
data, for example, we only feed 32 bytes and stop, barfing on "corrupt"
data.

That is the issue this series is about. The approach of the series takes
is to wrap zlib's state object with our own, that has our own "avail_in"
field (by the way, the same issue exists in "next_out/avail_out" on the
output side) that uses the same type of "length" used in other parts of
our system.

The type of the "avail_in" and "avail_out" fields in the wrapper needs to
be updated to match that type when you address the "other" issue to update
all the internal "length" from "unsigned long" to "uintmax_t", but not
before. And updating the rest of the system to "uintmax_t" is not part of
the scope of this series.
