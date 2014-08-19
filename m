From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make config --add behave correctly for empty and NULL values
Date: Mon, 18 Aug 2014 23:03:51 -0700
Message-ID: <xmqqmwb1vwvs.fsf@gitster.dls.corp.google.com>
References: <1408357077-4745-1-git-send-email-tanayabh@gmail.com>
	<xmqqvbppwtir.fsf@gitster.dls.corp.google.com>
	<20140819051732.GA13765@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 08:04:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJcWo-0002q9-Io
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 08:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbaHSGEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 02:04:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57733 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589AbaHSGEH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 02:04:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6B6A2B9D2;
	Tue, 19 Aug 2014 02:04:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fsb0Vo7UUON90VDbD+VWZ/5cPEk=; b=s1wmUX
	fWCVB8dc04/Q7XeSkV/YcD3JrAvJ64O2//fQPCTXSqNZhBSnPpX4SZxJ4m0ZNOd3
	F9oth85YOIoiRtQpqE434FOvToAP9M1OOcmUu8Pc4o1ou7SZT7D4nlqxqDqdD3xy
	QEiLd6D4/lGbmfAAjzXN43aLIPfsK2XE4BWq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sVzs8czmh8HmCHZim/OqKFrybURRIphA
	xCVH1n42UgrkxV735sdwLtiAbxVFy6ToMM0l/C7n4HRVS82Tr+5EPslYZ2dicooy
	eF+4HpfrNq/NuX2731/5xh2Jz367cHpKJxgOvA6LqlCMyqAxqLnuUL0wvzPCpdEM
	J6SDVH4fgSk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C9B3E2B9CF;
	Tue, 19 Aug 2014 02:04:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A21A72B9CD;
	Tue, 19 Aug 2014 02:03:53 -0400 (EDT)
In-Reply-To: <20140819051732.GA13765@peff.net> (Jeff King's message of "Tue,
	19 Aug 2014 01:17:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 991A5844-2766-11E4-A725-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255442>

Jeff King <peff@peff.net> writes:

> I just used
>
>   #define CONFIG_REGEX_NONE ((void *)1)
>
> as my magic sentinel value, both for the string and compiled regex
> versions. Adding a bit to the store struct is a lot less disgusting and
> error-prone. So I won't share mine here. :)

Actually, I wrote something like that aloud but did not type it out
;-).  Great minds think alike.

We already have some code paths that use ((void *)1) as a special
pointer value, so in that sense I would say it is not the end of the
world if you added a new one.  At the end-user level (i.e. people
who write callers to set-multivar-in-file function), I actually like
your idea of inventing our own string syntax and parse it at the
place where we strip '!' out and remember that the pattern's match
status needs to be negated.  For example, instead of "a^" (to which
I cannot say with confidence that no implementation would match the
not-at-the-beginning caret literally), I would not mind if we taught
set-multivar-in-file that we use "!*" as a mark to tell "this
pattern never matches", and have it assign your "never matches"
mark, i.e. (void *)1, to store.value_regex.  Then matches() would
become

	static int matches(const char *key, const char *value)
        {
        	if (strcmp(key, store.key))
                	return 0; /* not ours */
		if (!store.value_regex)
                	return 1; /* always matches */
		if (store.value_regex == CONFIG_REGEX_NONE)
                	return 0; /* never matches */
		return store.do_not_match ^
                	!regexec(store.value_regex, value, 0, NULL, 0);
	}

or something like that, and the ugly "magic" will be localized,
which may make it more palatable.
