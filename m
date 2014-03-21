From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: disable translation when --porcelain is used
Date: Fri, 21 Mar 2014 10:38:14 -0700
Message-ID: <xmqqd2hfv4e1.fsf@gitster.dls.corp.google.com>
References: <CAPP0M7Rw50hPHm49FetNXPGESXOoAND4NXU9F=rajv+NA=G32Q@mail.gmail.com>
	<1395317561-9380-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq38iczrr4.fsf@gitster.dls.corp.google.com>
	<vpqior8dke6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ghostanarky@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 21 18:38:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR3P8-0005EK-28
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 18:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828AbaCURid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 13:38:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754960AbaCURiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 13:38:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9759B76CFA;
	Fri, 21 Mar 2014 13:38:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rfqJVEUqKVTd+ulVuuZncDTMi3A=; b=jmYiSu
	wTQcFHihjNiPByx/3/8meSbcFBJXS5AEio9hodEQxUmdMXUgPIB4iYUIaaxO7rzI
	nZJM/TeeGxZ8nAFX/BsSwfTeRJN09KMy4ZpoGGL0v/ve08z0HpRXUoUuncrI/+2j
	NKdUlpaQARU58hw9L5FT1AmEdUPpcu6bEQguM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CzpKYgUkSPvlYXXuyFiZuqXYUIEdaHdW
	2/Q/9dYTjsre4ksnmu5xVMmj3HltKQ6gHKNmyqZO/aADGPE+tC+fsSRjFODFg8hs
	F8YvjNAcEI+kL9dyZmLZhWPggRGlriLf21fmQGfZm5ZHhcJqrM2UhXgYozTjGXDb
	SOKBm+XCZPA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83E8E76CF9;
	Fri, 21 Mar 2014 13:38:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D86D576CF3;
	Fri, 21 Mar 2014 13:38:15 -0400 (EDT)
In-Reply-To: <vpqior8dke6.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	21 Mar 2014 09:29:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9558AD2C-B11F-11E3-A5BF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244707>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> diff --git a/wt-status.c b/wt-status.c
>>> index a452407..e55e5b9 100644
>>> --- a/wt-status.c
>>> +++ b/wt-status.c
>>> @@ -1509,19 +1509,23 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
>>>  		return;
>>>  	}
>>>  
>>> +	const char *gone   = s->no_gettext ? "gone"   : _("gone");
>>> +	const char *behind = s->no_gettext ? "behind " : _("behind ");
>>> +	const char *ahead  = s->no_gettext ? "ahead "  : _("ahead ");
>>
>> Having to repeat the same string constant twice (and a half for the
>> variable name) each is an eyesore.  I wonder if we can do better,
>> perhaps with:
>>
>> #define LABEL(string) (s->no_gettext ? (string) : _(string))
>>
>> and then
>>
>> 	color_fprintf(s->fp, header_color, LABEL(N_("gone")));
>>
>> or something along those lines?
>
> I first thought about trying something clever with the preprocessor, but
> since it's only for 3 strings, I went the KISS way. I tend to prefer my
> version for simplicity, but no strong opinion here.

Then I'll squash 61bf9709 (SQUASH??? fix decl-after-stmt and
simplify, 2014-03-20) in before merging the patch to 'next'.
