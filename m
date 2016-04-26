From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 07/10] convert: unify the "auto" handling of CRLF
Date: Tue, 26 Apr 2016 10:42:37 -0700
Message-ID: <xmqqy480gtbm.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1461603397-30873-1-git-send-email-tboegi@web.de>
	<xmqqtwipjx9f.fsf@gitster.mtv.corp.google.com>
	<41d4d5c6-f964-8d3f-0e07-fd98b2f6b71e@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:42:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av70X-0002W9-81
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbcDZRml convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 13:42:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751881AbcDZRml convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 13:42:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A03C5147F6;
	Tue, 26 Apr 2016 13:42:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tQOWC17XjupS
	kF9gLr4CUvihqUI=; b=fd1/6EdbATTje8t3ZWtL1y0YTj/oAaTEcak6Ctnkiy80
	1RP5Dnk1xXf30GpuuAGiKKIpOt5Qz56Xct/Wi8/BTaHM3zE6+FYk+0CCzqtgGzhT
	IUHaswDu4EFw1p4P1rvq0ZKY73dkFhm+5bDwlSoAFicIgP3hYr7DHSpUNNOkajE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iJkn+H
	0LAmZP/HUlXzlJzXP7doFzwOgl9YkSMfcYc2Y1Sp3rVwBZsvSNz6CY4fBzjnnrUg
	nm/Ks8/DpcQrHwP5MmRR/yFSKcTbOxpllk8WlEP4iFd8Uz/RIMH+ITlai1AmRVFM
	CRQFjAej1HwbN5vQGL/cYAIL7mtg3/SWVbpRI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 97D0D147F5;
	Tue, 26 Apr 2016 13:42:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B230147F4;
	Tue, 26 Apr 2016 13:42:38 -0400 (EDT)
In-Reply-To: <41d4d5c6-f964-8d3f-0e07-fd98b2f6b71e@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 26 Apr 2016 18:33:22
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 450A076C-0BD6-11E6-B623-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292625>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>>> diff --git a/convert.c b/convert.c
>>> index 24ab095..3782172 100644
>>> --- a/convert.c
>>> +++ b/convert.c
>>> @@ -227,7 +227,9 @@ static enum eol output_eol(enum crlf_action crl=
f_action)
>>>  		return EOL_LF;
>>>  	case CRLF_UNDEFINED:
>>>  	case CRLF_AUTO_CRLF:
>>> +		return EOL_CRLF;
>>=20
>> Hmph, do we want UNDEFINED case to return EOL_CRLF here?
>>=20
>>>  	case CRLF_AUTO_INPUT:
>>> +		return EOL_LF;
> One of the compilers claimed that UNDEFINED was not handled in switch=
-case.
> A Warning may be better ?=20
>>>  	case CRLF_TEXT:
>>>  	case CRLF_AUTO:
>>>  		/* fall through */

The original made it fall-through; a very simple "a patch that makes
auto=3Dcrlf or auto=3Dinput do something different shouldn't have any
effect on the undefined case" was what triggered my reaction.

If returning EOL_CRLF does not make any sense for UNDEFINED case, it
shouldn't.  If the codeflow should not reach without crlf_action
computed to something other than UNDEFINED, then you should have a
die("BUG") there.

Looking at a larger context, you already have a warning there:

    static enum eol output_eol(enum crlf_action crlf_action)
    {
            switch (crlf_action) {
            case CRLF_BINARY:
                    return EOL_UNSET;
            ...
            case CRLF_AUTO:
                    /* fall through */
                    return text_eol_is_crlf() ? EOL_CRLF : EOL_LF;
            }
            warning("Illegal crlf_action %d\n", (int)crlf_action);
            return core_eol;
    }

which tells me that you shouldn't even have CRLF_UNDEFINED listed if
you have no intention to treat UNDEFINED as a valid input in this
codepath.  Instead just doing

	switch (crlf_action) {
        case ...: /* handle all valid inputs appropriately */
        	return ...;
	...
	default: /* the above should cover all valid cases */
		break;
	}
        warning(...);
        return ...;

and not listing CRLF_UNDEFINED in any of the case arms would make
your intention more clear.

>>=20
> How about this as the commit message:
> --------------------------------------
> ...
> The 'eol' attribute had higher priority than 'text=3Dauto'. Binary
> files may had been corrupted, and this is not what users expect to ha=
ppen.
>
> Make the 'eol' attribute to work together with 'text=3Dauto'.

The primary issue I had was that "work together" was a useful
explanation only to those who already understand what you are trying
to do with this patch.

Something like:

	Having an "eol" attribute is taken as a declaration that the
	path is text.  This may be logical (on a binary blob, you
	wouldn't be defining an "eol" attribute in the first place)
	but is not very useful if you wanted to say "I do not know
	if the path is text; inspect the contents to see if it is
	text, and apply this 'eol' conversion only if it is".

	"text=3Dauto" attribute combined with an "eol" attribute ought
	to have meant that, but it didn't.  Make it so.

would be sufficient without any configuration example, I would think.

> With this change
>
> $ echo "* text=3Dauto eol=3Dcrlf" >.gitattributes
> has the same effect as
> $ git config core.autocrlf true
>
> and
>
> $ echo "* text=3Dauto eol=3Dlf" >.gitattributes
> has the same effect as
> $ git config core.autocrlf input
