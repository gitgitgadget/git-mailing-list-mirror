From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Tue, 19 Apr 2016 16:07:35 -0700
Message-ID: <xmqqoa95xknc.fsf@gitster.mtv.corp.google.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
	<1461013950-12503-3-git-send-email-sbeller@google.com>
	<20160419050342.GA19439@sigill.intra.peff.net>
	<CAGZ79kbzg7SmJHFpxeJNKmLaEEw+irCxUedo45jGx8G8fmPtKg@mail.gmail.com>
	<20160419170624.GA3999@sigill.intra.peff.net>
	<CA+P7+xp60r6Tsv0_=Qy6Wo39MmXMbCba7g5goPQD-e8FNaaEjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 01:07:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asekC-0003mb-1Y
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbcDSXHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 19:07:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751336AbcDSXHj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:07:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AE41145ED;
	Tue, 19 Apr 2016 19:07:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6c0gKgYplBg23kf0jMKqpgibJ18=; b=ayk4WC
	QKzXGU6ZE4N9W+hjp9PWaTbS422tahlhncaodXgXiPdwtZ++uKAenM6JUimtOxH9
	sFxrTeUBDHnovNST2nL2TsrY6SG3DHk/8sVdZb2hM0bEtjSHMuJe04pSNyH7pXu0
	DjOMygV05tSTGvDeZoyTNxvhQLCuR0RNzw+lA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V4r/njFrCLoG0QEtXXt4yU7VlOrsDuZ6
	0EMFp8hY9PSdo+vzvX84n6exhBM6is+6ea8fcwZIFpZZAQ4GAIhQzi6nRBkrPA/U
	CSFYxcXEj2HNx4KplQbGfDeBUhLtcFrmnVU0anRUdLHHGAbJ2aeofUdW/UY3qzoH
	Hv49JHQ30kg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 12111145EC;
	Tue, 19 Apr 2016 19:07:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F6D3145EB;
	Tue, 19 Apr 2016 19:07:37 -0400 (EDT)
In-Reply-To: <CA+P7+xp60r6Tsv0_=Qy6Wo39MmXMbCba7g5goPQD-e8FNaaEjw@mail.gmail.com>
	(Jacob Keller's message of "Tue, 19 Apr 2016 16:02:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 81F38322-0683-11E6-8B0C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291949>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Tue, Apr 19, 2016 at 10:06 AM, Jeff King <peff@peff.net> wrote:
>> On Tue, Apr 19, 2016 at 08:17:38AM -0700, Stefan Beller wrote:
>>
>>> On Mon, Apr 18, 2016 at 10:03 PM, Jeff King <peff@peff.net> wrote:
>>>
>>> > I guess this will invalidate old patch-ids, but there's not much to be
>>> > done about that.
>>>
>>> What do you mean by that? (What consequences do you imagine?)
>>> I think diffs with any kind of heuristic can still be applied, no?
>>
>> I mean that if you save any old patch-ids from "git patch-id", they
>> won't match up when compared with new versions of git. We can probably
>> ignore it, though. This isn't the first time that patch-ids might have
>> changed, and I think the advice is already that one should not count on
>> them to be stable in the long term.
>>
>> -Peff
>
> Plus they'll be stable within a version of Git, it's only recorded
> patch ids that change, which hopefully isn't done very much if at all.
>
> Thanks,
> Jake

Some people, like those who did things like 30e12b92 (patch-id: make
it stable against hunk reordering, 2014-04-27), _may_ care.
