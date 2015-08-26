From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Wed, 26 Aug 2015 13:54:58 +0200
Message-ID: <vpqd1yap8ml.fsf@anie.imag.fr>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<xmqqy4h04mx4.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZRYWNVmMeMCZSa+GcOTQ7NzuVB9RH_TFJ6-u7aFhrU=NA@mail.gmail.com>
	<xmqq8u904ix0.fsf@gitster.dls.corp.google.com>
	<xmqq37z82u2a.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZS=Mtz0ny0tUWRBY0vfAgiRzaszeF0m_pxnK3+VGn1eVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 13:55:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUZIO-0003Ro-LN
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 13:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932911AbbHZLzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 07:55:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41505 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794AbbHZLzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 07:55:05 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7QBsvj4024897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 26 Aug 2015 13:54:57 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7QBsw46032725;
	Wed, 26 Aug 2015 13:54:58 +0200
In-Reply-To: <CAOLa=ZS=Mtz0ny0tUWRBY0vfAgiRzaszeF0m_pxnK3+VGn1eVg@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 26 Aug 2015 15:37:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 26 Aug 2015 13:54:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7QBsvj4024897
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441194898.08794@69c00NwZEVS7LWXp564A5Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276606>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Tue, Aug 25, 2015 at 4:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> On Mon, Aug 24, 2015 at 10:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>>> ...
>>>>>> +     performed. If used with '--quote' everything in between %(align:..)
>>>>>> +     and %(end) is quoted.
>>>> ...
>>>> I might have misunderstood you, But based on the discussion held here
>>>> (thread.gmane.org/gmane.comp.version-control.git/276140)
>>>> I thought we wanted everything inside the %(align) .... %(end) atoms
>>>> to be quoted.
>>>
>>> Perhaps I misunderstood your intention in the doc.
>>>
>>> I took "everything in between %(align:...) and %(end) is quoted" to
>>> mean that
>>>
>>>       %(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)
>>>
>>> can never satisfy %(if:empty), because %(align)%(end) would expand
>>> to a string that has two single-quotes, that is not an empty string.
>>>
>>> If that is not what would happen in the "branch --list" enhancement,
>>> then the proposed behaviour is good, but the above documentation would
>>> need to be updated when it happens, I think.  It at least is misleading.
>>
>> OK, now I checked the code, and I _think_ the recursive logic is
>> doing the right thing (modulo minor nits on comment-vs-code
>> discrepancy and code structure I sent separately).
>>
>
> For the current code %(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)
> would print non-empty, I guess the documentation holds in that case.
> Not sure if we require it to print non-empty.

You don't want the %(if) condition to depend on whether
--shell/--python/... is used. Since %(if:empty)%(align)%(end)%(then)
holds when you don't use --shell, you also want it to hold when you
quote. IOW, you should check for emptyness before (or actually without)
doing the quoting. I guess this is what you're doing, and if so, I think
it's "The Right Thing".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
