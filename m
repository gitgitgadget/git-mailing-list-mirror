From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] help: add help_unknown_ref
Date: Wed, 01 May 2013 15:12:13 -0700
Message-ID: <7vobcu4af6.fsf@alter.siamese.dyndns.org>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com>
	<1367407327-5216-2-git-send-email-vikrant.varma94@gmail.com>
	<CALkWK0nMMi-nmAMUGXCaJDCV29G3dOzYTosKqSw+bFzc0osiaA@mail.gmail.com>
	<51817319.6060201@gmail.com>
	<CALkWK0nJSoBoAXR=ViGan6keFzXjmDGkfKqqWkTHqF89mHDDOQ@mail.gmail.com>
	<51818CFA.9030305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Vikrant Varma <vikrant.varma94@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 00:12:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXfGA-0001R1-F7
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 00:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab3EAWMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 18:12:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39088 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755978Ab3EAWMR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 18:12:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2F0B1B43A;
	Wed,  1 May 2013 22:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fLeciEUanB4BYKdCiC0sC1xnmt8=; b=MAcBTj
	ZLfcXm6I58dfM5j0ZOCWcd9c91uqLYSneg83b5T2yhdNPoQwkbG0kHRc/A7xDCkx
	8AIzg0SYjupHhbLE5kHs33QSMk2RwDwsHbakV4zmbNpzs/z4eDAzJj+TVWp6EXeU
	1ncQQ0fp8FVIzaqlpQSNyDCm9GGYGYG/nKgi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Itpl1LZuFgPiv13lkiHhwmljsD2sX6eZ
	Tvlm/W3WmPvfSMZYLrhx2olI5+MCKGNp2sFTVGTS7s0+5lsNHyu5JwLeOXtijKp4
	RVdmABMIMOk/zwrpQ8ZxEzCbKWegeS03nC6klB5JSTHRR/SfAAp35zLRvg8wcrZY
	5vzwCfK3FmE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA17F1B439;
	Wed,  1 May 2013 22:12:16 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C4BF1B432;
	Wed,  1 May 2013 22:12:15 +0000 (UTC)
In-Reply-To: <51818CFA.9030305@gmail.com> (Vikrant Varma's message of "Thu, 02
	May 2013 03:15:30 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E3E9FEC-B2AC-11E2-8A73-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223154>

Vikrant Varma <vikrant.varma94@gmail.com> writes:

> On 02-05-2013 02:02, Ramkumar Ramachandra wrote:
>>> ref_cb.similar_refs has already been defined. The compiler won't let me
>>> assign to it unless I cast first. However, I think compound literals are a
>>> C99/gcc feature. Is this better?
>>>
>>>          struct similar_ref_cb ref_cb = {ref, STRING_LIST_INIT_NODUP};
>>
>> As Johannes pointed out, ref is a variable and that is problematic.
>> Leave the cast on: I didn't notice the compiler warning in my head.
>>
> Is it okay to use a compound literal? It's not supported in C89.

Building on top of what was suggested in the other message, the
helper could be made more reusable by doing something like this:

	int suggest_misspelt_ref(const char *ref, struct string_list *suggested);

and the caller can do

	if (!commit) {
		struct string_list suggested = STRING_LIST_INIT;
                if (suggest_misspelt_ref(argv[1], &suggested)) {
                	... Did you mean one of these??? ...
			string_list_clear(&suggested);
		}
                die(_("'%s' is not something we can merge'), argv[1]);
	}

So I think this point is moot.  Of course, similar_ref_cb needs to
be updated to keep a pointer to an existing string_list, not an
instance of its own string_list.
