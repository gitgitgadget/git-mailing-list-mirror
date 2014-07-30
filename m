From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] utf8.c: fix strbuf_utf8_replace copying the last NUL to dst string
Date: Wed, 30 Jul 2014 11:23:24 -0700
Message-ID: <xmqqha1yzowz.fsf@gitster.dls.corp.google.com>
References: <1406639429-28748-1-git-send-email-pclouds@gmail.com>
	<xmqqha202b2v.fsf@gitster.dls.corp.google.com>
	<20140730102022.GA5653@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 20:23:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCYXK-0003U7-Hc
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 20:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459AbaG3SXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 14:23:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58294 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333AbaG3SXe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 14:23:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 201D52B187;
	Wed, 30 Jul 2014 14:23:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nm9oHDEY4uW/rPZFK0hW6vek0ow=; b=UwKvqD
	5wsPl8jgl8P2jsBGqIkzUUIZSO+Uydwxz6evZ8K/3OEUo+DWQfdvw7tRVGBXpnp9
	r9fv9ixjpZQZkc33OCzWCm0Cwu7rP5DHqZIGYl8LNNn8bZf36rwBfC0F1UZwlN0M
	750/dC3pFjK4O4fNEhexGOHRF0c3pziKDV2Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lusbLMYne4KBxB+KFFz90XPHN0lcKniG
	gQLfxDcQwDPI6ahthmtUvPUfXPplMAWVrFZ/hQ9b2kmMqs93Ttl2DflZeY2hpnA2
	O3ekm40dcVvT4a6GITJ27pPUJll7SLAPoptInbBKFR4EMrN5UQdx2aailn1Dtu2M
	kPstZRxr1LQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 158EE2B186;
	Wed, 30 Jul 2014 14:23:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AE7972B182;
	Wed, 30 Jul 2014 14:23:26 -0400 (EDT)
In-Reply-To: <20140730102022.GA5653@lanh> (Duy Nguyen's message of "Wed, 30
	Jul 2014 17:20:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 993D4AB6-1816-11E4-A54A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254506>

Duy Nguyen <pclouds@gmail.com> writes:

>> > it returns 0 and steps 'src' by one. 
>> 
>> Here "it" refers to utf8_width()?  Who steps 'src' by one?
>
> utf8_width() steps 'src'.
>
>> 
>> Ahh, did you mean *src == NUL, i.e. "already at the end of the
>> string"?
>
> Yes.. I guess you have a better commit message prepared for me now :)

Heh.  At least you realized that the log message was uninformative ;-)

>> I think utf8_width() called with an empty string should not move the
>> pointer past that end-of-string NUL in the first place.  It makes me
>> wonder if it would be a better fix to make it not to do that (and
>> return 0), but if we declare it is the caller's fault, perhaps we
>> may want to add
>> 
>> 	if (!**start)
>>         	die("BUG: empty string to utf8_width()???");
>> 
>> at the very beginning of utf8_width(), even before it calls
>> pick-one-utf8-char.
>> 
>> Still puzzled...
>
> I don't know. I mean, in a UTF-8 byte sequence, NUL is a valid
> character (part of the ASCII subset), so advancing '*start' by one
> makes sense.

Dubious.  NUL may be valid but it is valid only in the sense that it
will mark the end of the string, i.e. the caller is expected to do:

        const char *string = ...;

        while (not reached the end of the string) {
                this_char = pick_one_char(&string);
                do something to this_char;
        }

and there are two ways to structure such a loop:

 (1) Make pick-one-char signal the termination condition.  i.e.

	while ((this_char = pick_one(&string)) != EOF)
		do something to this_char;

     That's a typical getchar()-style loop.  It would better not
     advance string when it returns EOF.

 (2) Make it the responsibility of the caller not to call beyond the
     end. i.e.

	while (string < end) {
        	this_char = pick_one_char(&string);
		do something to this char;
	}

and your patch takes the latter, which I think is in line with the
way how existing callchain works.  So the addition of "BUG" merely
is to make sure that everybody follows that same convention.

We cannot declare that it is caller's responsibility to feed
sensible input to the function only at one callsite and allow other
callsites feed garbage to the same function, after all, no?
