From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: [PATCH] change contract between system_path and it's callers
Date: Mon, 24 Nov 2014 12:20:55 -0800
Message-ID: <xmqqk32kwdso.fsf@gitster.dls.corp.google.com>
References: <87mw7gae8k.fsf@gmail.com>
	<1416838063-16797-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqoarwwfz1.fsf@gitster.dls.corp.google.com>
	<87ppcc4b2g.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Alex Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 21:21:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt08A-0006QJ-Qg
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 21:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbaKXUVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 15:21:01 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750802AbaKXUU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 15:20:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FBF8214E2;
	Mon, 24 Nov 2014 15:20:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lmm6pIu6qTJN4iPigBjyDRACk9E=; b=si53W6
	r03H+n0Gxtfn9x/H+u2luP0Gs9u/xDCM8KRFLnIohRCfPthAesP2s3UujP9JcLmV
	m8dZwiBlVjgsY0od9fWlcbDu9JowHYJ5yDNcXMmNlJrbu9StHxMLfcJzvbOZt6BN
	bR0R2k98ElHc8VSEPiVe8gptqWTUoxQvawdwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GisD50nZ+wDwLAAwqdyhjGpKmuou9t8O
	emIhgi6C147yVh2kcTDQVFVmmEYEepOa3hOpUN2rRc7XziQRsI9C7RlFoXeBwaIx
	q8Ag5sPGDehxmhJQShDhh2kmM1XHvSYqUgDqKAMHdFw6Icb3R1cS0zCtj7G5dqsk
	Neldl5HAqac=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 33C23214E1;
	Mon, 24 Nov 2014 15:20:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 79B5F214E0;
	Mon, 24 Nov 2014 15:20:56 -0500 (EST)
In-Reply-To: <87ppcc4b2g.fsf@gmail.com> (Alex Kuleshov's message of "Tue, 25
	Nov 2014 01:53:35 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6591B834-7417-11E4-9E5C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260143>

Alex Kuleshov <kuleshovmail@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> @ 2014-11-25 01:33 ALMT:
> ...
>>>  	if (git_attr_system()) {
>>> -		elem = read_attr_from_file(git_etc_gitattributes(), 1);
>>> +		char *etc_attributes = git_etc_gitattributes();
>>> +		elem = read_attr_from_file(etc_attributes, 1);
>>> +		free(etc_attributes);
>>
>> And freeing here is actively wrong, I think.  You are freeing the
>> piece of memory still pointed by "static char *system_wide" in the
>> function git_etc_gitattributes(); when it is called again, the
>> caller will get a pointer into the memory you have freed here.
>
> Why? If i understand correctly we don't use etc_attributes anymore in
> this function and if we'll call this function again
> git_etc_gitattributes will create new pointer and system_path alloc
> memory for it or i'm wrong with it?

The function keeps a singleton in "static const char *system_wide"
so that it has to call system_path() only once, and keeps the value
for second and subsequent calls.  From its callers' point of view,
they are only peeking the memory it returns.

This aspect does not change with your patch.

    -static const char *git_etc_gitattributes(void)
    +static char *git_etc_gitattributes(void)
     {
    -	static const char *system_wide;
    +	static char *system_wide;
            if (!system_wide)
                    system_wide = system_path(ETC_GITATTRIBUTES);
            return system_wide;
