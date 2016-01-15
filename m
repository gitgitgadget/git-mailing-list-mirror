From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Fri, 15 Jan 2016 09:37:26 -0800
Message-ID: <xmqqwpraiw15.fsf@gitster.mtv.corp.google.com>
References: <1452708927-9401-1-git-send-email-sbeller@google.com>
	<xmqq4mehm92b.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka0rxYK7GRSjh13XOsg887EgqYtc5B60z9qU=tAoJGERQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 18:37:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK8JZ-0005Gn-SF
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 18:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbcAORh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 12:37:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751944AbcAORh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 12:37:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B94539676;
	Fri, 15 Jan 2016 12:37:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EoR1pMvP+aFYHd1jzaRKSnukekA=; b=P5iijH
	S3yuZxOPAZcfB2mp61o1Wdzqo397Siqxv+ZPhZPXWTBh3lk624m1WVzcm7FuV26u
	JWfiFSX6K000naEqPR8yQyGLG3VCpmBed2/7vz1Mn/JUxxjRxv/zXCcPp/bwD9oA
	H3mFs4892wli1qn7+npKdoWw24SrglYMeNSE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h5T3sHfe5kSwy4vVbYVEghGOB1szDvmJ
	xreesmnFAugyoBSIa9qm23YtlprkqBycurF+kLv6NPzHBYfssbHMZfBZsaa2gZOY
	dmDvK2iIor0eE67JNX290ctgmvueQBxEy4PIF2Q7RiHW1SMPbD5HeU3aqoAMR5N8
	6gJP/BkgNfQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 32E7D39675;
	Fri, 15 Jan 2016 12:37:28 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AB3173966D;
	Fri, 15 Jan 2016 12:37:27 -0500 (EST)
In-Reply-To: <CAGZ79ka0rxYK7GRSjh13XOsg887EgqYtc5B60z9qU=tAoJGERQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 13 Jan 2016 14:47:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A5543066-BBAE-11E5-9859-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284190>

Stefan Beller <sbeller@google.com> writes:

> On Wed, Jan 13, 2016 at 2:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>> +     while (url) {
>>> +             if (starts_with_dot_dot_slash(url)) {
>>> +                     char *rfind;
>>> +                     url += 3;
>>> +
>>> +                     rfind = last_dir_separator(remoteurl);
>>> +                     if (rfind)
>>> +                             *rfind = '\0';
>>> +                     else {
>>> +                             rfind = strrchr(remoteurl, ':');
>>> +                             if (rfind) {
>>> +                                     *rfind = '\0';
>>> +                                     colonsep = 1;
>>> +                             } else {
>>> +                                     if (is_relative || !strcmp(".", remoteurl))
>>> +                                             die(_("cannot strip one component off url '%s'"), remoteurl);
>>> +                                     else
>>> +                                             remoteurl = xstrdup(".");
>>> +                             }
>>> +                     }
>>
>> It is somewhat hard to see how this avoids stripping one (or both)
>> slashes just after "http:" in remoteurl="http://site/path/", leaving
>> just "http:/" (or "http:").
>
> it would leave just 'http:/' if url were to be ../../some/where/else,
> such that the constructed url below would be http://some/where/else.

Is that a good outcome, though?  Isn't it something we would want to
catch as an error?
