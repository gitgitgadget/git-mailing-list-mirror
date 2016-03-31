From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/4] notes: don't leak memory in git_config_get_notes_strategy
Date: Thu, 31 Mar 2016 15:54:37 -0700
Message-ID: <xmqq7fgil0lu.fsf@gitster.mtv.corp.google.com>
References: <1459447446-32260-1-git-send-email-sbeller@google.com>
	<1459447446-32260-2-git-send-email-sbeller@google.com>
	<CAPig+cRPNt1aNdsONXgX0SkgNiYtTS8vCGQzE2u4+vpd-N-Vew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 00:54:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1allUE-0007Gz-08
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 00:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbcCaWyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 18:54:41 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932204AbcCaWyl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 18:54:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC2B85285C;
	Thu, 31 Mar 2016 18:54:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7uhFB3Ptq8L6PTQ72Mxm3rrxMOU=; b=C81GIn
	vWZR7KrSwGpEtyPd2lylXlCWaRlySwsaktnZC4xfm3EwFOo/hJibaPFW3rzcQgfa
	qxzex8voG0kM++2bXD9E42wkHuap8koMATSVUnTksSun1cQsCvGRCIyrQEDMDbyc
	s2GKoMpJRbndn8jNaGUMJkkoMONiZbeYPtMag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uvI48oA0c9iQY7DNwp4wjJwGXZAguWRj
	nBsize5RfH7Pts/gHG8J0ZaeHG335c8pVgJZLAELT8nOXGwXivuCJ2CHVpAEBlVI
	GDbOsXhcNs4LCaSI56p6Q03xxsJZl8awyDmeERQYHrtAWzEeSAtbb91Ph+IRwBpb
	D0ikXxpH4Ag=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A2BF15285B;
	Thu, 31 Mar 2016 18:54:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 217C55285A;
	Thu, 31 Mar 2016 18:54:39 -0400 (EDT)
In-Reply-To: <CAPig+cRPNt1aNdsONXgX0SkgNiYtTS8vCGQzE2u4+vpd-N-Vew@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 31 Mar 2016 17:08:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8C5838CA-F793-11E5-A6BD-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290483>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Mar 31, 2016 at 2:04 PM, Stefan Beller <sbeller@google.com> wrote:
>> `value` is just a temporary scratchpad, so we need to make sure it doesn't
>> leak. It is xstrdup'd in `git_config_get_string_const` and
>> `parse_notes_merge_strategy` just compares the string against predefined
>> values, so no need to keep it around longer. Instead of using
>> `git_config_get_string_const`, use `git_config_get_value`, which doesn't
>> return a copy.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/builtin/notes.c b/builtin/notes.c
>> @@ -746,7 +746,7 @@ static int git_config_get_notes_strategy(const char *key,
>>  {
>>         const char *value;
>>
>> -       if (git_config_get_string_const(key, &value))
>> +       if (git_config_get_value(key, &value))
>
> Hmm, doesn't this introduce a rather severe regression? Unless I'm
> misreading the code (possible), with the original, if 'key' was
> boolean (lacked a value in the config file), then it would complain:
>
>     Missing value for 'floop.blork'
>
> but, with this change, it will dereference NULL and crash.
>
> (My understanding was that Peff's suggestion to use
> git_config_get_value() implied a bit of work beyond the simple textual
> substitution of 'git_config_get_value' for
> 'git_config_get_string_const'.)

Yup, thanks for spelling it out.
