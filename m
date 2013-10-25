From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] merge-base: "--reflog" mode finds fork point from reflog entries
Date: Fri, 25 Oct 2013 09:53:53 -0700
Message-ID: <xmqqmwlxjnq6.fsf@gitster.dls.corp.google.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
	<1382641884-14756-1-git-send-email-gitster@pobox.com>
	<1382641884-14756-3-git-send-email-gitster@pobox.com>
	<CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
	<xmqq61smmkc0.fsf@gitster.dls.corp.google.com>
	<CAPig+cQ2tWFXX-RYnUrHEZCaqaPV6ZwgoPfiNPv9P1jFNTGEYg@mail.gmail.com>
	<xmqqwql2l3ln.fsf@gitster.dls.corp.google.com>
	<xmqqsivql37i.fsf_-_@gitster.dls.corp.google.com>
	<526A19CA.9020609@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 18:54:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZkeA-0000dA-LZ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 18:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab3JYQx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 12:53:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab3JYQx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 12:53:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03EFD4BC53;
	Fri, 25 Oct 2013 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6RaXACZ4nhOhqpILQ+cZo9WdEzw=; b=haIjMC
	A/XggeTvWFtDUbj7Hh/8+vVmPmKOUTDLLWzM6ly8xKTTFH+FDc0ewUgEnjp4k4NN
	E+99oRMTaBv/Nr8Mzp4vrk4+ZaLzs6PFYfd3HZ0SFYhEg2fxXlxCCT/TErqaGGXL
	iXWdEtj/RTfbrc+blO5LE/hq/AlAcKL2SHJ2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KPTDkfEqhhRpZIP6uEKTd4yWSHcX01c/
	p2g5X3fMV4u3btEJJQSw2Y7LLozl+iQj817M3lvaW4n7vLMrqxrUDbnoj63YmOJ9
	H2RMDwOVwcr0MF7G0phiWtWcPfVDw8SSgE/azRn7zGMRpNxrnKYktQop5ykq0D4H
	wQUiIwCu2gk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA84B4BC51;
	Fri, 25 Oct 2013 16:53:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FFED4BC4C;
	Fri, 25 Oct 2013 16:53:56 +0000 (UTC)
In-Reply-To: <526A19CA.9020609@viscovery.net> (Johannes Sixt's message of
	"Fri, 25 Oct 2013 09:12:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0968B5B6-3D96-11E3-BBD5-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236709>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> +	for count in 1 2 3 4 5
>> +	do
>> +		git merge-base --reflog base $(cat derived$count) >actual &&
>> +		test_cmp expect$count actual || break
>> +	done &&
>
> This does not work as intended because the exit code of 'break' is always
> zero. Unlike 'exit' and 'return', it does *not* pick up the exit code of
> the last command that was executed.

You are right. I obviously was not thinking straight.

> You could put the loops into a function from which you 'return',
> but that is obscure in this case. The first iteration was better,
> IMO.

I do not think using "return 1" is a good thing to do, either.

We saw breakages with different shells around the use of "return"
and we know the original "exit 1 inside subshell" works reliably
everywher.

I'll send out a revamped version later today, updating not just the
test but the implementation.

Thank for a dose of sanity.
