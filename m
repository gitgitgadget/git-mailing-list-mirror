From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http: use credential API to handle proxy authentication
Date: Fri, 30 Oct 2015 12:31:29 -0700
Message-ID: <xmqq8u6kkvam.fsf@gitster.mtv.corp.google.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	<1446025245-10128-1-git-send-email-k.franke@science-computing.de>
	<1446025245-10128-3-git-send-email-k.franke@science-computing.de>
	<CAPig+cRK-EPpH4dUMpYBcjR22Wqw4RnNTYeBvw-M7h=CTFGviQ@mail.gmail.com>
	<20151030182426.GA16389@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:31:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsFOi-0000vd-Ba
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758627AbbJ3Tbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:31:32 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753242AbbJ3Tbb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:31:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E9C8A2641E;
	Fri, 30 Oct 2015 15:31:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tmgY8yqDsHtOoTQdBt7EXnIQ2Gs=; b=OyiXvz
	42NcJEq9VsxIuotnHhxJtBVw2AhT3omud8wYuuMBzkxGegmj0luteA2rZj1dC+Uc
	VQLTAnekZG9YSIZ0lbZQSIINAMNIAT0a/TtwrL3pULBhaKnVYNsChiOP8GEghDRT
	lwtN9F0HQvGQFA7e9TPhlmFjGE1WkbB/2p3VU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D6JlembfqFIOvBzgR25hBb+8wGkAnqdt
	xAFLUqsZlknC7kDFDNnjPn3bczyengnR3tmR4KRkRufsRoy6ht758HWNaxTfX3xF
	eGcUVGTwqt2t/2/OpSK4AGEE2j7oyfbM42+M4naWDu3qUD0eM3VWqoF/c3id+v6M
	E7CCFbhzQ2g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0E1B2641C;
	Fri, 30 Oct 2015 15:31:30 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6B4E82641B;
	Fri, 30 Oct 2015 15:31:30 -0400 (EDT)
In-Reply-To: <20151030182426.GA16389@science-computing.de> (Knut Franke's
	message of "Fri, 30 Oct 2015 19:24:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D21CC1C0-7F3C-11E5-97F0-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280530>

Knut Franke <k.franke@science-computing.de> writes:

> On 2015-10-28 14:58, Eric Sunshine wrote:
>> > +               }
>> > +               if (!curl_http_proxy) {
>> > +                       copy_from_env(&curl_http_proxy, "ALL_PROXY");
>> > +                       copy_from_env(&curl_http_proxy, "all_proxy");
>> > +               }
>> 
>> If this sort of upper- and lowercase environment variable name
>> checking is indeed desirable, I wonder if it would make sense to fold
>> that functionality into the helper function.
>
> It's just for consistency with libcurl here, not generally desirable; so I don't
> think it makes sense to add it to the helper.

I agree.  Unlike many environment variables, historically these
proxy environment variables were all lowercase only for quite a
while (found as early as in CERN libwww 2.15 March '94).

It appears that CURL did not know this and implemented only
uppercase variants, which was later corrected to take both
(http://sourceforge.net/p/curl/bugs/40/ shows a fix in Nov 2000).

So both unfortunately are used in user's environment and we need to
pay attention to both.  As lowercase version is the more kosher one,
looking at uppercase first and then overriding it with the lowercase
one is the right order, I think.

It's a mess, but it is limited to these proxy-ish variables and does
not deserve a helper to promote the pattern.
