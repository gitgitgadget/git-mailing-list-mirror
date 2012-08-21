From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fetch/push: allow refs/*:refs/*
Date: Tue, 21 Aug 2012 10:37:54 -0700
Message-ID: <7vpq6kdu31.fsf@alter.siamese.dyndns.org>
References: <1345484397-10958-1-git-send-email-gitster@pobox.com>
 <1345484397-10958-2-git-send-email-gitster@pobox.com>
 <50332E2D.2070602@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 21 19:38:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3sPB-00057B-2s
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 19:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758248Ab2HURiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 13:38:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758045Ab2HURh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 13:37:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C83574B3;
	Tue, 21 Aug 2012 13:37:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=198KSGeKYd9a21Yqb8SYGvxICAU=; b=oycFNP
	0MFWgERouKL3pU8yhReAm+sHU4wRQZ6iRWzVgTMKRFwHfPT5NIIAWt5HzkW7UoVk
	bfUhLBr/3SxNBSKAtteFhiq1vkBb81tzBlxgZT14VfLau+5zFyPhQ9EHvtBVHk0m
	pUkc38onGbrfaCiQirJNXSgWqBWZjJizpoj6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PQHO1aPMTD6YJWQDI0JOoC5+DWsZ9pQQ
	7bpa3ZhPfTrPiBDScQ+L1yqCCFVRgjHHBhJ2vvJEq+1xRz4VgtfdJoYmkkyoHiIf
	EpK4OOn6E2Z0NOX15Tfze3SuyZmTiJHOu9V+3hp5p8bCfhfX0b6OFZ1E4tgMCpxT
	DwaXHJCs2N8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89C1F74B2;
	Tue, 21 Aug 2012 13:37:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E708674B1; Tue, 21 Aug 2012
 13:37:55 -0400 (EDT)
In-Reply-To: <50332E2D.2070602@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 21 Aug 2012 08:43:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F11C04A4-EBB6-11E1-A8A0-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203974>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
>> index 6207ecd..a3e3fa3 100644
>> --- a/builtin/fetch-pack.c
>> +++ b/builtin/fetch-pack.c
>> @@ -546,7 +546,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
>>  	for (ref = *refs; ref; ref = next) {
>>  		next = ref->next;
>>  		if (!memcmp(ref->name, "refs/", 5) &&
>> -		    check_refname_format(ref->name + 5, 0))
>> +		    check_refname_format(ref->name, 0))
>>  			; /* trash */
>>  		else if (args.fetch_all &&
>>  			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
>
> I understand that you didn't introduce this code, but it seems like a
> suspicious combination of conditions:
>
>     if ((ref->name starts with "refs/")
>         and (ref->name has invalid format))

This protects us from getting contaminated by bogus ref under refs/
when running "fetch refs/heads/*:refs/remotes/origin/*" no?

The remote side can also throw phony "I have this object, too, but
not at a particular ref---this entry is only to let you know I have
it, so that we can negotiate minimal transfer better" entries that
are labelled with strings that do not begin with "refs/" and do not
pass check_refname_format() (and because they are not refs, they do
not have to pass the test) at us, and we do not want to filter them
out in this function.  But we do not want anything that is malformed
under "refs/".
