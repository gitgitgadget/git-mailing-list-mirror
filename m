From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat: convert modes to use portable file type values
Date: Mon, 01 Dec 2014 09:57:16 -0800
Message-ID: <xmqqsigzp81v.fsf@gitster.dls.corp.google.com>
References: <87vblxl8ah.fsf@gmail.com>
	<CACsJy8CKEwOVcB_MUaK8mmSmQuKHC6R6K0YymjCrTP3aYFdbPg@mail.gmail.com>
	<CAEvUa7mhjG1xPoJedp4XYrxr39_EuzvGtONLv0B=uBw+vQB5pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 18:57:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvVDx-0004py-Ro
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 18:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178AbaLAR5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 12:57:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754154AbaLAR5V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 12:57:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D059520E79;
	Mon,  1 Dec 2014 12:57:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vuqPmYA8Zfla2AcKYdDCpOqTwQA=; b=PUOTsI
	GNWLEjazoULz3tcL+k1JWl0Qv9RSs4inT4+WpLPfJvgeI39JQ0Ul/MO5O2xJcjJn
	/e8ESBS7+ba9i8guY2ILqZk1eeN8nvLftVyhFvIBHuexb0hnB3WWBc6PhllSdnbT
	uUY8qdBsU8LYVfWe7eAsZGTrQWLcJZlocW0IY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eLJkWSOcDUqPAhi4lZOdO6Mth5/VArFE
	L+An/B2akAbFe+8I2EZfG6MYj+/Oxd0rHXdWsp14i4GDy96aLbsmyi+JKYbuQU4d
	Nzc0Lj5F41txwQZ6jI9lQj7teZ2S8ymP33/pdWXe/R2LbOLTcZVYE53+hmTgISIB
	qf35+qoZfXs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C7B9520E77;
	Mon,  1 Dec 2014 12:57:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5150320E69;
	Mon,  1 Dec 2014 12:57:18 -0500 (EST)
In-Reply-To: <CAEvUa7mhjG1xPoJedp4XYrxr39_EuzvGtONLv0B=uBw+vQB5pw@mail.gmail.com>
	(David Michael's message of "Mon, 1 Dec 2014 12:49:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7DA24864-7983-11E4-949B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260501>

David Michael <fedora.dm0@gmail.com> writes:

> On Mon, Dec 1, 2014 at 9:44 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, Nov 30, 2014 at 9:41 AM, David Michael <fedora.dm0@gmail.com> wrote:
>>> +int git_stat(const char *path, struct stat *buf)
>>> +{
>>> +       int rc;
>>> +       rc = stat(path, buf);
>>> +       if (buf != NULL)
>>
>> It's a minor thing, but maybe test "!rc" instead of "buf != NULL"?
>
> Okay, it makes sense to only do the conversion for a successful return code.
>
> Should it test for both a zero return code and a non-null pointer?  I
> don't know if there are any cases where passing a null pointer is
> legal.  The standard doesn't seem to explicitly forbid it.  z/OS
> returns -1 and sets errno to EFAULT when stat() is given NULL, but
> this patch should be able to be used on any platform.

Huh?  I am confused.  Since when is it legal to give NULL as statbuf
to (l)stat(2)?

Wouldn't something like this be sufficient and necessary?

	int rc = stat(path, buf);
        if (rc)
		return rc;

That is, let the underlying stat(2) diagnose any and all problems
(and leave clues in errno) and parrot its return value to the caller
to signal the failure?
