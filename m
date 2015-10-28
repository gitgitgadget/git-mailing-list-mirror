From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http: allow selection of proxy authentication method
Date: Wed, 28 Oct 2015 09:59:48 -0700
Message-ID: <xmqqoafjkjy3.fsf@gitster.mtv.corp.google.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	<1446025245-10128-1-git-send-email-k.franke@science-computing.de>
	<1446025245-10128-2-git-send-email-k.franke@science-computing.de>
	<xmqqsi4vkkcf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Wed Oct 28 17:59:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrU4q-0002D2-Kb
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 17:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbbJ1Q7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 12:59:52 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751159AbbJ1Q7v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 12:59:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 789CA23C19;
	Wed, 28 Oct 2015 12:59:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KShflpTXfxmrOlyOD4xch+7xA1Y=; b=sVHr88
	3URMgbxnSYliCWANBonEO7IYNn7Rasnd2kx9OqCtNhu+Vf2t7SnZ7hP6+XWbYsJ3
	gyKeoKqXeJLMdzBTB70lMkkULwJsU4HlTLfq0U+XZPUqwQdhaA8PMutb5Z2uP9ya
	bnd729EL4kw2gS8e+nFtvPtZC94y+/N8JkEtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kW0vnhxV0E6Wg2wrQDPtPr/eQ91ekwrl
	POAjRmrP7zNXgXDGkUjX6n7sTB8jklnnO/4sjvtX0gb+fZ6LEuurKwue9ENbuzAp
	5b0uL2RaDU4RnMaDDHA+iMaiOylSN9/s75cep5navMG1G/QSHLgkokJZDwfq4p+q
	27o9dEEnw0c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 70A6E23C18;
	Wed, 28 Oct 2015 12:59:50 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EF7EA23C17;
	Wed, 28 Oct 2015 12:59:49 -0400 (EDT)
In-Reply-To: <xmqqsi4vkkcf.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 28 Oct 2015 09:51:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4CFD9328-7D95-11E5-907D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280377>

Junio C Hamano <gitster@pobox.com> writes:

>> +static void copy_from_env(const char **var, const char *envname)
>> +{
>> +	const char *val = getenv(envname);
>> +	if (val)
>> +		*var = xstrdup(val);
>> +}
>> +
>> +static void init_curl_proxy_auth(CURL *result)
>> +{
>> +	copy_from_env(&http_proxy_authmethod, "GIT_HTTP_PROXY_AUTHMETHOD");
>
> Unless this helper is used regularly from many other places, is use
> makes it harder to follow the flow of the logic, as it does not
> offer clear and obvious abstraction, especially with the name
> "copy_from_env()".  I was forced to look at the implementation to
> see what happens when the environment variable does not exist to
> make sure the right thing happens (i.e. http_proxy_authmethod is
> unchanged).

I see you use this liberally in 2/2, it is a handy helper to have,
and I do _not_ think it is a good idea to open-code this in 1/2 and
turn it into a helper in 2/2.  IOW, I am OK with this "one helper
with a single caller introduced and used in 1/2".  I primarily was
wishing that its name more clearly conveyed that it sets the
variable from the environment _only if_ the environment variable
exists, and otherwise it does not clobber.

The implementation of the helper seems to assume that the variable
must not be pointing at a free-able piece of memory when it is
called (that is why *var is assigned to without freeing the old
value).  That's another subtle thing the callers need to be aware of
(i.e. deserves at least a comment in front of the function, but as
always a good name that clearly conveys it would be more
preferrable, if we can find one).

Thanks.
