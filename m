From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/28] shallow.c: add mark_new_shallow_refs()
Date: Tue, 26 Nov 2013 14:20:21 -0800
Message-ID: <xmqq7gbuvm8q.fsf@gitster.dls.corp.google.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
	<1385351754-9954-9-git-send-email-pclouds@gmail.com>
	<xmqqli0cw2b9.fsf@gitster.dls.corp.google.com>
	<CACsJy8DgaqtQUohRwek2+cPxTEssvtDGb812Uhjy+R7pib2O8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 23:20:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlQzc-0001x1-RM
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 23:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758051Ab3KZWUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Nov 2013 17:20:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56332 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756572Ab3KZWUX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 17:20:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94CE956EFC;
	Tue, 26 Nov 2013 17:20:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=peB9e0J4eqW0fVVg+HgsL4ZMHrI=; b=iXckYF
	0vObtO356/lnAO0Vlt4ISHoIv/6v8+uZXFNMM+/V7QsnCELCxHJTodUaVK7OJHya
	4GckYnhJpQMzfF4XEfgzUqjg9rjgwKvmH4a3zPqR/dtvoi5W4tabJhTk/pK29zn3
	1Bxk+y7FYWauGLDGEKkBj+lERYBVwrCHqmQss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FZmKB6pPyAiF3kiWnknFmWXo52nDy59T
	ZT3GCmQQQoLJlLb4mVjkHumf7CnFi/8+DEfe4+vLXs5NTMLAGGC0jnEtARXLgI9F
	wnmQT+gwjve5u/NLABvFLxfvWqIshm8zhzmqvra+7tjvZL368gVhvkv3LDqyo59V
	+JVs5fssQso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8126356EFB;
	Tue, 26 Nov 2013 17:20:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4A0456EF9;
	Tue, 26 Nov 2013 17:20:22 -0500 (EST)
In-Reply-To: <CACsJy8DgaqtQUohRwek2+cPxTEssvtDGb812Uhjy+R7pib2O8Q@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 26 Nov 2013 20:18:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F11BD2F6-56E8-11E3-951A-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238399>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Nov 26, 2013 at 5:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Hmph.  the use of ->util field in this patch feels that it was
>> something commit-slab data structure was invented to solve.
>
> Good stuff! Thanks.
>
>>> +             if (c->util == NULL)
>>> +                     c->util = bitmap;
>>> +             else {
>>> +                     /*
>>> +                      * Deliberately leak a lot in commit->util
>>> +                      * because there can be many pointers to the
>>> +                      * same bitmap. Probably should allocate in a
>>> +                      * pool and free the whole pool at the end.
>>> +                      */
>>
>> ... or perhaps make the bitmap into
>>
>>         struct {
>>                 int refcnt;
>>                 uint32_t bits[FLEX_ARRAY];
>>         }
>>
>> and refcnt them?
>
> I still prefer memory pools so I just need to do a few free() than
> walking through all the commits again and refcnt-- or free() them.

Fair enough.

> Sorry to break the patches this way and lose the overall call flow.
> It's just too big to put all into one patch. 13/28 is the one that put
> the pieces together but basically
>
>  1. receive the remote's .git/shallow
>  2. call remote_reachable_shallow_points() to exclude our shallow commits
>  3. get the pack and install it (or unpack it)
>  4. call this function to determine what new ref needs new shallow
> commits from the result of #2

Thanks for a roadmap.  Will find time to re-read the thing with it.
