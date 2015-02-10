From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] trailer: add a trailer.trimEmpty config option
Date: Tue, 10 Feb 2015 13:58:19 -0800
Message-ID: <xmqqsiedv37o.fsf@gitster.dls.corp.google.com>
References: <20150207131112.394.30858.chriscool@tuxfamily.org>
	<xmqq386hcw33.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1pWH5yaJaJ_gV1t5q5qfgs58AtcSr+ZqDTnWzfHK1uBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 23:00:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLIr3-00057e-Rt
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 23:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736AbbBJWAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 17:00:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754731AbbBJWAS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 17:00:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3657337927;
	Tue, 10 Feb 2015 17:00:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mELssQaAADi5w8lOoSBnCSnKLaY=; b=FwEWxl
	m9mt6wDwYpI19kjilrUj6bYxgBcftYG8mcuiGqDrZXMr0VMWcn04BQeu4w2s4lAz
	3TkczaX4L1OqY4B+a/15hF5ancfiivEsQWPpbOLBlDvVFUbwHEGWmNAbmBHbKEev
	kwralVz3FGYywIPFscAEwuZprQnsj8iya890I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QigiHz8T9Nviboty4QK3Qt9qV1hRLxKU
	1KOdTynbrCIFRQ5FLgKi8crHJh304BIDlHHvo3O/3wphYXKFFsI7k+aeCGsBn+JW
	9bxjdYJmL1QXmJLNq2oRD0HrHty6/4xxHySNrzaqvcCUMtULhc2+wfpwAnZ+V3gA
	mdNzyiYWgjw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DA1437926;
	Tue, 10 Feb 2015 17:00:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D9BB37836;
	Tue, 10 Feb 2015 16:58:20 -0500 (EST)
In-Reply-To: <CAP8UFD1pWH5yaJaJ_gV1t5q5qfgs58AtcSr+ZqDTnWzfHK1uBw@mail.gmail.com>
	(Christian Couder's message of "Sat, 7 Feb 2015 23:19:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED0E51C4-B16F-11E4-982C-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263649>

Christian Couder <christian.couder@gmail.com> writes:

> I think that very few new features are now needed to make it possible
> to use the code in other commands like commit, format-patch, am, etc,
> but this patch implements one of the needed features.
>
>>     - do "trailer stuff" by calling a central helper that does
>>       "trailer stuff" a pointer to the middle, trailers, struct.
>>
>>       - when the trailer becomes a reusable subsystem, this central
>>         helper will become the primary entry point to the API.
>>
>>       - "trailer stuff" will include adding new ones, removing
>>         existing ones, and rewriting lines.  What you do in the
>>         current process_command_line_args() and
>>         process_trailers_lists() [*1*] would come here.
>>
>>     - write out the result, given the outermost struct.  This will
>>       become another entry point in the API.
>>
>> Structured that way, callers will supply that outermost structure,
>> and can trust that the trailers subsystem will not molest
>> message_proper or lines_after_trailers part.
>
> I don't think it is a big improvement because it is easy to see that
> the current code doesn't molest the part before and after the
> trailers.

You force the callers that want only the "trailer" thing to happen
to:

 - pass first and last around.

 - keep each line of the message body in separate strbuf and have
   it in the same array as the trailers

Neither of which is necessary.  I recall that during the review of
the previous rounds your own code had to work this around by first
concatenating lines (each of which are unnecessarily in separate
"struct strbuf"s) into a single strbuf, only to call a helper that
takes a single strbuf to count what to ignore in it, and then
iterate over the array of strbuf to add up the lengths of them,
which would have been unnecessary if the underlying data structure
were saner.
