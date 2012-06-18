From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_name: don't trigger detailed diagnosis for file
 arguments
Date: Mon, 18 Jun 2012 11:01:30 -0700
Message-ID: <7vwr3433et.fsf@alter.siamese.dyndns.org>
References: <vpq395tvlc0.fsf@bauges.imag.fr>
 <1339958341-22186-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vehpc4jpw.fsf@alter.siamese.dyndns.org> <vpqpq8wpled.fsf@bauges.imag.fr>
 <7v62ao4ihf.fsf@alter.siamese.dyndns.org> <vpqipeopkpj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 18 20:01:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SggGf-0002ee-G7
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 20:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268Ab2FRSBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 14:01:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464Ab2FRSBc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 14:01:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B7C68E26;
	Mon, 18 Jun 2012 14:01:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HK7OokAPaIPXTLng+vhkDDSMV04=; b=Da8lS2
	clE5CJ0MAXnT875BO5F636RWDXf3H5lTjo6DS8vW8lAfu8tQ8XudR1POKxwQcBIn
	zSbEsGZOxrplzj9u5JSvTr9KnHtZaosue3PQd3+DWt54BaXjbVZ8t7IOCDDsGZeu
	F9gXOQcUpojII+aKuCfq9SARQ42eDwwcdGLTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eC3R9gWV0ifdRawfqxvzWZvKYiaRMzTv
	mOabG0TKpm26Cx5z2/zZtBR0kGjsXnd21KYK3qBuuO3q057mCcrI3d1m2Kk83fPw
	N+p97CrWBZpXit4Q/BBbkPv7osyLTypOULVBWhCvdfUdj2xDmr1q229+JZsxgUUa
	0kHBoIc2XVM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 614EA8E24;
	Mon, 18 Jun 2012 14:01:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7C4A8E1D; Mon, 18 Jun 2012
 14:01:31 -0400 (EDT)
In-Reply-To: <vpqipeopkpj.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 18 Jun 2012 19:56:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2AD6AA2-B96F-11E1-A0B3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200155>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> My version reads as
>>>
>>>   try something;
>>>   if (it failed && I'm only here to report an error)
>>>           report_error();
>>>
>>> which I find easier to understand.
>>
>> I agree that _this_ part is easy to understand when written that
>> way.  But then shouldn't there be a blanket "The caller is here only
>> to report an error, but all the previous code didn't find any error,
>> so there is something wrong" check much later in the code before it
>> returns a success?  Or am I being too paranoid?
>
> Currently, there's no problem if get_sha1_with_context_1 returns without
> dying, because the caller does:
>
> 	if (!(arg[0] == ':' && !isalnum(arg[1])))
> 		/* try a detailed diagnostic ... */
> 		get_sha1_with_mode_1(arg, sha1, &mode, 1, prefix);
>
> 	/* ... or fall back the most general message. */
> 	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
> 	    "Use '--' to separate paths from revisions", arg);
>
> If we failed to give a nice diagnosis, we give the generic error
> message.
>
> We could add this check within get_sha1_with_context_1 to simplify the
> task of the caller, but that would require adding it before each
> "return" statement, which I think is overkill.

OK.
