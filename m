From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use child_process_init() to initialize struct child_process variables
Date: Wed, 29 Oct 2014 12:16:05 -0700
Message-ID: <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
References: <54500212.7040603@web.de> <20141029172109.GA32234@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 20:16:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjYj9-0003qh-HT
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 20:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbaJ2TQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2014 15:16:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754881AbaJ2TQJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Oct 2014 15:16:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63635190C7;
	Wed, 29 Oct 2014 15:16:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cyTY3p6hHj4k
	81bo0iA1J5VICJw=; b=NccuCKy+HfPJp1a7ZKLwyuEMlImT4HW7FOAtQ7dVgGKj
	vzNitDAPtWiGHq4uRXfScSPIMjZ8GxP9miptXW9f8tWH3I/pSlx0E0KeajLCDvrf
	KMurvzLoxd0Az3isUIrbpaKsrLwILKQu95ZDd6W6zb7WOYU5Qn0ihMy4m1jZzCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wf+pLM
	yNjJneFXFPANMBtW+0QMPCON5uCVK7yepiSd37n1mP7k6W2ELo1BUlwS0BQocLVj
	q2QQx5uHHNZfWsti4/jCnU3olepwzEMtRv74VPH78nS8I1b+mddpfFGi3FbfHh14
	waqhf3B2NaFHjzJNpX8be3qIaS5zoisCknEvI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A5BD190C6;
	Wed, 29 Oct 2014 15:16:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29B9A190C4;
	Wed, 29 Oct 2014 15:16:07 -0400 (EDT)
In-Reply-To: <20141029172109.GA32234@peff.net> (Jeff King's message of "Wed,
	29 Oct 2014 13:21:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 089C4A3A-5FA0-11E4-BE85-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 28, 2014 at 09:52:34PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> --- a/bundle.c
>> +++ b/bundle.c
>> @@ -381,7 +381,7 @@ int create_bundle(struct bundle_header *header, =
const char *path,
>>  	write_or_die(bundle_fd, "\n", 1);
>> =20
>>  	/* write pack */
>> -	memset(&rls, 0, sizeof(rls));
>> +	child_process_init(&rls);
>>  	argv_array_pushl(&rls.args,
>>  			 "pack-objects", "--all-progress-implied",
>>  			 "--stdout", "--thin", "--delta-base-offset",
>
> I wondered if this one could use CHILD_PROCESS_INIT in the declaratio=
n
> instead. And indeed, we _do_ use CHILD_PROCESS_INIT there, but we use
> the same variable twice for two different child processes in the same
> function. Besides variable reuse being slightly confusing, the name
> "rls" (which presumably stands for "rev-list" for the first child) me=
ans
> nothing here, where we are calling "pack-objects". Maybe it would be
> cleaner to introduce a second variable?

It has been this way since day one at b1daf300 (Replace
fork_with_pipe in bundle with run_command, 2007-03-12); I agree that
two variables might make things less confusing.

> I also suspect the function would be a lot more readable broken into =
two
> sub-functions (reading from rev-list and writing to pack-objects), bu=
t I
> did not look closely enough to see whether there were any complicatin=
g
> factors.

Probably three helper functions:

 - The first is to find tops and bottoms (this translates fuzzy
   specifications such as "--since 30.days" into a more concrete
   revision range "^A ^B ... Z" to establish bundle prerequisites),
   which is done by running a "rev-list --boundary".

 - The second is to show refs, while paying attention to things like
   "--10 maint master" which may result in the tip of 'maint' not
   being shown at all.  I am not sure if this part can/should take
   advantage of revs.cmdline, though.

 - The last is to create the actual pack data.

I agree with your analysis on the change in column.c and trailer.c

Thanks.
