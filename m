From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] rev-parse: introduce --exclude=<glob> to tame wildcards
Date: Fri, 01 Nov 2013 13:01:50 -0700
Message-ID: <xmqqy55728nl.fsf@gitster.dls.corp.google.com>
References: <52264070.3080909@kdbg.org>
	<1383334455-18623-1-git-send-email-gitster@pobox.com>
	<1383334455-18623-4-git-send-email-gitster@pobox.com>
	<CAPig+cQf+FEiZiLfHUsH2XH9KcpCqmJP7xVPok-Ww9fuTX_Wxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 21:01:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcKur-0006hY-A3
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 21:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab3KAUBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 16:01:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab3KAUBw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 16:01:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D8B74D6D0;
	Fri,  1 Nov 2013 16:01:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wB+7sXUkvg/zH2nEjv4FIjDlfR0=; b=g7CMFy
	aSvHK7/4pj7VPUOvN3ks4Yx6XAwDoWGTLuHpZtR7VsBNtFehf0wF/hQn/IBvQLPQ
	6KRH+Ca4taYNqVHvwH9nq6dk7P6/T9o6L/j1/9iUs+oDZIvCg9zGXBvHwJzmC9Hm
	fzvWE2aN2yqBGT61ds/qQo0twrd03Ee1Kw1Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mbsX3V1Jb5yma0VgduzYONCRaZDtvqfM
	begcIYc+O7aurFy+KyNlOfFs8uJg+FUfjCJZGj4W4p4UYBui4h+aP02YgAi/wNm9
	Pr/Yh5SejznyEEDNmpTEiNcElHLSV0J0RMTyyrtkPjheaCfyyOju9QkAOAsCdXbm
	LwqiN0kwfk4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 532514D6CF;
	Fri,  1 Nov 2013 16:01:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B14464D6CC;
	Fri,  1 Nov 2013 16:01:51 -0400 (EDT)
In-Reply-To: <CAPig+cQf+FEiZiLfHUsH2XH9KcpCqmJP7xVPok-Ww9fuTX_Wxw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 1 Nov 2013 15:43:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 72F482C2-4330-11E3-B42F-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237223>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Nov 1, 2013 at 3:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Teach "rev-parse" the same "I'm going to glob, but omit the ones
>> that match these patterns" feature as "rev-list".
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  Documentation/git-rev-parse.txt | 14 ++++++++++++++
>>  builtin/rev-parse.c             | 17 +++++++++++++++++
>>  t/t6018-rev-list-glob.sh        | 12 ++++++++++++
>>  3 files changed, 43 insertions(+)
>>
>> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
>> index 2b126c0..d4639a2 100644
>> --- a/Documentation/git-rev-parse.txt
>> +++ b/Documentation/git-rev-parse.txt
>> @@ -155,6 +155,20 @@ shown.  If the pattern does not contain a globbing character (`?`,
>>         character (`?`, `*`, or `[`), it is turned into a prefix
>>         match by appending `/*`.
>>
>> +--exclude=<glob-pattern>::
>> +       Do not include refs matching '<glob-pattern>' that the next `--all`,
>> +       `--branches`, `--tags`, `--remotes`, or `--glob` would otherwise
>> +       consider. Repetitions of this option accumulate exclusion patterns
>> +       up to the next `--all`, `--branches`, `--tags`, `--remotes`, or
>> +       `--glob` option (other options or arguments do not clear
>> +       accumlated patterns).
>> ++
>> +The patterns given should not begin with `refs/heads`, `refs/tags`, or
>> +`refs/remotes` when applied to `--branches`, `--tags`, or `--remotes`,
>> +restrictively, and they must begin with `refs/` when applied to `--glob`
>
> Did you mean s/restrictively/respectively/ ?

I guess so; it was "cut&paste without thinking" from [Patch 2/5] ;-).

>
>> +or `--all`. If a trailing '/{asterisk}' is intended, it must be given
>> +explicitly.
