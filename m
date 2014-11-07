From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Fri, 07 Nov 2014 08:51:47 -0800
Message-ID: <xmqqr3xfgdi4.fsf@gitster.dls.corp.google.com>
References: <20141107081324.GA19845@peff.net>
	<20141107083805.GA26365@peff.net>
	<CACsJy8CPLvmbcdHHmfu6g0dUXJVQ8NhwqfGPD=-kcBmzF_ha6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 17:52:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmmlX-0000Hn-2B
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 17:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbaKGQv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 11:51:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64226 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751225AbaKGQvz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 11:51:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 086831A16F;
	Fri,  7 Nov 2014 11:51:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=quhofS93zn/eaX6ibn/2OUMhYlI=; b=DaQYGD
	h7h50QhpFnqShqrLMbU1KYB6cMlPeUKyZlX5Jr5W3CVhuV214OIUuoXN0JHS2ea0
	W7Lj42NEHEp2Q3MgvkMyYFtyeTEFnuPaU1u8s8JRzVeeJpXWQJTrDBzNHl9hLTjD
	HZg7YewHiGs04jfr4Dq7/9HvRrmCmp+rHsso4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N/iTAj/FgkfWgXS6mJ4+ZpDW5xGHPaal
	ouFoL6+kvFL8rlij3JBXgeMBnCbIlgolqAnNduuGNr7IBhmV4gYi+6RU9LAxemwB
	cNvqC9+rDlmAyT1KnFQSqW5oHFKC2mH2c2fmdER7K9p/yC+DyeK8QfZ/c19N7sXN
	it6yHnnl4pM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F0D731A16D;
	Fri,  7 Nov 2014 11:51:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FFF21A16B;
	Fri,  7 Nov 2014 11:51:49 -0500 (EST)
In-Reply-To: <CACsJy8CPLvmbcdHHmfu6g0dUXJVQ8NhwqfGPD=-kcBmzF_ha6g@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 7 Nov 2014 17:13:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5DE457F8-669E-11E4-B7E9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Nov 7, 2014 at 3:38 PM, Jeff King <peff@peff.net> wrote:
>> On Fri, Nov 07, 2014 at 03:13:24AM -0500, Jeff King wrote:
>>
>>> I noticed that "git checkout $tree -- $path" will _always_ unlink and
>>> write a new copy of each matching path, even if they are up-to-date with
>>> the index and the content in $tree is the same.
>>
>> By the way, one other thing I wondered while looking at this code: when
>> we checkout a working tree file, we unlink the old one and write the new
>> one in-place. Is there a particular reason we do this versus writing to
>> a temporary file and renaming it into place?  That would give
>> simultaneous readers a more atomic view.
>>
>> I suspect the answer is something like: you cannot always do a rename,
>> because you might have a typechange, directory becoming a file, or vice
>> versa; so anyone relying on an atomic view during a checkout operation
>> is already Doing It Wrong.  Handling a content-change of an existing
>> path would complicate the code, so we do not bother.
>
> Not a confirmation, but it looks like Linus did it just to make sure
> he had new permissions right, in e447947 (Be much more liberal about
> the file mode bits. - 2005-04-16).

I think you are referring to the "... to get the new one with the
right permissions" comment in that patch, but I do not think that
affects the choice between (1) unlink and write anew to the final
and (2) create a new temporary and rename.  Either way, you do not
update the existing file in-place and try to checkout the permission
bits with chmod(2).
