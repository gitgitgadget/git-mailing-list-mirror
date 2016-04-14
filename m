From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and related stuff
Date: Thu, 14 Apr 2016 11:12:43 -0700
Message-ID: <xmqqd1psgiuc.fsf@gitster.mtv.corp.google.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
	<1459980722-4836-4-git-send-email-dturner@twopensource.com>
	<CACsJy8C5NhaAAW=wzpwkBdLvVZz8wVM7QX==n_CL5g+LLAKY=A@mail.gmail.com>
	<1460153784.5540.19.camel@twopensource.com>
	<1460417232.5540.53.camel@twopensource.com>
	<CACsJy8C2FtdetQ_NJSKR_JCZ5Ju0E3rV7Du=J4f2_kn5qrcHxg@mail.gmail.com>
	<1460482108.5540.59.camel@twopensource.com>
	<xmqqfuuqr9ca.fsf@gitster.mtv.corp.google.com>
	<CACsJy8B6o-8YJYemcYX3NwyMaY9jV666ZwKJYwfbwMSmzM-YGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w6Z2YXIgw77Ds3I=?= <aevarb@gmail.com>,
	jeffhost@microsoft.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:12:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqll6-0008MZ-AP
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbcDNSMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:12:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53054 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754530AbcDNSMr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:12:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A1F5113295;
	Thu, 14 Apr 2016 14:12:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IvSa3Goez7aDlNOdsqky4GnYNTg=; b=ZrGiw4
	tW4yZwKrZtN5EGJVbk4MZrKa1OxmUh5ErJ3Q9RYdES/+1m95AgUuw0OCvLMKnSdy
	RPOQIr6GyQCclyrGVAU1QMZQ/VwLm6bvTQj7A5BeG7799gPQBDLGhMJWtOGfhCbh
	edwdynNEj8fupYXV25jHGJY555o1lEkqxl4PY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U1DuUXZgPlTOnqhZQaufjoMWBr3pX5Ub
	vHYKXd0qj2wiyxMCpMpMejaQtc9vvJaF4vk7ZxR+7EURicBzIh7SCmq1mBt32i4z
	yUoQF2aPgu848gtXBygJ3LgfICM7CRKDYZDtknamoQjyCAvHK5/1sZJxnYHnAUb2
	BHECO8UmIPI=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A1E413294;
	Thu, 14 Apr 2016 14:12:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0EE9613293;
	Thu, 14 Apr 2016 14:12:44 -0400 (EDT)
In-Reply-To: <CACsJy8B6o-8YJYemcYX3NwyMaY9jV666ZwKJYwfbwMSmzM-YGw@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 14 Apr 2016 17:43:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7C8D98FC-026C-11E6-8DEF-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291543>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Apr 13, 2016 at 1:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>  - access is slow (unless cached, but we can't be sure)
>>>
>>> We could solve this (and the other problem) with mlock.
>>
>> Probably you meant madvise(2)?
>>
>> For something of a size comparable to the index file held by
>> index-helper-daemon in-core, I'd expect we wouldn't page too
>> badly.
>
> I had a look at linux implementation of madvise(MADV_WILLNEED). All it
> does is force populating the entire memory region, which is good. But
> I suspect when memory is under pressure, some pages may be reclaimed.

I share that suspicion.  Why is such a reclamation bad thing, though?

> index files in monster repo case can go up to a few hundred megabytes,
> chances of being reclaimed rise accordingly. But we can reconsider
> mlock() later when/if real problems happen.

Holding onto "a few hundred megabytes" just so that occasional Git
operations will not stall with the daemon and slowing down the
overall work of the user by panalizing other elements in the user's
workflow does not sound like a good trade-off to me.  Wouldn't the
user better off by not using the daemon at that point, which would
give the few hundred megabytes back to the system for better uses?
