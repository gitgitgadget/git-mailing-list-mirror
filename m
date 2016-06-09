From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/38] refs: create a base class "ref_store" for files_ref_store
Date: Thu, 09 Jun 2016 09:14:55 -0700
Message-ID: <xmqq60tijq4g.fsf@gitster.mtv.corp.google.com>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
	<8ee7d7359f6763cba29dc788aba2f236204bb76e.1464983301.git.mhagger@alum.mit.edu>
	<xmqqbn3drkwd.fsf@gitster.mtv.corp.google.com>
	<575978DA.30608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 09 18:15:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB2bq-0002L7-OO
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 18:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbcFIQPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 12:15:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932082AbcFIQO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 12:14:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BBD021ED2;
	Thu,  9 Jun 2016 12:14:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JPMdmt3IhY/FwzT5b9jniHt1rbg=; b=Wdt0Wy
	HTDG5GelRsBEl9Rwtkhj39ZEy9VLClRz3uz71Md7p42Uo4g/M+79txIUvv69Ai8k
	1jyqDoIbbFgMRPXPN2+S5CpUrhoLSIaDt/e7Jllv1uyuUDXKF4Sk9tmtfIn3md3E
	/0v3rVz0n+KZu+qLuJCWMxfSuByT3/UPcSDBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ivt48BKwvTCmzUR4M/rzoYoK/coAw/lW
	uUrrmj4mj2Tj7euKj1tSG6RO0GG49CcOILcDHhaZVY+6VhoKd37TNXK3tdHc4dmb
	l2e8VfL6tg4cM2IN9+ymtADnV3PPmy22Uti6d7OnhguzfZhTY5JjMr+Mi+1ZiQAO
	3VGYKpnhQYY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 62CCE21ED1;
	Thu,  9 Jun 2016 12:14:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D453821EC8;
	Thu,  9 Jun 2016 12:14:56 -0400 (EDT)
In-Reply-To: <575978DA.30608@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 9 Jun 2016 16:10:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4EC09C04-2E5D-11E6-9D27-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296898>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>>> +
>>> +static struct ref_store *main_ref_store = NULL;
>>> +
>>> +static struct ref_store *submodule_ref_stores = NULL;
>> 
>> Let's let BSS take care of these initialization.
>
> I like the `= NULL` because it expresses "yes, I care about the initial
> values of these variables", which to me is more valuable than saving a
> few bytes in the size of the executable. But in fact, GCC does the
> obvious optimization: it detects that these variables are being
> initialized to zero, and puts them in BSS anyway. I'd be surprised if
> other compilers don't do the same. So I'd prefer to leave this as-is, if
> it's OK with you.

Sorry; I shouldn't have phrased it with BSS, because the main point
of the convention is not about "saving bytes by placing it in BSS".

Lack of "= ..." is a clear-enough clue that the code wants these
pointers initialized to NULL.  And in this snippet:

	static struct foo the_foo;

        static struct foo *default_foo = &the_foo;
        static struct foo *other_foo;

we want the presence of "=" as a clue that something special is
going on only for default_foo (it is not initialied to the nul value
for the type like usual static variables).  If you wrote it this way,

        static struct foo *default_foo = &the_foo;
        static struct foo *other_foo = NULL;

the reader has to say "something funny going on about other_foo?"
when scanning up to "other_foo =" and then "... ah, no that is just
wasted typing and reading, it is left to NULL after all".

So, no, it is not OK with me.

Otherwise I would have said "I wonder if ..." ;-)
