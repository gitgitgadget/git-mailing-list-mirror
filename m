From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add support for specifying an SSL cipher list
Date: Thu, 07 May 2015 09:33:01 -0700
Message-ID: <xmqqvbg4qreq.fsf@gitster.dls.corp.google.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
	<xmqq8ud0s7sv.fsf@gitster.dls.corp.google.com>
	<20150507160413.GB16334@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lars Kellogg-Stedman <lars@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 07 18:33:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqOjX-000267-25
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbbEGQdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:33:06 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751035AbbEGQdE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 12:33:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B1864D374;
	Thu,  7 May 2015 12:33:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NFm2vA1z6UILLz0CIWH7Z0D4Kmg=; b=QLaIwm
	MRW2Rg/6hg8xUNvyD7v7CgdEkJYVbJ1RR2C+vDXAB7bsJlR7NNGk7RBzDksQ+HJ6
	jL0baAA6LaQ/xgjbQjCu6XBMbcubvOKp/2Tx3FS0NcSGk9rm6gkxejfsaBbBww3K
	P1OfRU0dkiAjpB8UYbAVP2Oyr8GgQVY2uh4dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=can235Cpn1+/R4P5tQo5fSk6Bkj6pzXH
	fHz/Fr6eLxwVd9yAQYy91flyv0+IUJm9XTuMwClAIwbU4E6zJsf7M32d6KhidQgz
	nUz4pX/zmnryFZOcfLNpKzcfTxFfcb3A+JHCBZg0WIr5QQjd+w4a+so63eexpcGi
	uq5yrCqNT6Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9436A4D373;
	Thu,  7 May 2015 12:33:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3CD74D36E;
	Thu,  7 May 2015 12:33:02 -0400 (EDT)
In-Reply-To: <20150507160413.GB16334@redhat.com> (Lars Kellogg-Stedman's
	message of "Thu, 7 May 2015 12:04:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BB290668-F4D6-11E4-A3FA-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268546>

Lars Kellogg-Stedman <lars@redhat.com> writes:

> [Apologies for the dupe; this should have been cc'd to the list]
>
>> It is not clear to me what definition of "override" this sentence
>> uses.
>
> I was using it in what I thought was the common sense of "git will use
> the value in the environment variable if it exists rather than any
> value in the git configuration".  I apologize if this wasn't clear;
> can you suggest how I might rephrase that?

I was hinting that the usual "override" that needs to specify
the list to be used exactly would not be very useful, in that
people often want to say one of the three things:

 - allow this to be used in addition to what you usually use; or

 - what you usually use is fine, but never use this one as it was
   recently discovered to be insecure; or

 - I have something nonstandard configured but ignore that
   configuration for this invocation only and reset to the default
   behaviour.

If you are changing the behaviour in your reroll, I suspect you
wouldn't be doing the common "override".  If you are going to do the
'reset on empty', then 'You can set the environment variable to an
empty string to reset to the default cipher list used by libcURL.'
may be a natural way to describe it.

I briefly wondered if lack of the other two ("allow this too",
"forbid this") might become an issue not just for the environment,
but also for the configuration variable.  It is probably not a huge
issue because you can say "http.<url>.sslCipherList" to limit the
scope of the affected site [*1*].

CURLOPT_SSL_CIPHER_LIST appeared in cURL 7.9 which is relatively
ancient, so it should be safe to use (please write that down in your
commit log message).

Thanks.


[Footnote]

*1* And it is a bad idea to address "allow this too" and "forbid
    this" at our level---the semantics of CURLOPT_SSL_CIPHER_LIST
    given by libcURL itself depends on the crypto backend (when
    using OpenSSL and GnuTLS, you can say !, +, - to tweak; when
    using NSS, you can only say "use these and nothing else").
