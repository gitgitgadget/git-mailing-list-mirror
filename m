From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit.c: use strchrnul() to scan for one line
Date: Mon, 16 May 2016 08:57:59 -0700
Message-ID: <xmqq1t523shk.fsf@gitster.mtv.corp.google.com>
References: <xmqq37pj55bg.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1605160810020.3303@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 16 17:58:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2KuK-0002Cq-BU
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 17:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399AbcEPP6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 11:58:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754392AbcEPP6E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 11:58:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB6AD1CA08;
	Mon, 16 May 2016 11:58:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xbYtMGCXCqmeGY4En7GRQZl9rxU=; b=uGzPEg
	bT/Jakj9Qd1xl4rNpYbNjZNndFsoVL+qzpAuPOWHk+MkQmJ7Asjt8fGzM/0Te/zu
	xwgpWZCoIyGV+DdzwutAvQS/eQf88hsdva03uKC45Be5CDMxUdTVcC5LfIEeqa8e
	+Oni8NMQTy284eGV2VfQmUx5hxe4Km/EOKe7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BLhaE3Xmo43kjz19fjn7BsjWNYWawugK
	HBwGdh9UchjoGgGCVc1UXYVAK1GpwaNgjcSuZu3NzwQbh9+rB6Ka9UPICnDuFOYH
	q4I/cUjgYvoW/9/g87YvYMPhH0jR8MhfGS5UYxNr6//SasBnKFzOLENOOEuVbEZh
	yrTUtmKXVzM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DDEFA1CA07;
	Mon, 16 May 2016 11:58:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33D311CA06;
	Mon, 16 May 2016 11:58:02 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605160810020.3303@virtualbox> (Johannes
	Schindelin's message of "Mon, 16 May 2016 08:12:33 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F804B26A-1B7E-11E6-8A59-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294746>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 15 May 2016, Junio C Hamano wrote:
>
>> diff --git a/commit.c b/commit.c
>> index 3f4f371..1f9ee8a 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -415,8 +415,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
>>  		p++;
>>  	if (*p) {
>>  		p += 2;
>> -		for (eol = p; *eol && *eol != '\n'; eol++)
>> -			; /* do nothing */
>> +		eol = strchrnul(p, '\n');
>>  	} else
>>  		eol = p;
>
> ACK. This was my fault, when I introduced the code in 9509af68 (Make
> git-revert & git-cherry-pick a builtin, 2007-03-01). To be fair,
> strchrnul() was introduced only later, in 659c69c (Add strchrnul(),
> 2007-11-09).

Oh, there is no fault.

I was reading through attr.c to see how bad a work to revamp
attribute lookup would look like, found a hand-rolled strchrnul()
that predates the widespread use of the function, and looked for
similar patterns while I was updating it.  As there were many false
positives (i.e. "Yes, this loop is looking for the end of line, but
it does something else to the characters on the line while doing so,
so it cannot become strchrnul()") that I needed eyeballing in order
to reject and avoid incorrect conversion, it is very much appreciated
that you double-checked this one that I spotted.

Thanks.
