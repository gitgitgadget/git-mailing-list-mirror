From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] tree.c: update read_tree_recursive callback to pass strbuf as base
Date: Wed, 03 Dec 2014 08:13:08 -0800
Message-ID: <xmqq1toglnjf.fsf@gitster.dls.corp.google.com>
References: <1417338302-8208-1-git-send-email-pclouds@gmail.com>
	<1417338302-8208-2-git-send-email-pclouds@gmail.com>
	<xmqqk32bp3nk.fsf@gitster.dls.corp.google.com>
	<CACsJy8B7G9xQerZ+6GTPQuG2v1DuJLXfsKFobuz_vyFahnXuYQ@mail.gmail.com>
	<CAPig+cS1OK6pv5A0vuJf=j6eFrNv70=AYgVz3zQny-md15_xKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 17:13:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwCYo-0005NX-9L
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 17:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486AbaLCQNN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Dec 2014 11:13:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752203AbaLCQNL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2014 11:13:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3798322867;
	Wed,  3 Dec 2014 11:13:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XMfUHtQ2JIHF
	6A/DgyfZkml2B50=; b=J9Ya0qefcfIy/xHcxtC1uSuQU8A0/Aq51yC0rS67bMxg
	ksNVpStKtbKfU3EfpnurhusQoHIKYz/C8n928K4GbGHv5E7JQb0Nxwv0Vr1hqkvU
	FVZ5sLr/xIjlt2KJToAO0oe2y0DOtOiAKiz3kgzHuI5fDJMZww0qAHbs1hwwt7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pXznBz
	vqpFoTMLXfQ1zmHRpi18WhlX2W5RoXcK0FCLab1b0bk8k/DHMaefYLe3yi2rbH4Y
	cBaqZFerJw7dhi1S7R8qplRSE4q9e0nBDU4fBz5t32rdlp/WVRkutPVN3oVZyzqL
	mSo+WF5wIQcfOCKL1FGl/Z2HjvjiN7lSU2Hz4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 22DCB22866;
	Wed,  3 Dec 2014 11:13:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D9C222865;
	Wed,  3 Dec 2014 11:13:09 -0500 (EST)
In-Reply-To: <CAPig+cS1OK6pv5A0vuJf=j6eFrNv70=AYgVz3zQny-md15_xKg@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 2 Dec 2014 19:11:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 45E9C3D6-7B07-11E4-8BE4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260656>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Dec 2, 2014 at 7:11 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Dec 2, 2014 at 2:32 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writ=
es:
>>>
>>>> This allows the callback to use 'base' as a temporary buffer to
>>>> quickly assemble full path "without" extra allocation. The callbac=
k
>>>> has to restore it afterwards of course.
>>>
>>> Hmph, what's the quote around 'without' doing there?
>>
>> because it's only true if you haven't used up all preallocated space
>> in strbuf. If someone passes an empty strbuf, then underneath strbuf
>> may do a few realloc until the buffer is large enough.
>
> Would it be easier to understand if written like this?
>
>     This allows the callback to use 'base' as a temporary buffer to
>     quickly assemble full path, thus avoiding allocation/deallocation
>     for each iteration step.

Thanks.

I am not Duy so I do not know if that matches what he wanted to say,
or if it matches what the change gives us.  Your phrasing wouldn't
have made me say "Hmph...?" and it is an improvement that goes in
the right direction, I think.

A question during the review, especially on proposed log messages
and documentation changes, is rarely just a request to explain it to
the questioner in the discussion. It is an indication that what is
being commented on needs tweaking to be understood.
