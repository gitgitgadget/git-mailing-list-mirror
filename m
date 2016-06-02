From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segfault in the attr stack
Date: Wed, 01 Jun 2016 17:22:51 -0700
Message-ID: <xmqq8tyowias.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79ka_4vZfNhgOyMeFKdossO-S5Q7RVnvEzB8YAJNc1YQ+uQ@mail.gmail.com>
	<CAGZ79kbSKgS42nAShsK3JV78geam3k84=ipWRx7vbRODuHcmcA@mail.gmail.com>
	<CAPc5daXuQAeWvJAciRA_Kzyoxa=atEntGzKhqzjiN+ho6TnQyg@mail.gmail.com>
	<xmqqh9dcwmrr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 02:23:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8GPc-0006h1-FS
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 02:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbcFBAW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 20:22:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750931AbcFBAWz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 20:22:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 97B0C2031E;
	Wed,  1 Jun 2016 20:22:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MbcTE/JHSSRqGaBv/zaufeWI9X4=; b=WZZY/p
	BWY2jTyAdItbVKWoqilM+M3CmyoEF5rdqiZD6ZIgixi83B58SClEa9q1x81tpfXl
	lIinHB0/Fs5o1cPgRVOgnX7jQ5AkDpPvF2UYyVoAOF8FgdOlaV2DJcYNZ6D11ycj
	mb0w37yng4y1fxFCGdXkyxauOzARTVsbrxRvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d66y/OOWNarQ2dGvrZW1H4RQ3PBe1vbN
	RYAvulBwzoVEAjz9GtwIieXESz3QbTFtA2oEUWdQCJI/CxO140V+x4DJJlQYJLO5
	RdzvtE2ffPiGXg7y13eDbPJk+vy+jXwuUgAu/DdCTrOyy8FmGayNmLtnn7RNyUBg
	9yJJENq67bw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FB9B2031B;
	Wed,  1 Jun 2016 20:22:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18B962031A;
	Wed,  1 Jun 2016 20:22:53 -0400 (EDT)
In-Reply-To: <xmqqh9dcwmrr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Jun 2016 15:46:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 25677FE0-2858-11E6-807A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296179>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Gaah, of course.
>>
>> This is coming from the cache preload codepath, where multiple threads
>> try to run ce_path_match().
>> It used to be OK because pathspec magic never looked at attributes,
>> but now it does, and attribute system is not thread-safe.
>
> The symlink check code has dealt with a similar issue in the past in
> the codepath.  threaded_has_symlink_leading_path() is called with
> per-thread data structure called "cache", because the leading
> symbolic link check uses a cache that is shared across different
> invocations of the check.
>
> We need something similar to duplicate the attribute stack per
> thread.  git_check_attrs() currently uses the singleton instance of
> attr_stack chain, that is rooted at the file scope global
> "attr_stack", and no wonder that would be clobbered when multiple
> threads try to use it.  The result of attribute collection is also
> accumulated in a file scope global, which should probably be moved
> to the "struct git_attr_check" introduced in the jc/attr topic.
>
> We need to teach the callchain that includes prepare_attr_stack()
> and bootstrap_attr_stack() to take a pointer to the attr_stack root,
> give git_check_attr_threaded() that takes such root so that threaded
> code can use per-thread attr stack, and for non-threaded
> applications use &the_default_attr just like the file scope global
> "default_cache" is used in symlinks.c.  Then a threaded attribute
> lookup can maintain its own attr_stack when running more than one
> instance of lookup.

Another is the global attr dictionary.  It is like the global object
hash, so the look-up and insertion into it need to be protected the
same way with mutex, just like builtin/pack-objects.c serializes the
object store access with locks.
