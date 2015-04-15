From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] refs.c: remove lock_fd from struct ref_lock
Date: Wed, 15 Apr 2015 11:35:06 -0700
Message-ID: <xmqqbnipkzol.fsf@gitster.dls.corp.google.com>
References: <1429050308-9617-1-git-send-email-sbeller@google.com>
	<1429050308-9617-4-git-send-email-sbeller@google.com>
	<552E2608.7020104@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 15 20:35:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiS9f-0000o8-2t
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 20:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbbDOSfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 14:35:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52338 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751422AbbDOSfM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 14:35:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C496C486DB;
	Wed, 15 Apr 2015 14:35:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=97phePMdUcZButP7sAf9QY+z5cI=; b=aAXv04
	JS//9exThzCLxYoUcjA3o+3mexhxJqtwA3ihlUcb4tzPCiHzPD/zS0o/nFx25z/j
	WQUeNTRmVTzvZLQa8c0mGUMBzJ3rbWpiDpQVM6sT/07xnzFhL9XK1GqEDa2YxGMY
	/CnP6D97YyJb7QlGAEzue7T2dXsXdYn4yHOQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VWJaPcqtr5nsZoqpT4HMX7HUZhuVUexa
	SzEj7B7D1AQQkzTEFSZ9n2xO43nbDTkksuafHrNc9rfv2+AqJMzQgGkE8vsSHJA4
	esp9WsR/P6I/fk06Wvcbo+jLAnyNGZeQ759NnpH1u7hWRk2kPzq3LffsBwR+1+yf
	B6dQxnSztbo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BE00A486DA;
	Wed, 15 Apr 2015 14:35:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 45A1F486D9;
	Wed, 15 Apr 2015 14:35:07 -0400 (EDT)
In-Reply-To: <552E2608.7020104@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 15 Apr 2015 10:49:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 23CDA204-E39E-11E4-B927-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267229>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This whole series LGTM; however, I suggest that this patch be split up.
> See below.
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  refs.c | 16 ++++++----------
>>  1 file changed, 6 insertions(+), 10 deletions(-)
>> 
>> diff --git a/refs.c b/refs.c
>> index 14e52ca..4066752 100644
>> --- a/refs.c
>> +++ b/refs.c
>> [...]
>> @@ -2335,8 +2333,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>>  		goto error_return;
>>  	}
>>  
>> -	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
>> -	if (lock->lock_fd < 0) {
>> +	if (hold_lock_file_for_update(lock->lk, ref_file, lflags) < 0) {
>> +		last_errno = errno;
>>  		if (errno == ENOENT && --attempts_remaining > 0)
>>  			/*
>>  			 * Maybe somebody just deleted one of the
>> [...]
>
> Here you add the line "last_errno = errno". It is a good change, but it
> is not part of removing ref_lock::lock_fd.

I think this patch came from an ancient codebase before 06839515
(lock_ref_sha1_basic: do not die on locking errors, 2014-11-19),
which added the "last_errno = errno", and was not rebased to match
more recent codebase.

I am planning to apply these on top of v2.4.0-rc, so there will be
no new "save to last_errno" in the end.

Thanks.
